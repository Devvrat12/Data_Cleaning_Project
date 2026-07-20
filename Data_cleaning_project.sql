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

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT * , 
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions ) as row_num	
FROM layoffs_staging;

SET SQL_SAFE_UPDATES = 0;
DELETE 
FROM layoffs_staging2
WHERE row_num > 1;
SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;


