******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. TablasInteres.
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
      *-----------------------
       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
      *-----------------------
       WORKING-STORAGE SECTION.
      *-----------------------
       01 tasa-interes-tabla.
          05 tipo-prestamo OCCURS 5 TIMES.
             10 nombre-prestamo  PIC X(20).   *> Nombre del tipo de préstamo
             10 tasa-interes     PIC 9V99.    *> Tasa de interés correspondiente
       01  tipo-busqueda         PIC 9.
       01  i                     PIC 9.
       01  i-prestamo            PIC 9 VALUE 6.
       01  continuar             PIC X VALUE "S".

       PROCEDURE DIVISION.

       PERFORM INDICAR-PRESTAMOS-CREAR
           UNTIL i-prestamo <= 5.

       PERFORM LLENAR-TABLA-PRESTAMO
           VARYING i FROM 1 BY 1 UNTIL i > i-prestamo.

       PERFORM VISUALIZAR-TABLA-PRESTAMO
           UNTIl continuar = "N"

       STOP RUN.

       INDICAR-PRESTAMOS-CREAR.
           DISPLAY
           "Indica el numero de Prestamos a Crear(hasta 5): "
           ACCEPT i-prestamo
           IF i-prestamo < 1 OR i-prestamo > 5
               DISPLAY "Indicar un numero del 1 al 5..."
               MOVE 6 to i-prestamo
           END-IF.

       LLENAR-TABLA-PRESTAMO.
           DISPLAY "--------------------"
           DISPLAY "Prestamo " i
           DISPLAY "Indicame Nombre del Prestamo: "
               ACCEPT nombre-prestamo(i)
           DISPLAY "Indicame la Tasa del Prestamo: "
               ACCEPT tasa-interes(i).

       VISUALIZAR-TABLA-PRESTAMO.
           DISPLAY "--------------------"
           DISPLAY  "Indica el numero de Prestamos a Buscar: "
           ACCEPT i.
           DISPLAY "Nombre del Prestamo: " nombre-prestamo(i)
           DISPLAY "Tasa de Prestamo: " tasa-interes(i)
           DISPLAY "Quieres Buscar Otro Prestamo(S/N): "
           ACCEPT continuar.