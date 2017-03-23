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

##Question 1: Merge the data based on the country shortcode. How many of the IDs match?

CombineData <- merge(gdpdata, edudata, by.x = "CountryCode", by.y = "CountryCode")
dim(CombineData)[1]

##Question 2: Sort the data frame in ascending order by GDP (so United States is last). What is the 13th country in the resulting data frame?

arrange(CombineData, desc(Rank))[13,3]

##Question 3: What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups?

### average GDP rankings for the "High income: OECD"
mean(subset(CombineData, Income.Group %in% "High income: OECD", select = c(Rank))$Rank)

### average GDP rankings for the "High income: nonOECD"
mean(subset(CombineData, Income.Group %in% "High income: nonOECD", select = c(Rank))$Rank)

##Question 4: Show the distribution of GDP value for all the countries and color plots by income group. Use ggplot2 to create your plot.

library(ggplot2)
ggplot(CombineData,aes(x =Income.Group, y = GDP.Value)) + scale_y_log10() + geom_point(color = "steelblue", size = 4, alpha = 1/2)

##Question 5: Provide summary statistics of GDP by income groups.

tapply(CombineData$GDP.Value, CombineData$Income.Group, summary)

##Question 6: Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

library(Hmisc)
CombineData$Rank.Groups = cut2(CombineData$Rank, g = 5)
table(CombineData$Income.Group, CombineData$Rank.Groups)

