##Download the files

file1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(file1, destfile = "GDP.csv")
file2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(file2, destfile = "EDU.csv")


##Format the columns
##Skip column 3 because it is an empty column

gdpdata <- read.csv("GDP.csv", skip = 4, nrows = 190)
edudata <- read.csv("EDU.csv")
gdpdata <- gdpdata[, c(1,2,4,5)]
colnames(gdpdata) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")
gdpdata$GDP.Value <- as.numeric(gsub(",", "", gdpdata$GDP.Value))

