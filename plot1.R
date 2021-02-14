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
#View(household)
#summary(household)

#Data period 2007/02/01 to 2007/02/02
d1<-strptime("2007/02/01", "%Y/%m/%d")
d2<-strptime("2007/02/02", "%Y/%m/%d")

#Only keep the rows whose dates are between time1 and time2
household1 <-household[household$Date>=d1 & household$Date<=d2,]
#View(household1)
#summary(household1)


#Transform the third column into numeric
household1[,3]<-as.numeric(as.character(household1[,3]))
  #-->Error in hist.default(household$Global_active_power, main = "Global Active Power",  : 
  #'x' must be numeric
  
  #Check file for characteristics 
  #library(dplyr)
  #cran <- tbl_df(household)
  #cran


#Save histogram as plot1.png
png("plot1.png", width = 480, height = 480)


#Create histogram
hist(household1$Global_active_power, 
     main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col="red")

#Closing the png file device - back to default
dev.off()

