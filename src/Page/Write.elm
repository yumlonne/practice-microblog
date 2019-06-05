module Page.Write exposing (Model, Msg, update, view)

import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MODEL


type alias Model =
    { title : String
    , body : String
    }



-- UPDATE


type Msg
    = OnInputTitle String
    | OnInputBody String
    | Post


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInputTitle title ->
            ( { model | title = title }
            , Cmd.none
            )

        OnInputBody body ->
            ( { model | body = body }
            , Cmd.none
            )

        Post ->
            -- TODO
            ( model, Cmd.none )



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Write Page"
    , body =
        [ div []
            [ input [ onInput OnInputTitle ] []
            , textarea [ onInput OnInputBody ] []
            ]
        ]
    }
