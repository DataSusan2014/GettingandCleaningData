# File-Name:       run_analysis.R           
# Date:            09_21_2014                                
# Author:          Susan Lupiani
# Email:           datasusan2014@gmail.com                                      
# Purpose:         download and unzip files for the web
 

#set working directory
setwd("C:/Users/Susan/Documents/R")

#load packages
library(dplyr)

#Download file from Internet
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Dataset.zip")

#Extract files from zip
unzip("Dataset.zip")

#read in all data
#xdata
x_test <- read.table("~/R/UCI HAR Dataset/test/X_test.txt", quote="\"")
x_train <- read.table("~/R/UCI HAR Dataset/train/x_train.txt", quote="\"")
#ydata
y_test <- read.table("~/R/UCI HAR Dataset/test/y_test.txt", quote="\"")
y_train <- read.table("~/R/UCI HAR Dataset/train/y_train.txt", quote="\"")
#subjectdata
subject_test <- read.table("~/R/UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("~/R/UCI HAR Dataset/train/subject_train.txt", quote="\"")
#activity_labels and features
activity_labels <- read.table("~/R/UCI HAR Dataset/activity_labels.txt", quote="\"")
features <- read.table("~/R/UCI HAR Dataset/features.txt", quote="\"")

#Adding column names to test data
colnames(subject_test) <- c("Subject")

#clean up features
features[ ,2] <- gsub("\\(", "", features[ ,2])
features[ ,2] <- gsub("\\)", "", features[ ,2])
features[ ,2] <- gsub("\\-", ".", features[ ,2])

colnames(x_test) <- features[,2]
colnames(y_test) <- c("ActivityID")
colnames(activity_labels) <- c("ActivityID", "Activity")

#Adding column names to training data
colnames(subject_train) <- c("Subject")
colnames(x_train) <- features[,2]
colnames(y_train) <- c("ActivityID")

#merging data together
#add activity_labels to data
y_test <- merge(y_test, activity_labels)
y_train <- merge(y_train, activity_labels)

#create one table with test data and one table with train data
mergedTest <- cbind(cbind(subject_test, y_test), x_test)
mergedTrain <- cbind(cbind(subject_train, y_train), x_train)

#create one table with all data
mergedAll <- rbind(mergedTest, mergedTrain)

#find columns with mean and std (include Subject and Activity columns first)
ident <- c(1,3)
means <- grep("mean", colnames(mergedAll))
stds <- grep("std", colnames(mergedAll))
meanstd <- c(ident, c(means, stds))

#create new data set with only the above columns
justMeanStd <- mergedAll[ ,meanstd]

#to calculate statistics, convert to tbl_df
cran <- tbl_df(justMeanStd)

#group by Subject and activity
by_SubjAct <- group_by(cran, Subject, Activity)

#calculate means for each column (by Subject and Activity)

AveragesbySubjAct <- summarise_each(by_SubjAct, funs(mean))

#create text file of results
write.table(AveragesbySubjAct, file = "Question5.csv", row.name=FALSE)

