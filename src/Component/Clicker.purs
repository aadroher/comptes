module Comptes.Component.Clicker where

import Prelude
import Comptes.Component.Part.Button as B
import Comptes.Store as CS
import Control.Monad.State (class MonadState)
import Data.List (List(..), (:))
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.Store.Connect (Connected, connect)
import Halogen.Store.Monad (class MonadStore, updateStore)
import Halogen.Store.Select (selectEq)

type State
  = { count :: Int
    }

data Action
  = Initialize
  | Receive (Connected (Maybe CS.Store) Unit)
  | Increment
  | Decrement

component ::
  forall q o m.
  MonadStore CS.Action CS.Store m =>
  H.Component q Unit o m
component =
  connect (selectEq pure)
    $ H.mkComponent
        { initialState: \_ -> { count: 10 }
        , render
        , eval:
            H.mkEval
              H.defaultEval
                { handleAction = handleAction
                , receive = Just <<< Receive
                , initialize = Just Initialize
                }
        }

calculateResult :: Int -> List CS.Action -> Int
calculateResult n actions = case actions of
  Nil -> n
  (CS.Increment : as) -> calculateResult (n + 1) as
  (CS.Decrement : as) -> calculateResult (n - 1) as

count :: CS.Store -> Int
count { counter: { counterActions } } = calculateResult 0 counterActions

render :: forall cs m. State -> H.ComponentHTML Action cs m
render state =
  HH.div [ HP.classes [ HH.ClassName "button-container" ] ]
    $ [ HH.p_
          [ HH.text $ "Count is: " <> show state.count ]
      , B.button { label: "Increment", action: Increment, classNames: [ "increment" ] }
      , B.button { label: "Decrement", action: Decrement, classNames: [ "decrement" ] }
      ]

handleAction ::
  forall s m.
  MonadState State m =>
  MonadStore CS.Action s m =>
  Action ->
  m Unit
handleAction = case _ of
  Initialize -> H.modify_ \st -> st { count = -2 }
  Receive { context: maybeStore } -> case maybeStore of
    Just store -> H.modify_ \st -> st { count = count store }
    Nothing -> H.modify_ \s -> s
  Increment -> updateStore CS.Increment
  Decrement -> updateStore CS.Decrement
