# Read 2007-02-01 to 02-02 from household_power_consumption.txt.
# Process Date and Time columns into a single Date_time column.
readData <- function() {
    headers <- c("Date", "Time", 
                 "Global_active_power", "Global_reactive_power", 
                 "Voltage", "Global_intensity", 
                 "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    data <- read.table("household_power_consumption.txt", 
                       sep = ";", na.strings = "?", fill = TRUE, header = FALSE, 
                       skip = 66637, nrows = 2880, col.names = headers)
    data$datetime <- toDateTime(data$Date, data$Time)
    data$Date <- NULL
    data$Time <- NULL
    data
}

# Process the formatting for Date and Time in household_power_consumption.txt.
toDateTime <- function(dateStr, timeStr) {
    dateTimeStr <- paste(dateStr, timeStr, sep = " ")
    strptime(dateTimeStr, format = "%d/%m/%Y %H:%M:%S", tz = "UTC")
}

# Histogram for Global Active Power
drawPlot1 <- function(data) {
    with(data, hist(Global_active_power, col = "red", 
         main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)"))
}

# Time series for Global Active Power
drawPlot2 <- function(data, ylab = "Global Active Power (kilowatts)") {
    with(data, plot(datetime, Global_active_power, type = "l", 
         xlab = "",
         ylab = ylab))    
}

# Time series for Sub Metering
drawPlot3 <- function(data, box.lwd = par("lwd")) {
    with(data, plot(datetime, Sub_metering_1, type = "n", 
                    xlab = "",
                    ylab = "Energy sub metering"))    
    with(data, points(datetime, Sub_metering_1, type = "l", col = "black"))
    with(data, points(datetime, Sub_metering_2, type = "l", col = "red"))
    with(data, points(datetime, Sub_metering_3, type = "l", col = "blue"))
    legend("topright", lwd = 2, box.lwd = box.lwd, 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col = c("black", "red", "blue"))
}

# Multi-plot for Active & Reactive Power, Voltage, and Sub Metering
drawPlot4 <- function(data) {
    par(mfrow = c(2, 2))
    drawPlot2(data, ylab = "Global Active Power")
    with(data, plot(datetime, Voltage, type = "l"))
    drawPlot3(data, box.lwd = 0)
    with(data, plot(datetime, Global_reactive_power, type = "l"))
}
