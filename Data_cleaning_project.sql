-- DATA CLEANING PROJECT

SELECT *
FROM layoffs;

-- 1. REMOVE DUPLICATES.
-- 2. STANDARDIZE THE DATA.
-- 3. NULL VALUES OR BLANK VALUES.
-- 4. REMOVE ANY COLUMNS.

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM LAYOFFS_STAGING;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- REMOVING DUPLICATES

SELECT * , 
ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, date ) as row_num	
FROM layoffs_staging;

WITH duplicates_cte AS 
(
SELECT * , 
ROW_NUMBER() OVER(PARTITION BY company,  industry, total_laid_off, percentage_laid_off, 'date' ) as row_num	
FROM layoffs_staging
)
SELECT *
FROM duplicates_cte
WHERE row_num > 1;


SELECT * 
FROM layoffs_staging
WHERE COMPANY = 'Better.com';


WITH duplicates_cte AS 
(
SELECT * , 
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions ) as row_num	
FROM layoffs_staging
)
SELECT *
FROM duplicates_cte
WHERE row_num > 1;


SELECT * 
FROM layoffs_staging
WHERE COMPANY = 'Spotify';