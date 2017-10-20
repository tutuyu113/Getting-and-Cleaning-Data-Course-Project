###########################################################################################
############################## Peer-graded Assignment #####################################
###########################################################################################




 
#### PART 1: Merge the training and the test sets to creat one data set ####

## The zip file is downloaded and unzipped

XTest <- read.table("./R/Course 3/ProgrammingAssignment4/UCI HAR Dataset/test/X_test.txt")
YTest <- read.table("./R/Course 3/ProgrammingAssignment4/UCI HAR Dataset/test/y_test.txt")
SubjectTest <- read.table("./R/Course 3/ProgrammingAssignment4/UCI HAR Dataset/test/subject_test.txt")

XTrain <- read.table("./R/Course 3/ProgrammingAssignment4/UCI HAR Dataset/train/X_train.txt")
YTrain <- read.table("./R/Course 3/ProgrammingAssignment4/UCI HAR Dataset/train/y_train.txt")
SubjectTrain <- read.table("./R/Course 3/ProgrammingAssignment4/UCI HAR Dataset/train/subject_train.txt")

features <- read.table("./R/Course 3/ProgrammingAssignment4/UCI HAR Dataset/features.txt")
activity <- read.table("./R/Course 3/ProgrammingAssignment4/UCI HAR Dataset/activity_labels.txt")


X <- rbind(XTest,XTrain); colnames(X) <- features[,2]
Y <- rbind(YTest,YTrain)
Subject <- rbind(SubjectTest,SubjectTrain)





#### PART 2: Extract only the measurements on the mean and std for each measurement ####


X_sub <- subset(X, select=grep("mean\\(\\)|std\\(\\)", features[,2], value=TRUE))  # use subset() function to select columns with mean() or std() in the columns names





#### PART 3: Use descriptive activity names to name the activities in the data set ####

Y[,1] <- activity[Y[,1], 2]  # replace the names without ordering Y





#### PART 4: Label the data set with descriptive variable names ####

# X's column names are ready in the previous step

colnames(X_sub) <- gsub("\\(\\)", "", colnames(X_sub))  # delete the () in the colnames
colnames(X_sub) <- gsub("-", "_", colnames(X_sub))      # replace "-" with "_" in the colnames

colnames(Y) <- "Activity"
colnames(Subject) <- "SubjectID"

data <- cbind(Subject, Y, X_sub)





#### PART 5: Create a second data set with the average of each variable for each activity and each subject ####

library(reshape2)

data$SubjectID <- as.factor(data$SubjectID)  # turn the SubjectID into factor variables

datamelt <- melt(data, id=c("SubjectID", "Activity"))

average_datamelt <- dcast(datamelt, SubjectID+Activity~variable, mean)

write.table(average_datamelt, file="./R/Course 3/ProgrammingAssignment4/tidydata.txt", row.names = FALSE)



