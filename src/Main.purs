module Main where

import Prelude
import Comptes.Component.Clicker as Clicker
import Effect (Effect)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Comptes.Store (LogLevel(..), Store)
import Comptes.AppM (runAppM)
import Data.List.Types (List(..))

main :: Effect Unit
main =
  HA.runHalogenAff do
    body <- HA.awaitBody
    let
      initialStore :: Store
      initialStore = { logLevel: Dev, counter: { counterActions: Nil } }
    rootComponent <- runAppM initialStore Clicker.component
    runUI rootComponent unit body
