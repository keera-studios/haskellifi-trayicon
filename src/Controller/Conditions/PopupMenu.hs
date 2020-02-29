-- | Shows the popup menu when the user right-clicks the icon
--
-- (View => View): When the icon's menu is requested, the main menu is shown.
--
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

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
