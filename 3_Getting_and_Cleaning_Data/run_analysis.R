run_analysis <- function(){
    # Course Project - Runs an analysis on UCI HAR Dataset 
    # Course: Getting and Cleaning Data - John Hopkins 
    # coursera.org
    # Date: 17 Nov 2014
    #
    
    require(plyr) # Load the plyr package if not already loaded.
    
    ##
    ## Features and activities read in, cleaned and made ready for use.
    ##    
    features<-read.table("UCI HAR Dataset/features.txt", quote="\"") # Read in the features list
    features<-gsub("\\(\\)|-","",features[,2]) # Strip () and any - characters from dataframe and return vector
    features<-tolower(features) # Convert all feature labels to lower case
    
    # Get only features which end in mean() or std(), these are the summarized mean and std
    row_select<-subset(features,grepl("^.+(mean|std)$",features)) 
       
    # Read in activity labels
    activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt", quote="\"")
    
    ##
    ## Test Data is read, cleaned and bound together
    ##
    # Read in the y_test data (this identifies which activity was measured)
    y_test<-read.table("UCI HAR Dataset/test/y_test.txt", quote="\"",col.names="activity")
    subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", col.names="subject")
    y_test<-cbind(y_test,subject_test) # Column bind the activity with subject
    x_test<-read.table("UCI HAR Dataset/test/X_test.txt", quote="\"",col.names=features) # Read in the measurements 
    
    x_test<-subset(x_test, select=row_select) # Select only the measurements needed (found before in rowselect)
    x_test<-cbind(y_test,x_test) # Bind the subject, activity and measurements for test data
    
    print("Loaded and cleaned test data...") # Let user know whats happening
    
    ##
    ## Training data is read, cleaned and bound together
    ##
    # Read in the y_train data (this identifies which activity was measured)
    y_train<-read.table("UCI HAR Dataset/train/y_train.txt", quote="\"",col.names="activity")
    subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", col.names="subject")
    y_train<-cbind(y_train,subject_train) # Column bind the activity with subject
    x_train<-read.table("UCI HAR Dataset/train/X_train.txt", quote="\"",col.names=features) # Read in the measurements 
    
    x_train<-subset(x_train, select=row_select) # Select only the measurements needed (found before in rowselect)
    x_train<-cbind(y_train,x_train) # Bind the subject, activity and measurements for test data
    
    print("Loaded and cleaned train data") # Let user know whats happening
    
    ##
    ## Binding of final datasets, cleanup and writing to disk
    ##
    dt<-rbind(x_train,x_test) # Bind rows of train and test data set
    
    # Convert activity column to factor...then rename levels of factor using col 2 of activity labels
    # this converts numbers to character labels
    dt$activity<-factor(dt$activity, labels=activity_labels[,2]) 
    
    # Fix incorrectly named columns
    names(dt)[15]<-"fbodyaccjerkmagmean"
    names(dt)[16]<-"fbodyaccjerkmagstd"
    names(dt)[17]<-"fbodygyromagmean"
    names(dt)[18]<-"fbodygyromagstd"
    names(dt)[19]<-"fbodygyrojerkmagmean"
    names(dt)[20]<-"fbodygyrojerkmagstd"
    
    # Use column mean for each measurement is found based on subject and then activity
    dt<-ddply(dt,c("subject","activity"),numcolwise(mean)) # Get mean of each column based on subject and activity
    
    write.table(dt,"tidy_data.txt",row.name=FALSE) # Write data to disk
    print("Finished processing...data written to tidy_data.txt") # Let user know whats happening
    return(dt) # return the final data frame   
}




