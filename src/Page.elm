module Page exposing (Page(..))

import Page.Top
import Page.Write


type Page
    = Top Page.Top.Model
    | Write Page.Write.Model
    | NotFound



--    | Read { articleId : ArticleId }
--    | Search { word : String }
--    | NotFound
