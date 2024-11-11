******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ProcesarTransaccion.

       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT transacciones-in
           ASSIGN TO "C:\Users\anton\CobolSql\transacciones.txt"
           ORGANIZATION IS LINE SEQUENTIAL.

           SELECT RESUMEN-OUT
           ASSIGN TO "C:\Users\anton\CobolSql\resumen_transacciones.txt"
           ORGANIZATION IS LINE SEQUENTIAL.

      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
       FD  transacciones-in.
       01  transaccion-registro.
           05 CODIGO-CLIENTE      PIC 9(6).
           05 FECHA-TRANSACCION   PIC X(10).
           05 TIPO-TRANSACCION    PIC X(10).
           05 MONTO-TRANSACCION   PIC 9(7)V99.

       FD  RESUMEN-OUT.
       01  RESUMEN-REGISTRO      PIC X(80).

       *-----------------------
       WORKING-STORAGE SECTION.
      *-----------------------
       01  WS-CODIGO-ANTERIOR    PIC 9(6) VALUE ZEROS.
       01  WS-LINEA-RESUMEN      PIC X(80).
       01  SI-NO                 PIC X    VALUE "S".
       01  file-status           PIC XX.
       01  mensaje-error1        PIC X(60).

       PROCEDURE DIVISION.
       INICIO.

       PERFORM ABRIR-ARCHIVOS.

       PERFORM LEER-ARCHIVO.

       PERFORM PROCESAR-TRANSACCION
                   UNTIL SI-NO = "N".

       PERFORM CERRAR-ARCHIVO.

       ABRIR-ARCHIVOS.
           OPEN INPUT transacciones-in
           IF file-status = "35" THEN
              MOVE
                "El archivo TRANSACCIONES-IN no existe."
                 TO mensaje-error1
              PERFORM MOSTRAR-ERROR
              STOP RUN
           END-IF
           OPEN OUTPUT RESUMEN-OUT.


       LEER-ARCHIVO.
           READ transacciones-in INTO transaccion-registro
                AT END
                    MOVE "N" TO SI-NO
                NOT AT END
                    PERFORM PROCESAR-TRANSACCION
           END-READ.

       PROCESAR-TRANSACCION.
           IF CODIGO-CLIENTE NOT = WS-CODIGO-ANTERIOR
              MOVE "Código-Cliente:  " TO WS-LINEA-RESUMEN
              STRING WS-LINEA-RESUMEN DELIMITED BY SPACE
                     CODIGO-CLIENTE DELIMITED BY SPACE
                     INTO RESUMEN-REGISTRO
              WRITE RESUMEN-REGISTRO
              MOVE CODIGO-CLIENTE TO WS-CODIGO-ANTERIOR
           END-IF

           MOVE SPACES TO WS-LINEA-RESUMEN
           STRING "Fecha: " FECHA-TRANSACCION DELIMITED BY SPACE
               "Tipo: " TIPO-TRANSACCION DELIMITED BY SPACE
               "Monto: " MONTO-TRANSACCION DELIMITED BY SPACE
               INTO WS-LINEA-RESUMEN
           MOVE WS-LINEA-RESUMEN TO RESUMEN-REGISTRO
           WRITE RESUMEN-REGISTRO.
           PERFORM LEER-ARCHIVO.

       CERRAR-ARCHIVO.
           CLOSE TRANSACCIONES-IN
           CLOSE RESUMEN-OUT
           STOP RUN.

       MOSTRAR-ERROR.
           DISPLAY mensaje-error1.