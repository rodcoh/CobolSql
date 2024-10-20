******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. YOUR-PROGRAM-NAME.
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

       01  cliente.
           05 cliente-id             PIC 9(4).           *> ID único del cliente
           05 cliente-nombre         PIC X(30).          *> Nombre del cliente
           05 cliente-direccion      PIC X(50).          *> Dirección del cliente
           05 cuentas OCCURS 3 TIMES.
              10 cuenta-id           PIC 9(6).           *> ID de la cuenta bancaria
              10 cuenta-tipo         PIC X(15).          *> Tipo de cuenta (Corriente, Ahorro)
              10 cuenta-saldo        PIC 9(7)V99.        *> Saldo de la cuenta
              10 transacciones OCCURS 5 TIMES.
                 15 transaccion-id    PIC 9(6).           *> ID de la transacción
                 15 transaccion-monto PIC 9(7)V99.       *> Monto de la transacción
                 15 transaccion-tipo  PIC X(10).         *> Tipo (Depósito, Retiro)

       01  i                          PIC 9 VALUE 0.
       01  j                          PIC 9 VALUE 0.

       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.

       PERFORM CARGAR-DATOS-ESTRUCTURA.

       CARGAR-DATOS-ESTRUCTURA.
           MOVE 1234 TO cliente-id
           MOVE "Juan Pérez" TO cliente-nombre
           MOVE "Calle Falsa 123" TO cliente-direccion

           MOVE 101010 TO cuenta-id(1)
           MOVE "Cuenta Corriente" TO cuenta-tipo(1)
           MOVE 1000.50 TO cuenta-saldo(1)

           MOVE 500 TO transaccion-monto(1,1)
           MOVE "Depósito" TO transaccion-tipo(1,1)


           DISPLAY "Información del cliente: "
           DISPLAY "ID: " cliente-id
           DISPLAY "Nombre: " cliente-nombre
           DISPLAY "Dirección: " cliente-direccion

           PERFORM VARYING i FROM 1 BY 1 UNTIL i > 3
              IF cuenta-id(i) NOT = 0 THEN
                 DISPLAY "Cuenta ID: " cuenta-id(i)
                 DISPLAY "Tipo: " cuenta-tipo(i)
                 DISPLAY "Saldo: " cuenta-saldo(i)

                 PERFORM VARYING j FROM 1 BY 1 UNTIL j > 5
                    IF transaccion-id(i, j) NOT = 0 THEN
                       DISPLAY "Transacción ID: " transaccion-id(i, j)
                       DISPLAY "Monto: " transaccion-monto(i, j)
                       DISPLAY "Tipo: " transaccion-tipo(i, j)
                    END-IF
                 END-PERFORM
              ELSE
               MOVE 4 TO i
              END-IF
           END-PERFORM.

           STOP RUN.
