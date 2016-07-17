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

png("plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))

with(PowerDataXtract, plot(DateTime, as.numeric(as.character(Global_active_power)), type="l", xlab="", ylab="Global Active Power"))

with(PowerDataXtract, plot(DateTime, as.numeric(as.character(Voltage)), type="l", xlab="datetime", ylab="Voltage"))

with(PowerDataXtract, plot(DateTime, as.numeric(as.character(Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40)))
with(PowerDataXtract, lines(DateTime, as.numeric(as.character(Sub_metering_2)), col="red"))
with(PowerDataXtract, lines(DateTime, as.numeric(as.character(Sub_metering_3)), col="blue"))
legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ), cex = 0.8)

with(PowerDataXtract, plot(DateTime, as.numeric(as.character(Global_reactive_power)), type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()

