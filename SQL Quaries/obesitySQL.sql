-- CREATE DATABASE
CREATE DATABASE Obesity_Analysis;


-- CREATE TABLE AND SCHEMA
CREATE TABLE ObesityDataset(
			Age FLOAT, 
			Gender VARCHAR(60), 
			Height FLOAT, 
			Weight FLOAT, 
			CALC VARCHAR(60), 
			FAVC VARCHAR(60), 
			FCVC FLOAT, 
			NCP FLOAT, 
			SCC VARCHAR(60), 
			SMOKE VARCHAR(60), 
			CH2O FLOAT, 
			family_history_with_overweight VARCHAR(60), 
			FAF FLOAT, 
			TUE FLOAT, 
			CAEC VARCHAR(60), 
			MTRANS VARCHAR(60), 
			NObeyesdad VARCHAR(60));

			
-- Count total rows
SELECT COUNT(*) AS Total
FROM ObesityDataset;


-- Count unique obesity classes
SELECT 
  COUNT(DISTINCT NObeyesdad) AS obesity_Category,
  COUNT(DISTINCT Gender) AS gender_Category,
  COUNT(DISTINCT calc) AS calc_Category,
  COUNT(DISTINCT scc) AS scc_Category,
  COUNT(DISTINCT smoke) AS smoke_Category
FROM ObesityDataset;


-- Get average age
SELECT AVG(Age) AS avg_age 
FROM ObesityDataset;


-- Get average height
SELECT 
  COUNT(height) AS total_records,
  SUM(height) AS total_height,
  SUM(height)/ COUNT(Age) AS avg_height
FROM ObesityDataset;


-- Get min & max height, weight and age
SELECT MIN(Height) AS MIN_height, MAX(Height) AS MAX_height,
       MIN(Weight) AS MIN_weight, MAX(Weight) AS MAX_weight,
	   MIN(age) AS MIN_age, MAX(age) AS MAX_age
FROM ObesityDataset;


-- People who don't smoke and have high CH2O intake
SELECT smoke, ch2o
FROM ObesityDataset 
WHERE SMOKE = 'no' AND CH2O > 2.0;


-- People who smoke and have CH2O intake is under 1.2 and 1.9
SELECT smoke, ch2o
FROM ObesityDataset
WHERE SMOKE = 'yes' AND ch2o BETWEEN 1.2 AND 1.9;


-- Teenagers with family history of obesity
SELECT age, family_history_with_overweight
FROM ObesityDataset 
WHERE Age BETWEEN 13 AND 19 AND 
family_history_with_overweight = 'yes';


-- Average weight by gender
SELECT Gender, AVG(Weight) AS avg_weight 
FROM ObesityDataset 
GROUP BY Gender;
-- Average weight by gender along with all the informations of the table
SELECT *, 
AVG(Weight) OVER(PARTITION BY Gender) AS avg_weight
FROM ObesityDataset;


-- Count by transport method
SELECT MTRANS, COUNT(*) AS Total
FROM ObesityDataset 
GROUP BY MTRANS;
-- Count by transport method along with all the informations of the table
SELECT *,
COUNT(*) OVER(Partition By MTRANS) AS Total
FROM ObesityDataset;


-- Get gender distribution (value counts of gender)
SELECT Gender, COUNT(*) AS type_count 
FROM ObesityDataset 
GROUP BY Gender;
-- Get gender distribution along with all the informations of the table
SELECT *,
COUNT(*) OVER(Partition By Gender) AS Count_Gender
FROM ObesityDataset;

-- Count by obesity category
SELECT NObeyesdad, COUNT(*) AS total 
FROM ObesityDataset 
GROUP BY NObeyesdad;


-- Average food consumption (FCVC) by NObeyesdad
SELECT NObeyesdad, AVG(FCVC) AS avg_fcvc 
FROM ObesityDataset
GROUP BY NObeyesdad;


-- Average exercise (FAF) by gender
SELECT Gender, NObeyesdad, AVG(FAF) AS avg_faf 
FROM ObesityDataset 
GROUP BY Gender, NObeyesdad;
-- Average exercise (FAF) under gender for each obesity category
SELECT *, 
AVG(FAF) OVER(PARTITION BY Gender, NObeyesdad) AS avg_FAF
FROM ObesityDataset;


-- Rank by weight within each obesity category
SELECT weight, NObeyesdad, RANK() 
OVER (PARTITION BY NObeyesdad ORDER BY Weight DESC) AS weight_rank
FROM ObesityDataset;
-- Fetch the top two highest weight for each obesity category
SELECT weight, NObeyesdad
FROM (
	SELECT *, RANK() 
	OVER(PARTITION BY NObeyesdad ORDER BY weight DESC) AS Top_2
	FROM ObesityDataset
) X
WHERE X.Top_2<3;

-- Running average of CH2O by age
SELECT *, 
AVG(CH2O) 
OVER (ORDER BY Age ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ch2o_moving_avg
FROM ObesityDataset;

-- Percentile of FAF by gender
SELECT *, 
PERCENT_RANK() 
OVER (PARTITION BY Gender ORDER BY FAF) AS exercise_percentile
FROM ObesityDataset;

-- Difference from average weight in group
SELECT *, 
Weight - AVG(Weight) 
OVER (PARTITION BY NObeyesdad) AS weight_diff
FROM ObesityDataset;

-- Cumulative count of users by age
SELECT Age, 
COUNT(*) 
OVER (ORDER BY Age) AS cumulative_users 
FROM ObesityDataset;


-- REMOVE DUPLICATE VALUES
-- FIXED THE SYNTEX
-- HANDLE NULL VALUES
-- Rank users by Weight within each NObeyesdad category
-- Average FAF per NObeyesdad category
-- Moving average of CH2O intake by age
-- FETCH ALL THE INFORMATIONS
SELECT * FROM ObesityDataset;












