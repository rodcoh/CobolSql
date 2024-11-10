--
--***************************
--*  RESULTADO PROBLEMA 1   *
--***************************
    SELECT WORKDEPT, SUM(SALARY) AS SUM_SALARY
    FROM   EMPLOYEE
    GROUP  BY WORKDEPT
    ORDER  BY WORKDEPT;
--
--***************************
--*  RESULTADO PROBLEMA 2   *
--***************************
    SELECT WORKDEPT, COUNT(*) AS EMP_CONTADOR
    FROM   EMPLOYEE
    GROUP  BY WORKDEPT
    ORDER  BY WORKDEPT;
--
--***************************
--*  RESULTADO PROBLEMA 3   *
--***************************
    SELECT WORKDEPT, COUNT(*) AS EMP_CONTADOR
    FROM   EMPLOYEE
    GROUP  BY WORKDEPT
    HAVING COUNT(*) > 3
    ORDER  BY WORKDEPT;
--
--***************************
--*  RESULTADO PROBLEMA 4   *
--***************************
    SELECT WORKDEPT, SEX, DECIMAL(AVG(SALARY),8,2) AS AVG_SALARY,
           DECIMAL(AVG(BONUS),8,2) AS AVG_BONUS,
           DECIMAL(AVG(COMM),8,2) AS AVG_COMM,
           COUNT(*) AS CONTADOR
    FROM   EMPLOYEE
    GROUP  BY WORKDEPT, SEX
    HAVING COUNT(*) > 1
    ORDER  BY WORKDEPT, SEX;
--
--***************************
--*  RESULTADO PROBLEMA 5   *
--***************************
    SELECT WORKDEPT, DECIMAL(AVG(BONUS),8,2) AS AVG_BONUS,
           DECIMAL(AVG(COMM),8,2) AS AVG_BONUS
    FROM   EMPLOYEE
    GROUP  BY WORKDEPT
    HAVING AVG(BONUS) > 500
    AND    AVG(COMM) > 2000
    ORDER  BY WORKDEPT;
--
--***************************
--*  EJERCICIOS UNION       *
--***************************
--
--***************************
--*  RESULTADO PROBLEMA 1   *
--***************************
    SELECT LASTNAME, FIRSTNME, 'BEFORE A RAISE' AS WHEN,
           SALARY AS SALARIO
    FROM   EMPLOYEE
    WHERE  JOB <> 'MANAGER'
    AND    WORKDEPT = 'D21'
    UNION
    SELECT LASTNAME, FIRSTNME, 'AFTER A RAISE' AS WHEN,
           SALARY * 1.10 AS SALARIO
    FROM   EMPLOYEE
    WHERE  JOB <> 'MANAGER'
    AND    WORKDEPT = 'D21'
    ORDER  BY LASTNAME, WHEN DESC;
--
--***************************
--*  RESULTADO PROBLEMA 2   *
--***************************
    SELECT WORKDEPT, EMPNO AS EMPLEADO, SALARY AS SALARIO
    FROM   EMPLOYEE
    WHERE  WORKDEPT = 'A00'
    UNION ALL
    SELECT WORKDEPT, 'SUM' AS EMPLEADO, SUM(SALARY) AS SALARIO
    FROM   EMPLOYEE
    WHERE  WORKDEPT = 'A00'
    GROUP  BY WORKDEPT
    ORDER  BY WORKDEPT, SALARIO;
--
--***************************
--*  RESULTADO PROBLEMA 3   *
--***************************
    SELECT 1 AS TYPE, DEPTNO, 'DEPARTAMENTO' AS INFO,
           DEPTNAME AS NAME
    FROM   DEPARTMENT
    WHERE  DEPTNO IN ('A00','B01','C01')
    UNION
    SELECT 2 AS TYPE, A.DEPTNO, B.PROJNO AS INFO,
           PROJNAME AS NAME
    FROM   DEPARTMENT A, PROJECT B
    WHERE  A.DEPTNO = B.DEPTNO
    AND    A.DEPTNO IN ('A00','B01','C01')
    UNION
    SELECT 3 AS TYPE, C.DEPTNO, D.EMPNO AS INFO,
           D.LASTNAME NAME
    FROM   DEPARTMENT C, EMPLOYEE D
    WHERE  C.DEPTNO = D.WORKDEPT
    AND    C.DEPTNO IN ('A00','B01','C01')
    ORDER  BY DEPTNO, TYPE, INFO;
--
--***************************
--*  RESULTADO PROBLEMA 4   *
--***************************
    SELECT 'PROYECTO', PROJNO, RESPEMP, PRSTDATE, PRENDATE
    FROM   PROJECT
    WHERE  PROJNO LIKE 'IF%'
    UNION ALL
    SELECT ' ', B.PROJNO, B.EMPNO AS RESPEMP,
                EMSTDATE AS PRSTDATE, EMENDATE AS PRENDATE
    FROM   PROJECT A, EMP_ACT B
    WHERE  A.PROJNO = B.PROJNO
    AND    B.PROJNO LIKE 'IF%'
    ORDER  BY PROJNO, RESPEMP;
--
