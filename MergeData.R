## Merge the data based on country shortcode

CombineData <- merge(gdpdata, edudata, by.x = "CountryCode", by.y = "CountryCode")