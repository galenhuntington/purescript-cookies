## Module Web.Cookies

#### `COOKIE`

``` purescript
data COOKIE :: Effect
```

#### `setCookie`

``` purescript
setCookie :: forall eff value opts. String -> value -> opts -> Eff (cookie :: COOKIE | eff) Unit
```

Set cookie with specified name and value. Last argument (opts) is a map of optional arguments such as expiration time

#### `setSimpleCookie`

``` purescript
setSimpleCookie :: forall eff value opts. String -> value -> Eff (cookie :: COOKIE | eff) Unit
```

Set cookie with specified name and value and default options.

#### `getCookie`

``` purescript
getCookie :: forall eff value. String -> Eff (cookie :: COOKIE | eff) (Maybe value)
```

#### `deleteCookie`

``` purescript
deleteCookie :: forall eff. String -> Eff (cookie :: COOKIE | eff) Unit
```

 Delete cookie with specified name

