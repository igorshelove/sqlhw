--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type
SELECT model, maker , type FROM product ;
--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"
select *,
case 
when price > (select avg(price) from printer p3) then 1
else 0
end as avg 
from printer p2 ;
--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
select * from outcomes o
right join ships s
on s."name"  = o.ship
right  join  classes c  on c."class" = s."class"
where s."class"  is null; 

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
select * from   battles b
where cast(extract(year from b."date") as  int) not in (select launched from ships);

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select * from  battles b2 
left join  outcomes o
ON  o.battle = b2."name" 
left join  ships s
on s."name" = o.ship 
where s."class" ='Kongo';

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag
create or replace view   all_products_flag_300 as
 with t1  as 
 (select model, price  from pc 
 union 
 select model, price  from laptop l
 union 
 select model, price from printer p)
 select
 t1.model,
 t1.price,
 case 
	when t1.price > 300 then 1 
	else 0
end as flag 
 from t1 
join product  pr on pr.model  = t1.model;
--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag
create or replace view all_products_flag_avg_price as 
 with t1  as 
 (select model, price  from pc 
 union 
 select model, price  from laptop l
 union 
 select model, price from printer p)
 select
 t1.model,
 t1.price,
case 
when t1.PRICE > (select AVG(PRICE) from T1) then 1
else 0 
end avg 
 from t1 
join product  pr on pr.model  = t1.model;
--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
select p.model from printer pr join product p on p.model = pr.model 
where maker = 'A'
and  price  > (select avg(price) from  printer p2 
				join  product p3 
				on p3.model = p2.model 
				where maker in ('C', 'D'));
--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
select p.model from printer pr join product p on p.model = pr.model 
where maker = 'A'
and  price  > (select avg(price) from  printer p2 
				join  product p3 
				on p3.model = p2.model 
				where maker in ('C', 'D'));
--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
??
--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count
create or replace view count_products_by_makers as 
 with t1  as 
 (select model  from pc 
 union 
 select model  from laptop l
 union 
 select model from printer p)
 select
 count(t1.model), pr.maker
 from t1 
join product  pr on pr.model  = t1.model
group by  pr.maker ;
--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'
create table printer_copy  as
select p.maker, pr.* from  printer pr 
join product p on p.model = pr.model;

delete  from printer_copy pc 
where pc.maker ='D';

select  * from printer_copy;

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)
-- сделал в прошлом задании

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
create or replace view sunk_ships_by_classes as 
select  count(s."name"), coalesce(s."class", 0::text)  from outcomes o  --coalesce(s."class", 0::text)
left join ships s  on s."name"  = o.ship
where o."result" = 'sunk'
group by s."class";
--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0
create table classes_with_flag as 
select 
case 
	when numguns >=9 
	then 1 
	else 0
end  flag,
c2.*
from classes c2 ;
--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)


--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

select * from  outcomes o full  join  ships s on s."name"  = o.ship 
where s.name  ~ '^O|^M';

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.
select * from  outcomes o full  join  ships s on s."name"  = o.ship 
where s.name  ~ '\w+\s+?\w+';
--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
select count(name), launched from ships s
group by  launched ;

