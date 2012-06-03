module Model.Model where

type BasicModel = Model

data Model = Model
 { curWifiList :: [ ( String, String ) ] }
 deriving (Eq)

emptyBM :: Model
emptyBM = Model
 { curWifiList = [ ] }
