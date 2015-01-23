## download the file from url and create a directory
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
directory <- dir.create("C:/Users/538321/Documents/DataManagement/DataCleaning/assignment")
dataFileZIP <- "C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset.zip"
if(file.exists(dataFileZIP) == FALSE){
  download.file(fileURL, destfile = dataFileZIP)
}
## unzip the zip file
unzip("C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset.zip")
## hold features in a sparatete table
features <- read.table("C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset/features.txt")
## get x_train, Y_train, x_test,y_test in two tables
X_train <- read.table("C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset/train/X_train.txt")
Y_train <- read.table("C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset/train/y_train.txt")
X_test <- read.table("C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset/test/X_test.txt")
y_test <- read.table("C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset/test/y_test.txt")
##subjects traing and test in a separate data frame
subject_train <- read.table("C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset/train/subject_train.txt")
subject_test <- read.table("C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset/test/subject_test.txt")
## merge both x train and text files by rbind(appending)
X <- rbind(X_train, X_test)
## merge voth ytest and ytrain by rbind(appending)
Y <- rbind(Y_train, y_test)
s <- rbind(subject_train,subject_test)
## give coumn names to features table
names(features) <- c('feat_id', 'feat_name')
## hold the feature names by row 
interestingfeatures <- grep("-mean\\(\\)|-std\\(\\)",features$feat_name)
## give the featurenames to x file
x <- X[,interestingfeatures]
names(x) <-gsub("\\(|\\)", "", (features[interestingfeatures,2]))
## hold activities in a separte table
activities <- read.table("C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset/activity_labels.txt")
## give name to activities columns
names(activities) <- c("act_id", "act_name")
Y[,1]<- activities[Y[,1],2]
names(Y)<- "Activity"
names(s)<- "Subject"
## do a coulmn bind by subject Y and X activity
tidydataset <- cbind(s,Y,X)
tidyAvg <- aggregate(X, by = list( activity = Y[,1], subject = s[,1]), mean)
## write to table
write.table(tidyAvg, file="C:/Users/538321/Documents/DataManagement/DataCleaning/assignment/UCI-HAR-Dataset/tidyAvg.txt", row.names = FALSE)

