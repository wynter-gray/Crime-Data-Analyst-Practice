--1) View all columns from the incidents table.

SELECT *
FROM incidents$

--2) Show only incident_id, status, and occurred_dt.

SELECT incident_id, status, occurred_dt
FROM incidents$;

--3) Find incidents that are Cleared.

SELECT incident_id, status
FROM incidents$
WHERE status = 'Cleared';

-- Or could do SELECT * to return all columns for CLEARED

--4) Find incidents that occurred after January 1, 2025.

SELECT *
FROM incidents$
WHERE occurred_dt >= '2025-01-01';

--5) Find incidents with no offense code (missing data).

SELECT *
FROM incidents$
WHERE offense_code IS NULL;

--6) Show the 5 most recent incidents.

SELECT TOP 5 *
FROM incidents$
ORDER BY occurred_dt DESC;

--7) Show all incidents sorted by status then by date.

SELECT *
FROM incidents$
ORDER BY status, occurred_dt;

--8) Count total number of incidents.

SELECT COUNT(*) AS total_incidents
FROM incidents$

--9) Count number of incidents per status.

SELECT status, COUNT(*) AS incidents_per_status
FROM incidents$
GROUP BY status;

--10) Find the top 3 most common offense codes.

SELECT TOP 3 offense_code, COUNT(*) AS total 
FROM incidents$
WHERE offense_code IS NOT NULL
GROUP BY offense_code
ORDER BY total DESC;

--11) Join incidents with locations to show address.

SELECT address, incident_id, status
FROM locations$
JOIN incidents$ ON locations$.location_id=incidents$.location_id;

--12) Show incidents that occurred in ZIP code 80013.

SELECT incident_id, occurred_dt, zip_code
FROM incidents$
JOIN locations$ ON incidents$.location_id=locations$.location_id
WHERE zip_code = '80013';

--13) Replace missing offense_code values with 'Unknown'.

SELECT ISNULL(offense_code, 'Uknown') AS offense_code,
COUNT(*) as count_row
FROM incidents$
GROUP BY ISNULL(offense_code, 'Uknown');

--14) Find earliest and latest incident dates.

SELECT MIN(occurred_dt) AS earliest_incident,
MAX(occurred_dt) AS latest_incident
FROM incidents$;

--15) Count how many incidents have missing cleared_dt values.

SELECT COUNT(*) AS missing_clear_dates
FROM incidents$
WHERE cleared_dt IS NULL;

--16) Show call_id, final_call_type, and matching incident_id.

SELECT call_id, final_call_type, incident_id
FROM calls_for_service$
JOIN incidents$ ON calls_for_service$.location_id=incidents$.location_id;

--17) Count how many calls have a matching incident by location.

SELECT COUNT(DISTINCT call_id) AS calls_with_incidents
FROM calls_for_service$
JOIN incidents$ on calls_for_service$.location_id=incidents$.location_id;

--18) Find top 5 addresses with the most incidents.

SELECT TOP 5 address, COUNT(incident_id) AS total_incidents
FROM locations$
JOIN incidents$ ON locations$.location_id=incidents$.location_id
GROUP BY address
ORDER BY total_incidents DESC;

--19) Count incidents by weekday name.

SELECT DATENAME(weekday, occurred_dt) AS weekday_name,
COUNT(*) AS Total
FROM incidents$
GROUP BY DATENAME(weekday, occurred_dt)
ORDER BY Total DESC;

--20) Find average time to clear (hours).

SELECT AVG(DATEDIFF(hour, occurred_dt, cleared_dt)) AS avg_hrs_to_clear
FROM incidents$
WHERE cleared_dt IS NOT NULL;

