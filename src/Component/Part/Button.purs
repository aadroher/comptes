module Comptes.Component.Part.Button where

import Prelude
import Data.Array ((:))
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP

type ButtonProps a
  = { label :: String
    , action :: a
    , classNames :: Array String
    }

button ::
  forall props action.
  ButtonProps action -> HH.HTML props action
button { label, action, classNames } =
  HH.button
    [ HP.classes (HH.ClassName <$> "button" : classNames)
    , HE.onClick \_ -> action
    ]
    [ HH.text label ]
