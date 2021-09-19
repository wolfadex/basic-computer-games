module View exposing (..)

import Element exposing (Attribute, Color, Element)
import Element.Background as Background
import Element.Font as Font
import Route exposing (Route(..))


header : String -> Element msg
header title =
    Element.row
        [ Element.width Element.fill
        , Element.padding 16
        , Element.inFront
            (Element.el
                [ Element.centerX
                , Element.paddingXY 0 16
                , Font.color paperWhite
                , Font.bold
                , Font.size 24
                ]
                (Element.text title)
            )
        , Background.color green
        ]
        [ link
            [ Element.alignLeft
            , Font.color paperWhite
            ]
            { label = Element.text "Home"
            , url = Route.toString Route.Home
            }
        ]


body : List (Element msg) -> Element msg
body =
    Element.column
        [ Element.width Element.fill
        , Element.height Element.fill
        , Element.padding 16
        ]


link : List (Attribute msg) -> { label : Element msg, url : String } -> Element msg
link attrs =
    Element.link
        ([ Font.underline
         , Font.color linkBlue
         ]
            ++ attrs
        )


newTabLink : List (Attribute msg) -> { url : String, label : Element msg } -> Element msg
newTabLink attrs =
    Element.newTabLink
        ([ Font.underline
         , Font.color linkBlue
         ]
            ++ attrs
        )


paperWhite : Color
paperWhite =
    Element.rgb 0.85 0.85 0.7


green : Color
green =
    Element.rgb 0.2 0.7 0.6


linkBlue : Color
linkBlue =
    Element.rgb 0.1 0.2 0.9
