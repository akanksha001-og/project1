use mydb2;
create table department(
dpt_id int primary key,
dpt_name varchar(50)
);
DROP TABLE IF exists EMP1;
create table emp1
( emp1_id int primary key,
emp1_name varchar(25) not null,
salary int default 0,
dpt_id int,
DOJ DATE,
foreign key(dpt_id) references department(dpt_id)
);

insert into department values
(1,'ayushi'),
(2,'akanksha'),
(3,'suman'),
(4, 'ayush');

insert into emp1 values
(1, 'aka', 50000, 2, '2005-01-01'),
(2, 'jiya', 50000, 1, '2003-07-03'),
(3, 'akaksh', 40000, 4, '2001-03-02'),
(4, 'priya', 60000, 3, '2000-04-01');
select * from emp1;
select * from department;

select 
  emp1.emp1_name,
  department.dpt_name
  from emp1
  left join department
  on department.dpt_id = emp1.dpt_id;
  
  use mydb1;
   select * from products;
     select * from productlines;
     
     select products.productname,
          productlines.textdescription
          from products
          left join productlines
          on productlines.productline = products.productline;
          
          select * from offices;
          select * from employees;
          
          select employees.firstname,
			employees.lastname,
            offices.city,
            offices.state
            from employees
            left join offices
            on employees.officecode = offices.officecode;
            select * from products;
           select * from orderdetails;
           
           select products.productname,
           sum(orderdetails.quantityordered) as 'total'
           from products
           left join orderdetails
           on products.productcode = orderdetails.productcode
           group by productname;
           
           select * from products;
           select * from orderdetails;
           
          select 
          products.productname,
          avg(orderdetails.priceeach) as 'total_avg',
      sum(orderdetails.quantityordered * priceeach) as 'total'
          from products
          left join orderdetails
          on orderdetails.productcode = products.productcode
          group by productname;
          use mydb1;
          select * from employees;
          select * from orders;
          select * from customers;
          selecT * FROM ORDERDETAILS;
          select * from offices;
          SELECT * FROM PAYMENTS;
     use mydb1;     
SELECT 
	EMPLOYEES.FIRSTNAME, 
    EMPLOYEES.LASTNAME, 
      count(orders.ordernumber) as 'total'
FROM CUSTOMERS
JOIN employees
ON EMPLOYEES.EMPLOYEENUMBER = customers.salesrepemployeenumber
join orders
on CUSTOMERS.customernumber = orders.customernumber
group by  EMPLOYEES.FIRSTNAME,
    EMPLOYEES.LASTNAME;
          
select 
	employees.firstname, 
    employees.lastname,
		sum(orderdetails.quantityordered)
from customers 
join employees
on EMPLOYEES.EMPLOYEENUMBER = customers.salesrepemployeenumber
join orders
on orders.customernumber = customers.customernumber
join ORDERDETAILS
on orderdetails.ordernumber = orders.ordernumber
group by employees.firstname, 
    employees.lastname;
    use mydb1;
    select * from customers;
    
    
    # OFFICE CITY WISE CUSTOMER COUNT
    SELECT 
    offices.city, 
    count(customers.customername) as 'customer_count'
    from  
      offices
    left join 
      Employees
    on employees.officecode = offices.officecode
    join 
       customers
    on employees.employeenumber = customers.salesrepemployeenumber
    group by  
         offices.city
    order by customer_count desc
limit 5;
# EMPLOYEE NUMBER WISE PAYMENTS
SELECT * FROM CUSTOMERS;
select * from employees;
# EMPLOYEE NUMBER WISE PAYMENT

SELECT 
  employees.EMPLOYEENUMBER, 
   PAYMENTS.AMOUNT
FROM 
     EMPLOYEES 
LEFT JOIN CUSTOMERS
ON CUSTOMERS.SALESREPEMPLOYEENUMBER = EMPLOYEES.EMPLOYEENUMBER
LEFT JOIN PAYMENTS
ON 
   PAYMENTS.CUSTOMERNUMBER = CUSTOMERS.CUSTOMERNUMBER
group by 
    employees.EMPLOYEENUMBER, PAYMENTS.AMOUNT
order by PAYMENTS.AMOUNT desc
LIMIT 5;
use mydb1;
select * from employees;

select emp.firstname,
mang.firstname 
from employees as emp
join employees as mang
on  emp.reportsto = mang.employeenumber;
























   
    