--4331 S'19
--Lec 4 In Class Practice

--1.
--print names, dept numbers of employees supervised by manager with id 7839
--  in the increasing order of employee names

--name, dep number, manager
--clause 
SELECT  ename, deptno
FROM  emp
WHERE  mgr = 7839
ORDER BY ename;

--2.
--For the above query, limit the query result to be at most 2 rows
SELECT  ename, deptno
FROM  emp
WHERE  mgr = 7839 AND ROWNUM < 3
ORDER BY ename;

SELECT  ename, deptno
FROM  emp
WHERE  mgr = 7839 AND ROWNUM < 3;
--ORDER BY ename;

SELECT  ename, deptno
FROM  emp
WHERE ROWNUM < 3;

--3.
--print all employees' work information like this:
-- KING works in Dept 10
-- BLAKE works in Dept 30
--display the heading of the query result to be Work Info

--emp name, dept no. 

SELECT   ename || ' works in Dept ' || deptno AS "Work Info"
FROM  emp ;