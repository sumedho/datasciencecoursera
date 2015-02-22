# The MIT License (MIT)
#
# Copyright (c) 2015 <copyright holders>
#    
#    Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#    
#    The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


require(data.table)

NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

df<-subset(NEI, NEI$fips %in% c(24510)) # grab only Baltimore City measurements

dt<-data.table(df) # Convert to data table
data<-dt[,list(sum=sum(Emissions)),by=year] # Get sum of emissions by year

# Create new plot file
png("plot2.png", width=480,height=480) # set output format

# Bar plot of emissions
barplot(data$sum, main="Total PM2.5 Emissions in Baltimore City", xlab = "Year", ylab="PM2.5 Emissions (Tons)",names.arg=data$year, col="orange")

# close file
dev.off() 