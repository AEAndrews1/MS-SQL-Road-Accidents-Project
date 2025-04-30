SELECT * FROM road_accident
--Primary KPI's
--CY Casualties
SELECT SUM(number_of_casualties) AS CY_Casualties FROM road_accident
WHERE YEAR(accident_date) = '2022'

--CY Accidents
SELECT COUNT(DISTINCT accident_index) AS CY_Accidents FROM road_accident
WHERE YEAR(accident_date) = '2022'

--Fatal Casualties
SELECT SUM(number_of_casualties) AS CY__Fatal_Accidents FROM road_accident
WHERE YEAR(accident_date) = '2022' and accident_severity = 'Fatal'

--Fatal Casualties (Excel)
SELECT SUM(number_of_casualties) AS Fatal_Casualties, CAST(SUM(number_of_casualties)AS DECIMAL (10,2)) * 100/
(Select CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) FROM road_accident) AS Fatal_PCT FROM road_accident
WHERE accident_severity = 'Fatal'

--Serious Casualties
SELECT SUM(number_of_casualties) AS CY__Serious_Accidents FROM road_accident
WHERE YEAR(accident_date) = '2022' and accident_severity = 'Serious'

--Serious Casualties (Excel)
SELECT SUM(number_of_casualties) AS Serious_Casualties, CAST(SUM(number_of_casualties)AS DECIMAL (10,2)) * 100/
(Select CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) FROM road_accident) AS Serious_PCT FROM road_accident
WHERE accident_severity = 'Serious'

--Slight Casualties
SELECT SUM(number_of_casualties) AS CY__Slight_Accidents FROM road_accident
WHERE YEAR(accident_date) = '2022' and accident_severity = 'Slight'


--Slight Casualties (Excel)
SELECT SUM(number_of_casualties) AS Slight_Casualties, CAST(SUM(number_of_casualties)AS DECIMAL (10,2)) * 100/
(Select CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) FROM road_accident) AS Slight_PCT FROM road_accident
WHERE accident_severity = 'Slight'

--Secondary KPI's
--Casualties By Vehicle Type
SELECT
	CASE	
		WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricultural'
		WHEN vehicle_type IN ('Car', 'Taxi/Private hire car') THEN 'Car'
		WHEN vehicle_type IN ('Motorcycle 125cc and under', 'Motorcycle 50cc and under', 'Motorcycle over 125cc and up to 500cc', 'Motorcycle over 500cc', 'Pedal cycle') THEN 'Bike'
		WHEN vehicle_type IN ('Bus or coach (17 or more pass seats)', 'Minibus (8 - 16 passenger seats)') THEN 'Bus'
		WHEN vehicle_type IN ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t', 'Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
		ELSE 'Other'
	END AS vehicle_group,
	SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR (accident_date) = '2022'
GROUP BY
	CASE
		WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricultural'
		WHEN vehicle_type IN ('Car', 'Taxi/Private hire car') THEN 'Car'
		WHEN vehicle_type IN ('Motorcycle 125cc and under', 'Motorcycle 50cc and under', 'Motorcycle over 125cc and up to 500cc', 'Motorcycle over 500cc', 'Pedal cycle') THEN 'Bike'
		WHEN vehicle_type IN ('Bus or coach (17 or more pass seats)', 'Minibus (8 - 16 passenger seats)') THEN 'Bus'
		WHEN vehicle_type IN ('Goods 7.5 tonnes mgw and over', 'Goods over 3.5t. and under 7.5t', 'Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
		ELSE 'Other'
	END

--CY Casualties vs PY Casualties Monthly Trend
SELECT DATENAME(MONTH, accident_date) AS Month_Name, SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR (accident_date) = '2022'
GROUP BY DATENAME(MONTH, accident_date)

SELECT DATENAME(MONTH, accident_date) AS Month_Name, SUM(number_of_casualties) AS PY_Casualties
FROM road_accident
WHERE YEAR (accident_date) = '2021'
GROUP BY DATENAME(MONTH, accident_date)

--CY Casualties by Road Type
SELECT road_type, SUM(number_of_casualties)AS CY_Casualties
FROM road_accident
WHERE YEAR (accident_date) = '2022'
GROUP BY road_type

--CY Casualties by Urban/Rural
SELECT urban_or_rural_area, SUM(number_of_casualties) AS CY_Casualties, CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) * 100/
(SELECT CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) FROM road_accident WHERE YEAR (accident_date) = '2022') 
AS CY_Casualties_PCT
FROM road_accident
WHERE YEAR (accident_date) = '2022'
GROUP BY urban_or_rural_area


--CY Casualties by Urban/Rural (Excel)
SELECT urban_or_rural_area, SUM(number_of_casualties) AS Casualties, CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) * 100/
(SELECT CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) FROM road_accident) --WHERE YEAR (accident_date) = '2022') 
AS Casualties_PCT
FROM road_accident
--WHERE YEAR (accident_date) = '2022'
GROUP BY urban_or_rural_area


--CY Casualties by Light Condition
SELECT
	CASE	
		WHEN light_conditions IN ('Daylight') THEN 'Day'
		WHEN light_conditions IN ('Darkness - lighting unknown', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - no lighting') THEN 'Night'
	END AS light_conditions,
	SUM(number_of_casualties) AS CY_Casualties,
	CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 /
	(SELECT CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) FROM road_accident WHERE YEAR(accident_date) = '2022') AS DECIMAL(10,2)) 
	AS CY_Casualties_PCT
FROM road_accident
WHERE YEAR (accident_date) = '2022'
GROUP BY
	CASE	
		WHEN light_conditions IN ('Daylight') THEN 'Day'
		WHEN light_conditions IN ('Darkness - lighting unknown', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - no lighting') THEN 'Night'
	END

--CY Casualties by Light Condition (Excel)
SELECT
	CASE	
		WHEN light_conditions IN ('Daylight') THEN 'Day'
		WHEN light_conditions IN ('Darkness - lighting unknown', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - no lighting') THEN 'Night'
	END AS light_conditions,
	SUM(number_of_casualties) AS Casualties,
	CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 /
	(SELECT CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) FROM road_accident) AS DECIMAL(10,2)) 
	AS Casualties_PCT
FROM road_accident
--WHERE YEAR (accident_date) = '2022'
GROUP BY
	CASE	
		WHEN light_conditions IN ('Daylight') THEN 'Day'
		WHEN light_conditions IN ('Darkness - lighting unknown', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - no lighting') THEN 'Night'
	END


--Top 10 Locations by No. of Casualties
SELECT TOP 10 local_authority, SUM(number_of_casualties) AS Total_Casualties
FROM road_accident
GROUP BY local_authority
ORDER BY Total_Casualties DESC

--CY Casualties by Road Surface
SELECT
	CASE	
		WHEN road_surface_conditions IN ('Dry') THEN 'Dry'
		WHEN road_surface_conditions IN ('Wet or damp', 'Flood over 3cm. deep') THEN 'Wet'
		WHEN road_surface_conditions IN ('Frost or ice', 'Snow') THEN 'Snow or Ice'
	END AS road_surface_conditions,
	SUM(number_of_casualties) AS CY_Casualties,
	CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 /
	(SELECT CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) FROM road_accident WHERE YEAR(accident_date) = '2022') AS DECIMAL(10,2)) 
	AS CY_Casualties_PCT
FROM road_accident
WHERE YEAR (accident_date) = '2022'
GROUP BY
	CASE	
		WHEN road_surface_conditions IN ('Dry') THEN 'Dry'
		WHEN road_surface_conditions IN ('Wet or damp', 'Flood over 3cm. deep') THEN 'Wet'
		WHEN road_surface_conditions IN ('Frost or ice', 'Snow') THEN 'Snow or Ice'
	END


--CY Casualties by Road Surface (Excel)
SELECT
	CASE	
		WHEN road_surface_conditions IN ('Dry') THEN 'Dry'
		WHEN road_surface_conditions IN ('Wet or damp', 'Flood over 3cm. deep') THEN 'Wet'
		WHEN road_surface_conditions IN ('Frost or ice', 'Snow') THEN 'Snow or Ice'
	END AS road_surface_conditions,
	SUM(number_of_casualties) AS CY_Casualties,
	CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 /
	(SELECT CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) FROM road_accident) AS DECIMAL(10,2)) 
	AS CY_Casualties_PCT
FROM road_accident
--WHERE YEAR (accident_date) = '2022'
GROUP BY
	CASE	
		WHEN road_surface_conditions IN ('Dry') THEN 'Dry'
		WHEN road_surface_conditions IN ('Wet or damp', 'Flood over 3cm. deep') THEN 'Wet'
		WHEN road_surface_conditions IN ('Frost or ice', 'Snow') THEN 'Snow or Ice'
	END

--CY Casualties by Weather Conditions
SELECT
	CASE	
		WHEN weather_conditions IN ('Fine + high winds', 'Fine no high winds') THEN 'Fine'
		WHEN weather_conditions IN ('Raining + high winds', 'Raining no high winds') THEN 'Rain Weather'
		WHEN weather_conditions IN ('Fog or mist', 'Snowing + high winds', 'Snowing no high winds') THEN 'Snow or Fog'
		ELSE 'Other'
	END AS weather_conditions,
	SUM(number_of_casualties) AS CY_Casualties,
	CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 /
	(SELECT CAST(SUM(number_of_casualties) AS DECIMAL (10,2)) FROM road_accident WHERE YEAR(accident_date) = '2022') AS DECIMAL(10,2)) 
	AS CY_Casualties_PCT
FROM road_accident
WHERE YEAR (accident_date) = '2022'
GROUP BY
	CASE	
		WHEN weather_conditions IN ('Fine + high winds', 'Fine no high winds') THEN 'Fine'
		WHEN weather_conditions IN ('Raining + high winds', 'Raining no high winds') THEN 'Rain Weather'
		WHEN weather_conditions IN ('Fog or mist', 'Snowing + high winds', 'Snowing no high winds') THEN 'Snow or Fog'
		ELSE 'Other'
	END
