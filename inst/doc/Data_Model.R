## ---- echo=FALSE--------------------------------------------------------------
knitr::opts_chunk$set(fig.width = 7, fig.height = 5)

## ----data_model_1-------------------------------------------------------------
suppressPackageStartupMessages(library(AirMonitor))

# Recipe to create Washington fires in August of 2014:
monitor <-
  # Start with NW Megafires
  NW_Megafires %>%
  # Filter to only include Washington state
  monitor_filter(stateCode == "WA") %>%
  # Filter to only include August
  monitor_filterDate(20150801, 20150831)

# 'mts_monitor' objects can be identified by their class
class(monitor)

# They alwyas have two elements called 'meta' and 'data'
names(monitor)

# Examine the 'meta' dataframe
dim(monitor$meta)
names(monitor$meta)

# Examine the 'data' dataframe
dim(monitor$data)

# This should always be true
identical(names(monitor$data), c('datetime', monitor$meta$deviceDeploymentID))

## ----Methow_Valley, results = "hold"------------------------------------------
# Calculate daily means for the Methow Valley from monitors in Twisp and Winthrop
TwispID <- "450d08fb5a3e4ea0_530470009"
WinthropID <- "40ffdacb421a5ee6_530470010"

# Recipe to calculate Methow Valley August Means:
Methow_Valley_AugustMeans <- 
  # Start with NW Megafires
  NW_Megafires %>%
  # Select monitors from Twisp and Winthrop
  monitor_select(c(TwispID, WinthropID)) %>%
  # Average them together hour-by-hour
  monitor_collapse(deviceID = 'MethowValley') %>%
  # Restrict data to of July
  monitor_filterDate(20150801, 20150901) %>%
  # Calculate daily mean
  monitor_dailyStatistic(mean, minHours = 18) %>%
  # Round data to one decimal place
  monitor_mutate(round, 1)

# Look at the first week
Methow_Valley_AugustMeans$data[1:7,]

## ----custom_use---------------------------------------------------------------
# Spokane area AQSIDs all begin with "53063"
Spokane <-
  NW_Megafires %>%
  monitor_filter(stringr::str_detect(AQSID, "^53063")) %>%
  monitor_filterDate(20150801, 20150808) %>%
  monitor_dropEmpty()

# Show the daily statistic
Spokane %>% 
  monitor_dailyStatistic(mean) %>%
  monitor_getData()

# Use a custom function to convert from ug/m3 to oz/ft3 
Spokane %>% 
  monitor_mutate(function(x) { return( (x / 28350) * (.3048)^3 ) }) %>%
  monitor_dailyStatistic(mean) %>%
  monitor_getData()

# Pull out the time series data to calculate correlations
Spokane %>% 
  monitor_getData() %>% 
  dplyr::select(-1) %>% 
  cor(use = "complete.obs")

