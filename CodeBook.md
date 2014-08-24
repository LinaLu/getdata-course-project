Introduction:
=================
This code book describes the variables of the data, and all transformations that have been applied on the it.

Data set description
=================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Variables 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

Data transformations
=====================

The raw data need to be stored in the `UCI HAR Dataset/` directory.

#### Merges the training and the test sets to create one data set.

`read.csv` is used to load the data to R environment for the data.
```
training <- read.csv("UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
training[,562]<- read.csv("UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="")
training[,563] <- read.csv("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")

test <- read.csv("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
test[,562] <- read.csv("UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="")
test[,563] <- read.csv("UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")

dataset <- rbind(training,test)

features <- read.csv("UCI HAR Dataset/features.txt", header=FALSE, sep="")
names(dataset) <- c(as.vector(features$V2), "activity", "subject")
```

#### Subset by keeping only columns/variables measuring either mean or standard deviation. 
Column are filtered by pattern `mean` and `std`, other columns are dropped from the data set
```
mean_std_index <-grep("mean|std",names(dataset), ignore.case = TRUE)
dataset_mean_std <- subset(dataset[,c(mean_std_index,562,563)])
```
#### Descriptive activity names to name the activities in the data set. 
The class labels linked with their activity names fetched from the file `activity_labels.txt` and applied to dataset_mean_std.
```
activity_label <- read.csv("UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")

dataset_mean_std$activity <- sapply(dataset_mean_std$activity, function(x){
    activity_label[x,2]
  })

```
#### Renames the data set columns with more human friendly names
```
names(dataset_mean_std) <- replatePatterns(c("[()]","-", "A", "B", "G", "J", "M"), 
                                           c("","_", "_a", "_b", "_g", "_j", "_m"), 
                                           names(dataset_mean_std))
```

####  Creates a second *tidy* data set with the average of each variable for each activity and each subject. 
```
dataset_average <- aggregate(. ~ activity + subject, data = dataset_mean_std, mean)
```
####  Exports the created dataset as tidy.txt
```
write.table(dataset_average,"tidy.txt",row.name=FALSE)
```