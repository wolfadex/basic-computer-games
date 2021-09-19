module Route exposing (..)

import Url exposing (Url)
import Url.Parser


type Route
    = Home
    | AceyDucey
    | NotFound Url


fromUrl : Url -> Route
fromUrl url =
    Url.Parser.parse parser url
        |> Maybe.withDefault (NotFound url)


parser : Url.Parser.Parser (Route -> a) a
parser =
    Url.Parser.oneOf
        [ Url.Parser.map Home Url.Parser.top
        , Url.Parser.map AceyDucey (Url.Parser.s "acey-ducey")
        ]


toString : Route -> String
toString route =
    case route of
        Home ->
            "/"

        NotFound url ->
            "/"

        AceyDucey ->
            "acey-ducey"
