module Web.Cookies (
           setCookie
         , setSimpleCookie
         , getCookie
         , deleteCookie
         , deleteSimpleCookie
         , CookiesOptions
         , path
         , domain
         , expires
         -- , expires' -- not exporting for now
         , secure
         ) where

import Prelude
import Effect (Effect)
import Data.Maybe (Maybe(..))
import Data.Options (Option, Options, options, opt, (:=))
import Data.JSDate (JSDate)

foreign import data CookiesOptions :: Type

-- Following are the available cookies options
--

path :: Option CookiesOptions String
path = opt "path"

domain :: Option CookiesOptions String
domain = opt "domain"

expires :: Option CookiesOptions JSDate
expires = opt "expires"

--  Needs better name.
expires' :: Option CookiesOptions Int
expires' = opt "expires"

secure :: Option CookiesOptions Boolean
secure = opt "secure"
       
       
foreign import _setCookie :: forall value opts. String -> value -> opts -> Effect Unit

foreign import _getCookie :: forall value. String -> Effect (Array value)

-- |  Get cookie with specified name.
getCookie :: forall value. String -> Effect (Maybe value)
getCookie key = do
    cook <- _getCookie key
    prepare cook
    where prepare [value] = pure $ Just value
          prepare _ = pure Nothing

-- | Set cookie with specified name and value. Last argument (opts) is a map of optional arguments such as expiration time.
setCookie :: forall value. String -> value -> Options CookiesOptions -> Effect Unit
setCookie name value opts = _setCookie name value $ options opts

-- | Set cookie with specified name and value. No options to the cookie are specified.
setSimpleCookie :: forall value. String -> value -> Effect Unit
setSimpleCookie name value = setCookie name value mempty

-- | Delete cookie with specified name and options.
deleteCookie :: String -> Options CookiesOptions -> Effect Unit
deleteCookie name opts = setCookie name "" $ opts <> expires' := -1

-- | Delete cookie with specified name. No options to the cookie are specified.
deleteSimpleCookie :: String -> Effect Unit
deleteSimpleCookie name = deleteCookie name mempty
