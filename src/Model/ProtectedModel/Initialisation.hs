-- |
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Model.ProtectedModel.Initialisation where

import qualified Model.ReactiveModel as RM
import Model.ProtectedModel.ProtectedModelInternals

initialiseSystem :: ProtectedModel -> IO ()
initialiseSystem pm = applyToReactiveModel pm RM.initialiseSystem
