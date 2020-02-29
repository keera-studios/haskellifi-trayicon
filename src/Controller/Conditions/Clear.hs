-- | Clears the wifi list when requested
--
-- (View => Model): When the "clear wifi list" menu is activated (view), the list is cleared (model).
--
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Controller.Conditions.Clear where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 menu <- mainMenuClear $ uiBuilder $ view cenv
 menu `on` menuItemActivate $ clearWifiList $ model cenv
