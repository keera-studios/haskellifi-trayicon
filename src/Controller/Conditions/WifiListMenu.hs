-- | Shows a menu with the current wifi list when the status icon is activated.
--
-- (View => View)
--
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Controller.Conditions.WifiListMenu where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
  icon <- trayIcon $ uiBuilder $ view cenv
  icon `on` statusIconActivate $ condition cenv

condition :: CEnv -> IO ()
condition cenv = do
  menu <- wifiListMenu $ uiBuilder $ view cenv
  widgetShowAll menu
  menuPopup menu Nothing
