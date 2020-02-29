-- |
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Model.ReactiveModel.WifiList
   ( getWifiList
   , addWifi
   , clearWifiList
   )
  where

-- Internal imports
import Model.Model
import Model.ReactiveModel.ReactiveModelInternals
import Model.ReactiveModel.ModelEvents

addWifi :: ReactiveModel -> (String, String) -> ReactiveModel
addWifi rm n = triggerEvent rm' ev
  where rm' = rm `onBasicModel` (\b -> b { curWifiList = cwl ++ [ n ] })
        cwl = curWifiList $ basicModel rm
        ev  = WifiListChanged

getWifiList :: ReactiveModel -> [ (String, String) ]
getWifiList = curWifiList . basicModel

clearWifiList :: ReactiveModel -> ReactiveModel
clearWifiList rm = triggerEvent rm' ev
  where rm' = rm `onBasicModel` (\b -> b { curWifiList = [] })
        ev  = WifiListChanged
