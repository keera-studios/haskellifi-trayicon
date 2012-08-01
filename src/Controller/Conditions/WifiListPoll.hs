-- | Updates the wifi list regularly (every 5 seconds), selecting only those
-- wifis for which a password can be suggested.
--
-- This is an IO => Model condition. It modifies the model from a concurrent
-- thread. It does not interact with the view in any way.
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
  -- Get List of wifis
  list <- fmap (filter isCrackeableWifi) getDetectedWifis
             
  -- Add only those that aren't present in the list already
  let pm = model cenv
  curList <- getWifiList pm
  forM_ list $ \e -> when (e `notElem` curList) $ addWifi pm e
