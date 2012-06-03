-- | Shows the popup menu when the user right-clicks the icon
module Controller.Conditions.PopupMenu where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
  icon <- trayIcon $ uiBuilder $ view cenv
  icon `on` statusIconPopupMenu $ condition cenv

condition :: CEnv -> Maybe MouseButton -> TimeStamp -> IO()
condition cenv m t = do
  let ui = uiBuilder $ view cenv

  menu <- mainMenu ui
  menuPopup menu $ fmap (\m' -> (m', t)) m
