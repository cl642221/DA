-- Group By
SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM parks_and_recreation.employee_demographics
Group BY gender;

SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
Group BY occupation;
# 通过 GROUP BY 子句，可以更方便地对数据进行汇总和分析，使得数据的展示和理解更加直观。
# 基本用法 GROUP BY 子句通常与聚合函数一起使用，例如 COUNT、SUM、AVG、MAX 和 MIN。
# 常用场景
# 汇总数据：如计算销售额、平均值、最大值、最小值等。
# 分类统计：如统计每个分类的商品数量、每个城市的用户数量等。
# 分组排序：与 ORDER BY 结合使用，对分组后的数据进行排序。
# 数据分析：与 HAVING 子句结合使用，筛选出符合条件的分组数据。

-- ORDER BY
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender, age DESC;