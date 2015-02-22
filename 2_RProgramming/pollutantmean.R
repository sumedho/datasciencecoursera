pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  # Create vector of total values
  total_vec<-vector(mode="numeric",length=0)
  
  # Loop through files 
  for(file in id)
  {
    # Create the complete filename from input
    f<-paste(sprintf("%03d",file),".csv",sep="")
    
    # Create the full filepath
    fpath<-file.path(directory,f)
    
    # Read in the required column
    data<-read.csv(fpath)[,c(pollutant)]
    
    # Add the current data column vector to the sum
    total_vec<-c(total_vec,data)
  }  
  
  # Find the mean of all non-NA values
  m<-mean(total_vec[!is.na(total_vec)])
  
  # Round to 3 significant figures
  m<-round(m,digits=3)
  
  # Return the mean
  return(m)
}