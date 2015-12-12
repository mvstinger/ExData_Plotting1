# Plot3.R

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
                       colClasses=c('character', 'character', rep('NULL', 4), rep('numeric', 3)),
                       col.names=c('aux_date', 'aux_time',
                                   'a','b','c','d',  # a-d not collected (NULL)
                                   'Sub_metering_1','Sub_metering_2','Sub_metering_3'), 
                       skip=66637,
                       nrows=2880
)
# Convert date and time rows into single POSIXct and keep only new "Date_time"
#   and "Sub_metering_x" subset.
raw_data[, "Date_time"] <- as.POSIXct(
  paste(raw_data[,1], raw_data[,2], sep=" "),
  format="%d/%m/%Y %H:%M:%S"
)
clean_data <- subset(raw_data, select = c("Date_time",
                                          "Sub_metering_1",
                                          "Sub_metering_2",
                                          "Sub_metering_3"))

##  PLOT
# Set up PNG device
png('.//plot3.png',
    bg="white",
    width=480, height=480, units="px")

# Plot Sub_metering_1 first (black line, no marker)
plot(clean_data[,"Date_time"], clean_data[,"Sub_metering_1"],
     type="l",
     xlab="",
     ylab="Energy sub metering"
     )
# Plot Sub_metering_2 second (red line, no marker)
lines(clean_data[, "Date_time"], clean_data[,"Sub_metering_2"],
     type="l",
     col="red"
     )
# Plot Sub_metering_3 last (blue line, no marker)
lines(clean_data[, "Date_time"], clean_data[,"Sub_metering_3"],
      type="l",
      col="blue"
      )
legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lwd=c(1,1,1))
dev.off()