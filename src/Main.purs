module Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (logShow)
import Effect.Console (log)
import Euler (answer)

main :: Effect Unit
main = do
  log "Welcome to the counter!"
  logShow answer
  