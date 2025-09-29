-- Exploratory Data Analysis -- 
SELECT *
FROM layoffs_copy;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_copy; 

SELECT *
FROM layoffs_copy
ORDER BY total_laid_off DESC;

SELECT *
FROM layoffs_copy
WHERE percentage_laid_off = 1;

SELECT *
FROM layoffs_copy
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off) as total_layoff
FROM layoffs_copy
GROUP BY company
ORDER BY total_layoff DESC;

SELECT MIN(date), MAX(date)
FROM layoffs_copy;

SELECT industry, SUM(total_laid_off) as total_layoff
FROM layoffs_copy
GROUP BY industry
ORDER BY total_layoff DESC;

SELECT country, SUM(total_laid_off) as total_layoff
FROM layoffs_copy
GROUP BY country
ORDER BY total_layoff DESC;

SELECT year(date), SUM(total_laid_off) as total_layoff
FROM layoffs_copy
GROUP BY year(date)
ORDER BY year(date) DESC;

SELECT *
FROM layoffs_copy;

SELECT substring(date,1,7) as month_year, SUM(total_laid_off) as total_layoff
FROM layoffs_copy
WHERE substring(date,1,7) is not null
GROUP by month_year
ORDER by month_year ASC;

WITH Rolling_Total AS 
(
SELECT substring(date,1,7) as month_year, SUM(total_laid_off) as total_layoff
FROM layoffs_copy
WHERE substring(date,1,7) is not null
GROUP by month_year
ORDER by month_year ASC
)
SELECT month_year, total_layoff, 
SUM(total_layoff) OVER(ORDER BY month_year) as rolling_total 
FROM Rolling_Total;

SELECT company, YEAR(date), SUM(total_laid_off) as total_layoff
FROM layoffs_copy
GROUP BY company, YEAR(date)
ORDER BY YEAR(date) DESC; 

WITH company_year (company,years,total_layoff)  as
( 
SELECT company, YEAR(date), SUM(total_laid_off) as total_layoff
FROM layoffs_copy
GROUP BY company, YEAR(date)
ORDER BY YEAR(date) DESC
)
SELECT * , 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_layoff DESC) as ranking
FROM company_year
WHERE years is not null
ORDER by ranking ASC; 

-- Using 2 CTE -- 
WITH company_year (company,years,total_layoff)  as
( 
SELECT company, YEAR(date), SUM(total_laid_off) as total_layoff
FROM layoffs_copy
GROUP BY company, YEAR(date)
ORDER BY YEAR(date) DESC
), company_year_rank as 
(
SELECT * , 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_layoff DESC) as ranking
FROM company_year
WHERE years is not null
)
SELECT *
FROM company_year_rank
WHERE ranking <=5 ; 