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

require(plyr) 
require(ggplot2)
require(gridExtra)

# Read in data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

# grab only Baltimore City measurements
df<-subset(NEI, NEI$fips %in% c(24510)) 

# Use ddply to group by type and then year with col sum
data<-ddply(df,c("type","year"), numcolwise(sum))

# Plot bar plot of data
p1<-qplot(factor(year),Emissions, data = data, geom="bar", fill=type, stat="identity", position = "dodge", xlab="Year", ylab="PM 2.5 Emissions (Tons)")

# Plot line graph of data
p2<-qplot(factor(year),Emissions, data = data, colour = type, geom = "line", group = type, xlab = "Year", ylab="PM 2.5 Emissions (Tons)") + geom_point()

# Create new plot file
png("plot3.png", width=960,height=480) # set output format

# Arrange final plot as two side by side graphs
grid.arrange(p1,p2,ncol=2, main="Total Emissions by Type - Baltimore City")

# close file
dev.off() 