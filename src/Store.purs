module Comptes.Store where

import Prelude
import Data.List (List, (:))

data LogLevel
  = Dev
  | Prod

derive instance eqLogLevel :: Eq LogLevel

derive instance ordLogLevel :: Ord LogLevel

data Action
  = Increment
  | Decrement

type CounterStore
  = { counterActions :: List Action
    }

type Store
  = { logLevel :: LogLevel
    , counter :: CounterStore
    }

reduceCounter :: CounterStore -> Action -> CounterStore
reduceCounter store action = store { counterActions = action : store.counterActions }

reduce :: Store -> Action -> Store
reduce store action = store { counter = reduceCounter store.counter action }
