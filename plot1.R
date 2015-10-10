## Exploratory Data Analysis - Assignment 1 - Plot 1
# Read in data and generate plot1.png

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

# Generate plot1
# Background is set to transparent as the plots in the repo have transparent background
png('plot1.png',
    width=480,
    height=480,
    units='px',
    bg='transparent')
hist(sub_data$Global_active_power,
     breaks=12,
     xlim=c(0,6),
     ylim=c(0,1200),
     col='red',
     xlab='Global Active Power (kilowatts)',
     ylab='Frequency',
     main='Global Active Power')
dev.off()
