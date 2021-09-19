module Page.NotFound exposing (view)

import Element exposing (..)
import Url exposing (Url)


view : Url -> { title : String, body : Element msg }
view url =
    { title = "Not Found"
    , body = text ("\"" ++ url.path ++ "\" Not Found")
    }
