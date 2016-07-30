This procedure takes training and test data and congeals them into a tidy data set for averaging.

A few important points:

(a) "Features" are the variable names (column names).
(b) Test labels and Training labels are the NUMERIC activity labels.
        Note that these are later converted into sensible language via the activity_labels.

This assumes that you have the dplyr package installed.

The following are the basic steps performed, which are commented in detail in the R script:

1. Read in data files;
2. Use dplyr package to convert all files to tbl_df;
3. Rename some of the column names for the features, activities and labels;
4. Patch in column names into test and train data;
5. Bind the numeric row labels;
6. Lookup/patch in descriptive activity code labels (e.g., walking, Laying)
7. Extract only columns dealing with mean or standard deviation (WIDE form used);
8. Use dplyr to "group_by" activity and subject;
9. Create tidy data set.

The attached CodeBook.md is an additional useful reference to the variable names.