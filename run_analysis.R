replatePatterns <- function(pattern, replacement, x, ...) {
  result <- x
  for (i in 1:length(pattern)) {
    result <- gsub(pattern[i], replacement[i], result, ...)
  }
  result
}


training <- read.csv("UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
training[,562]<- read.csv("UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="")
training[,563] <- read.csv("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")

test <- read.csv("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
test[,562] <- read.csv("UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="")
test[,563] <- read.csv("UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")

dataset <- rbind(training,test)

features <- read.csv("UCI HAR Dataset/features.txt", header=FALSE, sep="")
names(dataset) <- c(as.vector(features$V2), "activity", "subject")

rm(training)
rm(test)



mean_std_index <-grep("mean|std",names(dataset), ignore.case = TRUE)
dataset_mean_std <- subset(dataset[,c(mean_std_index,562,563)])
activity_label <- read.csv("UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")

dataset_mean_std$activity <- sapply(dataset_mean_std$activity, function(x){
  activity_label[x,2]
})

names(dataset_mean_std) <- replatePatterns(c("[()]","-", "A", "B", "G", "J", "M"), 
                                           c("","_", "_a", "_b", "_g", "_j", "_m"), 
                                           names(dataset_mean_std))


dataset_average <- aggregate(. ~ activity + subject, data = dataset_mean_std, mean)

write.table(dataset_average,"tidy.txt",row.name=FALSE)



