--task1  (lesson8)
-- oracle: х

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
select fm.member_name , fm.status,  sum(p.unit_price*p.amount) as costs from FamilyMembers as fm
left join  Payments as  p
on fm.member_id =  p.family_member
where extract(YEAR from p.date) = 2005
group by fm.member_name , fm.status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
select distinct(p1.name) from  Passenger p1
inner join  Passenger p2 
on p1.name = p2.name 
and p1.id<>p2.id
--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
??
select count(DISTINCT sch.date)  from Student s
        inner join  Student_in_class sc on sc.student = s.id
        inner join  class c on sc.class= c.id
        inner join Schedule sch on sch.class = c.id
        where first_name = 'Anna'
--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
select count(*) as count  from Schedule s inner join Subject su 
on su.id = s.subject
where s.date ='2019-09-02'
--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
дубль
--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32 -- результат не принят 
select round(avg(extract(year from  sysdate()) - extract(year from birthday))) as age from FamilyMembers 
--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
select
 g.good_name as  good_type_name,
 sum(p.amount * p.unit_price) as costs from Payments p
 join Goods g on g.good_id = p.good
 where extract (year from p.date)
group by g.good_name
--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
select extract(year from sysdate()) - max(extract(year from birthday)) from Student
--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
--10 класса нету
select extract(year from  sysdate()) - min(extract(year from s.birthday))  from Student  s  left  join Student_in_class sc on s.id = sc.id
where sc.class = 10
--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
select fm.status, fm.member_name, sum(p.amount*p.unit_price) as costs from Payments p join Goods g on p.good = g.good_id
 join GoodTypes gt on gt.good_type_id = g.type
 right join FamilyMembers fm on fm.member_id = p.family_member
 where  gt.good_type_name = 'entertainment'
 group by fm.status, fm.member_name
--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
delete from Company where  name  in (
select t2.name from (
select count(*) as count, c.name from Trip t
 join Company c on c.id = t.company
group by c.name
having count in (
select min(t.cnt) from 
(select count(*) as cnt, c.name from Trip t
join Company c on c.id = t.company
group by c.name) as t )) as t2 )
--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
with t1 as (select COUNT(*)  as count ,  s1.classroom  from Schedule s1
group  by  s1.classroom
having count in (select  max(t.cnt) from (
select COUNT(*) cnt,  classroom  from Schedule
group  by  classroom
order  by  COUNT(*) desc) as t))
select classroom from t1
--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
select last_name from  Teacher t  left join Schedule sc on sc.teacher = t.id
left join Subject su on su.id = sc.subject
where su.name in ('Physical Culture')
order by last_name asc
--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63
select concat(last_name, '.', LEFT(first_name , 1), '.', LEFT(middle_name , 1), '.') as name from Student s
order by name asc 

