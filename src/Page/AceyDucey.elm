module Page.AceyDucey exposing (Model, Msg, init, update, view)

import Card exposing (Card, Deck, compareCards)
import Element exposing (..)
import Element.Input as Input
import Random
import View


type Model
    = Start
    | Dealing Int
    | Dealt DealModel
    | Show ShowModel


type alias DealModel =
    { money : Int
    , leftCard : Card
    , rightCard : Card
    , nextCard : Card
    , betAmount : String
    }


type alias ShowModel =
    { money : Int
    , leftCard : Card
    , rightCard : Card
    , nextCard : Card
    }


init : Model
init =
    Start


type Msg
    = NewGame
    | DealCards Deck
    | ChangeBet String
    | SkipBet
    | MakeBet Int
    | DealNext


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( NewGame, Start ) ->
            dealNewHand 100

        ( NewGame, Show _ ) ->
            dealNewHand 100

        ( DealCards (leftCard :: rightCard :: nextCard :: _), Dealing money ) ->
            ( Dealt
                { money = money
                , leftCard = leftCard
                , rightCard = rightCard
                , nextCard = nextCard
                , betAmount = "0"
                }
            , Cmd.none
            )

        ( ChangeBet amount, Dealt state ) ->
            ( Dealt { state | betAmount = amount }
            , Cmd.none
            )

        ( SkipBet, Dealt state ) ->
            dealNewHand state.money

        ( MakeBet bet, Dealt state ) ->
            case ( compareCards state.nextCard state.leftCard, compareCards state.nextCard state.rightCard ) of
                ( GT, LT ) ->
                    updateBet bet state

                ( LT, GT ) ->
                    updateBet bet state

                _ ->
                    updateBet (-1 * bet) state

        ( DealNext, Show state ) ->
            dealNewHand state.money

        _ ->
            ( model, Cmd.none )


updateBet : Int -> DealModel -> ( Model, Cmd Msg )
updateBet amount state =
    ( Show
        { money = state.money + amount
        , leftCard = state.leftCard
        , rightCard = state.rightCard
        , nextCard = state.nextCard
        }
    , Cmd.none
    )


dealNewHand : Int -> ( Model, Cmd Msg )
dealNewHand money =
    ( Dealing money
    , Random.generate
        DealCards
        (Card.shuffleDeck Card.newDeck)
    )


view : Model -> { title : String, body : Element Msg }
view model =
    { title = "Acey Ducey"
    , body =
        column [ width fill ]
            [ View.header "Acey Ducey"
            , View.body
                [ case model of
                    Start ->
                        viewStart

                    Dealing _ ->
                        viewDealing

                    Dealt state ->
                        viewDeal state

                    Show state ->
                        viewShow state
                ]
            ]
    }


viewStart : Element Msg
viewStart =
    column
        [ spacing 64, width fill ]
        [ paragraph
            []
            [ text instructions ]
        , View.button
            (centerX :: View.buttonPrimary)
            { label = text "New Game"
            , onPress = Just NewGame
            }
        ]


instructions : String
instructions =
    """Acey Ducey is played in the following manner. The dealer (computer) deals 2 cards face up. You have an option to bet or pass depending on whether or not you feel the next card will have a value between the first 2. You start with $100."""


viewDealing : Element Msg
viewDealing =
    text "Dealing..."


viewDeal : DealModel -> Element Msg
viewDeal model =
    let
        ( betError, betAmount ) =
            if String.isEmpty model.betAmount then
                ( Nothing, 0 )

            else
                case String.toInt model.betAmount of
                    Nothing ->
                        ( Just "A bet must be a valid dollar amount", 0 )

                    Just amount ->
                        if amount > model.money then
                            ( Just "You can't bet more than you have", amount )

                        else
                            ( Nothing, amount )
    in
    column
        [ spacing 16 ]
        [ row
            []
            [ Card.viewCardBack "deck of cards"
            , Card.viewCard model.leftCard
            , Card.viewCard model.rightCard
            ]
        , Card.viewCardBack "next card"
        , text ("$" ++ String.fromInt model.money ++ " remaining")
        , Input.text
            []
            { label = Input.labelLeft [] (text "Bet Amount")
            , placeholder = Nothing
            , text = model.betAmount
            , onChange = ChangeBet
            }
        , row
            [ spacing 16 ]
            [ View.button
                (alignTop :: View.buttonSecondary)
                { label = text "Pass"
                , onPress = Just SkipBet
                }
            , column
                []
                [ View.button
                    View.buttonPrimary
                    { label = text "Bet"
                    , onPress =
                        case betError of
                            Nothing ->
                                Just (MakeBet betAmount)

                            Just _ ->
                                Nothing
                    }
                , case betError of
                    Nothing ->
                        none

                    Just err ->
                        text err
                ]
            ]
        ]


viewShow : ShowModel -> Element Msg
viewShow model =
    column
        [ spacing 16 ]
        [ row
            []
            [ Card.viewCardBack "deck of cards"
            , Card.viewCard model.leftCard
            , Card.viewCard model.rightCard
            ]
        , Card.viewCard model.nextCard
        , text ("$" ++ String.fromInt model.money ++ " remaining")
        , if model.money > 0 then
            View.button
                View.buttonPrimary
                { label = text "Deal"
                , onPress = Just DealNext
                }

          else
            View.button
                View.buttonPrimary
                { label = text "New Game"
                , onPress = Just NewGame
                }
        ]
