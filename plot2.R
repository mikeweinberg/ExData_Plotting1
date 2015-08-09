
# download data file
if (!file.exists("household_power_consumption.zip"))
{
  download.file(
    url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
    destfile="household_power_consumption.zip"
  )
}
#read in data file
household_power_consumption <- read.csv(
  unz(description="household_power_consumption.zip", filename="household_power_consumption.txt"), 
  sep=";", 
  na.strings="?")

#format dates
household_power_consumption$Date <-as.Date(household_power_consumption$Date, format="%d/%m/%Y")

#subset to only the two days
days <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))



household_power_consumption <- subset(household_power_consumption,
                                      household_power_consumption$Date %in% days)
#add DateTime column for X axis
household_power_consumption$DateTime <- as.POSIXlt(paste(strftime(household_power_consumption$Date, format="%Y-%m-%d"), household_power_consumption$Time))



png(filename = "plot2.png",
    width = 480, height = 480)

plot(household_power_consumption$DateTime
     , household_power_consumption$Global_active_power,
     xlab="", ylab="Global Active Power (kilowatts)", type="n"
     )
lines(household_power_consumption$DateTime , household_power_consumption$Global_active_power)
dev.off()