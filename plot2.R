
## Download and Unzip File
if (!file.exists("data")) {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./data/electric_power_data.zip", method ="curl")
unzip("./data/electric_power_data.zip", exdir = "./data")
closeAllConnections()

## Read Table
PowerConsumption <- read.table("household_power_consumption.txt",
                        header = TRUE, sep = ";", na.strings = "?",
                        stringsAsFactors = FALSE)

## Create Date and DateTime Variables
Date2 <- as.Date(PowerConsumption$Date, format="%d/%m/%Y")
DateTime <- paste(as.character(PowerConsumption$Date),
                        as.character(PowerConsumption$Time), sep = " ")
DateTime2 <- strptime(DateTime, format = "%d/%m/%Y %H:%M:%S")

## Bind Date and DateTime Variables to Power Consumption Dataframe
PowerConsumption2 <- cbind(Date2, DateTime2, PowerConsumption)

## Subset Dataframe to Include Only 2 Days and Required Variables
PowerConsumption2Days <- subset(PowerConsumption2,
        Date2 %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),
        select = c(Date2, DateTime2, Global_active_power, Global_reactive_power,
                   Voltage, Sub_metering_1, Sub_metering_2, Sub_metering_3))

## Construct and Save Plot 2
png("plot2.png", width = 480, height = 480, res = 72)
plot(PowerConsumption2Days$DateTime2, 
        PowerConsumption2Days$Global_active_power, type = "l", lwd = 1.5,
        xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

