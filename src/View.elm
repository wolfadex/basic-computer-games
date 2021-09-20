module View exposing (body, button, buttonPrimary, buttonSecondary, green, header, link, newTabLink, paperWhite)

import Element exposing (Attribute, Color, Element)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region
import Element.Input
import Route



-- LAYOUT


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
        , Region.navigation
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
        [ Element.width (Element.fill |> Element.maximum 600)
        , Element.height Element.fill
        , Element.padding 16
        , Element.centerX
        ]



-- ELEMENTS


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


button : List (Attribute msg) -> { onPress : Maybe msg, label : Element msg } -> Element msg
button attrs config =
    Element.Input.button
        (Element.paddingXY 16 8 :: attrs)
        config



-- STYLES


buttonPrimary : List (Element.Attr decorative msg)
buttonPrimary =
    [ Background.color green
    , Font.color paperWhite
    ]


buttonSecondary : List (Element.Attr decorative msg)
buttonSecondary =
    [ Background.color linkBlue
    , Font.color paperWhite
    ]



-- COLOR


paperWhite : Color
paperWhite =
    Element.rgb255 0xF9 0xFB 0xFF


green : Color
green =
    Element.rgb 0.2 0.7 0.6


linkBlue : Color
linkBlue =
    Element.rgb 0.1 0.2 0.9
