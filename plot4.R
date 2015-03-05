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

png("plot4.png")
    par(mfrow = c(2,2))
    
    plot(dt,x$Global_active_power,ylab="Global Active Power", type = "l")
    
    plot(dt,x$Voltage,ylab="Voltage", type = "l",xlab = "datetime")
    
    plot(dt,x$Sub_metering_1,type="l",ylab="Energy sub metering", xlab = "")
    lines(dt,x$Sub_metering_2,type="l",col="red")
    lines(dt,x$Sub_metering_3,type="l",col="blue")
    legend("topright" , lty =1, col = c("black","blue", "red"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
    
    plot(dt,x$Global_reactive_power,ylab="Global_reactive_power", type = "l",xlab = "datetime")
dev.off()