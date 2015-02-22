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

# Read in the data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")

# grab only Baltimore City and Los Angeles County measurements
NEI<-subset(NEI, NEI$fips %in% c("24510","06037"))

# Merge classification codes into NEI
NEI_SCC<-merge(NEI,SCC,by="SCC")

# Grab the Motor vehicle sources - uses Mobile and Highway as keywords to grab all on-road data
mvsources<-subset(NEI_SCC,grepl("Mobile", SCC.Level.One ) & grepl("Highway", SCC.Level.Two))

# Use ddply to calculate the final dataframe - table by fips and year using col sum
df<-ddply(mvsources,c("fips","year"), numcolwise(sum))

# Separate the LA and BC areas
la<-df[df$fips=="06037",]
bc<-df[df$fips=="24510",]

# Grab just the total emissions data and calculate the difference
la_change<-diff(la$Emissions)
bc_change<-diff(bc$Emissions)

# Create empty data.frame to hold % change data
change<-data.frame(matrix(ncol=0,nrow=6))

# Calculate the percentage change for each point
percent <-c(la_change[1]/la$Emissions[1]*100,la_change[2]/la$Emissions[2]*100,la_change[3]/la$Emissions[3]*100,bc_change[1]/bc$Emissions[1]*100,bc_change[2]/bc$Emissions[2]*100,bc_change[3]/bc$Emissions[3]*100);

# Create new data frame with all data
change$city<-c("06037","06037","06037","24510","24510","24510")
change$percent<-percent
change$year<-c("1999-2002","2002-2005","2005-2008","1999-2002","2002-2005","2005-2008")

# Create a scatterplot for each city with linear regression line
p1<-qplot(factor(year),Emissions, data = df, geom="point", color=fips,xlab="Year",ylab="PM2.5 Emissions (Tons)") + facet_grid(fips~., scales="free_y") + geom_smooth(method="lm",aes(group=1),se=FALSE) + scale_color_discrete(name ="Location", labels=c("Los Angeles County", "Baltimore City")) + theme(legend.title=element_blank())

# Barplot of results 
p2<-qplot(factor(year),percent, data = change, geom="bar", fill=city, stat="identity", position = "dodge", xlab="Year Interval",ylab="Percentage Change") + scale_fill_discrete(name ="Location", labels=c("Los Angeles County","Baltimore City")) + theme(legend.title=element_blank()) 

# Create new plot file
png("plot6.png", width=1100,height=600) # set output format

grid.arrange(p1,p2,ncol=2,main="Change in Total Motor Vehicle Emissions")

# close file
dev.off() 