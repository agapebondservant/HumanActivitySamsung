# HumanActivitySamsung

run_analysis.R is a script which provides a summarized data table from 30 volunteers with information about time and frequency based signals associated with accelerometer and gyroscope data. 

The data is retrieved from the following site: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

By running the script, data from the training and test files will be merged, and a data table will be generated with the following fields:

Subject - Identifier of the subject/volunteer
Activity - Name of the activity performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING or LAYING)
Time-Based Sensors for X dimension (Time BodyAcc Mean - X, Time BodyAcc Standard Deviation -X, etc) 
Time-Based Sensors for Y dimension (Time BodyAcc Mean - Y, Time BodyAcc Standard Deviation -Y, etc) 
Time-Based Sensors for Z dimension (Time BodyAcc Mean - Z, Time BodyAcc Standard Deviation -Z, etc) 
Frequency-Based Sensors for X dimension (Time BodyAcc Mean - X, Time BodyAcc Standard Deviation -X, etc) 
Frequency-Based Sensors for Y dimension (Frequency BodyAcc Mean - Y, Frequency BodyAcc Standard Deviation -Y, etc) 
Frequency-Based Sensors for Z dimension (Frequency BodyAcc Mean - Z, Frequency BodyAcc Standard Deviation -Z, etc) 
Total Acceleration Vector for X dimension
Total Acceleration Vector for Y dimension
Total Acceleration Vector for Z dimension
Angular Velocity for X dimension
Angular Velocity for Y dimension
Angular Velocity for Z dimension
