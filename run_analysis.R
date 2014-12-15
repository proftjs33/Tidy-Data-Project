##############################################################
# script for part 1 of the 'Getting and Cleaning Data' project
##############################################################
# set the working directory to the master directory
#setwd("~/GitHub/Tidy-Data-Project")

#### COMMON LABELS AND FEATURES #########################
# read the activity labels, this gives a 6x2 table linking the 
# numbers 1:6 with the 6 activities of the test data
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
# read the features, this gives a 561x2 linking the 
# numbers 1:561 with the features (summary statistics
# on different observation types)
features <- read.table("UCI HAR Dataset/features.txt")

#### TEST DATA ##########################################
# read the set of outcomes (values of the summary
# statistics) for the test subjects, 
# this gives a 2947x561 table of 561 
# statistical values for 2947 tests
x_test <- read.table("UCI HAR Dataset/test/x_test.txt")
# read the set of activity id numbers associated with 
# each line of data in the y_test table
# this gives a 2947x1 table of values from 1:6
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
# convert the numbers into descriptive strings as defined in activity_labels
test_activities <- as.matrix(activity_labels[y_test[,1],2])
colnames(test_activities) <- "activities"
# read the number designating the test subject for each
# line of data in the x_test table,
# this gives a 2947x1 table containing values from 1:30
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
# add column headings to the 3 tables
colnames(x_test) <- features[,2]
colnames(subject_test) <- "subject"
colnames(y_test) <- "activity"
# bind the sets in the order "category", "subject", "activity", "data"
# result in train_data
test_data <- cbind("category"= "test", subject_test, test_activities, x_test)

#### TRAIN DATA ##########################################
# read the set of outcomes (values of the summary
# statistics) for the training subjects, 
# this gives a 2947x561 table of 561 
# statistical values for 2947 tests
x_train <- read.table("UCI HAR Dataset/train/x_train.txt")
# read the set of activity id numbers associated with 
# each line of data in the x_train table
# this gives a 2947x1 table of values from 1:6
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
# convert the numbers into descriptive strings as defined in activity_labels
train_activities <- as.matrix(activity_labels[y_train[,1],2])
colnames(train_activities) <- "activities"
# read the number designating the subject for each
# line of data in the x_train table,
# this gives a 2947x1 table containing values from 1:30
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
# add column headings to the 3 tables
colnames(x_train) <- features[,2]
colnames(subject_train) <- "subject"
colnames(y_train) <- "activity"
# bind the sets in the order "category", "subject", "activity", "data"
# result in train_data
train_data <- cbind("category"= "train", subject_train, train_activities, x_train)

#### ALL DATA #############################################################
# bind the rows of test_data to the bottom of train_data
all_data <- rbind(train_data,test_data)
# get the numbers of the columns that contain "mean" and not "meanFreq"
# meanCol <- grep("mean()",colnames(all_data))
meanCol <- intersect(grep("mean",colnames(all_data)),grep("meanFreq",colnames(all_data),invert=TRUE))
# get the numbers of the columns that contain "std"
stdCol <- grep("std()",colnames(all_data))
# combine and sort the column numbers
sortCols <- sort(c(1,2,3,meanCol,stdCol))
# extract the columns having names containing "mean" or "std"
mean_std_data <- all_data[,sortCols]
# write the table into the file raw_data.txt
write.table(mean_std_data,"raw_data.txt",row.names=FALSE)

#### CALCULATE THE MEANS OF ALL VARIABLES BY ACTIVITY AND SUBJECT ####
# For each factor column, find the mean for each activity, subject combination
n<-ncol(mean_std_data)
for(i in 4:n){
    x<-sapply(split(mean_std_data[,i], mean_std_data[,2:3]),mean)  
    if(i==4){
        z<-t(as.matrix(x))
    } else {
        y<-t(as.matrix(x))
        z<-rbind(z,y)
    }
}
# transpose the result, the row names contain the subject and activity
z<-t(z)
rowNames<-rownames(z)
# Name the columns according to the 'factor' in that column
colnames(z)<-colnames(mean_std_data)[4:n]
# get the subject and activity from the row names
# accumulate in subj_act_mat table
n<-nrow(z)
for( i in 1:n){
    subj_act<-t(as.matrix(unlist(strsplit(rowNames[i],"[.]"))))
    if(i==1) 
            subj_act_mat<-subj_act
    else
        subj_act_mat<-rbind(subj_act_mat,subj_act)
}
# Rename the columns
colnames(subj_act_mat)<-c("subject","activity")
# bind the columns of subj_act_mat and z
tidyData<-cbind(subj_act_mat,z)
write.table(tidyData,"tidyData.txt", row.names=FALSE)
