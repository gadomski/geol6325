library(ggplot2)
library(reshape2)

snotel <- read.delim("~/Documents/Classes/GEOL 6325/final-project/snotel.txt")
snotel.boxed <- snotel[snotel$lat > 37 & snotel$lat < 39 & snotel$lon < -107 & snotel$lon > -108,]
if (!exists("beartown")) {
  beartown <- read.csv("http://www.wcc.nrcs.usda.gov/reportGenerator/view_csv/customSingleStationReport/daily/327:CO:SNTL%7Cid=%22%22%7Cname/POR_BEGIN,POR_END/WTEQ::value,PREC::value,TMAX::value,TMIN::value,TAVG::value,PRCP::value", comment.char="#")
}
beartown$Date <- as.Date(beartown$Date)
snow_year <- function(date) {
  mon <- as.numeric(format(date, "%m"))
  year <- as.numeric(format(date, "%Y"))
  if (mon >= 10) {
    return(year)
  } else {
    return(year-1)
  }
}
snow_day <- function(date, year) {
  days <- as.numeric(date - as.Date(paste0(as.character(year), "-10-01")))
  return(days)
}
beartown$Snow.Year <- mapply(snow_year, beartown$Date)
beartown$Snow.Day <- mapply(snow_day, beartown$Date, beartown$Snow.Year)
beartown$Snow.Density <- beartown$Snow.Water.Equivalent..in. / beartown$Precipitation.Accumulation..in.

ggplot(beartown[beartown$Snow.Year > 2010,], aes(Snow.Day, Snow.Density, color=factor(Snow.Year))) +
  geom_line() +
  xlab("Snow day (days since October 1st)") +
  ylab("Snow density as a percentage of water's density") +
  ggtitle("Snow density at Beartown Snotel") +
  guides(colour = guide_legend(title="Snow year"))
ggsave("images/beartown.png", width=12, height=6)
