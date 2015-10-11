
##  Introduction
# 
# This assignment uses data from the UC Irvine Machine Learning Repository
# (http://archive.ics.uci.edu/ml/), a popular repository for machine learning
# datasets. In particular, we will be using the "Individual household electric 
# power consumption Data Set" which I have made available on the course web 
# site:
#         
#       Dataset: Electric power consumption [20Mb]
#       (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)
# 
# Description: Measurements of electric power consumption in one household with
# a one-minute sampling rate over a period of almost 4 years. Different
# electrical quantities and some sub-metering values are available.
# 
# The following descriptions of the 9 variables in the dataset are taken from
# the UCI web site:
#         
#       Date: Date in format dd/mm/yyyy
#       Time: time in format hh:mm:ss
#       Global_active_power: household global minute-averaged active power
#                            (in kilowatt)
#       Global_reactive_power: household global minute-averaged reactive power
#                            (in kilowatt)
#       Voltage: minute-averaged voltage (in volt)
#       Global_intensity: household global minute-averaged current intensity
#                            (in ampere)
#       Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active
#                       energy). It corresponds to the kitchen, containing
#                       mainly a dishwasher, an oven and a microwave (hot
#                       plates are not electric but gas powered).
#       Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active
#                       energy). It corresponds to the laundry room, 
#                       containing a washing-machine, a tumble-drier, a
#                       refrigerator and a light.
#       Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active
#                       energy). It corresponds to an electric water-heater
#                       and an air-conditioner.

##  Loading the data

#       When loading the dataset into R, please consider the following:
#       The dataset has 2,075,259 rows and 9 columns. First calculate a rough
#       estimate of how much memory the dataset will require in memory before
#       reading into R. Make sure your computer has enough memory (most modern
#       computers should be fine).
conv <- 2^20 # bytes/MB
dsize<- 8 # bytes/numeric data type
rows<-2075259
cols<-9
memory_MB <- rows * cols * dsize / conv # 142MB

# We will only be using data from the dates 2007-02-01 and 2007-02-02. One
# alternative is to read the data from just those dates rather than reading
# in the entire dataset and subsetting to those dates.

#household<-read.table(file="household_power_consumption.txt", header = TRUE, sep = ";")

hpc5rows <- read.table(file="household_power_consumption.txt", header = TRUE, sep = ";", nrows = 5, na.strings = c("?",""))
hpc.classes <- sapply(hpc5rows, class)
hpc <- read.table(file="household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?",""), colClasses = hpc.classes)

hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$timetemp <- paste(hpc$Date, hpc$Time)

hpc.df <- as.data.frame(hpc)
hpc.df$Time <- strptime(hpc.df$timetemp, format = "%Y-%m-%d %H:%M:%S")
#class(hpc.df)

# Restrict to correct day subset
hpc.days<-hpc.df[hpc.df$Date == "2007-2-1" | hpc.df$Date == "2007-2-2",]

png(file = "plot1.png", width = 480, height = 480, bg = "white")
hist(hpc.days$Global_active_power, main = "Global Active Power",xlab = "Global Active Power (kilowatts)",ylab = "Frequency", col = "red")
dev.off()

library("dplyr")
# hpc <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?",""), colClasses = hpc.classes))



# Use sqldef
library(sqldf)
# define hpc as a file with indicated format 
hpc <- file("household_power_consumption.txt") 
attr(hpc, "file.format") <- list(header = TRUE, sep = ";", colClasses = classes) 

# use sqldf to read it in keeping only indicated rows
# hpc.df <- sqldf("select Date from hpc group by Date order by Date")
# hpc.df <- sqldf("select Date, Global_active_power from hpc where Date = '01/02/2007' or Date = '02/02/2007'") 

hpc.df <- sqldf("select Date, Global_active_power from hpc where Date in ('1/2/2007','2/2/2007')")
# update data not available
hpc.df$Global_active_power[hpc.df$Global_active_power=='?']<-NA

hist(hpc.df$Global_active_power, main = "Global Active Power",xlab = "Global Active Power (kilowatts)",ylab = "Frequency", col = "darkred")



# fix up type of value__1 
wp.df$value__1 <- as.numeric(as.character(wp.df$value__1)) 

head(wp.df) 



# You may find it useful to convert the Date and Time variables to Date/Time
# classes in R using the strptime() and as.Date() functions.

# Note that in this dataset missing values are coded as ?.















