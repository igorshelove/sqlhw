--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)???  не понятна  задача  нужно объяснение 
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц


--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type),
-- в рамках которого будет процентное соотношение всех товаров по типу устройства. Вывод: производитель,
create or replace  view  distribution_by_type as  --- ошибка  при создании  view   Canceling statement due to lock timeout
select count(p.model)*100/(select count(*) from product)||'%',  p."type" from  product p
group by  p."type" ;


--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму
https://colab.research.google.com/drive/1cKSm8gQ6uzbtfLIdfeqbVaXasRJ4P6oR?usp=sharing

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но у название корабля должно состоять из двух слов
create table ships_two_words as 
select * from  ships s 
where s."name" ~ '\w+?\s+?\w+';

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"
select  * from ships s 
where 1=1
and s."class"  is null
and  s."name" ~ '^S';


--task6 (lesson5) не понятно задание , нужно объяснение 
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model
select * from  product p
inner join  printer p2  on p2.model = p.model 
and p.maker= 'A'
and p2.price >(select avg(p3.price) from  printer p3
			   join product p4  on p3.model = p4.model
			   where  p4.maker='C')

