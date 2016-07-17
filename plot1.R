library(lubridate)

setwd("Code/ExploratoryDataAnalysis/WeekOne")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Windows
download.file(URL, destfile="household_power_consumption.zip")

# Other OS
# download.file(URL, destfile="household_power_consumption.zip", method="curl")

unzip("household_power_consumption.zip")     
PowerData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
PowerDataXtract <- PowerData[as.character(PowerData$Date) %in% c("1/2/2007", "2/2/2007"),]
DateTime <- paste(PowerDataXtract$Date, PowerDataXtract$Time)
DateTime <- dmy_hms(DateTime)
PowerDataXtract <- cbind(PowerDataXtract, DateTime)

png("plot1.png", width=480, height=480, units="px")
with(PowerDataXtract, hist(as.numeric(as.character(Global_active_power)), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()