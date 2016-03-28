This script must be run in the same  working directory where the samsung files are. 
all files (train and test) should be in the same directory.

The Script first read all data and then make a single data frame of train data and test data.
Both data are unified in just one data frame called Datos
subset the data frame, getting only the mean and std of each measure
The variable activity is labeled with the activities names
The data frame is labeled
A new data frame named datos2 is created, which contain the mean of each of the columns of datos by each activity and subject
