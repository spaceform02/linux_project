#!/bin/bash

# Extracting the file

# Here I saved the website url as variable to avoid repetitive use
export DATA_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

# Extracting the file and saving into the raw directory
wget -O ./raw/data.csv "$DATA_URL"

#confirming the file has been downloaded
if [ -f ./raw/data.csv ]; then
  echo "File downloaded successfully."
else
  echo "Failed to download the file."
fi


## Transforming the file
# renaming the column named Variable_code to variable_code
sed '1s/Variable_code/variable_code/' ./raw/data.csv > ./transformed/column_change.csv

#confirming the column name has truly changed and saved correcty
if [ -f ./transformed/column_change.csv ]; then
    if head -n 1 ./transformed/column_change.csv | grep -q "variable_code"; then
        echo "Column name changed successfully."
    else
        echo "Failed to change the column name."
    fi
else
  echo "Failed to create the transformed file."
fi

#Extracting year, Value, Units, variable_code into a new file
cut -d "," -f 1,5,6,9 ./transformed/column_change.csv > ./transformed/2023_year_finance.csv


#confirming the transformed file has been created
if [ -f ./transformed/2023_year_finance.csv ]; then
  echo "Transformed file created successfully."
  if head -n 1 ./transformed/2023_year_finance.csv | grep -q "Year,Units,variable_code,Value"; then
      echo "Columns extracted successfully."
  else
      echo "Failed to extract the columns."
  fi
else
  echo "Failed to create the transformed file."
fi

##Load the transformed file into a Gold folder
cp ./transformed/2023_year_finance.csv ./gold/2023_year_finance.csv

#Confirmed the file has been loaded into the Gold folder
if [ -f ./gold/2023_year_finance.csv ]; then
  echo "File loaded into Gold folder successfully."
else
  echo "Failed to load the file into Gold folder."
fi
