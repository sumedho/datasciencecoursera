CodeBook
=============

###Setup

Course project for Getting and Cleaning Data. 

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Raw Data

####Identifying information
* `features.txt` - A text file containing names for each feature (e.g. acceleration on X, gyro on Y).
* `activity_labels.txt` - A text file containing the labels for each activity (WALKING, LAYING etc).
* `subject_test.txt` - Contains an integer which identifies each of the test subjects.
* `subject_train.txt` - Contains an integer which identifies each of the train subjects.
* `y_test.txt` - Contains an integer which corresponds to the measured activity for the test data.
* `y_train.txt` - Contains an integer which corresponds to the measured activity for the train data.

####Measurements
The measurements that are associated with each subject and associated activity are contained in the following:

* `X_test.txt` - Contains measurements for test subjects for every feature in the `features.txt` file.
* `X_train.txt` - Contains measurements for train subjects for every feature in the `features.txt` file.

###Codebook

1. Read in `features.txt`, strip () and - characters, convert to lowercase and output a 561 element character vector.
2. Subset the required variables - only aggregate mean and std measurements (not individual X,Y or Z) were subset. Theye were selected due to the fact that aggregate variables have mean() or std() at the end of the name.
3. Read in `activity_labels.txt` to 6 x 2 data frame with column 1 being integers and column 2 as a factor with 6 levels (1,2,3,4,5,6).
4. Read in `y_test.txt` to a vector of integers. The column name is *activity*.
5. Read in `subject_test.txt` to a vector of integers. The column name is *subject*.
6. Column bind the `subject_test.txt` and `y_test.txt` to create a data frame.
7. Read the `X_test.txt` into a data frame of all numbers. Assign the feature names to the column names on import.
8. Subset out the required features from the full `X_test.txt` dataset.
9. Column bind the Step 6 and Step 8 datasets and output a data frame.
10. Repeat Steps 4 to 9 on the train dataset.
11. Row bind the final test and train datasets into a final large data frame.
12. Apply a factor to the activity labels and change the labels to descriptive labels from the `activity_labels.txt`. The factor has 6 levels and consists of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
13. The columns from 15 to 20 were renamed to fbodyaccjerkmagmean, fbodyaccjerkmagstd, fbodygyromagmean, fbodygyromagstd, fbodygyrojerkmagmean, fbodygyrojerkmagstd. 
14. The data was summarized by taking mean of each feature for each activity for each subject. 
15. The final data frame was kept in narrow format and exported to a text file called `tidy_data.txt` using row.names=FALSE (A requirement of the course). 






