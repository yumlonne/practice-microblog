module Main exposing (main)

-- PROJECT MODULES

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html
import Page
import Page.Top
import Page.Write
import Router
import Url
import Url.Parser



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- Model


type alias ArticleId =
    Int


type alias Model =
    { key : Nav.Key
    , page : Page.Page
    }


init : flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key, page = Router.routing url.path }, Cmd.none )



-- UPDATE


type Msg
    = GotTopPageMsg Page.Top.Msg
    | GotWritePageMsg Page.Write.Msg
    | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( UrlChanged url, _ ) ->
            ( { model | page = Router.routing url.path }, Cmd.none )

        ( LinkClicked urlReq, _ ) ->
            case urlReq of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ( GotTopPageMsg subMsg, Page.Top subModel ) ->
            Page.Top.update subMsg subModel
                |> updateWith (Page.Top >> updateModel model) GotTopPageMsg model

        ( GotWritePageMsg writePageMsg, Page.Write writeModel ) ->
            Page.Write.update writePageMsg writeModel
                |> updateWith (Page.Write >> updateModel model) GotWritePageMsg model

        ( _, _ ) ->
            ( model, Cmd.none )



--            let
--                ( newPageModel, cmd ) =
--                    Page.Write.update writePageMsg writeModel
--            in
--            ( { model | page = Page.Write newPageModel }, cmd )


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )


updateModel : Model -> Page.Page -> Model
updateModel model page =
    { model | page = page }



-- VIEW


view : Model -> Document Msg
view model =
    case model.page of
        Page.Top subModel ->
            viewPage Page.Top.view GotTopPageMsg subModel

        Page.Write writeModel ->
            viewPage Page.Write.view GotWritePageMsg writeModel

        _ ->
            { title = "WIP"
            , body =
                []
            }



--Page.Write.view model


viewPage : (subModel -> Document subMsg) -> (subMsg -> Msg) -> subModel -> Document Msg
viewPage viewFunc toMsg subModel =
    let
        { title, body } =
            viewFunc subModel
    in
    { title = title
    , body = List.map (Html.map toMsg) body
    }
