# Reading data; the code is common for all plots
# data.table is necessary to use fread
require(data.table)
# set locale to default, otherwise days of the week appear in local language
Sys.setlocale("LC_ALL", "C")
# fread is much faster than read.csv
dffull <- fread("household_power_consumption.txt", sep=";", na.strings=c("?", "NA"), data.table=FALSE)
# we have to process only 2 first day of February 2007
df<-dffull[dffull$Date == "1/2/2007" | dffull$Date == "2/2/2007",]
# remove full dataframe to release memory
rm(dffull)
# columns 3 - 9 are numeric
for(i in 3:9) df[,i]<-as.numeric(df[,i])
# columns 2 will contain full date and time in POSIXct format
df[,2]<-as.POSIXct(strptime(paste(df[,1], df[,2]), "%d/%m/%Y %H:%M:%S"))

# Plotting; the code is specific for this plot
png(filename="plot2.png", width=480, height=480, units="px", type="cairo")
plot(df$Time, df$Global_active_power, type="l", main="", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
