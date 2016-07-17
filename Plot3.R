library(lubridate)

setwd("C:/Users/stjmk/Code/ExploratoryDataAnalysis/WeekOne")
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

png("plot3.png", width=480, height=480, units="px")
with(PowerDataXtract, plot(DateTime, as.numeric(as.character(Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40)))
with(PowerDataXtract, lines(DateTime, as.numeric(as.character(Sub_metering_2)), col="red"))
with(PowerDataXtract, lines(DateTime, as.numeric(as.character(Sub_metering_3)), col="blue"))
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
dev.off()