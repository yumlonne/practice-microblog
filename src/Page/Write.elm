module Page.Write exposing (Model, Msg, update, view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Input as Input



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
        [ layout [ explain Debug.todo ] <|
            column []
                [ Input.button []
                    { onPress = Nothing
                    , label =
                        link []
                            { label = text "←"
                            , url = "/"
                            }
                    }
                , Input.text [ centerX, centerY ]
                    { label = Input.labelLeft [ centerY ] (text "タイトル")
                    , onChange = OnInputTitle
                    , placeholder = Nothing
                    , text = model.title
                    }
                , Input.multiline []
                    { label = Input.labelHidden "本文"
                    , onChange = OnInputBody
                    , placeholder = Just <| Input.placeholder [] (el [] <| text "本文")
                    , spellcheck = True
                    , text = model.body
                    }
                , Input.button []
                    { onPress = Just Post
                    , label = text "送信"
                    }
                ]
        ]
    }
