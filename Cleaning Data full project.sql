-- Data Cleaning

-- prepare the data
-- create a new database
	-- create a new schema
    -- rename this schema
    -- import the data
    
-- data query
SELECT *
FROM layoffs; -- 裁员

-- 1. Remove Duplicates
-- 2. Standardize the data (spelling issure...)
-- 3. Null Values or blank values (see if these null values can be populated填充)
-- 4. Remove column and row that aren't necessary
	-- should not to do this when manipulate the massive datasetss
    -- in the real work, do not remove the data from row datasets
    -- create a new table, same as raw dataset!!

-- Create a copy table with same column name as layoffs --

CREATE TABLE layoff_staging
LIKE layoffs;

SELECT *
FROM layoff_staging;

-- insert the data into layoffs_staging
INSERT layoff_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoff_staging;


    
-- Identify Duplicates --
-- 对比所有项，并标记有几行，如果行数大于1，则为重复
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off,percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_num
-- `date`: date with back ticks, becuse date is the keyword in MySQL
FROM layoff_staging;-- when the row_number is large than 1, then duplicates


-- create a cte to identify the duplicates
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off,percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_num
-- 'date': date with back ticks, becuse date is the keyword in MySQL
FROM layoff_staging-- when the row_number is large than 1, then duplicates
) 
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoff_staging
WHERE company = 'Cazoo';

-- WITH duplicate_cte AS
-- (
-- SELECT *,
-- ROW_NUMBER() OVER(
-- PARTITION BY company, location, industry, total_laid_off,percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_num
-- 'date': date with back ticks, becuse date is the keyword in MySQL
-- FROM layoffs_staging-- when the row_number is large than 1, then duplicates
-- ) 
-- Delete -- does not work, the cte table can not be updated, 
-- delete statement is a update statement
-- FROM duplicate_cte
-- WHERE row_num > 1;
-- create another table with row-num to deltet the duplicates --
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
  `row_num` INT 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off,percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_num
-- 'date': date with back ticks, becuse date is the keyword in MySQL
FROM layoff_staging; -- when the row_number is large than 1, then duplicates

-- delete the duplicates

DELETE
FROM layoffs_staging2
WHERE row_num > 1;		

SELECT *
FROM layoffs_staging2;

-- Standardizing Data
-- finding issues in your data and fix it

SELECT company, TRIM(company)
FROM layoffs_staging2;
-- 每一列数据都有可能因为拼写或者不同的空格，可能存在同样的公司或者数据，但是写法不一样的可能性，而这一步就是删除这些可能性
-- take off the white space
UPDATE layoffs_staging2
SET company = TRIM(company); -- take the white space off the end

SELECT DISTINCT industry -- DISTINCT 不显示重复的内容
FROM layoffs_staging2
ORDER BY 1;
-- 检查是否有相同含义的数据，但不是用一样的词表示

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';
-- 将检查出来的都用一个词进行替换

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;


SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1; -- 按这一列升序进行排序

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';
-- same function as the above statement, get rid of '.' from country
-- SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
-- FROM layoffs_staging2
-- order by 1;

-- time series visualization, need to change the format of date, text is not good for time series visualizaiton
-- it is necessary to change it to a date column 

-- change the time to date format --
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') -- very helpful
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- NEVER DO THIS IN RAW DATA ! ! ! !--
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE; -- change the date column format to DATE

SELECT *
FROM layoffs_staging2;

-- Nulls & Blank Values --
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; -- useless infors when total_laid_off and percentage_laid_off both are null


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.company = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL )
AND t2.industry IS NOT NULL;
 
DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP column row_num;

SELECT *
FROM layoffs_stshizoaging2;
