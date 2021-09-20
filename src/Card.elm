module Card exposing (Card, Deck, Face(..), Suit(..), compareCards, newDeck, shuffleDeck, viewCard, viewCardBack)

import Element exposing (Color, Element)
import Element.Background
import Element.Font
import Element.Region
import Html.Attributes
import Random exposing (Generator)
import Random.List


type alias Deck =
    List Card


allFaces : List Face
allFaces =
    [ Ace
    , Two
    , Three
    , Four
    , Five
    , Six
    , Seven
    , Eight
    , Nine
    , Ten
    , Jack
    , Queen
    , King
    ]


allSuits : List Suit
allSuits =
    [ Spade
    , Heart
    , Club
    , Diamond
    ]


newDeck : Deck
newDeck =
    List.foldl
        (\suit deck ->
            List.map (\face -> { face = face, suit = suit }) allFaces
                ++ deck
        )
        []
        allSuits


shuffleDeck : Deck -> Generator Deck
shuffleDeck =
    Random.List.shuffle


type Face
    = Ace
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Ten
    | Jack
    | Queen
    | King


type Suit
    = Spade
    | Heart
    | Club
    | Diamond


type alias Card =
    { face : Face
    , suit : Suit
    }


viewCard : Card -> Element msg
viewCard card =
    viewWrapper
        { content =
            case ( card.face, card.suit ) of
                -- Spades
                ( Ace, Spade ) ->
                    "🂡"

                ( Two, Spade ) ->
                    "🂢"

                ( Three, Spade ) ->
                    "🂣"

                ( Four, Spade ) ->
                    "🂤"

                ( Five, Spade ) ->
                    "🂥"

                ( Six, Spade ) ->
                    "🂦"

                ( Seven, Spade ) ->
                    "🂧"

                ( Eight, Spade ) ->
                    "🂨"

                ( Nine, Spade ) ->
                    "🂩"

                ( Ten, Spade ) ->
                    "🂪"

                ( Jack, Spade ) ->
                    "🂫"

                ( Queen, Spade ) ->
                    "🂭"

                ( King, Spade ) ->
                    "🂮"

                -- Hearts
                ( Ace, Heart ) ->
                    "🂱"

                ( Two, Heart ) ->
                    "🂲"

                ( Three, Heart ) ->
                    "🂳"

                ( Four, Heart ) ->
                    "🂴"

                ( Five, Heart ) ->
                    "🂵"

                ( Six, Heart ) ->
                    "🂶"

                ( Seven, Heart ) ->
                    "🂷"

                ( Eight, Heart ) ->
                    "🂸"

                ( Nine, Heart ) ->
                    "🂹"

                ( Ten, Heart ) ->
                    "🂺"

                ( Jack, Heart ) ->
                    "🂻"

                ( Queen, Heart ) ->
                    "🂽"

                ( King, Heart ) ->
                    "🂾"

                -- Clubs
                ( Ace, Club ) ->
                    "🃑"

                ( Two, Club ) ->
                    "🃒"

                ( Three, Club ) ->
                    "🃓"

                ( Four, Club ) ->
                    "🃔"

                ( Five, Club ) ->
                    "🃕"

                ( Six, Club ) ->
                    "🃖"

                ( Seven, Club ) ->
                    "🃗"

                ( Eight, Club ) ->
                    "🃘"

                ( Nine, Club ) ->
                    "🃙"

                ( Ten, Club ) ->
                    "🃚"

                ( Jack, Club ) ->
                    "🃛"

                ( Queen, Club ) ->
                    "🃝"

                ( King, Club ) ->
                    "🃞"

                -- Diamonds
                ( Ace, Diamond ) ->
                    "🃁"

                ( Two, Diamond ) ->
                    "🃂"

                ( Three, Diamond ) ->
                    "🃃"

                ( Four, Diamond ) ->
                    "🃄"

                ( Five, Diamond ) ->
                    "🃅"

                ( Six, Diamond ) ->
                    "🃆"

                ( Seven, Diamond ) ->
                    "🃇"

                ( Eight, Diamond ) ->
                    "🃈"

                ( Nine, Diamond ) ->
                    "🃉"

                ( Ten, Diamond ) ->
                    "🃊"

                ( Jack, Diamond ) ->
                    "🃋"

                ( Queen, Diamond ) ->
                    "🃍"

                ( King, Diamond ) ->
                    "🃎"
        , color = getCardColor card
        , accessibleName = getCardName card
        }


getCardName : Card -> String
getCardName { suit, face } =
    getFaceName face ++ " of " ++ getSuitNamePlural suit


getFaceName : Face -> String
getFaceName face =
    case face of
        Ace ->
            "Ace"

        Two ->
            "Two"

        Three ->
            "Three"

        Four ->
            "Four"

        Five ->
            "Five"

        Six ->
            "Six"

        Seven ->
            "Seven"

        Eight ->
            "Eight"

        Nine ->
            "Nine"

        Ten ->
            "Ten"

        Jack ->
            "Jack"

        Queen ->
            "Queen"

        King ->
            "King"


getSuitNamePlural : Suit -> String
getSuitNamePlural suit =
    case suit of
        Spade ->
            "Spades"

        Club ->
            "Clubs"

        Heart ->
            "Hearts"

        Diamond ->
            "Diamonds"


getCardColor : Card -> Color
getCardColor { suit } =
    case suit of
        Spade ->
            Element.rgb 0 0 0

        Club ->
            Element.rgb 0 0 0

        Heart ->
            Element.rgb 1 0 0

        Diamond ->
            Element.rgb 1 0 0


viewCardBack : String -> Element msg
viewCardBack accessibleName =
    viewWrapper
        { color = Element.rgb 0.65 0 1
        , content = "🂠"
        , accessibleName = accessibleName
        }


viewWrapper : { color : Color, content : String, accessibleName : String } -> Element msg
viewWrapper { color, content, accessibleName } =
    Element.el
        [ Element.Font.size 128
        , Element.Font.color color
        , Element.Background.color (Element.rgb 1 1 1)
        , Element.htmlAttribute (Html.Attributes.tabindex 0)
        , Element.Region.description accessibleName
        ]
        (Element.text content)


compareCards : Card -> Card -> Order
compareCards left right =
    case ( left.face, right.face ) of
        ( Ace, Ace ) ->
            EQ

        ( Ace, _ ) ->
            LT

        ( _, Ace ) ->
            GT

        ( Two, Two ) ->
            EQ

        ( Two, _ ) ->
            LT

        ( _, Two ) ->
            GT

        ( Three, Three ) ->
            EQ

        ( Three, _ ) ->
            LT

        ( _, Three ) ->
            GT

        ( Four, Four ) ->
            EQ

        ( Four, _ ) ->
            LT

        ( _, Four ) ->
            GT

        ( Five, Five ) ->
            EQ

        ( Five, _ ) ->
            LT

        ( _, Five ) ->
            GT

        ( Six, Six ) ->
            EQ

        ( Six, _ ) ->
            LT

        ( _, Six ) ->
            GT

        ( Seven, Seven ) ->
            EQ

        ( Seven, _ ) ->
            LT

        ( _, Seven ) ->
            GT

        ( Eight, Eight ) ->
            EQ

        ( Eight, _ ) ->
            LT

        ( _, Eight ) ->
            GT

        ( Nine, Nine ) ->
            EQ

        ( Nine, _ ) ->
            LT

        ( _, Nine ) ->
            GT

        ( Ten, Ten ) ->
            EQ

        ( Ten, _ ) ->
            LT

        ( _, Ten ) ->
            GT

        ( Jack, Jack ) ->
            EQ

        ( Jack, _ ) ->
            LT

        ( _, Jack ) ->
            GT

        ( Queen, Queen ) ->
            EQ

        ( Queen, _ ) ->
            LT

        ( _, Queen ) ->
            GT

        ( King, King ) ->
            EQ
