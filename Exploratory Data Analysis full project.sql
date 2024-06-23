SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- 看一下裁员率为100%的公司，并且哪个公司人数最多 --
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- 看一下裁员率为100%的公司，并且哪个公司投资最多 --
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT *
FROM layoffs_staging2
WHERE country = 'United States'
ORDER BY percentage_laid_off DESC;

-- 按照公司计算总裁员数并排序 --
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- 从时间可以看出是哪个阶段，比如这个数据反映的是covid阶段三年的裁员数
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- 按照行业计算总裁员数 --
-- 消费业和零售业裁员率最高，原因有可能是很多商店关门
-- retail 零售业
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;



-- 从国家看 --
-- USA far the most
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- 看每年的总裁员人数 --
-- 2023 only has 3 mounths data, but the layoffs is super high
-- in 2023 the number of layoffs is ramoing up, just 3 mounth data is most closed the data from 2022 1 year data.
SELECT YEAR(`date`) , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

-- 从投资的阶段stage来看 --
SELECT stage , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- 总裁员率, 平均裁员率，按照公司 ， 但是有意义吗这样的信息????? --
-- 这个数据不是很相关 --
SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- 裁员的进展， rolling sum滚动总和， 从一开始的裁员，一步一步叠加，到最后的裁员 --

-- 将每个月的总裁员人数得到，并按找月份排序， 注意这里将年份也写出来了，这样可以从2020 年开始排序
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off)-- the month
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC;

-- 进行rolling sum
