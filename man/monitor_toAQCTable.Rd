% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/monitor_toAQCTable.R
\name{monitor_toAQCTable}
\alias{monitor_toAQCTable}
\title{Convert monitor data into an AQI category table}
\usage{
monitor_toAQCTable(
  monitor,
  NAAQS = c("PM2.5_2024", "PM2.5"),
  siteIdentifier = "locationName"
)
}
\arguments{
\item{monitor}{\emph{mts_monitor} object.}

\item{NAAQS}{Version of NAAQS levels to use. See Note.}

\item{siteIdentifier}{Metadata column used to identify sites or a character
vector with site identifiers.}
}
\value{
Table of AQI category counts.
}
\description{
Creates a table of AQI category vs monitoring site with a count
of the number of times each AQI category was experienced at each site. The
count will be a count of hours or days depending on averaging period of
the incoming \code{monitor} object.

When \code{siteIdentifier} is used, the identifiers must be in the same
order as \code{monitor$meta}.
}
\note{
On February 7, 2024, EPA strengthened the National Ambient Air Quality
Standards for Particulate Matter (PM NAAQS) to protect millions of Americans
from harmful and costly health impacts, such as heart attacks and premature
death. Particle or soot pollution is one of the most dangerous forms of air
pollution, and an extensive body of science links it to a range of serious
and sometimes deadly illnesses. EPA is setting the level of the primary
(health-based) annual PM2.5 standard at 9.0 micrograms per cubic meter to
provide increased public health protection, consistent with the available
health science.
See \href{https://www.epa.gov/pm-pollution/final-reconsideration-national-ambient-air-quality-standards-particulate-matter-pm}{PM NAAQS update}.
}
\examples{
library(AirMonitor)

# Lane County, Oregon AQSIDs all begin with "41039"
LaneCounty <-
  NW_Megafires \%>\%
  monitor_filter(stringr::str_detect(AQSID, '^41039')) \%>\%
  monitor_filterDate(20150801, 20150901)

# Count of hours each site spent in each AQ category in August
LaneCounty \%>\%
  monitor_toAQCTable()

# Count of days each site spent in each AQ
LaneCounty \%>\%
  monitor_dailyStatistic(mean) \%>\%
  monitor_toAQCTable()

# Count of days each site spent in each AQ (simplified names)
siteNames <- c(
  "Eugene 1", "Eugene 2", "Eugene 3",
  "Springfield", "Oakridge", "Cottage Grove"
)
LaneCounty \%>\%
  monitor_dailyStatistic(mean) \%>\%
  monitor_toAQCTable(siteIdentifier = siteNames)

# Count of days at each AQ level with the new, 2024 NAAQS
LaneCounty \%>\%
  monitor_dailyStatistic(mean) \%>\%
  monitor_toAQCTable(NAAQS = "PM2.5_2024")


}
