# Course Project - Basic Plotting
# Course: Getting and Cleaning Data - John Hopkins 
# coursera.org
# Date: 5 Feb 2014
# Plot1

# read, subset and convert
hpc <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE) # read data
data<-subset(hpc, hpc[[1]] %in% c("1/2/2007","2/2/2007")) # grab only the dates of interest
data[,3]<-suppressWarnings(as.numeric(data[,3])) # convert global active power to numeric
data[[1]]<-as.POSIXct(paste(data[,1],data[,2]), format="%d/%m/%Y %H:%M:%S") # combine date and time into POSIX time

# plotting 
png("plot1.png", width=480,height=480) # set output format
hist(data[[3]], col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)") #plot histogram in red
dev.off() # close file