use project;

drop table if exists emp_log;
drop table if exists emp;
drop table if exists dept;
drop table if exists student;
drop view  if exists  v1;

-- create dept table
create table dept (
    deptno int primary key,
    dname varchar(14),
    loc varchar(13)
);

insert into dept (deptno, dname, loc) values
(10, 'accounting', 'new york'),
(20, 'research', 'dallas'),
(30, 'sales', 'chicago'),
(40, 'operations', 'boston');

-- create emp table
create table emp (
    empno int primary key,
    ename varchar(10),
    job varchar(9),
    mgr int,
    hiredate date,
    sal decimal(7,2),
    comm decimal(7,2),
    deptno int,
    foreign key (deptno) references dept(deptno)
);

insert into emp values
(7369, 'smith', 'clerk', 7902, '1980-12-17', 800, null, 20),
(7499, 'allen', 'salesman', 7698, '1981-02-20', 1600, 300, 30),
(7521, 'ward', 'salesman', 7698, '1981-02-22', 1250, 500, 30),
(7566, 'jones', 'manager', 7839, '1981-04-02', 2975, null, 20),
(7654, 'martin', 'salesman', 7698, '1981-09-28', 1250, 1400, 30),
(7698, 'blake', 'manager', 7839, '1981-05-01', 2850, null, 30),
(7782, 'clark', 'manager', 7839, '1981-06-09', 2450, null, 10),
(7788, 'scott', 'analyst', 7566, '1987-07-13', 3000, null, 20),
(7839, 'king', 'president', null, '1981-11-17', 5000, null, 10),
(7844, 'turner', 'salesman', 7698, '1981-09-08', 1500, 0, 30),
(7876, 'adams', 'clerk', 7788, '1987-07-13', 1100, null, 20),
(7900, 'james', 'clerk', 7698, '1981-12-03', 950, null, 30),
(7902, 'ford', 'analyst', 7566, '1981-12-03', 3000, null, 20),
(7934, 'miller', 'clerk', 7782, '1982-01-23', 1300, null, 10);

-- create student table
create table student (
    rno int primary key,
    sname varchar(14),
    city varchar(20),
    state varchar(20)
);

insert into student values
(1, 'john', 'new york', 'ny'),
(2, 'alice', 'dallas', 'tx'),
(3, 'bob', 'chicago', 'il');

-- create emp_log table
create table emp_log (
    emp_id int,
    log_date date,
    new_salary decimal(10,2),
    action varchar(20)
);

-- 2. list employees in asc order of deptno, desc of job
select * from emp order by deptno asc, job desc;

-- 3. unique job groups in desc order
select distinct job from emp order by job desc;

-- 4. employees who joined before 1981
select * from emp where hiredate < '1981-01-01';

-- 5. empno, ename, sal, daily sal in asc order of annual salary
select empno, ename, sal, (sal/30) as daily_sal
from emp
order by (sal*12) asc;

-- 6. empno, ename, sal, exp for mgr 7369
select empno, ename, sal, timestampdiff(year, hiredate, curdate()) as exp
from emp
where mgr = 7698;

-- 7. employees whose comm > sal
select * from emp where comm > sal;

-- 8. clerks or analysts in desc order
select * from emp where job in ('clerk', 'analyst') order by job desc;

-- 9. employees with annual salary between 22000 and 45000
select * from emp
where (sal*12) between 22000 and 45000;

-- 10. enames starting with s and with five characters
select * from emp
where ename like 's____%';

-- 11. empno not starting with digit 78
select * from emp
where empno not like '78%';

-- 12. clerks of deptno 20
select * from emp where job = 'clerk' and deptno = 20;

-- 13. employees senior to their mgrs
select e.*
from emp e
join emp m on e.mgr = m.empno
where e.hiredate < m.hiredate;

-- 14. employees of deptno 20 whose jobs are same as deptno 10
select * from emp
where deptno = 20 and job in (select distinct job from emp where deptno = 10);

-- 15. employees whose sal same as ford or smith in desc order
select * from emp
where sal in (select sal from emp where ename in ('ford','smith'))
order by sal desc;

-- 16. employees whose jobs same as smith or allen
select * from emp
where job in (select job from emp where ename in ('smith','allen'));

-- 17. jobs of deptno 10 not found in deptno 20
select distinct job from emp
where deptno = 10
and job not in (select distinct job from emp where deptno = 20);

-- 18. highest salary in emp
select max(sal) as highest_sal from emp;

-- 19. details of highest paid employee
select * from emp where sal = (select max(sal) from emp);

-- 20. total salary given to mgrs
select sum(sal) as total_mgr_sal from emp where job = 'manager';

-- 21. employees whose names contain 'a'
select * from emp where ename like '%a%';

-- 22. employees with min sal for each job in asc order
select *
from emp e
where sal = (select min(sal) from emp where job = e.job)
order by job asc;

-- 23. employees whose sal greater than blake's
select * from emp where sal > (select sal from emp where ename = 'blake');

-- 24. create view v1 to select ename, job, dname, loc with same deptno
create view v1 as
select e.ename, e.job, d.dname, d.loc
from emp e
join dept d on e.deptno = d.deptno;

-- 25. create procedure with dno input to fetch ename and dname
delimiter $$
create procedure get_emp_dept_by_dno(in dno int)
begin
    select e.ename, d.dname
    from emp e
    join dept d on e.deptno = d.deptno
    where e.deptno = dno;
end $$
delimiter ;

-- 26. add column pin bigint to student
alter table student add pin bigint;

-- 27. modify sname length and create trigger for salary update
alter table student modify sname varchar(40);

delimiter $$
create trigger after_salary_update
after update on emp
for each row
begin
    if old.sal <> new.sal then
        insert into emp_log (emp_id, log_date, new_salary, action)
        values (new.empno, curdate(), new.sal, 'new salary');
    end if;
end $$
delimiter ;
