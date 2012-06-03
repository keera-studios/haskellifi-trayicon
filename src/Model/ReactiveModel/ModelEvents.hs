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
