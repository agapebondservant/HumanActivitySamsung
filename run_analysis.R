#load useful libraries
library(stringr)
library(dplyr)

# download and unzip source file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "mergedData.zip"
if (!file.exists(fileName)){
        download.file(fileUrl,destfile = "mergeddata.zip")
        unzip(fileName)
}


#Get the Activities/Activity Labels associated with the dataset
activities <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"),
                    read.table("UCI HAR Dataset/test/y_test.txt"))
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityIdsAndLabels <- merge(activities,activityLabels)
names(activityIdsAndLabels) <- c("Activity Id","Activity Name")

#Get Feature Labels for mean, std
featureLabels <- read.table("UCI HAR Dataset/features.txt")
meanStdFilter <- grep(".*-mean.*|.*-std.*)",featureLabels[,2])
featureLabels <- featureLabels[meanStdFilter,]

#Get the mean,std time and frequency domain variables
domainVariables <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"),
                              read.table("UCI HAR Dataset/test/X_test.txt"))
domainVariables <- domainVariables[,meanStdFilter]

#Update the domain variable column names to more meaningful names
names(domainVariables) <- featureLabels[,2]
names(domainVariables) <- gsub("^t", "Time ", names(domainVariables))
names(domainVariables) <- gsub("^f", "Frequency ", names(domainVariables))
names(domainVariables) <- gsub("\\(\\)", '', names(domainVariables))
names(domainVariables) <- gsub("mean", "Mean ", names(domainVariables))
names(domainVariables) <- gsub("std", "Standard Deviation ", names(domainVariables))


#Get the triaxial acceleration from the accelerometer (total acceleration)
totalAccelerationX <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt"),
                           read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"))
totalAccelerationY <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt"),
                            read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"))
totalAccelerationZ <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt"),
                            read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"))
names(totalAccelerationX) <- sapply(names(totalAccelerationX),function(x){paste("Total Acceleration X -",x)})
names(totalAccelerationY) <- sapply(names(totalAccelerationY),function(x){paste("Total Acceleration Y -",x)})
names(totalAccelerationZ) <- sapply(names(totalAccelerationZ),function(x){paste("Total Acceleration Z -",x)})


#Get the Triaxial Angular velocity
angularVelocityX <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt"),
                            read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"))
angularVelocityY <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt"),
                          read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"))
angularVelocityZ <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt"),
                          read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"))
names(angularVelocityX) <- sapply(names(angularVelocityX),function(x){paste("Angular Velocity X -",x)})
names(angularVelocityY) <- sapply(names(angularVelocityY),function(x){paste("Angular Velocity Y -",x)})
names(angularVelocityZ) <- sapply(names(angularVelocityZ),function(x){paste("Angular Velocity Z -",x)})

#Get the subject identifiers
subjects <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"),
                  read.table("UCI HAR Dataset/test/subject_test.txt"))
names(subjects) <- c('Subject')

#Merge all the results together
dataset <- cbind(subjects,
                 activityIdsAndLabels,
                 domainVariables,
                 totalAccelerationX,
                 totalAccelerationY,
                 totalAccelerationZ,
                 angularVelocityX,
                 angularVelocityY,
                 angularVelocityZ)

#Group Results by subject and activity
groupBySubjectAndActivity <- group_by(dataset, subjects[,1],activityIdsAndLabels[,2])
summarizedDataset <- summarize_all(groupBySubjectAndActivity,mean)

#Write results to text file
write.table(summarizedDataset,file = "data.txt", row.name=FALSE)