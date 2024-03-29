% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrcc_loadAnnual.R
\name{wrcc_loadAnnual}
\alias{wrcc_loadAnnual}
\title{Load annual WRCC monitoring data}
\usage{
wrcc_loadAnnual(
  year = NULL,
  archiveBaseUrl = paste0("https://airfire-data-exports.s3.us-west-2.amazonaws.com/",
    "monitoring/v2"),
  archiveBaseDir = NULL,
  QC_negativeValues = c("zero", "na", "ignore"),
  QC_removeSuspectData = TRUE
)
}
\arguments{
\item{year}{Year [YYYY].}

\item{archiveBaseUrl}{Base URL for monitoring v2 data files.}

\item{archiveBaseDir}{Local base directory for monitoring v2 data files.}

\item{QC_negativeValues}{Type of QC to apply to negative values.}

\item{QC_removeSuspectData}{Removes monitors determined to be misbehaving.}
}
\value{
A \emph{mts_monitor} object with WRCC data. (A list with
\code{meta} and \code{data} dataframes.)
}
\description{
Loads pre-generated .rda files containing annual
WRCC data.

If \code{archiveDataDir} is defined, data will be loaded from this local
archive. Otherwise, data will be loaded from the monitoring data repository
maintained by the USFS AirFire team.

Current year files loaded by this function are updated once per week.

For the most recent data in the last 10 days, use \code{wrcc_loadLatest()}.

For daily updates covering the most recent 45 days, use \code{wrcc_loadDaily()}.
}
\note{
Some older WRCC timeseries contain only values of 0, 1000, 2000, 3000, ... ug/m3.
Data from these deployments pass instrument-level QC checks but these
timeseries generally do not represent valid data and should be removed.
With \code{QC_removeSuspectData = TRUE} (the default), data is checked and
periods reporting only values of 0:10 * 1000 ug/m3 are invalidated.

Only those personally familiar with the individual instrument deployments
should work with the "suspect" data.
}
\examples{
\dontrun{
library(AirMonitor)

# Fail gracefully if any resources are not available
try({

# See https://en.wikipedia.org/wiki/Snake_River_Complex_Fire

# WRCC monitors during the Snake River Complex Fire
wrcc_loadAnnual(2021) \\%>\\%
  monitor_filter(stateCode \\%in\\% c("ID", "MT")) \\%>\\%
  monitor_filterDate(20210707, 20210820, timezone = "America/Denver") \\%>\\%
  monitor_timeseriesPlot(
    ylim = c(0, 300),
    xpd = NA,
    addAQI = TRUE,
    main = "WRCC monitors during Snake River Complex Fire"
  )

}, silent = FALSE)
}
}
\seealso{
\code{\link{wrcc_loadDaily}}

\code{\link{wrcc_loadLatest}}
}
