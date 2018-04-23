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

# Plot 2

plot(household_power_filter$DateTime, household_power_filter$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()