module App.Button where

import Prelude
import Data.Array ((:))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP

data Action
  = Increment
  | Decrement

instance showAction :: Show Action where
  show Increment = "Increment"
  show Decrement = "Decrement"

type State
  = { count :: Int
    , events :: Array Action
    }

updateState :: State -> Action -> State
updateState s _ = s

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
    { initialState: \_ -> { count: 10, events: [] }
    , render
    , eval: H.mkEval H.defaultEval { handleAction = handleAction }
    }

render :: forall cs m. State -> H.ComponentHTML Action cs m
render state =
  let
    events_ = HH.div_ $ (\e -> HH.p_ [ HH.text $ show e ]) <$> state.events
  in
    HH.div [ HP.classes [ HH.ClassName "button-container" ] ]
      $ [ HH.p_
            [ HH.text $ "Count is: " <> show state.count ]
        , HH.button
            [ HE.onClick \_ -> Increment ]
            [ HH.text "Increment" ]
        , HH.button
            [ HE.onClick \_ -> Decrement ]
            [ HH.text "Decrement" ]
        , events_
        ]

handleAction :: forall cs o m. Action → H.HalogenM State Action cs o m Unit
handleAction = case _ of
  Increment -> H.modify_ \st -> st { count = st.count + 1, events = Increment : st.events }
  Decrement -> H.modify_ \st -> st { count = st.count - 1, events = Decrement : st.events }
