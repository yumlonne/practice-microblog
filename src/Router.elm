module Router exposing (routing)

import Page


routing : String -> Page.Page
routing url =
    case url of
        "/" ->
            Page.Top {}

        "/index.html" ->
            Page.Top {}

        "/write" ->
            Page.Write { title = "", body = "" }

        --        -- TODO
        --        "/read" ->
        --            Top
        --
        --        -- TODO
        --        "/search" ->
        --            Top
        _ ->
            Page.NotFound
