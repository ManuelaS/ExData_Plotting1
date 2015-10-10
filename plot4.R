## Exploratory Data Analysis - Assignment 1 - Plot 4
# Read in data and generate plot4.png

# Download and unzip data file
if (!file.exists('./household_power_consumption.txt')) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = 'exdata-data-household_power_consumption',
                method = "curl")
  unzip('exdata-data-household_power_consumption')
}

data <-read.table('./household_power_consumption.txt',
                  sep=';',
                  header=TRUE,
                  stringsAsFactors=FALSE,
                  na.strings='?',
                  colClasses=c(rep('character',2),rep('numeric',7)))

# Format date and time and subset dataset to only 2007-02-01 and 2007-02-02
data$Date = as.Date(data$Date,format='%d/%m/%Y')
sub_data <- data[data$Date=='2007-02-01' | data$Date=='2007-02-02',]
merged_date_time <- strptime(paste(sub_data$Date,sub_data$Time, sep=' '),'%Y-%m-%d %H:%M:%S')

# Generate plot4
# Background is set to transparent as the plots in the repo have transparent background
png('plot4.png',
    width=480,
    height=480,
    units='px',
    bg='transparent')
# Create 2 x 2 layout
par(mfrow = c(2, 2))

# Top-left plot
plot(merged_date_time,sub_data$Global_active_power,
     type='l',
     xlab='',
     col='black',
     ylab='Global Active Power')

# Top-right plot
plot(merged_date_time,sub_data$Voltage,
     type='l',
     xlab='datetime',
     ylab='Voltage',
     col='black')

# Bottom-left plot
plot(merged_date_time,sub_data$Sub_metering_1,
     type='l',
     col='black',
     xlab='',
     ylab='Energy sub metering',
     main='')
lines(merged_date_time,sub_data$Sub_metering_2,col='red')
lines(merged_date_time,sub_data$Sub_metering_3,col='blue')
legend('topright',
       c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),
       bty='n',
       lwd=1)

# Bottom-right plot
plot(merged_date_time,sub_data$Global_reactive_power,
     type='l',
     xlab='datetime',
     ylab='Global_reactive_power',
     col='black')

dev.off()




