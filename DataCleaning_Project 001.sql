## Data Cleaning ##
-- 1. Remove Duplicates -- 
-- 2. Standardize the Data --
-- 3. Blank values or NULL values --
-- 4. Remove the Columns -- 

SELECT * 
FROM layoffs;

-- to copy or dublicate the table using CREATE TABLE (new table name) LIKE (Ori table) -- 

CREATE TABLE layoffs_copy
LIKE layoffs;
 
SELECT * 
FROM layoffs_copy;

-- to copy data from original table into new table (INSERT ~ SELECT ~ FROM)--
INSERT layoffs_copy
SELECT * 
FROM layoffs;

-- Using window function ROW_NUMBER --
SELECT *,
ROW_NUMBER () OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoffs_copy; 

-- Using CTE -- 
WITH cte_duplicate AS (
SELECT *,
ROW_NUMBER () OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoffs_copy)
SELECT *
FROM cte_duplicate
WHERE row_num > 1 ; 

WITH cte_duplicate AS (
SELECT *,
ROW_NUMBER () OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoffs_copy)
DELETE 
FROM cte_duplicate
WHERE row_num > 1 ; 

CREATE TABLE `layoffs_copy2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num`  INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

SELECT *
FROM layoffs_copy2;

INSERT INTO layoffs_copy2
SELECT *,
ROW_NUMBER () OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoffs_copy;

SELECT *
FROM layoffs_copy2
WHERE row_num >1 ;

DELETE FROM layoffs_copy2
WHERE row_num > 1;

-- Standardizing Data --layoffs
SELECT *
FROM layoffs_copy2;

DROP table layoffs_copy; 

CREATE TABLE layoffs_copy
LIKE layoffs;
 
SELECT * 
FROM layoffs_copy;

INSERT layoffs_copy
SELECT * 
FROM layoffs;

SELECT *,
ROW_NUMBER () OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoffs_copy; 

WITH cte_duplicate AS (
SELECT *,
ROW_NUMBER () OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoffs_copy)
SELECT *
FROM cte_duplicate
WHERE row_num > 1 ; 

WITH cte_duplicate AS (
SELECT *,
ROW_NUMBER () OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoffs_copy)
DELETE 
FROM cte_duplicate
WHERE row_num > 1 ; 
INSERT INTO layoffs_copy2
SELECT *,
ROW_NUMBER () OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoffs_copy;

SELECT *
FROM layoffs_copy2
WHERE row_num >1 ;

DELETE FROM layoffs_copy2
WHERE row_num > 1;

-- Standardizing Data --layoffs
USE layoff_analysis;

SELECT company 
FROM layoffs_copy
order by company ASC; 

SELECT company, TRIM(company)
FROM layoffs_copy;

Update layoffs_copy
SET company = TRIM(company);

SELECT distinct industry
FROM layoffs_copy 
ORDER BY industry ASC;

SELECT *
FROM layoffs_copy
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_copy
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT distinct country, TRIM( TRAILING '.' from country)
FROM layoffs_copy
Order by 1;

UPDATE layoffs_copy
SET country = TRIM( TRAILING '.' from country)
WHERE country LIKE 'United States%';

-- Date Data Type Update --

ALTER TABLE layoffs_copy
RENAME column n_date to date ;

SELECT n_date,
    STR_TO_DATE(n_date, '%m/%d/%Y') AS converted_date
FROM layoffs_copy
ORDER BY converted_date DESC;
    
UPDATE layoffs_copy
SET n_date = STR_TO_DATE(n_date, '%m/%d/%Y');
    
ALTER TABLE layoffs_copy
MODIFY COLUMN n_date date ;

SELECT *
FROM layoffs_copy;

SELECT * 
FROM layoffs_copy
WHERE (total_laid_off is null
AND percentage_laid_off is null)
AND funds_raised_millions is null;

SELECT *
FROM layoffs_copy
WHERE industry is null
OR industry = '' ;

SELECT *
FROM layoffs_copy
WHERE company = 'Airbnb';

-- Filling in the Blank or Replace Data ? -- 

SELECT t1.industry, t2.industry
FROM layoffs_copy t1
JOIN layoffs_copy t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry is NULL OR t1.industry = '')
AND t2.industry is NOT NULL;

UPDATE layoffs_copy
SET industry = null
where industry = '';


UPDATE layoffs_copy t1
JOIN layoffs_copy t2
	ON t1.company = t2.company
    AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE (t1.industry is NULL)
AND t2.industry is NOT NULL;

SELECT *
From layoffs_copy
WHERE total_laid_off is null
AND percentage_laid_off is null;

DELETE 
From layoffs_copy
WHERE total_laid_off is null
AND percentage_laid_off is null;

ALTER TABLE layoffs_copy
DROP COLUMN stage;