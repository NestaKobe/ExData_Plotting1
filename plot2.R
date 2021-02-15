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
household[,3]<-as.numeric(as.character(household[,3]))


#Save plot as plot2.png
png("plot2.png", width = 480, height = 480)

#Create plot
with(household, plot(posix, Global_active_power, 
      type = "l",
      xlab="", 
      ylab="Global Active Power (kilowatts)"))

#Closing the png file device - back to default
dev.off()
