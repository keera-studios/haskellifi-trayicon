-- | Keeps the menu in sync with the wifi list in the model, and copies the
-- corresponding password when a menu item is activated.
--
-- Model => View: Update the wifi list when necessary
-- View => IO:    Copy the corresponding password when a menu item is activated
--
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Controller.Conditions.WifiListSync where

import Control.Arrow
import Control.Monad
import Control.Monad.IfElse
import Graphics.UI.Gtk

import CombinedEnvironment
import Crypto.DefaultTelefonicaPassword

-- | Installs handlers to update the wifi list when it changes
installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
  let pm = model cenv
  onEvent pm Initialised $ condition cenv
  onEvent pm WifiListChanged $ condition cenv

-- | Updates the menus with the wifi list, and installs each menu item's
-- handler
condition :: CEnv -> IO ()
condition cenv = do
  let (ui, pm) = ((uiBuilder . view) &&& model) cenv

  -- | Removes all menu items
  menu <- wifiListMenu ui
  submenus <- containerGetChildren menu
  mapM_ (containerRemove menu) submenus

  list <- fmap (map fst) $ getWifiList pm
  if null list
   then -- Adds a dummy menu item indicating that no wifis have been found
        do item <- menuItemNewWithLabel "(No wifis found)"
           menuShellAppend menu item
           widgetSetSensitive item False
   else -- Adds one menu item per wifi, and installs its event handler
        forM_ list $ \s -> void $ do
          item <- menuItemNewWithLabel s
          menuShellAppend menu item
          item `on` menuItemActivate $ handleMenuItem s cenv

-- | Obtains the wifi details from the model, generates the default password,
-- and copies it to the clipboard.
handleMenuItem :: String -> CEnv -> IO()
handleMenuItem n cenv = do
  -- Get wifi details (default pass)
  let pm = model cenv
  list <- getWifiList pm
  let bssid = lookup n list
      pass  = fmap (\bssid' -> getWifiPass (n, bssid')) bssid

  -- If a pass can be generated, copy it to the clipboard
  awhen pass $ \pass' -> do
    let cbtag = selectionClipboard
    cb <- clipboardGet cbtag
    clipboardSetText cb pass'
