port module Letterfall exposing (..)

import Html exposing (Html)
import Html.App as App
import Html.Events exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import String exposing (..)
import Random exposing (Seed, Generator)
import Array
import Random.Array
import Random.Int

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { letters : List String
  }

alphabet = String.split "" "abcdefghijklmnopqrstuvwxyz"


init: (Model, Cmd Msg)
init =
  (Model  alphabet,  d3Update alphabet)

-- UPDATE

type Msg = Shuffle  | ReplaceCards (Int, Array.Array String)

port d3Update : List String -> Cmd msg



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Shuffle ->
        (model, Random.generate ReplaceCards
             (Random.pair
              (Random.int 1 25)
              (Random.Array.shuffle
               (Array.fromList alphabet))))

    ReplaceCards (len,chars) ->
        let newalpha = (Array.toList (Array.slice 0 len chars))
        in
            (Model newalpha, d3Update  newalpha)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW

-- am going to pass this off to D3 soonish

view : Model -> Html Msg
view model =
  Html.div []
    [ Html.h1 [] [ Html.text (toString model.letters) ]
    ,Svg.svg
        [ width "960", height "120", viewBox "0 0 960 120"]
        [ g [class "letters", transform "translate(32,60)"][]
        ]

    , Html.button [ onClick Shuffle ] [ text "Roll" ]
    ]


svgletters : List String -> List (Svg msg)
svgletters letters =
    List.indexedMap svgletter letters


svglettersD3 : List String -> List (Svg msg)
svglettersD3 letters =
    List.indexedMap svgletter letters



svgletter : number -> String -> Svg msg
svgletter i letter =
    let
        xpos = (toString (i * 32))
    in
        text' [x xpos , y "60", fontSize "55", fill "blue" ]
            [Svg.text letter]
