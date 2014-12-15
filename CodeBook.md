This file contains descriptions of the data, the variables and the steps used 
to clean the data.
-------------------------------------------------------------------------------
I. DATA
	A. 	The source of the data is the website
		https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
		a full description is available at the website
		http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
		Much of the following data and factor description is taken from the files
		provided in the .zip file.
	B.	Description of experiments performed to obtain data.
	===========================================================================
	Human Activity Recognition Using Smartphones Dataset
	Version 1.0
	===========================================================================
	Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
	Smartlab - Non Linear Complex Systems Laboratory
	DITEN - Università degli Studi di Genova.
	Via Opera Pia 11A, I-16145, Genoa, Italy.
	activityrecognition@smartlab.ws
	www.smartlab.ws
	===========================================================================
	Experiments were carried out with a group of 30 volunteers within an age 
	bracket of 19-48 years. Each person performed six activities (WALKING, 
	WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing 
	a smartphone (Samsung Galaxy S II) on the waist. Using its embedded 
	accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular
	velocity were captured at a constant rate of 50Hz. 
	
	The obtained dataset was randomly partitioned into two sets, where 70% of the 
	volunteers were selected for generating the training data and the remaining 
	30% were used for the test data. 

	The sensor signals (accelerometer and gyroscope) were pre-processed by applying 
	noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 
	50% overlap (128 readings/window). The sensor acceleration signal, which has 
	gravitational and body motion components, was separated using a Butterworth 
	low-pass filter into body acceleration and gravity. The gravitational force was 
	assumed to have only low frequency components, therefore a filter with 0.3 Hz 
	cutoff frequency was used. From each window, a vector of features was obtained 
	by calculating variables from the time and frequency domain (Fourier 
	Transformation applied).
	===========================================================================
	License:
	========
	Use of this dataset in publications must be acknowledged by referencing the 
	following publication [1] 
	[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
	Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
	Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
	Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
	
	This dataset is distributed AS-IS and no responsibility implied or explicit 
	can be addressed to the authors or their institutions for its use or misuse. 
	Any commercial use is prohibited.

	Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 
	2012.	
	===========================================================================
	C.	Files provided for general information:
		1. 	File activity_labels.txt, provides a correspondence between the 
			integers [1:6] and the six activities given above.
		2. 	File features.txt containing a list of all the 'features' or summary 
			statistics of the experiments. 
		3. 	File features_info.txt containing a description of the 'features'.
		4.	A README.txt file describing the files in the data set.
		
	D.	Files provided for each record (one row in each file for each record):
		1. 	Two files containing vectors of 561 features each with time and 
			frequency domain variables. The training set data is in the file 
			X_train.txt in the 'train' folder and it has 7352 rows each containing 
			one of the vectors. The test data is in the corresponding X_test.txt 
			file in the 'test' folder and it has 2947 rows each containing one of
			the vectors. The order of the data in each vector is the same as the 
			order of the list of features given in the features.txt file (I.C.2).
		2.	Two files containing the activity label for the corresponding row in the 
			features files (I.D.1). The training labels are in the file y_train.txt
			in the 'train' folder while the test labels are in the corresponding 
			file y_test.txt in the 'test' folder. 
		3.	Two files containing an identifier of the subject who carried out the 
			experiment that produced the row in the features file. They are
			subject_train.txt, for the training data, and subject_test.txt, for the
			test data.
			
II. STEPS USED TO CLEAN THE DATA
	A.	From the 561 feachers, the data from ones that wete a mean or a standard 
		deviation(stdev) were identified. This resulted in 66 'features of interest'. 
	B.	The data for the 66 features of interest was extracted from each of the two
		files in I.D.1 and placed in two tables. The table from the training file
		had 7352 rows and 66 columns. The table from the test file had 2947 rows 
		and 66 columns. The column names for the two tables were the names assigned
		to the corresponding feature in the data sets. These column names came from 
		the file features.txt.
	C.	Three columns were added to both tables. 
		1.	The first column indicates which set the data came from, either 'train'
			or 'test'. The name of this column is 'category'.
		2.	The second column contains the descriptive name corresponding to the 
			integer id of the subject doing the experiment that resulted in the row. 
			This information came from the subject files described in I.D.3 with 
			correspondence between the integer id and the descriptive name given 
			in the activity labels file (I.C.1).
		3.	The third column contains the integer id corresponding to the activity 
			done in the experiment. The name given to this column is 'activity'.
			This information came from the y_ files described in I.D.2.
	D.	The two data tables were merged into one table. This table, named 
		mean_std_data, had 10299 rows and 69 columns. This table was written into 
		the file named raw_data.txt. This file was useful in checking the results
		of the next step using MS Excel.
	E.	The data in the columns of all rows having matching subject-activity pairs 
		was averaged and the resulting matrix was named 'z'. This matrix has 180
		rows and 66 columns since the category, subject and activity columns as well
		as the colomn names were stripped in the calculations.
	F. 	The subject and activity columns were reattached and the columns renamed to
		result in the table named tidyData. This table was written (without row names)
		into the file tidyData.txt.

III. VARIABLES
	A.	The steps II.A-F resulted in a table with 68 variables (columns). Names of 
		the first two are 'subject' and 'activity'. The names of the remaining 66 
		are the same as the names of the original factors from which they were 
		calculated as given in the file features.txt.
	B. 	Each row of the subject variable identifies the subject who performed the 
		experiment used to obtain the data in that row.
	C.	Each row of the activity variable identifies the activity that was performed
		during the experiment used for that row.
	D.	The 66 remaining variables have the names of the original features from which
		they were derrived. Their names may be broken into descriptive parts. Examples
		include tBodyAcc-mean()-X and fBodyAccJerk-std()-Z.
		1.	First is a character indicating the domain of the values, either 't' for 
			time or 'f' for frequency.
		2.	Characters 2 to the '-' are descriptions of the physical characteristic
			of the action associated with the feature. 
		3.	After the '-' and before the '()' are either mean or std, indicating whether
			the summary statistic that was averaged in II.E was a mean or a standard
			deviation.
		4.	The final characters, if any, indicate the direction of the action, along
			the X, Y or Z axis.
	
IV. R-SCRIPT
	A. 	A file of R script named run_analysis.R in included in this repo. 
	B.	When executed in the order given, from a working directory containing a subfolder
		'UCI HAR Dataset' containing the data as unzipped from the data file provided 
		at the URL given above, the steps descripbed in II will be performed and the 
		tidyData.txt file will be written into the working directory.
	C.	This file contains tidy data since each variable is contained in one column and
		each different observation of a variable is in a different row.