--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT IF(GRADE < 8, NULL, NAME), GRADE, MARKS
FROM STUDENTS JOIN GRADES
WHERE MARKS BETWEEN MIN_MARK AND MAX_MARK
ORDER BY GRADE DESC, NAME
--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem
-- частичное решение 
with t as (select 
name as  Doctor,
NULL as Professor ,
NULL as Singer,
NULL as Actor   
from OCCUPATIONS
where Occupation  = 'Doctor'
union 
select
NULL as Doctor ,
name as Professor ,
NULL as Singer,
NULL as Actor   
from OCCUPATIONS
where Occupation  = 'Professor'
 union
 select   
NULL as Doctor ,
NULL as Professor ,
name as Singer,
NULL as Actor   
from OCCUPATIONS
where Occupation  = 'Singer'
union
 select   
NULL as Doctor ,
NULL as Professor ,
NULL as Singer,
 name as Actor   
from OCCUPATIONS
where Occupation  = 'Actor'
) 
select with t as (select 
name as  Doctor,
NULL as Professor ,
NULL as Singer,
NULL as Actor   
from OCCUPATIONS
where Occupation  = 'Doctor'
union 
select
NULL as Doctor ,
name as Professor ,
NULL as Singer,
NULL as Actor   
from OCCUPATIONS
where Occupation  = 'Professor'
 union
 select   
NULL as Doctor ,
NULL as Professor ,
name as Singer,
NULL as Actor   
from OCCUPATIONS
where Occupation  = 'Singer'
union
 select   
NULL as Doctor ,
NULL as Professor ,
NULL as Singer,
 name as Actor   
from OCCUPATIONS
where Occupation  = 'Actor'
) 
 -- Professor, Singer, Actor  from t 

 -- Professor, Singer, Actor  
--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
--дубль
--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem
select CITY from STATION
where not REGEXP_LIKE(lower(CITY), '^a|^e|^i|^o|^u|^y')
group by CITY;
--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem
select CITY from STATION
where not REGEXP_LIKE(lower(CITY), '^[^aieou]|.*?[^aeiou]$')
group by CITY;

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
select CITY from STATION
where not REGEXP_LIKE(lower(CITY), '^[^aieou]|.*?^[^aeiou]$')
group by CITY;
--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem
select name from Employee
where months <10
and  salary > 2000;
--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
--дубль

