rankall <- function(outcome, num = "best") {
  ## Read outcome data

## Check that state and outcome are valid
## For each state, find the hospital of the given rank
## Return a data frame with the hospital names and the
## (abbreviated) state name
  
  
  data<-read.csv("outcome-of-care-measures.csv", colClasses = "character")
  data[,11]<-suppressWarnings(as.numeric(data[,11]))
  data[,17]<-suppressWarnings(as.numeric(data[,17]))
  data[,23]<-suppressWarnings(as.numeric(data[,23]))
  
  # Get list of unique state names
  state_list<-unique(data$State)
  
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
  
  # Create empty vectors to store data
  hospital<-vector(mode="character",length=0)
  state<-vector(mode="character",length=0)
  
  # Loop through state data
  for(state_id in state_list)
  {
    # Get each state in turn
    state_data<-subset(data,data$State==state_id)
    
    # Sort on ascending outcome and then hospital name
    sorted<-state_data[order(state_data[[sel]],state_data[[2]]),]
    
    # Get rid of all NA values
    so<-subset(sorted, !is.na(sorted[[sel]]))
    
    
    # Check the num value and assign correctly
    if(num=="best")
    {
      # If best grab the 1st entry
      hospital<-c(hospital,so[1,2])
      state<-c(state,state_id)
    }
    else if(num=="worst")
    {
      # Grab last value (nrow of data frame)
      hospital<-c(hospital,so[nrow(so),2])
      state<-c(state,state_id)
    }
    else 
    {
      # Or just grab the number given
      hospital<-c(hospital,so[num,2])
      state<-c(state,state_id)
    }

      
  }
  # Create the final data frame
  complete<-data.frame(hospital,state)
  # Sort the data frame on state names
  complete<-complete[order(complete[[2]]),]
  # Return the final answer
  return(complete)
}