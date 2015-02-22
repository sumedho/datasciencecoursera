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
require(ggplot2)

# Read in the data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

# grab only Baltimore City measurements
baltimoreNEI<-subset(NEI, NEI$fips %in% c(24510)) 

# Merge classification codes into NEI
baltimoreNEI_SCC<-merge(baltimoreNEI,SCC,by="SCC")

# Grab the Motor vehicle sources - uses Mobile and Highway as keywords to grab all on-road data
mvsourcesBaltimore<-subset(baltimoreNEI_SCC,grepl("Mobile", SCC.Level.One ) & grepl("Highway", SCC.Level.Two))

# Convert to data table
dt<-data.table(mvsourcesBaltimore)

# Get sum by year using data.table
df<-dt[,list(sum=sum(Emissions)),by=year]

# Barplot of emissions by year
qplot(factor(year),sum, data = df, fill="red",geom="bar", stat="identity", position = "dodge", xlab="Year",ylab="PM2.5 Emissions (Tons)", main="Motor Vehicle Emissions - Baltimore City") + guides(fill=FALSE)

# Save the plot to png in current working directory
ggsave("plot5.png", width=7, height=6, dpi=100)