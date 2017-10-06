module Example.Transform where

import Java

import Control.Lens
import Data.Aeson
import Data.Aeson.Lens
import Data.Text (Text)
import qualified Data.Text as T

fixJson :: JString -> JString
fixJson = toJava . transform . fromJava
  where transform :: Text -> Text
        transform json = json & (key "first_name" . _String) %~ T.toUpper
                          & (key "last_name"  . _String) %~ T.toUpper
                          & (key "events" . key "clicks" . _Integral) %~ (+ 50)

foreign export java "@static eta.example.Transform.fixJson"
  fixJson :: JString -> JString
