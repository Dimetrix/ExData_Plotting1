rawdata <- read.table("household_power_consumption.txt", sep = ";",header = TRUE, colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), na.strings = "?")
rawdata$Date <- as.Date(rawdata$Date, "%d/%m/%Y")
subsetdata <- subset(rawdata,rawdata$Date == "2007-02-01" | rawdata$Date == "2007-02-02")
rm(rawdata)
subsetdata$DateTime <- strptime(paste(subsetdata$Date,subsetdata$Time, sep = " "), "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2, 2), mar = c(4, 3, 1, 0), cex = 0.75)
with(subsetdata, {
    
    #1
    plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    
    #2
    plot(DateTime, Voltage, type = "l", xlab = "datetime")
    
    #3
    plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright",lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty = "n")
    
    #4
    plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
})

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()