library(ggplot2)
library(reshape2)

snotel <- read.delim("~/Documents/Classes/GEOL 6325/final-project/snotel.txt")
snotel.boxed <- snotel[snotel$lat > 37 & snotel$lat < 39 & snotel$lon < -107 & snotel$lon > -108,]
if (!exists("beartown")) {
  #beartown <- read.csv("http://www.wcc.nrcs.usda.gov/reportGenerator/view_csv/customGroupByMonthReport/daily/327:CO:SNTL%7Cid=%22%22%7Cname/POR_BEGIN,POR_END/WTEQ::value", comment.char="#")
  beartown <- read.csv("http://www.wcc.nrcs.usda.gov/reportGenerator/view_csv/customSingleStationReport/daily/327:CO:SNTL%7Cid=%22%22%7Cname/POR_BEGIN,POR_END/WTEQ::value,PREC::value,TMAX::value,TMIN::value,TAVG::value,PRCP::value", comment.char="#")
}
#beartown.melt <- melt(beartown, id.vars=c("Water.Year", "Day"), value.name="SWE", variable.name="Month")
beartown.melt$SWE <- as.numeric(beartown.melt$SWE)
beartown.2014 <- beartown.melt[beartown.melt$Water.Year==2014,]

ggplot(beartown.2014, aes(seq(1, nrow(beartown.2014)), SWE)) + geom_point() + xlab("Day of snow season, starting October 1")
ggsave("images/beartown.png")
