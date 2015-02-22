# Course Project - Basic Plotting
# Course: Getting and Cleaning Data - John Hopkins 
# coursera.org
# Date: 5 Feb 2014
# Plot 3

# read, subset and convert
hpc <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE) # read data
data<-subset(hpc, hpc[[1]] %in% c("1/2/2007","2/2/2007")) # grab only the dates of interest
data[,3]<-suppressWarnings(as.numeric(data[,3])) # convert global active power to numeric
data[,7]<-suppressWarnings(as.numeric(data[,7])) # convert sub metering 1 to numeric
data[,8]<-suppressWarnings(as.numeric(data[,8])) # convert sub metering 2 to numeric
data[,9]<-suppressWarnings(as.numeric(data[,9])) # convert sub metering 3 to numeric
data[[1]]<-as.POSIXct(paste(data[,1],data[,2]), format="%d/%m/%Y %H:%M:%S") # combine date and time into POSIX time

# plotting 
png("plot3.png", width=480,height=480) # set output format
plot(data$Date,data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="") # plot first submeter
lines(data$Date, data$Sub_metering_2, col="red") # plot second submeter in red
lines(data$Date, data$Sub_metering_3, col="blue") # plot third submeter in red
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=c(1,1,1),col=c("black","red","blue")) # plot legend
dev.off() # close file