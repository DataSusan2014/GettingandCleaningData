GettingandCleaningData
======================

Programming assignment for Coursera - Getting and Cleaning Data


#09-21-2014
#Susan, susandata2014@gmail.com
The data was downloaded from the Internet and unzipped. The following files were loaded into R: Activity_Labels, Features, Subject_train, Subject_test, x_train, x_test, y_train, y_test. The Features table is going to become the column headings, so at this point the text was cleaned up to remove “()” and “-“ from the names. Once completed, the column headings from the Features table were added to the x_test and x_train tables. Column names “ActivityID” and “Activity” were added to y_test and y_train and “Subject” was added to Subject_train and Subject_test. Activity_Labels were then merged with the y_test and y_train tables. Then one table was created that contained all the data, called mergedAll.
Once a table was created with all the data, a second table was created that only contained columns for means and standard deviations, called justMeanStd. 
Finally, a table was created that contained the means of every column, grouped by Subject and Activity, called AveragesbySubjAct. 
