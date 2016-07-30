## This assumes that there is a subfolder named 'test' in your current working directory.

testdata<-read.table("./test/X_test.txt",header=FALSE,sep="")  ## read in test data
testlabels<-read.table("./test/y_test.txt",header=FALSE,sep="")  ## read in test labels
        ## These will be the initial row 'names' for the test data.
testsubjects<-read.table("./test/subject_test.txt",header=FALSE,sep="")  ## read in test subjects


trainingdata<-read.table("./train/X_train.txt",header=FALSE,sep="")  ## read in training data
traininglabels<-read.table("./train/y_train.txt",header=FALSE,sep="")  ## read in training labels
        ## These will be the initial row 'names' for the training data.
trainingsubjects<-read.table("./train/subject_train.txt",header=FALSE,sep="")  ## read in test subjects


features<-read.table("./features.txt",header=FALSE,sep="")  ## read in features;
        ## These will become the column labels of the training and test data.

activitylabels<-read.table("./activity_labels.txt",header=FALSE,sep="")  ## read in activity labels
        ## These will become the descriptive row names

## Assumes you have the dplyr package available.
library(dplyr)

## Converts all of the data files into tbl_df for easier workings.
testdata_df<-tbl_df(testdata)
testlabels_df<-tbl_df(testlabels)
testsubjects_df<-tbl_df(testsubjects)

trainingdata_df<-tbl_df(trainingdata)
traininglabels_df<-tbl_df(traininglabels)
trainingsubjects_df<-tbl_df(trainingsubjects)

features_df<-tbl_df(features)

activitylabels_df<-tbl_df(activitylabels)


## Give the features file more descriptive column names.
features_df<-rename(features_df,featurelabels=V2)

## Give the activity labels file a more descriptive column name.
activitylabels_df<-rename(activitylabels_df,activitycodes=V2)

## Give the subjects files (train and test) more descriptive column names.
testsubjects_df<-rename(testsubjects_df,subjectnumber=V1)
trainingsubjects_df<-rename(trainingsubjects_df,subjectnumber=V1)


colnames(testdata_df)<-features_df$featurelabels  ## For the test data
colnames(trainingdata_df)<-features_df$featurelabels  ## For the training data

## Make the column names in the labels files more descriptive
traininglabels_df<-rename(traininglabels_df,activitynumbers=V1)
testlabels_df<-rename(testlabels_df,activitynumbers=V1)


## Bind the row number labels as the first column
testdata_df<-cbind(testlabels_df,testsubjects_df,testdata_df)
trainingdata_df<-cbind(traininglabels_df,trainingsubjects_df,trainingdata_df)

## Create a descriptive activity code vector.
activitydescrs<-c(Walking=1,Walking_Upstairs=2,walking_Downstairs=3,Sitting=4,Standing=5,Laying=6)

## Patch in the descriptive activity name for each of test and training data
testdata_df$activityname<-names(activitydescrs)[match(testdata_df$activitynumbers,activitydescrs)]
trainingdata_df$activityname<-names(activitydescrs)[match(trainingdata_df$activitynumbers,activitydescrs)]

## Merge the Training and Test data together.
joineddata_df<-bind_rows(testdata_df,trainingdata_df)

## Next let's piecewise extract the activity names, mean columns and standard deviation columns.
## Also the subjects
meanextractDF<-select(joineddata_df,contains("mean"))
stdextractDF<-select(joineddata_df,contains("std"))
activityextractDF<-select(joineddata_df,contains("activityname"))
subjectextractDF<-select(joineddata_df,contains("subjectnumber"))

## And sew them together with bind_cols in dplyr
meanstd_DF<-bind_cols(activityextractDF,subjectextractDF,meanextractDF,stdextractDF)

## Next, "group_by" activityname in dplyr
meanstd_DF_grouped<-group_by(meanstd_DF,activityname,subjectnumber)

## To get the final tidy data set
tidy_avg_set<-summarize_all(meanstd_DF_grouped,funs(mean))


