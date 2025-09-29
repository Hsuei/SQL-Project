# SQL-Project
Data Cleaning and Manipulating with SQL

Executive Summary

Analysis of the layoff data reveals that the tech and startup downturn, primarily driven by the Financial Services and Consumer sectors, saw its peak in total workforce reduction in 2023. The trend is characterized by a "mass layoffs" approach, where a small number of companies are responsible for the largest cuts.

Key Insights 💡

1. Total Workforce Impact & Trend
   
Peak Layoffs in 2023: While the earliest layoffs occurred in 2020, the highest volume of total layoffs occurred in 2023, indicating that the economic impact worsened significantly over time (based on SELECT year(date), SUM(total_laid_off)).

Monthly Fluctuation: The rolling total analysis confirms that the crisis did not slow down, with total layoffs accumulating rapidly, especially toward the end of the dataset's timeline (based on the Rolling_Total CTE).

2. Industry Concentration
   
Top 3 Heaviest Hit Industries: The Consumer, Retail, and Financial industries bear the largest burden of total layoffs (based on SELECT industry, SUM(total_laid_off)). This suggests these sectors faced the most pronounced over-hiring, market correction, or funding challenges.

Financial Sector's Unique Role: The Financial industry, in particular, saw some of the highest total layoff numbers, suggesting a sector-specific correction, likely driven by rising interest rates and economic uncertainty.

3. Company-Level Impact
   
Mass Layoff Approach: The data is skewed by a small number of companies performing extremely large cuts. The ranking CTE shows that a select few companies dominate the Top 5 rankings for total layoffs each year.

Layoffs as a Last Resort: A high number of layoff events resulted in 100% of the company's workforce being laid off (based on WHERE percentage_laid_off = 1), indicating business failure or complete pivot, not just optimization.

4. Geographic and Funding Correlates
   
United States Dominance: The United States accounts for the vast majority of total layoffs (based on SELECT country, SUM(total_laid_off)), confirming that the US market was the epicenter of this economic correction.

Funding Paradox: The companies with the highest total layoffs are often correlated with those that have received the highest funding in millions, suggesting that large capital injection did not prevent significant workforce reductions.
