best <- function(state, outcome) {
  ## Read outcome data

## Check that state and outcome are valid
## Return hospital name in that state with lowest 30-day death
## rate
  data<-read.csv("outcome-of-care-measures.csv", colClasses = "character")
  data[,11]<-suppressWarnings(as.numeric(data[,11]))
  data[,17]<-suppressWarnings(as.numeric(data[,17]))
  data[,23]<-suppressWarnings(as.numeric(data[,23]))
  
  state_data<-subset(data,data$State==state)
  names(state_data)[2]<-"hospital"
  names(state_data)[11]<-"ha"
  names(state_data)[17]<-"hf"
  names(state_data)[23]<-"pn"
  
  sel<-0
  if(outcome == "heart attack")
  {
    sel<-11
  }
  else if(outcome =="heart failure")
  {
    sel<-17
  }
  else if(outcome == "pneumonia")
  {
    sel<-23
  }
  else
  {
    stop("invalid outcome")
  }
  
  sorted<-state_data[order(state_data[[sel]]),]
  top_ha<-sorted[1,2]
  if(is.na(top_ha))
  {
    stop("invalid state")
  }
  return(top_ha)
}