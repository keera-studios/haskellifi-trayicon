-- | Regularly updates the wifi list
module Controller.Conditions.WifiListPoll where

import Control.Concurrent
import Control.Monad
import Graphics.UI.Gtk

import CombinedEnvironment
import Crypto.DefaultTelefonicaPassword
import Network.NetworkManager.Wifi

installHandlers :: CEnv -> IO()
installHandlers cenv = void $
  timeoutAdd (condition cenv >> return True) 5000

condition :: CEnv -> IO ()
condition cenv = void $ forkIO $ do
  let pm = model cenv
  list <- fmap (filter isCrackeableWifi) $ getDetectedWifis
             
  curList  <- getWifiList pm
  flip mapM_ list $ \e -> when (e `notElem` curList) $ addWifi pm e
