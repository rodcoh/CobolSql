******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. subprogramaprincipal.
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
       01  saldo-cuenta       PIC 9(9)V99.
       01  tasa-interes       PIC 9V999.
       01  saldo-actualizado  PIC 9(9)V99.
       01  saldo-actualizado-z PIC ZZZZZZZ9V99.
       01  continuar          PIC X.
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

       DISPLAY "Ingrese el saldo de la cuenta: "
       ACCEPT saldo-cuenta.

       DISPLAY "Ingrese la tasa de interés (ej. 0.05 para 5%): "
       ACCEPT tasa-interes.

       CALL 'calcular-intereses' USING saldo-cuenta
                                       tasa-interes
                                       saldo-actualizado.

       MOVE saldo-actualizado TO saldo-actualizado-z.
       DISPLAY "El saldo actualizado con intereses es: "
               saldo-actualizado-z.
      *ACCEPT continuar.

       STOP RUN.
