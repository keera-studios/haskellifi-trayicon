-- | Returns a list of wifis by running nmcli
-- (Network Manager's command line interface)
--
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Network.NetworkManager.Wifi where

import Data.Maybe
import HSH.Command
import Text.Parsec

-- Returns a list of detected wifis. Each 'wifi' is composed of two elements:
-- the essid and the bssid
getDetectedWifis :: IO [ (String, String) ]
getDetectedWifis = do
  s <- tryEC $ run ("nmcli", ["-f", "ssid,bssid", "dev", "wifi", "list"])
  let s'  = either (const "") id s
      s'' = tail $ lines s'

  -- Get the essid and MAC for each wifi
  let pairs = map getESSIDAndBSSID s''
  return $ catMaybes pairs

-- Parse the essid and bssid
getESSIDAndBSSID :: String -> Maybe (String, String)
getESSIDAndBSSID s =
   case parse nmcliLine "(stdin)" s of
            Left _e -> Nothing
            Right r -> Just r

-- Parses one line of nmcli output
nmcliLine = do
  essid <- quotedName
  separators
  bssid <- textWithoutSpaces
  return (essid, bssid)

-- Parses a string between simple quotes
quotedName = do
  char '\''
  content <- many (noneOf "\'")
  char '\''
  return content

-- Parses text with no blanks
textWithoutSpaces = many (noneOf " \t\r\n")

-- A string of spaces and/or tabs
separators = many (char ' ' <|> char '\t')
