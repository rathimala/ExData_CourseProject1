#### Exploratory Data Analysis - Course Project 1 - Plot1.R

#load data set - household_power_consumption
pcData <- as.data.frame(read.csv("household_power_consumption.txt", header = TRUE, sep = ";"))
str(pcData)

# 'data.frame':  2075259 obs. of  9 variables:
#   $ Date                 : Factor w/ 1442 levels "1/1/2007","1/1/2008",..: 342 342 342 342 342 342 342 342 342 342 ...
# $ Time                 : Factor w/ 1440 levels "00:00:00","00:01:00",..: 1045 1046 1047 1048 1049 1050 1051 1052 1053 1054 ...
# $ Global_active_power  : Factor w/ 4187 levels "?","0.076","0.078",..: 2082 2654 2661 2668 1807 1734 1825 1824 1808 1805 ...
# $ Global_reactive_power: Factor w/ 533 levels "?","0.000","0.046",..: 189 198 229 231 244 241 240 240 235 235 ...
# $ Voltage              : Factor w/ 2838 levels "?","223.200",..: 992 871 837 882 1076 1010 1017 1030 907 894 ...
# $ Global_intensity     : Factor w/ 222 levels "?","0.200","0.400",..: 53 81 81 81 40 36 40 40 40 40 ...
# $ Sub_metering_1       : Factor w/ 89 levels "?","0.000","1.000",..: 2 2 2 2 2 2 2 2 2 2 ...
# $ Sub_metering_2       : Factor w/ 82 levels "?","0.000","1.000",..: 3 3 14 3 3 14 3 3 3 14 ...
# $ Sub_metering_3       : num  17 16 17 17 17 17 17 17 17 16 ...

datetime <- paste0(pcData$Date, " ", pcData$Time) #concatenate Date and Time variables
head(datetime)
# [1] "16/12/2006 17:24:00" "16/12/2006 17:25:00" "16/12/2006 17:26:00" "16/12/2006 17:27:00"
# [5] "16/12/2006 17:28:00" "16/12/2006 17:29:00"
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S") 
head(datetime)
# [1] "2006-12-16 17:24:00 MYT" "2006-12-16 17:25:00 MYT" "2006-12-16 17:26:00 MYT"
# [4] "2006-12-16 17:27:00 MYT" "2006-12-16 17:28:00 MYT" "2006-12-16 17:29:00 MYT"

class(datetime) #change the datetime variable into date() format
# [1] "POSIXlt" "POSIXt" 
datetime <- as.Date(datetime)
class(datetime)
# [1] "Date"
head(datetime) # change the data format to date() format
# [1] "2006-12-16" "2006-12-16" "2006-12-16" "2006-12-16" "2006-12-16" "2006-12-16"

pcData$datetime <- datetime # add a datetime variable (date type) to data frame.
head(pcData)
# Date     Time Global_active_power Global_reactive_power Voltage Global_intensity
# 1 16/12/2006 17:24:00               4.216                 0.418 234.840           18.400
# 2 16/12/2006 17:25:00               5.360                 0.436 233.630           23.000
# 3 16/12/2006 17:26:00               5.374                 0.498 233.290           23.000
# 4 16/12/2006 17:27:00               5.388                 0.502 233.740           23.000
# 5 16/12/2006 17:28:00               3.666                 0.528 235.680           15.800
# 6 16/12/2006 17:29:00               3.520                 0.522 235.020           15.000
# Sub_metering_1 Sub_metering_2 Sub_metering_3   datetime
# 1          0.000          1.000             17 2006-12-16
# 2          0.000          1.000             16 2006-12-16
# 3          0.000          2.000             17 2006-12-16
# 4          0.000          1.000             17 2006-12-16
# 5          0.000          1.000             17 2006-12-16
# 6          0.000          2.000             17 2006-12-16


Data_2days <- subset(pcData, datetime >= "2007-02-01" & datetime <= "2007-02-02")

str(Data_2days)
# 
# 'data.frame':  2880 obs. of  10 variables:
#   $ Date                 : Factor w/ 1442 levels "1/1/2007","1/1/2008",..: 16 16 16 16 16 16 16 16 16 16 ...
# $ Time                 : Factor w/ 1440 levels "00:00:00","00:01:00",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ Global_active_power  : Factor w/ 4187 levels "?","0.076","0.078",..: 127 127 126 126 125 124 124 124 124 82 ...
# $ Global_reactive_power: Factor w/ 533 levels "?","0.000","0.046",..: 44 45 46 47 45 43 43 43 44 2 ...
# $ Voltage              : Factor w/ 2838 levels "?","223.200",..: 1823 1840 1859 1898 1824 1737 1754 1771 1778 1797 ...
# $ Global_intensity     : Factor w/ 222 levels "?","0.200","0.400",..: 8 8 8 8 8 8 8 8 8 6 ...
# $ Sub_metering_1       : Factor w/ 89 levels "?","0.000","1.000",..: 2 2 2 2 2 2 2 2 2 2 ...
# $ Sub_metering_2       : Factor w/ 82 levels "?","0.000","1.000",..: 2 2 2 2 2 2 2 2 2 2 ...
# $ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...
# $ datetime             : Date, format: "2007-02-01" "2007-02-01" "2007-02-01" ...
object_size(Data_2days)
# 543 kB

head(Data_2days)
#         Date     Time Global_active_power Global_reactive_power Voltage Global_intensity
# 66637 1/2/2007 00:00:00               0.326                 0.128 243.150            1.400
# 66638 1/2/2007 00:01:00               0.326                 0.130 243.320            1.400
# 66639 1/2/2007 00:02:00               0.324                 0.132 243.510            1.400
# 66640 1/2/2007 00:03:00               0.324                 0.134 243.900            1.400
# 66641 1/2/2007 00:04:00               0.322                 0.130 243.160            1.400
# 66642 1/2/2007 00:05:00               0.320                 0.126 242.290            1.400
# Sub_metering_1 Sub_metering_2 Sub_metering_3   datetime
# 66637          0.000          0.000              0 2007-02-01
# 66638          0.000          0.000              0 2007-02-01
# 66639          0.000          0.000              0 2007-02-01
# 66640          0.000          0.000              0 2007-02-01
# 66641          0.000          0.000              0 2007-02-01
# 66642          0.000          0.000              0 2007-02-01           


tail(Data_2days)
#         Date     Time Global_active_power Global_reactive_power Voltage Global_intensity
# 69511 2/2/2007 23:54:00               3.696                 0.226 240.710           15.200
# 69512 2/2/2007 23:55:00               3.696                 0.226 240.900           15.200
# 69513 2/2/2007 23:56:00               3.698                 0.226 241.020           15.200
# 69514 2/2/2007 23:57:00               3.684                 0.224 240.480           15.200
# 69515 2/2/2007 23:58:00               3.658                 0.220 239.610           15.200
# 69516 2/2/2007 23:59:00               3.680                 0.224 240.370           15.200
# Sub_metering_1 Sub_metering_2 Sub_metering_3   datetime
# 69511          0.000          1.000             17 2007-02-02
# 69512          0.000          1.000             18 2007-02-02
# 69513          0.000          2.000             18 2007-02-02
# 69514          0.000          1.000             18 2007-02-02
# 69515          0.000          1.000             17 2007-02-02
# 69516          0.000          2.000             18 2007-02-02




## Plot1.R

class(Data_2days$Global_active_power)
# [1] "factor"

#convert the data type from factor to numeric
Data_2days$Global_active_power <- as.numeric(as.character(Data_2days$Global_active_power))

summary(Data_2days$Global_active_power)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.220   0.320   1.060   1.213   1.688   7.482 

png(file="plot1.png", width=480, height=480, units="px")
hist(Data_2days$Global_active_power,col="red", main = " Global Active Power", 
     xlab = " Global Active Power (Kilowatts)" )
dev.off()
# RStudioGD 
#         2 


