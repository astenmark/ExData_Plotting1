# plot1.R

dataarch <- "household_power_consumption.zip"
datafile <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
colclasses <- c("character",
                "character",
                "numeric",
                "numeric",
                "numeric",
                "numeric",
                "numeric",
                "numeric",
                "numeric")

# Download the file if it doesn't exist
if (!file.exists(dataarch))
    download.file(url, dataarch, method = "curl")

# Read the data file
data <- read.csv(unz(dataarch, datafile),
                 nrows = 2075260,
                 comment.char = "",
                 colClasses = colclasses,
                 stringsAsFactors = FALSE,
                 sep = ";", na.strings = "?")

# Convert Date and Time columns to something useful
data$TimeStamp <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S", tz = "US/Pacific")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Get data from 2007-02-01 and 2007-02-02
subdata <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"),]

# Plot the histogram
png("plot1.png")
hist(subdata$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")
dev.off()

