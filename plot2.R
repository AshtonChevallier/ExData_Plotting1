#If you don't have Power Consumption Data in your wd, download it and unzip it.
if(!file.exists("household_power_consumption.txt")){
    if(!file.exists("Power.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                      ,destfile = "Power.zip")
    }
    unzip("Power.zip")
}

# Read table in using na.strings as ? to remove any silly data, then set colclasses
data <- read.table("household_power_consumption.txt",sep=";",header = TRUE,na.strings="?"
                   ,colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#Filter out data we care about, note date format is dd/mm/yyyy
x <- data[data[,1] == "1/2/2007"|data[,1]=="2/2/2007",]

#Save some memory!
rm(data)

# Combine dates together, then coerce to POSIXct
dt <- as.POSIXct(strptime(paste(x$Date,x$Time),"%d/%m/%Y %H:%M:%S"))


#Create Plot 2 and Save
png("plot2.png")
plot(dt,x$Global_active_power,ylab="Global Active Power (kilowats)", type = "l",xlab="")
dev.off() 