-- | Get the wifi list from iwconfig.
module Network.Wifi.Iwconfig
   ( getNetworkDetectedWifis )
  where

import Data.List
import Data.Maybe
import Data.Either
import Control.Arrow
import Control.Monad
import HSH.Command
import Data.Hash.MD5
import Safe (tailSafe, initSafe)
import Text.Parsec

-- | Get the list of wifis from iwconfig
getNetworkDetectedWifis :: IO [ (String, String ) ]
getNetworkDetectedWifis = do
  ifaces <- getNetworkInterfaceList
  wifis  <- mapM getNetworkDetectedWifisForIface ifaces
  return $ concat wifis

-- | Get the list if interfaces (using ifconfig)
getNetworkInterfaceList :: IO [ String ]
getNetworkInterfaceList = do
  s <- run ("ifconfig", ["-a", "-s"])
  let ifaceLines = tail $ lines s
  return $ map (takeWhile (/= ' ')) ifaceLines

-- | Get the list of wifis detected by a given network interface
-- (For each wifi, include name and MAC)
getNetworkDetectedWifisForIface :: String -> IO [ (String, String) ]
getNetworkDetectedWifisForIface s = do
  -- Get the list of wifis and select only those lines that we need
  s <- tryEC $ run ("iwlist", [s, "scan"])
  let s'   = either (const "") id s
      s''  = filter isRelevantField $ lines s'
  
  -- Parse the lists and select the addresses and essids
  let addresses = mapMaybe getAddress s''
      essids    = mapMaybe getESSID s''

  -- Pair them up and return that list
  return $ zip essids addresses

  where isRelevantField text = any (`isInfixOf` text) relevantFields
        relevantFields  = [ fieldAddress, fieldESSID ]

-- | Parse a string and get a field that begins with a specific
-- text (if any)
getField :: String -> String -> Maybe String
getField _ [] = Nothing
getField field s@(_:xs)
 | field `isPrefixOf` s = stripPrefix field s
 | field `isInfixOf` s  = getField field xs
 | otherwise            = Nothing

-- | Get the address field
getAddress :: String -> Maybe String
getAddress = getField fieldAddress
    
-- | Get the ESSID field
getESSID :: String -> Maybe String
getESSID = fmap ( tailSafe . initSafe ) . getField fieldESSID

-- | Field prefixes
fieldAddress, fieldESSID :: String
fieldAddress = " - Address: "
fieldESSID   = "ESSID:"
