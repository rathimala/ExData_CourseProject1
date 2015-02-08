#### Exploratory Data Analysis - Course Project 1 - Plot4.R

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

datetime2 <- strptime(datetime, "%d/%m/%Y %H:%M:%S") 
head(datetime)
# [1] "2006-12-16 17:24:00 MYT" "2006-12-16 17:25:00 MYT" "2006-12-16 17:26:00 MYT"
# [4] "2006-12-16 17:27:00 MYT" "2006-12-16 17:28:00 MYT" "2006-12-16 17:29:00 MYT"

datetime <- as.Date(datetime2)
pcData$datetime <- datetime # add a datetime variable (date type) to data frame.
pcData$datetime2 <- datetime2

Data_2days <- subset(pcData, datetime >= "2007-02-01" & datetime <= "2007-02-02")
# 'data.frame':  2880 obs. of  11 variables:
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
# $ datetime2            : POSIXlt, format: "2007-02-01 00:00:00" "2007-02-01 00:01:00" "2007-02-01 00:02:00" ...


#convert the data type from factor to numeric
Data_2days$Global_active_power <- as.numeric(as.character(Data_2days$Global_active_power))
Data_2days$Sub_metering_1 <- as.numeric(as.character(Data_2days$Sub_metering_1))
Data_2days$Sub_metering_2 <- as.numeric(as.character(Data_2days$Sub_metering_2))
Data_2days$Sub_metering_3 <- as.numeric(as.character(Data_2days$Sub_metering_3))
Data_2days$Global_reactive_power <- as.numeric(as.character(Data_2days$Global_reactive_power))
Data_2days$Voltage <- as.numeric(as.character(Data_2days$Voltage))
Data_2days$Global_intensity <- as.numeric(as.character(Data_2days$Global_intensity))

png(file="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
with(Data_2days, {
  plot(datetime2, Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(datetime2, Voltage, type="l", col="black", ylab="Voltage", xlab="datetime")
  plot(datetime2, Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab="")
    lines(datetime2,Sub_metering_2, type="l", col="red")
    lines(datetime2, Sub_metering_3, type="l", col="blue")
    legend("topright", pch = "---", col=c("black", "red", "blue"), legend=c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), cex=0.4, pt.cex=0.2)
  plot(datetime2, Global_reactive_power, type="l", col="black", ylab="Global_reactive_power", xlab="datetime")
})

dev.off()

