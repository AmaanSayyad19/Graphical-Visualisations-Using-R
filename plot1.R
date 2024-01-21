# Read the data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "data.zip")
unzip("data.zip")

# Read the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

# Combine Date and Time into a single datetime column
data$Datetime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Filter data for the dates 2007-02-01 and 2007-02-02
filtered_data <- subset(data, as.Date(Datetime) == as.Date("2007-02-01") | as.Date(Datetime) == as.Date("2007-02-02"))

# Plot 1 - Histogram
png("plot1.png", width=480, height=480)
hist(filtered_data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()