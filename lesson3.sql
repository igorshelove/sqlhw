--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
select s."class" , count(s."name")from  outcomes o -- 
full join ships s on s."name" = o.ship
where o."result" ='sunk'
and s."name"  is not null
group by s."class" ;

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
select s."class" , min(s.launched) from ships s -- min(s.launched), s."class"
full join  outcomes o2 
on o2.ship = s."name" 
group by s."class"  ;

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.
select coalesce (s."class", null , 'empty class'), count(o.ship) from outcomes o  left join ships s  on s."name" = o.ship 
where  o."result" ='sunk'
group by s."class" ;

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).

select * from classes c inner join ships s on s."class" = c."class" ;

select  s."name" from ships s inner join classes c on c."class" = s."class" 
inner join (
			select max(c.numguns) as numguns_max, c.displacement from ships s
			inner join  classes c on s."class" =c."class" 
			full join  outcomes o  on o.ship  = s."class"
			group by  c.displacement ) as t 
			on c.numguns = t.numguns_max
			and c.displacement  = t.displacement;
--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
with t1 as (select max(pc.speed) , p3.maker from pc
join product p3 
on pc.model =  p3.model
where p3.maker in (
					select p.maker from product p 
					where p.type = 'Printer'
					and exists  (select 1 from  product p2
					where p2.maker =  p.maker
					and type = 'PC')
					group by p.maker )
and  ram = (select min(ram) from pc )
group by p3.maker)
select maker from t1;
