## Exploratory Data Analysis - Assignment 1 - Plot 2
# Read in data and generate plot2.png

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

png('plot2.png',
    width=480,
    height=480,
    units='px')
plot(merged_date_time,sub_data$Global_active_power,
     type='l',
     xlab='',
     ylab='Global Active Power (kilowatts)',
     col='black')
dev.off()
