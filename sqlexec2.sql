--
--***************************
--*  RESULTADO PROBLEMA 1   *
--***************************
    SELECT LASTNAME, FIRSTNME, DEPTNAME
    FROM   EMPLOYEE, DEPARTMENT
    WHERE  WORKDEPT = DEPTNO
    ORDER  BY 3,1;
--
--***************************
--*  RESULTADO PROBLEMA 2   *
--***************************
    SELECT LASTNAME, FIRSTNME, DEPTNAME, JOB
    FROM   EMPLOYEE, DEPARTMENT
    WHERE  WORKDEPT = DEPTNO
    AND    WORKDEPT BETWEEN 'A02' AND 'D22'
    AND    JOB NOT IN ('MANAGER')
    ORDER  BY 1;
--
--***************************
--*  RESULTADO PROBLEMA 3   *
--***************************
    SELECT DEPTNAME, LASTNAME, FIRSTNME
    FROM   EMPLOYEE, DEPARTMENT
    WHERE  EMPNO = MGRNO
    AND    JOB IN ('MANAGER')
    ORDER  BY 1;
--
--***************************
--*  RESULTADO PROBLEMA 4   *
--***************************
    SELECT DEPTNAME, LASTNAME, FIRSTNME
    FROM   EMPLOYEE, DEPARTMENT
    WHERE  WORKDEPT = DEPTNO
    AND    JOB IN ('MANAGER')
    ORDER  BY 1;
--
--***************************
--*  RESULTADO PROBLEMA 5   *
--***************************
    SELECT DISTINCT A.PROJNO, A.PROJNAME, B.ACTNO
    FROM   PROJECT A, EMP_ACT B
    WHERE  A.PROJNO = B.PROJNO
    AND    A.PROJNO LIKE 'AD%'
    ORDER  BY A.PROJNO, B.ACTNO;
--
--***************************
--*  RESULTADO PROBLEMA 6   *
--***************************
    SELECT DISTINCT C.WORKDEPT, C.LASTNAME, A.PROJNAME, B.ACTNO
    FROM   EMPLOYEE C, PROJECT A, EMP_ACT B
    WHERE  C.EMPNO = B.EMPNO
    AND    A.PROJNO = B.PROJNO
    AND    C.WORKDEPT BETWEEN 'A00' AND 'C01'
    ORDER  BY C.WORKDEPT, C.LASTNAME, B.ACTNO;
--
--***************************
--*  RESULTADO PROBLEMA 7   *
--***************************
    SELECT B.ACTNO, MGRNO, B.EMSTDATE, A.PROJNO, C.LASTNAME
    FROM   DEPARTMENT D, EMPLOYEE C, PROJECT A, EMP_ACT B
    WHERE  C.EMPNO = B.EMPNO
    AND    A.PROJNO = B.PROJNO
    AND    A.DEPTNO = D.DEPTNO
    AND    B.EMSTDATE >= '1982-10-15'
    ORDER  BY B.ACTNO, B.EMSTDATE;
--
--
