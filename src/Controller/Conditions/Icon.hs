-- | Installs the icon in the system traybar when the program is initialised
--
-- (Model => View): Installs the icon in the system traybar.
--
-- Note: The event comes from the model, although the exact contents of the
-- model is not used in any way.
module Controller.Conditions.Icon where

import Graphics.UI.Gtk

import CombinedEnvironment
import Paths_haskellifi_trayicon

installHandlers :: CEnv -> IO()
installHandlers cenv = onEvent pm Initialised $ condition cenv
  where pm = model cenv

condition :: CEnv -> IO ()
condition cenv = onViewAsync $ do
  let ui = uiBuilder $ view cenv
  icon     <- trayIcon ui
  iconFile <- getDataFileName "data/wifi.png"
  statusIconSetFromFile icon iconFile
