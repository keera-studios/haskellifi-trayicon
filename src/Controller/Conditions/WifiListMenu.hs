-- | Shows the popup menu when the user left-clicks the icon
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
