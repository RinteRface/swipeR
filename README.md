# swipeR

[![CRAN status](https://www.r-pkg.org/badges/version/swipeR)](https://cran.r-project.org/package=swipeR)

> Swiper is a R wrapper around the [Swiper](http://idangero.us/swiper/) javascript library 

## Installation

You can install the latest version of swipeR from github:

``` r
devtools::install:github("RinteRface/swipeR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(shiny)
library(swipeR)

 ui <- fluidPage(
  title = "Hello Shiny!",
  swiper(
   direction = "horizontal",
   mousewheel = TRUE,
   width = "100%",
   height = "800px",
   swiperSlide(img(src = "https://image.flaticon.com/icons/svg/165/165126.svg")),
   swiperSlide(
    tags$iframe(
     src = "http://www.rinterface.com/shiny/tablerDash/",
     width = "100%",
     frameBorder = "0",
     style = "position:fixed; height: calc(100% - 10px);"
    )
   ),
   swiperSlide(
    tags$iframe(
     width = "100%",
     height = "100%",
     src = "https://www.youtube.com/embed/u-Ofl67lz0g",
     frameborder = "0",
     allow = "accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture",
     allowfullscreen = NA
    )
   )
  )
 )

 shinyApp(ui, server = function(input, output) { })
```

