module Card exposing (Card, Deck, Face(..), Suit(..), compareCards, newDeck, shuffleDeck, viewCard, viewCardBack)

import Element exposing (Color, Element)
import Element.Background
import Element.Font
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
    viewWrapper <|
        case ( card.face, card.suit ) of
            -- Spades
            ( Ace, Spade ) ->
                ( Element.rgb 0 0 0, "🂡" )

            ( Two, Spade ) ->
                ( Element.rgb 0 0 0, "🂢" )

            ( Three, Spade ) ->
                ( Element.rgb 0 0 0, "🂣" )

            ( Four, Spade ) ->
                ( Element.rgb 0 0 0, "🂤" )

            ( Five, Spade ) ->
                ( Element.rgb 0 0 0, "🂥" )

            ( Six, Spade ) ->
                ( Element.rgb 0 0 0, "🂦" )

            ( Seven, Spade ) ->
                ( Element.rgb 0 0 0, "🂧" )

            ( Eight, Spade ) ->
                ( Element.rgb 0 0 0, "🂨" )

            ( Nine, Spade ) ->
                ( Element.rgb 0 0 0, "🂩" )

            ( Ten, Spade ) ->
                ( Element.rgb 0 0 0, "🂪" )

            ( Jack, Spade ) ->
                ( Element.rgb 0 0 0, "🂫" )

            ( Queen, Spade ) ->
                ( Element.rgb 0 0 0, "🂭" )

            ( King, Spade ) ->
                ( Element.rgb 0 0 0, "🂮" )

            -- Hearts
            ( Ace, Heart ) ->
                ( Element.rgb 1 0 0, "🂱" )

            ( Two, Heart ) ->
                ( Element.rgb 1 0 0, "🂲" )

            ( Three, Heart ) ->
                ( Element.rgb 1 0 0, "🂳" )

            ( Four, Heart ) ->
                ( Element.rgb 1 0 0, "🂴" )

            ( Five, Heart ) ->
                ( Element.rgb 1 0 0, "🂵" )

            ( Six, Heart ) ->
                ( Element.rgb 1 0 0, "🂶" )

            ( Seven, Heart ) ->
                ( Element.rgb 1 0 0, "🂷" )

            ( Eight, Heart ) ->
                ( Element.rgb 1 0 0, "🂸" )

            ( Nine, Heart ) ->
                ( Element.rgb 1 0 0, "🂹" )

            ( Ten, Heart ) ->
                ( Element.rgb 1 0 0, "🂺" )

            ( Jack, Heart ) ->
                ( Element.rgb 1 0 0, "🂻" )

            ( Queen, Heart ) ->
                ( Element.rgb 1 0 0, "🂽" )

            ( King, Heart ) ->
                ( Element.rgb 1 0 0, "🂾" )

            -- Clubs
            ( Ace, Club ) ->
                ( Element.rgb 0 0 0, "🃑" )

            ( Two, Club ) ->
                ( Element.rgb 0 0 0, "🃒" )

            ( Three, Club ) ->
                ( Element.rgb 0 0 0, "🃓" )

            ( Four, Club ) ->
                ( Element.rgb 0 0 0, "🃔" )

            ( Five, Club ) ->
                ( Element.rgb 0 0 0, "🃕" )

            ( Six, Club ) ->
                ( Element.rgb 0 0 0, "🃖" )

            ( Seven, Club ) ->
                ( Element.rgb 0 0 0, "🃗" )

            ( Eight, Club ) ->
                ( Element.rgb 0 0 0, "🃘" )

            ( Nine, Club ) ->
                ( Element.rgb 0 0 0, "🃙" )

            ( Ten, Club ) ->
                ( Element.rgb 0 0 0, "🃚" )

            ( Jack, Club ) ->
                ( Element.rgb 0 0 0, "🃛" )

            ( Queen, Club ) ->
                ( Element.rgb 0 0 0, "🃝" )

            ( King, Club ) ->
                ( Element.rgb 0 0 0, "🃞" )

            -- Diamonds
            ( Ace, Diamond ) ->
                ( Element.rgb 1 0 0, "🃁" )

            ( Two, Diamond ) ->
                ( Element.rgb 1 0 0, "🃂" )

            ( Three, Diamond ) ->
                ( Element.rgb 1 0 0, "🃃" )

            ( Four, Diamond ) ->
                ( Element.rgb 1 0 0, "🃄" )

            ( Five, Diamond ) ->
                ( Element.rgb 1 0 0, "🃅" )

            ( Six, Diamond ) ->
                ( Element.rgb 1 0 0, "🃆" )

            ( Seven, Diamond ) ->
                ( Element.rgb 1 0 0, "🃇" )

            ( Eight, Diamond ) ->
                ( Element.rgb 1 0 0, "🃈" )

            ( Nine, Diamond ) ->
                ( Element.rgb 1 0 0, "🃉" )

            ( Ten, Diamond ) ->
                ( Element.rgb 1 0 0, "🃊" )

            ( Jack, Diamond ) ->
                ( Element.rgb 1 0 0, "🃋" )

            ( Queen, Diamond ) ->
                ( Element.rgb 1 0 0, "🃍" )

            ( King, Diamond ) ->
                ( Element.rgb 1 0 0, "🃎" )


viewCardBack : Element msg
viewCardBack =
    viewWrapper ( Element.rgb 0.65 0 1, "🂠" )


viewWrapper : ( Color, String ) -> Element msg
viewWrapper ( color, cardText ) =
    Element.el
        [ Element.Font.size 128
        , Element.Font.color color
        , Element.Background.color (Element.rgb 1 1 1)
        ]
        (Element.text cardText)


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
