-- | Quits the program when the user activates the menu item
--
-- (View => View): Stops the graphical subsystem when the user selects the
-- option "Quit", effectively stopping the program too.
module Controller.Conditions.Quit where

import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment

installHandlers :: CEnv -> IO()
installHandlers cenv = void $ do
 menu <- mainMenuQuit $ uiBuilder $ view cenv
 menu `on` menuItemActivate $ mainQuit
