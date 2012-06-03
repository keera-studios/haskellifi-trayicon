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

getNetworkDetectedWifis :: IO [ (String, String ) ]
getNetworkDetectedWifis = do
  ifaces <- getNetworkInterfaceList
  wifis  <- mapM getNetworkDetectedWifisForIface ifaces
  return $ concat wifis

getNetworkInterfaceList :: IO [ String ]
getNetworkInterfaceList = do
  s <- run $ ("ifconfig", ["-a", "-s"])
  let ifaceLines = tail $ lines s
  return $ map (takeWhile (/= ' ')) ifaceLines

getNetworkDetectedWifisForIface :: String -> IO [ (String, String) ]
getNetworkDetectedWifisForIface s = do
  s <- tryEC $ run $ ("iwlist", [s, "scan"])
  let s'   = either (const "") id s
      s''  = filter isRelevantField $ lines s'
      addresses = catMaybes $ map getAddress s''
      essids    = catMaybes $ map getESSID s''
  return $ zip essids addresses
  where isRelevantField text = any (`isInfixOf` text) relevantFields
        relevantFields  = [ fieldAddress, fieldESSID ]

getField :: String -> String -> Maybe String
getField _ [] = Nothing
getField field s@(_:xs)
 | field `isPrefixOf` s = stripPrefix field s
 | field `isInfixOf` s  = getField field xs
 | otherwise            = Nothing

getAddress :: String -> Maybe String
getAddress = getField fieldAddress
    
getESSID :: String -> Maybe String
getESSID = ( fmap ( tailSafe . initSafe ) ) . ( getField fieldESSID )

fieldAddress, fieldESSID :: String
fieldAddress = " - Address: "
fieldESSID   = "ESSID:"
