create table employee(
id int not null auto_increment,
first_name varchar(50),
last_name varchar(50),
salary decimal(10,2),
joining_date datetime,
department varchar(25));
insert into employee values
(1,'John','Abraham',100000,'2013-01-01 12:00:00','Banking'),
(2,'Michael','Clarke',80000,'2013-01-01 12:00:00','Insurance'),
(3,'Roy','Thomas',70000,'2013-02-01 12:00:00','Banking'),
(4,'Tom','Jose',60000,'2013-02-01 12:00:00','Insurance'),
(5,'Jerry','Pinto',650000,'2013-02-01 12:00:00','Insurance'),
(6,'Phillip','Mathew',750000,'2013-01-01 12:00:00','Services'),
(7,'Jigar','Diesel',650000,'2013-01-01 12:00:00','Services'),
(8,'Jay','Stark',600000,'2013-02-01 12:00:00','Insurance');
select *from employee;
create table incentives(
emp_id int not null,
incentive_date date,
incentive_amount decimal(6,2));
insert into incentives values
(1,'2013-02-01',5000),
(2,'2013-02-01',3000),
(3,'2013-02-01',4000),
(1,'2013-01-01',4500),
(2,'2013-01-01',3500);
alter table employee 
add constraint primary key(id);
alter table incentives
add constraint foreign key(emp_id) 
references employee(id);
select *from incentives;
select *from employee;
use learnvern_1;

# 1. Get First_Name from employee table using alias Name "Employee Name"
select first_name from employee as Employee_Name;
# 2. Get first_name,joining year,joining month and joining date from employee table
select first_name, 
YEAR(joining_date) as joining_year,
month(joining_date) as joining_month,
day(joining_date) as joining_date
from employee;
# 3. Get all employee detailes from the employee table order by first_name ascending and salary descending
select *from employee order by first_name asc,salary desc;
# 4. Get employee details from employee table whose first name contains 'o'
select *from employee
where first_name = 'o%';
select date_format(joining_date, '%d-%b-%Y %H:%i:%sn AM') from employee;
# 5. Get employee details from employee table whose joining month is January
select *from employee
where month(joining_date) = '01'; 
# 6. Get department,total salary with respect to a departmnet from employee table order by total salary descending
select department,sum(salary) as total from employee
group by department 
order by total desc;
# 7. Get department wise maximum salary from employee table order by salary ascending
select department, max(salary) as max_salary
 from employee
group by department
order by max_salary asc;
# 8. select first_name,incentive amount from employee and 
#incentives table for those employyees who have incentives amount greater than3000
#select e.first_name,e.incentive_amount from employee join  on i.emp_id;
select e.first_name,i.incentive_amount from employee as e 
join incentives as i on e.id = i.emp_id 
where incentive_amount > 3000;
# 9. select 2nd Highest salary from employee table 
select distinct salary from employee
order by salary desc
limit 1 offset 1;
# 10. select first_name,incentive amount from employee and incentives table 
#for all employees who got incentives using left join
select e.first_name,i.incentive_amount as incentive, i.incentive_date
from incentives as i
left join employee as e on i.emp_id = e.id ;
# 11. Create View of employee table in which store first name,last name and salary only
CREATE VIEW employee_details AS
SELECT first_name, last_name, salary
FROM employee;
SELECT * FROM employee_details;
# 12. create procedure to find out department wise highest salry
delimiter //
create procedure dept_salary()
begin
select department,max(salary)from employee
group by department;
end //
use learnvern_1;
create table value_table(
id int not null,
first_name varchar(50),
last_name varchar(50),
salary decimal(10,2),
department varchar(25)
);

call dept_salary();
# 13. create after insert trigger on employee table which insert records in view table
 delimiter //
 create trigger view_table
 after insert on employee
 for each row
 begin
 insert into value_table(id,first_name,last_name,salary,department)
 values(new.id,new.first_name,new.last_name,new.salary,new.department);
 end //
 insert into employee values
 (9,'Benjamin','Tenison',600000,'2013-02-01 12:00:00','Insurance'),
 (10,'Kevin','Elevan',600000,'2013-01-01 12:00:00','Insurance');
 select * from value_table;
 # trigger worked 
 # End
 
 
 
 
 
 
 
 
 
 
 
 
 
 
