module Intersections exposing (main)


import Svg
import Svg.Attributes
import Html
import Html.Attributes exposing (class)
import LineChart
import LineChart.Colors as Colors
import LineChart.Coordinate as Coordinate
import LineChart as LineChart
import LineChart.Junk as Junk exposing (..)
import LineChart.Dots as Dots
import LineChart.Container as Container
import LineChart.Interpolation as Interpolation
import LineChart.Axis.Intersection as Intersection
import LineChart.Axis.Title as Title
import LineChart.Axis.Ticks as Ticks
import LineChart.Axis.Tick as Tick
import LineChart.Axis.Range as Range
import LineChart.Axis.Line as AxisLine
import LineChart.Axis as Axis
import LineChart.Legends as Legends
import LineChart.Line as Line
import LineChart.Events as Events
import LineChart.Grid as Grid
import LineChart.Legends as Legends
import LineChart.Area as Area
import Color



main : Html.Html msg
main =
  Html.div
    [ class "container" ]
    [ chart ]


chart : Html.Html msg
chart =
  LineChart.viewCustom
    { y = Axis.skinny 500 "y" .y [ -1, 0, 1, 2, 3 ]
    , x = Axis.skinny 700 "x" .x [ -1, 0 ,1, 2, 3]
    , container = Container.default "line-chart-1"
    , interpolation = Interpolation.default
    , intersection = Intersection.at 0 0
    , legends = Legends.default
    , events = Events.default
    , junk = customJunk
    , grid = Grid.default
    , area = Area.default
    , line = Line.default
    , dots = Dots.default
    }
    [ LineChart.line Colors.pink Dots.none "some data" data
    ]


customJunk : Junk.Config data msg
customJunk =
  Junk.custom <| \system ->
    { below = []
    , above =
        [ note system 0.2 0.25 0 0 "↙ The intersection"
        ]
    , html = []
    }


note : Coordinate.System -> Float -> Float -> Float -> Float -> String -> Svg.Svg msg
note system x y xo yo text =
  let _ = Debug.log "system" system in
  Svg.g
    [ Junk.transform [ Junk.move system x y, Junk.offset xo yo ]
    , Svg.Attributes.style "text-anchor: start;"
    ]
    [ Junk.label Color.black text ]



-- DATA


type alias Data =
  { x : Float, y : Float }


data : List Data
data =
  [ Data -1 -3
  , Data  6 3
  ]
