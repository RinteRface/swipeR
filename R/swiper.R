#' @title Create a swiper container
#'
#' @description A swiper container to include in a \link(fluidPage)
#'
#' @note See \url{http://idangero.us/swiper/api/#initialize} for the detailed API description.
#'
#' @param ... Slot for \link{swiperSlide}.
#' @param width swiper width in px or percentage.
#' @param height swiper height in px or percentage.
#' @param loop Whether to play slide in a loop. TRUE by default.
#' @param direction Swiper direction: 'horizontal' or 'vertical'
#' @param speed Swiper speed (ms).
#' @param spaceBetween Space between slides in px, 100 by default.
#' @param mousewheel Whether to enable mouse navigation. FALSE by default.
#' @param navigation Whether to display arrow for navigation between slides. FALSE by default.
#' @param pagination Whether to display bullet for pagination. TRUE by default.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(swipeR)
#'
#'  shinyApp(
#'   ui = fluidPage(
#'    title = "Hello Shiny!",
#'    swiper(
#'      direction = "horizontal",
#'      mousewheel = TRUE,
#'      width = "100%",
#'      height = "800px",
#'      swiperSlide(img(src = "https://image.flaticon.com/icons/svg/165/165126.svg")),
#'      swiperSlide(
#'        tags$iframe(
#'          src = "http://www.rinterface.com/shiny/tablerDash/",
#'          width = "100%",
#'          frameBorder = "0",
#'          style = "position:fixed; height: calc(100% - 10px);"
#'        )
#'      ),
#'      swiperSlide(
#'       tags$iframe(
#'         width = "100%",
#'         height = "100%",
#'         src = "https://www.youtube.com/embed/u-Ofl67lz0g",
#'         frameborder = "0",
#'         allow = "accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture",
#'         allowfullscreen = NA
#'       )
#'      )
#'    )
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
swiper <- function(..., width = "600px", height = "300px", loop = TRUE,
                   direction = c("horizontal", "vertical"),
                   speed = 400, spaceBetween = 100, mousewheel = FALSE,
                   navigation = FALSE, pagination = TRUE) {

  direction <- match.arg(direction)

  # convert loop into something that JS can understand
  loop <- tolower(loop)
  mousewheel <- tolower(mousewheel)

  # main tag
  swiperTag <- htmltools::tags$div(
    class = "swiper-container",
    style = paste0("width: ", width, "; ", "height: ", height, ";", style = "position: relative;"),

    # slide wrapper
    shiny::tags$div(
      class = "swiper-wrapper",
      ...
    ),

    # pagination
    if (pagination) htmltools::tags$div(class = "swiper-pagination"),

    # buttons
    if (navigation) {
      htmltools::tagList(
        htmltools::tags$div(class = "swiper-button-prev"),
        htmltools::tags$div(class = "swiper-button-next")
      )
    },

    # scrollbar
    htmltools::tags$div(class = "swiper-scrollbar")
  )


  # since we use pagination and navigation above for R, we
  # only convert them here for javascript
  navigation <- tolower(navigation)
  pagination <- tolower(pagination)

  if (navigation) {
    navigation <- "navigation: {
              nextEl: '.swiper-button-next',
              prevEl: '.swiper-button-prev'
            }"
  } else {
    navigation <- "//"
  }

  if (pagination) {
    pagination <- "pagination: {
              el: '.swiper-pagination',
              dynamicBullets: true
            }"
  } else {
    pagination <- "//"
  }


  # Javascript: init
  script <- htmltools::tags$head(
    htmltools::tags$script(
      paste0(
        "$(document).ready(function () {
          //initialize swiper when document ready

          var mySwiper = new Swiper ('.swiper-container', {

            // main effect
            effect: 'coverflow',
            grabCursor: true,
            centeredSlides: true,
            slidesPerView: 'auto',
            coverflowEffect: {
              rotate: 50,
              stretch: 0,
              depth: 100,
              modifier: 1,
              slideShadows : true,
            },

            // Optional parameters
            direction: '", direction, "',
            loop: ", loop, ",
            speed: ", speed, ",
            spaceBetween: ", spaceBetween, ",
            mousewheel: ", mousewheel ,",

            // navigation options
            ", navigation, ",

            // pagination options
            ", pagination, "

          });
        });
        "
      )
    )
  )

  # load the script and return the tag
  tags <- htmltools::tagList(
    htmltools::singleton(script),
    swiperTag
  )

  # give HTML dependencies
  htmltools::attachDependencies(tags, swiper_dep())

}


#' @title Create a swiper slide
#'
#' @description A swiper slide
#'
#' @param ... Slide content
#'
#' @export
swiperSlide <- function(...) {
  htmltools::tags$div(class = "swiper-slide", ...)
}
