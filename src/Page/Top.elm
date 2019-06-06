module Page.Top exposing (..)

import Browser exposing (Document)
import Element exposing (..)
import Element.Input as Input

-- MODEL

type alias Model =
    {  }

-- UPDATE

type Msg
    = NoOp

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp -> (model, Cmd.none)

view : Model -> Document Msg
view model =
    { title = "Top"
    , body =
        [ layout [] <|
            row []
                [ Input.button []
                    { onPress = Nothing
                    , label = link []
                        { label = text "書く"
                        , url = "/write"
                        }
                    }
                ]
        ]
    }
