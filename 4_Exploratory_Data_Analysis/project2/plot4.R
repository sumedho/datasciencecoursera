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
require(maps)
require(gridExtra)

# Load zip_code, lat, long and fips data
# from: http://cran.r-project.org/web/packages/noncensus/index.html
# install.packages("maps")
# install.packages("noncensus")
load("zip_codes.RData") 

# Load data
SCC<-readRDS("Source_Classification_Code.rds")
NEI<-readRDS("summarySCC_PM25.rds")


# zip_codes has many lat,long for each fips code
# this takes the mean of lat,long for each fips code
# to get approx lat,long for each fips area
fipsdata<-ddply(zip_codes,c("fips"),numcolwise(mean))

# Merge fips data with NEI to add lat,long to NEI data based on fips
NEIandLatLong<-merge(NEI,fipsdata,by="fips")
completeNEI<-merge(NEIandLatLong,SCC,by="SCC")

# Subset data based on Electric generation and coal keywords
coal<-subset(completeNEI,grepl("Electric Generation", SCC.Level.Two ) & grepl("Coal", SCC.Level.Three))


cc<-ddply(coal,c("fips","year","latitude","longitude"), numcolwise(sum))

# Minimum longitude
minlong=-140

# Remove Hawaii islands from map as it causes problems with visualization
# the aim is to see the overall trend across America and the change in Hawaii
# is too small to visualize correctly at that scale.
cc<-cc[cc$longitude>minlong,]

# Get 1999 data
cc1999<-cc[cc$year==1999,]

# Get 2002 data
cc2002<-cc[cc$year==2002,]

# Get 2005 data
cc2005<-cc[cc$year==2005,]

# Get 2008 data
cc2008<-cc[cc$year==2008,]

# Grab all US states polygon data
all_states<-map_data("state")

# Plot map of states
p<-ggplot()+geom_polygon(data = all_states, aes(x=long, y=lat, group=group), colour="white", fill="grey70")

# Plot point data
# create separate plots for each year, plotting over the base map of state polygons of USA
p1<-p+geom_point(data=cc1999, aes(x=longitude, y=latitude, colour=Emissions, size=Emissions), alpha=0.7) + scale_size_area(max_size=8,limits=c(0,30000), breaks=c(5000,10000,15000,20000,25000,30000)) + scale_colour_gradient(low="blue", high="yellow", limits=c(0,20000)) + ggtitle("1999")
p2<-p+geom_point(data=cc2002, aes(x=longitude, y=latitude, colour=Emissions, size=Emissions), alpha=0.7) + scale_size_area(max_size=8,limits=c(0,30000), breaks=c(5000,10000,15000,20000,25000,30000)) + scale_colour_gradient(low="blue", high="yellow", limits=c(0,20000)) + ggtitle("2002")
p3<-p+geom_point(data=cc2005, aes(x=longitude, y=latitude, colour=Emissions, size=Emissions), alpha=0.7) + scale_size_area(max_size=8,limits=c(0,30000), breaks=c(5000,10000,15000,20000,25000,30000)) + scale_colour_gradient(low="blue", high="yellow", limits=c(0,20000)) + ggtitle("2005")
p4<-p+geom_point(data=cc2008, aes(x=longitude, y=latitude, colour=Emissions, size=Emissions), alpha=0.7) + scale_size_area(max_size=8,limits=c(0,30000), breaks=c(5000,10000,15000,20000,25000,30000)) + scale_colour_gradient(low="blue", high="yellow", limits=c(0,20000)) + ggtitle("2008")

# Create new plot file
png("plot4.png", width=1100,height=800) # set output format

# Make 4x4 grid of plots with title
grid.arrange(p1,p2,p3,p4,ncol=2, main="PM2.5 Emissions (Tons) - Coal Combustion ")

# close file
dev.off() 
