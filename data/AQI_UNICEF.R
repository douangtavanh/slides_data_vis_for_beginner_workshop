library(tidyverse)
library(httr)
library(readxl)
library(lubridate)
library(jsonlite)

url_locations = "https://api.airgradient.com/public/api/v1/world/locations/measures/current"

# Construct a connection
response = GET(url_locations)
# Get content from the response
content_resp = content(response, as = "text")
# Parse content json
parsed_json <- fromJSON(content_resp, flatten = TRUE)
df <- as.data.frame(parsed_json)

# filter on UNICEF Lao
df_fil <- df[str_which(df$publicContributorName, "Laos"),]
# Export to csv
write_excel_csv(df_fil, "AQI_UNICEF.csv")
write_excel_csv(df, "RAW_AQI_UNICEF.csv")

