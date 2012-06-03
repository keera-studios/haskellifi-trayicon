{-# LANGUAGE TemplateHaskell #-}
-- | GUI loading and access to GUI elements from a glade builder
module View.Objects where

-- External imports
import Graphics.UI.Gtk
import Hails.Graphics.UI.Gtk.Builder
import Hails.Graphics.UI.Gtk.THBuilderAccessor

-- Internal imports
import Paths_haskellifi_trayicon

loadInterface :: IO Builder
loadInterface = loadDefaultInterface getDataFileName

-- gtkBuilderAccessor element name type name
gtkBuilderAccessor "trayIcon"      "StatusIcon"
gtkBuilderAccessor "mainMenu"      "Menu"
gtkBuilderAccessor "mainMenuClear" "MenuItem"
gtkBuilderAccessor "mainMenuQuit"  "MenuItem"
gtkBuilderAccessor "wifiListMenu"  "Menu"
