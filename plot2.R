# This assignment uses data from the UC Irvine Machine Learning Repository
# (http://archive.ics.uci.edu/ml/), a popular repository for machine learning
# datasets. In particular, we will be using the "Individual household electric 
# power consumption Data Set" which is made available on the course web 
# site:
#         
#       Dataset: Electric power consumption [20Mb]
#       (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)

# This code requires the compressed dataset to be downloaded and unzipped to
# the working directory as "household_power_consumption.txt". It then loads the
# full data set, converts Date and Time fields for use, subsets the data on
# needed days, and then creates the PNG plot.

# Read first 5 rows to get column classes
hpc5rows <- read.table(file="household_power_consumption.txt", header = TRUE, sep = ";", nrows = 5, na.strings = c("?",""))
hpc.classes <- sapply(hpc5rows, class)

# Read the whole file
hpc <- read.table(file="household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?",""), colClasses = hpc.classes)

# Convert date and time from factors, making new data frame for POSIXlt class (date & time)
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$timetemp <- paste(hpc$Date, hpc$Time)

hpc.df <- as.data.frame(hpc)
hpc.df$Time <- strptime(hpc.df$timetemp, format = "%Y-%m-%d %H:%M:%S")
#class(hpc.df)

# Restrict to correct day subset
hpc.days<-hpc.df[hpc.df$Date == "2007-2-1" | hpc.df$Date == "2007-2-2",]

# Create the plot
png(file = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")

plot(x=hpc.days$Time, y=hpc.days$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", bg = "transparent")
#hist(hpc.days$Global_active_power, main = "Global Active Power",xlab = "Global Active Power (kilowatts)",ylab = "Frequency", col = "red")

dev.off()

