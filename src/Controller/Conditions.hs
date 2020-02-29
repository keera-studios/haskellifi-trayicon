-- | This module contains a series of conditions that must hold between
-- the view and the model. Most of these conditions can be separated in
-- two conditions: one that must be checked only when the model changes
-- (and updates the view accordingly), and another that must be checked
-- when the view receives an event (and updates the model accordingly).
--
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Controller.Conditions
   ( installHandlers )
  where

-- Internal libraries
import CombinedEnvironment

-- Internal libraries: specific conditions
import qualified Controller.Conditions.Icon         as Icon
import qualified Controller.Conditions.PopupMenu    as PopupMenu
import qualified Controller.Conditions.Clear        as Clear
import qualified Controller.Conditions.Quit         as Quit
import qualified Controller.Conditions.WifiListMenu as WifiListMenu
import qualified Controller.Conditions.WifiListPoll as WifiListPoll
import qualified Controller.Conditions.WifiListSync as WifiListSync

installHandlers :: CEnv -> IO()
installHandlers cenv = do
  Icon.installHandlers         cenv
  Clear.installHandlers        cenv
  Quit.installHandlers         cenv
  PopupMenu.installHandlers    cenv
  WifiListMenu.installHandlers cenv
  WifiListPoll.installHandlers cenv
  WifiListSync.installHandlers cenv
