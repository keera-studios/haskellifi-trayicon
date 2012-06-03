-- | Shows the popup menu when the user right-clicks the icon
module Controller.Conditions.WifiListSync where

import Control.Arrow
import Control.Monad
import Control.Monad.IfElse
import Graphics.UI.Gtk

import CombinedEnvironment
import Crypto.DefaultTelefonicaPassword

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
  let pm = model cenv
  onEvent pm Initialised $ condition cenv
  onEvent pm WifiListChanged $ condition cenv

condition :: CEnv -> IO ()
condition cenv = do
  let (ui, pm) = ((uiBuilder . view) &&& model) cenv

  menu <- wifiListMenu ui

  submenus <- containerGetChildren menu
  mapM_ (containerRemove menu) submenus

  list <- fmap (map fst) $ getWifiList pm
  if null list
   then do item <- menuItemNewWithLabel "(No wifis found)"
           menuShellAppend menu item
           widgetSetSensitive item False
   else flip mapM_ list $ \s -> void $ do
          item <- menuItemNewWithLabel s
          menuShellAppend menu item
          item `on` menuItemActivate $ handleMenuItem s cenv

handleMenuItem :: String -> CEnv -> IO()
handleMenuItem n cenv = do
  let pm = model cenv
  list <- getWifiList pm
  let bssid = lookup n list
      pass  = fmap (\bssid' -> getWifiPass (n, bssid')) bssid
  awhen pass $ \pass' -> do
    let cbtag = selectionClipboard
    cb <- clipboardGet cbtag
    clipboardSetText cb pass'
