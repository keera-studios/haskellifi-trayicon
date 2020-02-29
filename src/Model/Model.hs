-- |
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Model.Model where

type BasicModel = Model

data Model = Model
 { curWifiList :: [ ( String, String ) ] }
 deriving (Eq)

emptyBM :: Model
emptyBM = Model
 { curWifiList = [ ] }
