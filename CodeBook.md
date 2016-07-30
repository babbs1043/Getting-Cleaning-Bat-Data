This code book describes the Testing and Training data used, as well as
variable transformations performed.

Read in the following data files using read.table, header=FALSE,sep="".
(a) test data (X_test.txt)
(b) test labels (y_test.txt)
(c) test subjects (subject_test.txt)
(d) training data (X_train.txt)
(e) training labels (y_train.txt)
(f) training subjects (subject_train.txt)
(g) features (features.txt)
(h) activity labels (activity_labels.txt)

Note that features will become the column labels.
test labels become the row labels for the test data, and training labels become the row labels
for the training data.
Note also that these interim numerical row labels are then converted into understandable activity labels using the activity labels file.

Activity Labels:
1. Walking
2. Walking Upstairs
3. Walking Downstairs
4. Sitting
5. Standing
6. Laying

Subject Numbers:
(a) Numbers from 1-30, identifying the various test subjects.

Load dplyr package using library(dplyr).

Columns used in the analysis were ANY columns containing the words "mean" or "std" anywhere.

Variable names (column names) were pulled from the features file (features.txt)

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Refer to the additional documentation provided with the raw data (features_info.txt) for
additional details concerning the features naming and variables, as well as their meanings.

Full comments on all processes done are contained in the run_analysis.R script.


