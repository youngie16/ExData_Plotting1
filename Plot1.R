
# Coursera Exploratory Data Analysis Week 1 Project

# Plot 1 - histogram of Global active power on first 2 days of feb



# Download and read in data
# some fields have missing data characterised by "?" capture in read statement

library(downloader)
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileurl, temp, mode = "wb")
unzip(temp,exdir = ".")

library(data.table)
pdata.all <- fread("household_power_consumption.txt", na.strings = "?" ,stringsAsFactors = "FALSE")
str(pdata.all)

# extract 2007-02-01 & 2007-02-02 days
# dates in data look like they are in UK order ie day,month, year because extracting as below gives similar frequencies on the histogram

earlyfeb.data <- subset(pdata.all,Date == "1/2/2007" | Date == "2/2/2007")
str(earlyfeb.data)


# open device and write graph to file

png(filename = "plot1.png", width = 480, height = 480)  # width and height requested are default values anyway
hist(earlyfeb.data$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)",
        main = "Global Active Power")
dev.off()
