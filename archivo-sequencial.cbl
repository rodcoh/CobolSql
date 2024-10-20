 ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Practica1.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT salarios
            ASSIGN TO "C:\\Users\\anton\\CobolSql\\NombreSalario.dat"
            ORGANIZATION IS LINE SEQUENTIAL
            FILE STATUS IS file-status.



       DATA DIVISION.
       FILE SECTION.
       FD  salarios.
       01  registro-entrada.
           05 nombre   PIC X(30).
           05 salario  PIC 9(7).

       WORKING-STORAGE SECTION.
       01  total-salarios  PIC 9(7) VALUE 0.
       01  contador        PIC 9(5) VALUE 0.
       01  fin             PIC X    VALUE SPACES.
       01  file-status     PIC XX.


       PROCEDURE DIVISION.

       PERFORM ABRIR-ARCHIVO.
       PERFORM LEER-ARCHIVO.
       PERFORM PROCESAR THRU PROCESAR
           UNTIL fin = "S".
       PERFORM IMPRIMIR.
       PERFORM CERRAR-ARCHIVO.
       STOP RUN.


       ABRIR-ARCHIVO.
           OPEN INPUT salarios
           IF file-status NOT = "00"
              DISPLAY "Error al abrir el archivo. Código de error: "
                 file-status
              STOP RUN
           END-IF
           MOVE "N" TO fin.

       LEER-ARCHIVO.
           READ salarios INTO registro-entrada
            AT END MOVE "S" TO fin.

       PROCESAR.
           ADD salario TO total-salarios
           ADD 1      TO contador
           PERFORM LEER-ARCHIVO.

       IMPRIMIR.
           DISPLAY "El Total Salarios es :" total-salarios
           DISPLAY "Total de Trabajadores :" contador.
           ACCEPT fin.

       CERRAR-ARCHIVO.
           CLOSE salarios.
