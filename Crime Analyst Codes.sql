-- 1) How many rows are in each table?

SELECT COUNT(*) as row_count
FROM incidents$
UNION ALL 
SELECT COUNT(*) as count_call
FROM calls_for_service$
UNION ALL
SELECT COUNT(*) as count_location 
FROM locations$;

-- 2) Find the earliest and latest incident date.

SELECT MIN(occurred_dt) AS earliest_incident, 
MAX(occurred_dt) AS latest_incident
FROM incidents$

--3) How many incidents are currently open?

SELECT COUNT(*) as open_incidents
FROM incidents$
WHERE status = 'Open';

--4) List all unique offense codes.

SELECT DISTINCT offense_code
FROM incidents$
WHERE offense_code IS NOT NULL 
ORDER BY offense_code;

--5) Show all incidents that occurred in the last 30 days.

SELECT *
FROM incidents$
WHERE occurred_dt >= DATEADD(day, -30, SYSDATETIME());

--6) Find all incidents with missing offense codes.

SELECT * 
FROM incidents$
WHERE offense_code IS NULL;

--7) Find all calls related to 'Theft Report'.

SELECT *
FROM calls_for_service$
WHERE final_call_type = 'Theft Report';

--8) Count incidents by status.

SELECT status, COUNT(*) as incident_count
FROM incidents$
GROUP BY status
ORDER by incident_count desc;

--9) Count incidents per ZIP code.

SELECT zip_code, COUNT(incident_id) as total_incidents 
FROM incidents$
JOIN locations$ on locations$.location_id=incidents$.location_id
GROUP BY zip_code
ORDER BY total_incidents desc;

--10) Find the top 5 most common offense codes.

SELECT TOP 5 offense_code, COUNT(*) AS Total
FROM incidents$
WHERE offense_code IS NOT NULL
GROUP BY offense_code
ORDER BY Total ASC;

--11) Match calls and incidents by location_id.

SELECT c.call_id, c.final_call_type, i.incident_id, i.status
FROM calls_for_service$ c
INNER JOIN incidents$ i ON c.location_id = i.location_id;

--12) Count how many calls have a matching incident.

SELECT COUNT(DISTINCT call_id) AS calls_with_incidents
FROM calls_for_service$
JOIN incidents$ ON calls_for_service$.location_id=incidents$.location_id;

--13) Find incidents where cleared_dt is before occurred_dt (data error).

SELECT cleared_dt, occurred_dt, incident_id
FROM incidents$
WHERE cleared_dt < occurred_dt;

--14) Replace missing census_tract with 'Unknown' when viewing results.

SELECT ISNULL(census_tract, 'Uknown') AS census_tract, 
COUNT(*) AS  count_rows
FROM incidents$
GROUP BY ISNULL(census_tract, 'Uknown');

--15) Show the 10 most recent incidents.

SELECT TOP 10 * 
FROM incidents$
ORDER BY occurred_dt desc;

--16) Count incidents by weekday name.

SELECT DATENAME(weekday, occurred_dt) AS weekday_name, COUNT(*) AS total
FROM incidents$
GROUP BY DATENAME(weekday, occurred_dt)
ORDER BY total DESC;

--17) Calculate average time-to-clear (in hours).

SELECT AVG(DATEDIFF(hour,occurred_dt,cleared_dt)) AS avg_clear_hrs
FROM incidents$
WHERE cleared_dt IS NOT NULL;

