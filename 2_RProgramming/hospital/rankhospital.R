rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data

## Check that state and outcome are valid
## Return hospital name in that state with the given rank
## 30-day death rate
  
  data<-read.csv("outcome-of-care-measures.csv", colClasses = "character")
  data[,11]<-suppressWarnings(as.numeric(data[,11]))
  data[,17]<-suppressWarnings(as.numeric(data[,17]))
  data[,23]<-suppressWarnings(as.numeric(data[,23]))
  
  # Check that the state exists in the data
  if(!state %in% data$State)
  {
    stop("invalid state")
  }
  
  # Grab the state subset
  state_data<-subset(data,data$State==state)
  # Rename the columns
  names(state_data)[2]<-"hospital"
  names(state_data)[11]<-"ha"
  names(state_data)[17]<-"hf"
  names(state_data)[23]<-"pn"
  
  # Select the appropriate column 
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
  
  
  # Sort on ascending outcome and then hospital name
  sorted<-state_data[order(state_data[[sel]],state_data[[2]]),]
  
  # Get rid of all NA values
  so<-subset(sorted, !is.na(sorted[[sel]]))
  
  # Check the num value and assign correctly
  if(num=="best")
  {
    num<-1
  }
  else if(num=="worst")
  {
    n<-dim(so)
    num<-n[1]
  }
  else if(num==is.numeric(num))
  {
    num<-num
  }
 
  # Return final value
  return(sorted[num,2])
}