-- | Shows the popup menu when the user right-clicks the icon
module Controller.Conditions.Icon where

import Paths_haskellifi_trayicon
import Graphics.UI.Gtk

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv =
  onEvent pm Initialised $ condition cenv
  where pm = model cenv

condition :: CEnv -> IO ()
condition cenv = onViewAsync $ do
  let ui = uiBuilder $ view cenv
  icon     <- trayIcon ui
  iconFile <- getDataFileName "data/wifi.png"
  statusIconSetFromFile icon iconFile
