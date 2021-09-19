module Page.Home exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Route exposing (Route(..))
import View


view : { title : String, body : Element msg }
view =
    { title = ""
    , body =
        column
            [ width fill ]
            [ row
                [ width fill
                , padding 16
                , Background.color View.green
                ]
                [ el
                    [ centerX
                    , Font.color View.paperWhite
                    , Font.bold
                    , Font.size 24
                    ]
                    (text "Basic Computer Games")
                ]
            , View.body
                [ column
                    [ spacing 16, width fill ]
                    [ paragraph
                        [ Border.widthEach
                            { top = 0
                            , bottom = 3
                            , left = 0
                            , right = 0
                            }
                        , padding 32
                        ]
                        [ text "A collection of games based on those found in the "
                        , View.newTabLink
                            []
                            { label = text "BASIC Computer Games book"
                            , url = "https://www.atariarchives.org/basicgames/index.php"
                            }
                        , text ", published in 1978. These games were originally written in "
                        , View.newTabLink
                            []
                            { label = text "BASIC"
                            , url = "https://en.wikipedia.org/wiki/BASIC"
                            }
                        , text " and I've ported them, roughly, to "
                        , View.newTabLink
                            []
                            { label = text "Elm"
                            , url = "https://elm-lang.org/"
                            }
                        , text "."
                        ]
                    , View.link
                        []
                        { label = text "Acey Ducey"
                        , url = Route.toString AceyDucey
                        }
                    ]
                ]
            ]
    }
