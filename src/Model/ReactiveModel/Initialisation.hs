-- |
-- Copyright   : (C) Ivan Perez trading as Keera Studios, 2012
-- License     : BSD3
-- Maintainer  : support@keera.co.uk

module Model.ReactiveModel.Initialisation where

import Model.ReactiveModel.ReactiveModelInternals
import Model.ReactiveModel.ModelEvents

initialiseSystem :: ReactiveModel -> ReactiveModel
initialiseSystem rm = triggerEvent rm Initialised
