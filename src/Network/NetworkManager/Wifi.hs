-- Returns a list of wifis by running nmcli
-- (Network Manager's command line interface)
module Network.NetworkManager.Wifi where

-- import Data.List
import Data.Maybe
-- import Data.Either
-- import Control.Arrow
-- import Control.Monad
import HSH.Command
-- import Data.Hash.MD5
-- import Safe (tailSafe, initSafe)
import Text.Parsec

-- Returns a list of detected wifis. Each 'wifi' is composed of two elements:
-- the essid and the bssid
getDetectedWifis :: IO [ (String, String) ]
getDetectedWifis = do
  s <- tryEC $ run $ ("nmcli", ["-f", "ssid,bssid", "dev", "wifi", "list"])
  let s'  = either (const "") id s
      s'' = tail $ lines s'
  pairs <- return $ map getESSIDAndBSSID s''
  return $ catMaybes pairs
  
getESSIDAndBSSID :: String -> Maybe (String, String)
getESSIDAndBSSID s =
   case parse nmcliLine "(stdin)" s of
            Left _e -> Nothing
            Right r -> Just r

nmcliLine = do
  essid <- quotedName
  separators
  bssid <- textWithoutSpaces
  -- eof
  return (essid, bssid)

quotedName = do
  char '\''
  content <- many (noneOf "\'")
  char '\''
  return content

textWithoutSpaces = many (noneOf " \t\r\n")

separators = many (char ' ' <|> char '\t')
