module Main exposing (main)

{-| Games from the book Basic Computer Games found in the archive <https://www.atariarchives.org/basicgames/index.php>
-}

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Navigation
import Element exposing (..)
import Page.AceyDucey as AceyDucey
import Page.Home as Home
import Page.NotFound as NotFound
import Route exposing (Route(..))
import Url exposing (Url)
import Url.Parser exposing ((</>))


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }


type alias Flags =
    ()


type alias Model =
    { key : Navigation.Key
    , page : Page
    }


type Page
    = HomePage
    | NotFoundPage Url
    | AceyDuceyPage AceyDucey.Model


init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key
      , page =
            url
                |> Route.fromUrl
                |> pageFromRoute
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type Msg
    = NoOp
    | ChangedUrl Url
    | ClickedLink UrlRequest
    | AceyDuceyMessage AceyDucey.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( ChangedUrl url, _ ) ->
            ( { model
                | page =
                    url
                        |> Route.fromUrl
                        |> pageFromRoute
              }
            , Cmd.none
            )

        ( ClickedLink urlRequest, _ ) ->
            ( model
            , case urlRequest of
                Internal url ->
                    Navigation.pushUrl model.key (Url.toString url)

                External url ->
                    Navigation.load url
            )

        ( AceyDuceyMessage message, AceyDuceyPage m ) ->
            let
                ( newAceyDuceyModel, cmds ) =
                    AceyDucey.update message m
            in
            ( { model | page = AceyDuceyPage newAceyDuceyModel }
            , Cmd.map AceyDuceyMessage cmds
            )

        _ ->
            ( model, Cmd.none )


pageFromRoute : Route -> Page
pageFromRoute route =
    case route of
        Home ->
            HomePage

        NotFound url ->
            NotFoundPage url

        AceyDucey ->
            AceyDuceyPage AceyDucey.init



-- updateWith :
--     (subModel -> Model)
--     -> (subMsg -> Msg)
--     -> Model
--     -> ( subModel, Cmd subMsg )
--     -> ( Model, Cmd Msg )
-- updateWith toModel toMsg model ( subModel, subCmd ) =
--     ( toModel subModel
--     , Cmd.map toMsg subCmd
--     )


view : Model -> Document Msg
view model =
    (case model.page of
        HomePage ->
            Home.view

        NotFoundPage url ->
            NotFound.view url

        AceyDuceyPage m ->
            let
                { title, body } =
                    AceyDucey.view m
            in
            { title = title
            , body = Element.map AceyDuceyMessage body
            }
    )
        |> (\{ title, body } ->
                { title =
                    "Basic Computer Games"
                        ++ (if String.isEmpty title then
                                ""

                            else
                                " - " ++ title
                           )
                , body = [ layout [ width fill, height fill ] body ]
                }
           )
