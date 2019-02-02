swiper_css <- "css/swiper.min.css"
swiper_js <- "js/swiper.min.js"

wiper_url <- "https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.4.6/"


# create the swiper dep
swiper_dep <- function() {
  htmltools::htmlDependency(
    name = "swiper",
    version = "4.4.6",
    c(href = wiper_url),
    script = swiper_js,
    stylesheet = swiper_css
  )
}


