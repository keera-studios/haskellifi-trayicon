-- |
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Model.ReactiveModel.ModelEvents
  ( ModelEvent ( WifiListChanged
               , Initialised
               )
  ) where

-- import GenericModel.GenericModelEvent
import qualified Hails.MVC.Model.ReactiveModel as GRM

data ModelEvent = UncapturedEvent
                | WifiListChanged
                | Initialised
 deriving (Eq,Ord)

instance GRM.Event ModelEvent where
  undoStackChangedEvent = UncapturedEvent
