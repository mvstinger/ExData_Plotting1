# Plot2.R

##  LOAD & DATA
# Data has columns:
#[1] "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power"
#[5] "Voltage"               "Global_intensity"      "Sub_metering_1"        "Sub_metering_2"       
#[9] "Sub_metering_3"
# Data is sampled 1/min, and starts at 16 Dec 2006


# Read data from file
raw_data <- read.table(".//household_power_consumption.txt",
                       sep=";",
                       header=FALSE,
                       na.strings="?",
                       colClasses=c('character', 'character', 'numeric', rep('NULL', 6)),
                       col.names=c('aux_date', 'aux_time', 'Global_active_power', 
                                   'a','b','c','d','e','f'), # a-f not collected (NULL)
                       skip=66637,
                       nrows=2880
)

# Convert date and time rows into single POSIXct and keep only new "Date_time"
#   and "Global_active_power" subset.
raw_data[, "Date_time"] <- as.POSIXct(
  paste(raw_data[,1], raw_data[,2], sep=" "),
  format="%d/%m/%Y %H:%M:%S"
)
clean_data <- subset(raw_data, select = c("Date_time", "Global_active_power"))


##  PLOT
# Set up PNG device
png('.//plot2.png',
    bg="white",
    width=480, height=480, units="px")

# Create plot
plot(clean_data[,"Date_time"], clean_data[,"Global_active_power"],
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)"
     )

dev.off()