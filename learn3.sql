use learnvern_3;
create table products(
productid int primary key,
productname varchar(20),
recommendedprice float(5,2),
category varchar(10));
insert into products values
(1,'DVD',105.00,'LivingRoom'),
(2,'Microwave',98.00,'Kitchen'),
(3,'Moniter',200.00,'Office'),
(4,'Speakers',85.00,'Office'),
(5,'Refrigerator',900.00,'Kitchen'),
(6,'VCR',165.00,'LivingRoom'),
(7,'CoffePot',35.00,'Kitchen');
select *from products;
create table customers(
customerid int primary key auto_increment,
first_name varchar(50),
lastname varchar(50),
city varchar(50),
state char(2),
zip varchar(10));
alter table customers rename column first_name to firstname;
insert into customers values
(1,'Chintan','Patel','Anand','GJ',388001),
(2,'Paresh','Prajapati','Nadiad','GJ',388001),
(3,'Pragnesh','Patel','Surat','GJ',388001),
(4,'Nilesh','Dharsandia','Mumbai','MH',388001),
(5,'Sonal','Patel','Mumbai','MH',388001),
(6,'Harshal','Patel','Mogari','GJ',388001),
(7,'Prakash','Rathod','Mogari','GJ',388001),
(8,'Aarzoo','Dodhiya','Rajkot','GJ',388001),
(9,'Hetal','Dave','Varanasi','UP',388001),
(10,'Nikita','Dave','Varanasi','UP',388001),
(11,'Vaibhav','Dave','Varanasi','UP',388001),
(12,'Paresh','Patel','Pune','GJ',388001),
(13,'Prakash','Patel','Pune','GJ',388001),
(14,'Sandhya','Patel','Heydrabad','AP',388001),
(15,'Divesh','Patel','Banglore','KA',388001),
(16,'Payal','Shah','Banglore','KA',388001),
(17,'Priyanka','Rana','Anand','GJ',388001),
(18,'Sanket','Dhebar','V.V.Nagar','GJ',388001),
(19,'Puja','Shah','Varanasi','UP',388001),
(20,'Priya','Shah','Varanasi','UP',388001);
update customers 
SET zip = 221002
WHERE customerid = 20;
#change zip code 
create table sales(
salesid int primary key auto_increment,
productid int,
customerid int,
salesprice float(6,2),
salesdate date);

insert into sales values
(1,1,1,130,'2005-06-14'),
(2,2,2,97,'2005-06-19'),
(3,3,3,200,'2005-09-20'),
(4,4,4,80,'2005-03-22'),
(5,5,5,899,'2005-01-23'),
(6,3,6,150,'2005-03-24'),
(7,3,7,209,'2005-03-10'),
(8,4,8,90,'2005-08-11'),
(9,6,9,130,'2005-08-12'),
(10,2,14,85,'2005-12-13');
insert into sales values
(11,3,15,240,'2005-05-14'),
(12,1,17,87,'2005-07-19'),
(13,2,18,99,'2005-09-20'),
(14,6,19,150,'2005-07-22'),
(15,5,5,900,'2005-03-06'),
(16,4,6,86,'2005-04-07'),
(17,2,2,88,'2005-11-08'),
(18,3,8,198,'2005-05-09'),
(19,1,9,150,'2005-10-10'),
(20,6,14,99,'2005-05-09');
insert into sales values
(21,6,15,104,'2005-09-20'),
(22,4,14,90,'2005-07-22'),
(23,1,1,130,'2005-03-06'),
(24,2,2,102,'2005-04-07'),
(25,1,3,114,'2005-11-08'),
(26,5,4,1000,'2005-05-09'),
(27,5,5,1100,'2005-10-10'),
(28,3,6,285,'2005-06-11'),
(29,2,7,87,'2005-10-12'),
(30,3,8,300,'2005-07-13'),
(31,3,20,205,'2005-12-31');
show tables;
alter table sales 
add foreign key(customerid)
references customers(customerid);
alter table sales 
add foreign key(productid)
references products(productid);
# 1. Return the FirstName, LastName, ProductName, and SalePrice for all products sold in the month of October2005.
select c.firstname,c.lastname,
 p.productname,s.salesprice ,s.salesdate
from sales as s
join customers as c on c.customerid = s.customerid
join products as p on p.productid = s.productid
where salesdate like '%-10-%';
# 2. Return the CustomerID, FirstName, and LastName of those individuals in 
#the Customer table who have made no Sales purchases
SELECT c.customerid, c.firstname, c.lastname
FROM customers as c
left join sales s ON c.customerid = s.customerid
where s.customerid is null;
# 3. Return the FirstName, LastName, SalePrice, Recommended SalePrice, and 
# the difference between the SalePrice and Recommended SalePrice for all Sales. 
# The difference must be returned as a positive number.
select c.firstname , c.lastname , s.salesprice,
 p.recommendedprice as recommendedprice, abs(salesprice - recommendedprice) as pricedifferance
from customers as c
join sales as s on c.customerid = s.customerid 
join products as p on p.productid = s.productid;
# 4. Return the average Saleprice by category.
select p.category ,avg(salesprice) from sales as s
join products as p on p.productid = s.productid
group by category;
# 5. Add the following customer and sale information to the database(using store procedure)
# First name Priyanka lastname Chopra city Mumbai state MH Zip 400002 productid 3 saleprice 205 saledate 12/31/2005 
delimiter //
create procedure insert_details(
in First_Name varchar(50),Last_Name varchar(50),
City varchar(50),State varchar(2),
Zip varchar(10),ProductId int ,
 SalesPrice float(6,2), SalesDate date)
 begin 
 insert into customers (firstname,lastname,city,state,zip)
 values (First_Name,Last_Name,City,State,Zip);
 insert into sales (salesprice,productid,salesdate) values(SalesPrice,ProductId,SalesDate);
 end //
# call the function 
call insert_details('Priyanka','Chopra','Mumbai','MH',400002,3,205,'2005-12-31');
# select *from customers & select *from sales to values updated or not
# 6. Return the product category and the average saleprice for those customers who have purcahsec two or more products
select  concat(c.firstname, ' ', c.lastname) as full_name, p.category,
avg(s.salesprice) as avg_sales from sales as s
join products as p on s.productid = p.productid
join customers as c on s.customerid = c.customerid
group by full_name, p.category; 
# 7. Update the sale price to the recommended sale price of the salesoccurring between 6/10/2005 and 6/20/2005
update sales as s
join products as p on s.productid = p.productid
set s.salesprice = p.recommendedprice
where s.salesdate between '2005-06-10' and '2005-06-20';
# 8. Number of sales by product category where the average recommendedprioce is 10 or more dollars greater than the average sale price.
select p.category, avg(p.recommendedprice) as recommended,
avg(s.salesprice) as avg_sales from sales as s 
join products as p on s.productid = p.productid
group by p.category
having avg(p.recommendedprice) >= avg(s.salesprice)+10;
# 9. Without using a declared iterative construct ,return sale date and the running total for all sale, ordered by the sale date in ascending order
select salesdate, sum(salesprice)
from sales
group by salesdate
order by salesdate asc ;
# 10. Make function to find sum of salesprice group by customerid. 
delimiter //
create function find_sum_sales()
returns float 
deterministic 
begin 
declare  total_sales float;
select customerid, sum(s.salesprice) into total_sales
from sales;
return total_sales;
end //
#  THE END 
