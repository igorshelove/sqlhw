--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко
не понял  как построить график , частично выполнил 
https://colab.research.google.com/drive/1ossUhqu9mF1RNneDzwqQ7QJlqpBi2Pkc?usp=sharing
--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
with t1 (select count(1) , Email from Person p 
group by email
having count(1) > 1)
select Email from t1;

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
select e.name  as Employee from Employee e 
join employee e2 on e2.id = e.managerid
where e.salary > e2.salary;
--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
оконки ?? 
--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
select p.firstname, p.lastname,a.city, a.state
  from Person p 
  left join  Address a 
  on a.personid =  p.personid;
