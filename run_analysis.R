####The code reads the Samsung Data in the working directory and outputs a tidy data.

# The main steps followed are the following :

# STEP 1: Extracts only the measurements on the mean and standard deviation for each measurement. 
# STEP 2: Merges the training and the test sets to create one data set.
# STEP 3: Uses descriptive activity names to name the activities in the data set
# STEP 4: Appropriately labels the data set with descriptive variable names. 
# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#### STEP 1: Extracts only the measurements on the mean and standard deviation for each measurement. 

## Read as data.frames, the test and train and the features text files in the UCI HAR Dataset

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# Name the column in subject and Y test and train files to "subject" and "activity" resp
colnames(subject_test)<-"subject"
colnames(subject_train)<-"subject"
colnames(Y_test)<-"activity"
colnames(Y_train)<-"activity"

 
# Extract the features pertaining to mean and standard deviation out of 561 features in the "features" data frame

a <- grep("mean",features[,2]) # list of column positions feature which contain "mean"
b <- grep("std",features[,2]) # list of column positions feature which contain "std"
col_rele <- sort(c(a,b)) # 79 out of 561 variables contain mean or std

# Using the above column draw a subset of X_test and X_train each which includes only columns with mean and std 

subsetX_test<-X_test[,col_rele]
subsetX_train<-X_train[,col_rele]

# Add subject and Y columns to X_test  and X_train data frames
newX_test <- cbind(subsetX_test,Y_test,subject_test)
newX_train <- cbind(subsetX_train,Y_train,subject_train)

#### STEP 2: Merges the training and the test sets to create one data set.

Merge_data <- rbind(newX_test,newX_train)

####  STEP 3: Use descriptive activity names to name the activities in the data set (in the activity column).

Merge_data$activity <- sub("1", "WALKING", Merge_data$activity)
Merge_data$activity <- sub("2", "WALKING_UP", Merge_data$activity)
Merge_data$activity <- sub("3", "WALKING_DOWN",Merge_data$activity)
Merge_data$activity <- sub("4", "SITTING", Merge_data$activity)
Merge_data$activity<- sub("5", "STANDING", Merge_data$activity)
Merge_data$activity <- sub("6", "LAYING", Merge_data$activity)


####  STEP 4:  Appropriately label the data set with descriptive variable names.

features_rele<-features[col_rele,] # relevant features: the features which are not related to mean and std removed

# the function mysub perfomes multiple substitutions to the features to obtain shorter yet descriptive fetures list
pattern <- c("Acc","Body","BodyBody" ,"Freq", "Gravity","Gyro", "Jerk", "Mag", "-mean","-std","-X", "-Y", "-Z", "[[:punct:]]")
replacement <- c("acc", "bdy","bdy", "freq","gr","gy","jk","mag", "mu", "std", "X", "Y", "Z", "")
f <- features_rele[ ,2]
mysub <- function(pattern, replacement, f) {
  for (i in 1:length(pattern)) {
    result <- gsub(pattern[i], replacement[i], result)
  }
}

# assign these new descriptive names to the columns of Merge_data STEP 3 
act_descrp <- c(result, "activity", "subject")  # vector with column names including all 79 features, "activity", "subject" 
names(Merge_data)<- act_descrp 



#### STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2)
 
# Merge the feature columns of the data frame and find the required means mean  
melt_data <- melt(Merge_data, id=c("activity", "subject"), measure.vars=) # dim = 813621 x 4
mean_data <- dcast(melt_data, subject+activity ~ variable, mean) # dim = 180 x 81

# Put the data into long form 
tidy_data <- melt(mean_data, id=c("activity", "subject"), measure.vars=)  # dim = 14220 x 4
  
# rename last two columns from "variable" and "value" to "feature" and "mean"
names(tidy_data)[3]<-"feature"
names(tidy_data)[4]<-"mean"

# Reorder the columns of tidy_data so that subject is the first and activity is the second column 
tidy_data<-tidy_data[, c(2,1,3,4)]

# Write the output as a ".txt" file
write.table(tidy_data, "TidyData.txt", quote=FALSE, row.names = FALSE, col.names=FALSE)


