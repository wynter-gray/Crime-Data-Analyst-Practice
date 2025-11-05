# Crime-Data-Analyst-Practice
Beginner SQL scripts and dataset for crime analyst practice (Excel + SQL Server queries).

## 📂 Files Included

| File | Description |
|------|--------------|
| **crime_training_dataset.xlsx** | Excel dataset with 3 tables: incidents, calls_for_service, and locations. |
| **crime_analyst_codes.sql** | SQL practice queries and sample solutions. |
| **second_crime_analyst.sql** | Second SQL practice queries and sample solutions. |
| **crime data analyst.pdf** | Report includes overview, tableau dashboard, SQL queries, and result previews. |

---

## 🧠 About the Dataset
The dataset simulates real-world police and crime reporting data.

- **incidents** → incident_id, offense_code, occurred_dt, cleared_dt, status, location_id  
- **calls_for_service** → call_id, call_dt, final_call_type, location_id  
- **locations** → location_id, address, zip_code, city, latitude, longitude  

---

## 💻 Run Locally (SQL Server Instructions)

1. Open **SQL Server Management Studio (SSMS)** or **Azure Data Studio**  
2. Create a new database named `CrimeAnalytics`  
3. Go to **Tasks → Import Data → From Excel**  
   - Select `crime_training_dataset.xlsx`  
   - Import each sheet as its own table:  
     - incidents  
     - calls_for_service  
     - locations  
4. Open and execute the queries from `crime_analysis_practice.sql`
