# Read the data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "data.zip")
unzip("data.zip")
# Load the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# Convert Date and Time to appropriate format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Datetime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Filter data for the dates 2007-02-01 and 2007-02-02
filtered_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Start PNG device
png(filename = "plot4.png", width = 480, height = 480)

# Set up a 2x2 plotting area
par(mfrow = c(2, 2))

# Plot 1: Time series plot of Global Active Power
plot(filtered_data$Datetime, filtered_data$Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power")

# Plot 2 - Voltage Series Plot
plot(filtered_data$Datetime, filtered_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(filtered_data$Datetime, filtered_data$Sub_metering_1, type = "l", col = "black",
     xlab = "", ylab = "Energy sub metering", ylim = c(0, max(filtered_data$Sub_metering_1, filtered_data$Sub_metering_2, filtered_data$Sub_metering_3)))
lines(filtered_data$Datetime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$Datetime, filtered_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n", cex = 0.8)

# Plot 4: Time series plot of Global Reactive Power
plot(filtered_data$Datetime, filtered_data$Global_reactive_power, type = "l", col = "black",
     xlab = "datetime", ylab = "Global Reactive Power")

# Close PNG device
dev.off()