household_power= read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

household_power$Global_active_power=as.numeric(household_power$Global_active_power)
household_power$Global_reactive_power=as.numeric(household_power$Global_reactive_power)
household_power$Voltage=as.numeric(household_power$Voltage)
household_power$Global_intensity=as.numeric(household_power$Global_intensity)
household_power$Sub_metering_1=as.numeric(household_power$Sub_metering_1)
household_power$Sub_metering_2=as.numeric(household_power$Sub_metering_2)


test_date_time= paste(household_power$Date,household_power$Time)
test_date_time= strptime(test_date_time,format= "%d/%m/%Y %H:%M:%S")
household_power$DateTime=test_date_time


household_power_filter= subset(household_power, household_power$DateTime >= as.POSIXlt("2007-2-1 00:00:00") & household_power$DateTime <= as.POSIXlt("2007-2-2 23:59:59"))

household_power_filter$Date=NULL
household_power_filter$Time=NULL

household_power_filter= na.omit(household_power_filter)

# Plot 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(household_power_filter$DateTime, household_power_filter$Global_active_power, ylab="Global Active Power", xlab="", type = "l" )
plot(household_power_filter$DateTime, household_power_filter$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(household_power_filter$DateTime, household_power_filter$Sub_metering_1, ylab = "Energy sub metering", xlab="", type = "l")
lines(household_power_filter$DateTime, household_power_filter$Sub_metering_2, col = "red")
lines(household_power_filter$DateTime, household_power_filter$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3") , col= c("black","red","blue"), lty = 1, cex=.3)

plot(household_power_filter$DateTime, household_power_filter$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime" )



dev.copy(png,"plot4.png", width=480, height=480)
dev.off()