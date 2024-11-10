--***************************
--*  RESULTADO PROBLEMA 1   *
--***************************
    SELECT EMPNO, LASTNAME, BIRTHDATE, SALARY
    FROM EMPLOYEE
    WHERE SALARY > 30000
    ORDER BY SALARY DESC;
--
--***************************
--*  RESULTADO PROBLEMA 2   *
--***************************
    SELECT LASTNAME, FIRSTNME, WORKDEPT
    FROM EMPLOYEE
    ORDER BY WORKDEPT, LASTNAME DESC;
--
--***************************
--*  RESULTADO PROBLEMA 3   *
--***************************
    SELECT DISTINCT EDLEVEL
    FROM EMPLOYEE
    ORDER BY EDLEVEL DESC;
--
--***************************
--*  RESULTADO PROBLEMA 4   *
--***************************
    SELECT DISTINCT EMPNO, PROJNO
    FROM EMP_ACT
    WHERE EMPNO <= '000100'
    ORDER BY EMPNO;
--
--***************************
--*  RESULTADO PROBLEMA 5   *
--***************************
    SELECT LASTNAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE SEX = 'M'
    ORDER BY LASTNAME;
--
--***************************
--*  RESULTADO PROBLEMA 6   *
--***************************
    SELECT LASTNAME, SALARY, COMM
    FROM EMPLOYEE
    WHERE SALARY > 20000
    AND   HIREDATE  > '1979-12-31'
    ORDER BY LASTNAME;
--
--***************************
--*  RESULTADO PROBLEMA 7   *
--***************************
    SELECT LASTNAME, SALARY, BONUS, COMM
    FROM EMPLOYEE
    WHERE (SALARY > 22000 AND BONUS = 400)
    OR    (COMM < 1900 AND BONUS = 500)
    ORDER BY LASTNAME;
--
--***************************
--*  RESULTADO PROBLEMA 8   *
--***************************
    SELECT LASTNAME, SALARY, BONUS, COMM
    FROM EMPLOYEE
    WHERE SALARY > 22000
    AND   BONUS IN (400,500)
    AND   COMM < 1900
    ORDER BY LASTNAME;
--
--***************************
--*  RESULTADO PROBLEMA 10  *
--***************************
    SELECT DISTINCT MGRNO, DEPTNO
    FROM  DEPARTMENT, EMPLOYEE
    WHERE DEPTNO = WORKDEPT
    ORDER BY 1;
--
--***************************
--*  RESULTADO PROBLEMA 11  *
--***************************
    SELECT EMPNO, LASTNAME, SALARY, BONUS
    FROM   EMPLOYEE
    WHERE  BONUS BETWEEN 800 AND 1000
    ORDER BY 4,1;
--
--***************************
--*  RESULTADO PROBLEMA 12  *
--***************************
    SELECT EMPNO, LASTNAME, SALARY, WORKDEPT
    FROM   EMPLOYEE
    WHERE  WORKDEPT BETWEEN 'A00' AND 'C01'
    ORDER BY 2,1;
--
--***************************
--*  RESULTADO PROBLEMA 13  *
--***************************
    SELECT PROJNO, PROJNAME
    FROM   PROJECT
    WHERE  PROJNAME LIKE '_%SUPPORT%'
    ORDER BY 1;
--
--***************************
--*  RESULTADO PROBLEMA 14  *
--***************************
    SELECT DEPTNO, DEPTNAME
    FROM   DEPARTMENT
    WHERE  DEPTNO LIKE '_1%'
    ORDER BY 1;
--
--***************************
--*  RESULTADO PROBLEMA 15  *
--***************************
    SELECT LASTNAME, FIRSTNME, MIDINIT, SALARY
    FROM   EMPLOYEE
    WHERE  JOB NOT IN ('PRES', 'MANAGER')
    ORDER BY 4 DESC
    FETCH FIRST 5 ROW ONLY;
--
--
