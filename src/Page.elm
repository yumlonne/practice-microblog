module Page exposing (Page(..))

import Page.Write


type Page
    = Top
    | Write Page.Write.Model
    | NotFound



--    | Read { articleId : ArticleId }
--    | Search { word : String }
--    | NotFound
