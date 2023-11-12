module Comptes.Store where

import Prelude
import Data.List (List(..), (:))

data LogLevel
  = Dev
  | Prod

derive instance eqLogLevel :: Eq LogLevel

derive instance ordLogLevel :: Ord LogLevel

data Action
  = Increment
  | Decrement

derive instance eqAction :: Eq Action

type CounterStore
  = { counterActions :: List Action
    }

type Store
  = { logLevel :: LogLevel
    , counter :: CounterStore
    }

calculateResult :: Int -> List Action -> Int
calculateResult n actions = case actions of
  Nil -> n
  (Increment : as) -> calculateResult (n + 1) as
  (Decrement : as) -> calculateResult (n - 1) as

count :: Store -> Int
count { counter: { counterActions } } = calculateResult 0 counterActions

reduce :: Store -> Action -> Store
reduce store action =
  store
    { counter
      { counterActions = action : store.counter.counterActions
      }
    }
