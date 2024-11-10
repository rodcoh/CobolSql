--
--***************************
--*  RESULTADO PROBLEMA 1   *
--***************************
    SELECT LASTNAME, SALARY, DECIMAL(SALARY * 1.05,8,2) AS SALARIOPOS,
           DECIMAL((SALARY - (SALARY * 0.05)),8,2) AS SALARIONEG
    FROM   EMPLOYEE
    WHERE  SALARY * 1.05 <= 20000
    ORDER  BY 2;
 --
--***************************
--*  RESULTADO PROBLEMA 2   *
--***************************
    SELECT LASTNAME, EDLEVEL, DECIMAL(SALARY + 1200,8,2) AS NUEVO_SAL,
           DECIMAL(BONUS / 2,8,2) AS NUEVO_BONO
    FROM   EMPLOYEE
    WHERE  EDLEVEL IN (20,18)
    ORDER  BY 2 DESC, NUEVO_SAL;
--
--***************************
--*  RESULTADO PROBLEMA 3   *
--***************************
    SELECT WORKDEPT, LASTNAME, SALARY,
           DECIMAL(SALARY - 1000,8,2) AS DECR_SALARIO
    FROM   EMPLOYEE
    WHERE  WORKDEPT = 'D11'
    AND    SALARY >= (20000 * 80) / 100
    AND    SALARY <= (20000 * 120) / 100
    ORDER  BY SALARY;
--
--***************************
--*  RESULTADO PROBLEMA 4   *
--***************************
    SELECT WORKDEPT, LASTNAME,
           COALESCE((SALARY + COMM + BONUS),0) AS TOTAL
    FROM   EMPLOYEE
    WHERE  WORKDEPT = 'D11'
    AND    COALESCE((SALARY + COMM + BONUS),0) >
           COALESCE((SALARY * 1.10),0)
    ORDER  BY TOTAL DESC;
--
--***************************
--*  RESULTADO PROBLEMA 5   *
--***************************
    SELECT PROJNO, COALESCE(MAJPROJ,'MAIN PROJECT') AS MEJOR_PROYECTO
    FROM   PROJECT
    WHERE  PROJNO LIKE 'MA%'
    ORDER  BY PROJNO;
--
--***************************
--*  RESULTADO PROBLEMA 6   *
--***************************
    SELECT YEAR(PRSTDATE) AS AYO, MONTH(PRSTDATE) AS MES, PROJNO
    FROM   PROJECT
    WHERE  PRENDATE = '1982-12-01'
    ORDER  BY PROJNO;
--
--***************************
--*  RESULTADO PROBLEMA 7   *
--***************************
    SELECT PROJNO,
      DECIMAL(ROUND(((DAYS(PRENDATE)-DAYS(PRSTDATE))/7.0),1),4,1)
      AS SEMANA
    FROM   PROJECT
    WHERE  PROJNO LIKE 'MA%'
    ORDER  BY PROJNO;
--
--***************************
--*  RESULTADO PROBLEMA 8   *
--***************************
    SELECT
      DAYS('2000-01-01')-DAYS('1969-07-20')
      AS DIAS
    FROM   PROJECT
    WHERE  PROJNO = 'MA2100'
--  ORDER  BY PROJNO;
--
