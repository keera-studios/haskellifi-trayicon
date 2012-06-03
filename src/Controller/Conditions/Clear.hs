module Controller.Conditions.Clear where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 menu <- mainMenuClear $ uiBuilder $ view cenv
 menu `on` menuItemActivate $ clearWifiList $ model cenv
