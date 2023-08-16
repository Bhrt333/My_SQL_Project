create database learnvern_2;
use learnvern_2;
create table sales_person(
id int not null,
sname varchar(15) not null,
city varchar(20),
commission decimal(3,2),
primary key(id));

insert into sales_person values
(1001,'Peel','London',0.12),
(1002,'Serres','San Jose',0.13),
(1003,'Rafiq','Barcelona',0.1),
(1004,'Motika','London',0.11),
(1007,'Jigar','New York',0.15);
create table customers(
id int not null,
cname varchar(15) not null,
city varchar(20),
rating integer,
sales_person_id int,
primary key(id));
insert into customers values
(2001,'Hoffman','London',100,1001),
(2002,'Giovanne','Roe',200,1003),
(2003,'Liu','San Jose',300,1002),
(2004,'Grass','Barcelona',100,1002),
(2006,'Clemens','London',300,1007),
(2007,'Periera','Roe',100,1004);
create table orders(
id int,
amount decimal(8,2),
order_date date,
cus_id int,
sales_person_id int);
desc orders;
insert into orders value
(3001,18.69,'1994-10-03',2008,1007);
insert into orders values
(3003,767.19,'1994-10-03',2001,1001),
(3002,1900.10,'1994-10-03',2007,1004),
(3005,3005,'1994-10-03',2003,1002),
(3006,3006,'1994-10-04',2008,1007),
(3009,3009,'1994-10-04',2002,1003),
(3007,3007,'1994-10-05',2004,1002),
(3008,3008,'1994-10-05',2006,1001),
(3010,3010,'1994-10-06',2004,1002),
(3011,3011,'1994-10-06',2006,1001);
select *from orders;
# 1. All orders for more than $1000
select amount from orders
where amount > 1000;
# 2. Names and cities of all salesperson in london with commission above 0.10
select sname, city,commission from sales_person
where city = 'London' and commission > 0.10;
# 3. All salespeople either in Barcelona or in London
select sname, city from sales_person
where city = 'Barcelona' or city='London';
# 4. All salespeople with commission between 0.10 and 0.12 (boundary values shoul be excluded)
select sname,commission from sales_person
where  commission >0.10 and commission< 0.12;
# 5. All customers with Null values in city column
select cname, city from customers
where city =' ';
# 6. All orders taken on 03-Oct and 04-oct 1994
select *from orders
where order_date between '1994-10-03' and '1994-10-04';
# add foriegn key for table joins
desc sales_person;
desc customers;
alter table customers
add constraint foreign key(sales_person_id) 
references sales_person(id);
alter table orders
add constraint foreign key(sales_person_id) 
references sales_person(id);
# 7. All customers serviced by Peel or Motika
select sp.sname, c.cname from sales_person as sp
join customers as c on c.sales_person_id= sp.id
where sname='Peel' or sname='Motika';
# 8. All customers whose names begin with a letter from A to B 
select cname from customers
where cname like 'A%' or cname like '%B';
# 9. All customers excluding with rating <= 100 unless they are located in Rome
select cname, city, rating from customers
where rating <=100 and city = 'Rome';
# 10. All orders except those with 0 or null value in amt field
select *from orders
where amount = 0;
# 11. Count the number of salesperson currently listining orders in the order table
select count(sales_person_id) from orders;  # 10
# 12. Largest order taken by each salesperson,datewise
select sp.sname,max(amount) as amount from orders as o
left join sales_person as sp on o.sales_person_id=sp.id
group by sname;
# 13.Largest order taken by each salesperson with order value more than $3000(i.e same city) 
select sp.sname,max(amount) as amount from orders as o
left join sales_person as sp on o.sales_person_id=sp.id
group by sname having amount > 3000;
# 14. Create store function for insert and update data in products table


