******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. calcular-intereses.
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
      *-----------------------
       DATA DIVISION.
       LINKAGE SECTION.
       01  saldo-cuenta      PIC 9(9)V99.
       01  tasa-interes      PIC 9V999.
       01  saldo-actualizado PIC 9(9)V99.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
      *FILE SECTION.
      *-----------------------
      *WORKING-STORAGE SECTION.
      *-----------------------
       PROCEDURE DIVISION USING saldo-cuenta
                                tasa-interes
                                saldo-actualizado.

       COMPUTE saldo-actualizado = saldo-cuenta +
                                   (saldo-cuenta * tasa-interes).

       EXIT PROGRAM.