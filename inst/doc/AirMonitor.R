## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.width = 7, fig.height = 5)

## ----library, echo = FALSE----------------------------------------------------
suppressPackageStartupMessages({
  library(AirMonitor)
  
  Camp_Fire <- Camp_Fire
})

## ----Sacramento_2-------------------------------------------------------------
monitor_leaflet(Camp_Fire)

## ----Sacramento_3-------------------------------------------------------------
Sacramento <-
  Camp_Fire %>%
  monitor_select("8ca91d2521b701d4_060670010")

Sacramento %>%
  monitor_timeseriesPlot(
    shadedNight = TRUE,
    addAQI = TRUE
  )

addAQILegend(cex = 0.8)

## ----Sacramento_4-------------------------------------------------------------
Sacramento_area <-
  Camp_Fire %>%
  monitor_filterByDistance(
    longitude = Sacramento$meta$longitude,
    latitude = Sacramento$meta$latitude,
    radius = 50000
  )

monitor_leaflet(Sacramento_area)

## ----Sacramento_5-------------------------------------------------------------
Sacramento_area %>%
  monitor_timeseriesPlot(
    shadedNight = TRUE,
    addAQI = TRUE,
    main = "Wildfire Smoke within 30 miles of Sacramento"
  )
addAQILegend(lwd = 1, pch = NA, bg = "white")

## ----Sacramento_6-------------------------------------------------------------
Sacramento_area %>%
  monitor_collapse(
    deviceID = "Sacramento_area"
  ) %>%
  monitor_dailyStatistic() %>%
  monitor_getData()

## ----Sacramento_7-------------------------------------------------------------
Sacramento_area %>%
  monitor_collapse() %>%
  monitor_dailyBarplot(
    main = "Daily Average PM2.5 in the Sacramento Area"
  )
addAQILegend(pch = 15, bg = "white")

