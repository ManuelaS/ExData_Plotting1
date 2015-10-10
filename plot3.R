## Exploratory Data Analysis - Assignment 1 - Plot 3
# Read in data and generate plot3.png

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

# Generate plot3
# Background is set to transparent as the plots in the repo have transparent background
png('plot3.png',
    width=480,
    height=480,
    units='px',
    bg='transparent')
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
       lty=1,
       lwd=1)
dev.off()
