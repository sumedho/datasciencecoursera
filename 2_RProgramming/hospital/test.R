outcome<-read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcome[,11]<-as.numeric(outcome[,11])
outcome[,17]<-as.numeric(outcome[,17])
outcome[,23]<-as.numeric(outcome[,23])
ha<-11
hf<-17
pn<-23
texas<-subset(outcome,outcome$State=="TX")
sorted<-texas[order(texas[[11]])]
top_ha<-sorted[2,1]

switch(outcome,
       "heart attack"=11,
       "heart failure"=17,
       "pneumonia"=23
       )