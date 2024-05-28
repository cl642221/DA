-- Having vs Where
# 都是给查找限定范围的
# WHERE 不可以单独在group by之前使用，会出错
# WHERE。。。LIKE。。。可以在group by之前使用
# dont forget ;
SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE salary > 60000
GROUP BY occupation
HAVING AVG(salary) > 65000;