#Exploratory data analysis - Course Project 1 assignment

file.name <- "./household_power_consumption.txt"
url       <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip.file  <- "./data.zip"

if (!file.exists("./household_power_consumption.txt")) {
  download.file(url, destfile = zip.file)
  unzip(zip.file)
  file.remove(zip.file)
}


#Read data file; change '?' to NA values
household <-read.csv2("household_power_consumption.txt", na.strings="?")
#is.na(household)

#Change the Date column in dataset to POSIXlt
household$Date<-strptime(household$Date, "%d/%m/%Y")

#Data period 2007/02/01 to 2007/02/02
d1<-strptime("2007/02/01", "%Y/%m/%d")
d2<-strptime("2007/02/02", "%Y/%m/%d")

#Only keep the rows whose dates are between d1 and d2
household <-household[household$Date>=d1 & household$Date<=d2,]


#Change the Date & Time column in dataset to POSIXlt
household$posix <- as.POSIXct(strptime(paste(household$Date, household$Time, sep = " "),
                                        format = "%Y-%m-%d %H:%M:%S"))


#Transform the first column into numeric
household[,3]<-as.numeric(as.character(household[,3])) #Global active power
household[,4]<-as.numeric(as.character(household[,4])) #Global reactive power
household[,5]<-as.numeric(as.character(household[,5])) #Voltage
household[,7]<-as.numeric(as.character(household[,7])) #Submetering 1
household[,8]<-as.numeric(as.character(household[,8])) #Submetering 2
household[,9]<-as.numeric(as.character(household[,9])) #Submetering 3

#Save plot as plot2.png
png("plot4.png", width = 480, height = 480)

#Create plots
par(mfrow=c(2,2))

#Plot 4.1
with(household, plot(posix, Global_active_power, 
                      type = "l",
                      xlab="", 
                      ylab="Global Active Power (kilowatts)"))

#Plot 4.2
with(household, plot(posix, Voltage,
                      type = "l",
                      xlab = "datetime"))

#Plot 4.3
with(household, plot(posix, Sub_metering_1, 
                      type = "l",
                      xlab="", 
                      ylab="Energy sub metering"))
with(household, lines(posix, Sub_metering_2, 
                       col="red"))
with(household, lines(posix, Sub_metering_3, 
                       col="blue"))
#Add legend
legend("topright", 
       lty= 1,
       col = c("black","blue", "red"),
       legend = c("Sub metering 1", "Sub metering 2","Sub metering 3"),
       cex = 0.75,
       bty = "n") 


#Plot 4.4
with(household, plot(posix, Global_reactive_power,
                     type = "l",
                     xlab = "datetime"))


#Closing the png file device - back to default
dev.off()
