# 📊 Automated Bash ETL Pipeline

An automated, Linux-based ETL (Extract, Transform, Load) pipeline built entirely with Bash scripting. This project extracts financial  data from the web, tranform it and moved it into a Gold layer relicating the Gold medallion architecture.

---

## 📌 Project Overview
As part of the CoreDataEngineers bootcamp assignment, this project automates daily data ingestion and transformation without relying on human intervention. It utilises various native Linux commands such as`wget`, `sed`, `cut`, etc to handle data efficiently.

## 📂 Directory Architecture
The script automatically creates the following directory structure upon execution:
* **`./raw/`**: The landing zone for the original, unmodified CSV data.
* **`./transformed/`**: The staging area where cleaned and filtered data is temporarily held.
* **`./gold/`**: The final production directory for fully processed, business-ready data.
* **`./json_and_CSV/`**: A folder where all scattered `.json` and `.csv` files from the user system are grouped together.

---

## ⚙️ Pipeline Breakdown

### 1. Extract
* Uses environment variables to securely define the target data URL.
* Downloads the 2023 Annual Enterprise Survey data using `wget` and saves it as `data.csv` in the `raw` directory.
* Includes validation checks to ensure the download completed successfully.

### 2. Transform
* **Standardization:** Uses the stream editor (`sed`) to standardise the column header `Variable_code` to lowercase `variable_code`.
* **Filtering:** Uses the `cut` command to strip out unnecessary data, isolating only the required columns: `Year`, `Value`, `Units`, and `variable_code`.
* Validates schema changes using `head` and `grep` before proceeding.

### 3. Load
* Moves the finalized dataset (`2023_year_finance.csv`) into the `gold` directory for downstream consumption.

### 4. File Management
* Executes a bulk file-moving operation using wildcards (`*.json`, `*.csv`) to locate loose files in the parent directory and consolidate them into the `json_and_CSV` folder.

---

## 🚀 How to Run the Script

**1. Clone the repository and navigate to the project folder:**
```bash
git clone https://github.com/spaceform02/linux_project/
cd linux_project
```

**2. Make the script executable:**
```bash
chmod +x script.sh
```

**3. Run the script manually:**
```bash
./script.sh
```

---

## ⏱️ Automation (Cron Job)
This pipeline is designed to run completely without human intervention every day at 12:00 AM. 

The task is scheduled using the cronjob command. The schedule and execution paths are configured as follows:

1. Open the cron editor by running `crontab -e` in the terminal.
2. Add the following configuration to the bottom of the file:
```bash
0 0 * * * /mnt/c/Users/lenovo/desktop/linux_assignment/script.sh >> /home/lenovo/cron.log 2>&1
```
