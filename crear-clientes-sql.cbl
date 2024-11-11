******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. crear-clientes-sql.
       DATA DIVISION.
       FILE SECTION.
      *
       WORKING-STORAGE SECTION.
       01  ID-CLIENTE    PIC X(36)
               VALUE "Introduce un ID del Cliente: ".
       01  NOMBRE        PIC X(33)
               VALUE "Introduce un nombre de Cliente: ".
       01  DIRECCION     PIC X(25)
               VALUE "Introduce una dirección: ".
       01  TELEFONO      PIC X(33)
               VALUE "Introduce un número de teléfono: ".

       01  CLIENTES-REGISTRO.
           05 CLIENTE-ID        PIC X(6).
           05 CLIENTE-NOMBRE    PIC X(50).
           05 CLIENTE-DIRECCION PIC X(100).
           05 CLIENTE-TELEFONO  PIC X(20).

       01  CLIENTES-REGISTRO-A.
           05 CLIENTE-ID-A        PIC X(6).
           05 CLIENTE-NOMBRE-A    PIC X(50).
           05 CLIENTE-DIRECCION-A PIC X(100).
           05 CLIENTE-TELEFONO-A  PIC X(20).


       01  SQLCODE  PIC S9(9) COMP-5.
       01  SQLSTATE PIC X(5).


       01  SI-NO     PIC X.
       01  ENTRADA   PIC X.
       01  continuar PIC X VALUE "S".
       01  opcion    PIC X.


       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

       PERFORM CONECTAR-SQL.

       PERFORM PROCESAR
           UNTIL continuar = "S".

       PERFORM DESCONECTAR-SQL.


       CONECTAR-SQL.
           EXEC-SQL
              CONNECT TO 'ProyectoCobolSql'
              USER 'root'
              USING '21281502'
           END-EXEC.

           IF SQLCODE NOT = 0
              DISPLAY "Error de conexión: " SQLCODE " - " SQLSTATE
              PERFORM DESCONECTAR-SQL
           END-IF
           DISPLAY "Conectados...."
           ACCEPT ENTRADA.


       PROCESAR.
           *> Limpiar la pantalla
           *> DISPLAY X"1B" "[2J"
           DISPLAY "--------------------"
           DISPLAY "1. Agregar Cliente"
           DISPLAY "2. Buscar Cliente"
           DISPLAY "3. Eliminar Cliente"
           DISPLAY "4. Actualizar empleado"
           DISPLAY "5. Salir"
           DISPLAY "--------------------"
           DISPLAY "Elija una opción: "
            ACCEPT opcion
           EVALUATE opcion
               WHEN 1
                  PERFORM INSERTAR-CLIENTE
               WHEN 2
                  PERFORM BUSCAR-CLIENTE
               WHEN 3
                  PERFORM ELIMINAR-CLIENTE
                WHEN 4
                  PERFORM ACTUALIZAR-CLIENTE
                WHEN 5
                  MOVE 'N' TO continuar
                WHEN OTHER
                  DISPLAY "Opción inválida."
           END-EVALUATE.



       INSERTAR-CLIENTE.
           DISPLAY ID-CLIENTE
           ACCEPT CLIENTE-ID

           DISPLAY NOMBRE
           ACCEPT CLIENTE-NOMBRE

           DISPLAY DIRECCION
           ACCEPT CLIENTE-DIRECCION

           DISPLAY TELEFONO
           ACCEPT CLIENTE-TELEFONO

           EXEC SQL
              INSERT INTO clientes (id_cliente,
                                    nombre_cliente,
                                    direccion_cliente,
                                    telefono_cliente)
              VALUES (:CLIENTE-ID,
                      :CLIENTE-NOMBRE,
                      :CLIENTE-DIRECCION,
                      :CLIENTE-TELEFONO)
           END-EXEC

           IF SQLCODE NOT = 0
              DISPLAY "Error al Insertar Cliente: " SQLCODE " - " SQLSTATE
           ELSE
             DISPLAY "Cliente insertado correctamente..."

             EXEC SQL
                COMMIT
             END-EXEC
           END-IF.


       BUSCAR-CLIENTE.
           DISPLAY ID-CLIENTE
           ACCEPT CLIENTE-ID

           EXEC SQL
              SELECT id_cliente,
                     nombre_cliente,
                     direccion_cliente,
                     telefono_cliente
              INTO :CLIENTE-ID,
                   :CLIENTE-NOMBRE,
                   :CLIENTE-DIRECCION,
                   :CLIENTE-TELEFONO
              FROM clientes
              WHERE id_cliente = :CLIENTE-ID
           END-EXEC

           IF SQLCODE = 100
              DISPLAY "No se encontró el cliente con el código: " CLIENTE-ID
           ELSE
             IF SQLCODE < 0
                DISPLAY "Error en SELECT: " SQLCODE " - " SQLSTATE
             ELSE
               DISPLAY "id DEL cLIENTE: " CLIENTE-ID
               DISPLAY "Nombre del Cliente: " CLIENTE-NOMBRE
               DISPLAY "Direccion del Cliente: " CLIENTE-DIRECCION
               DISPLAY "Telefono del Cliente: " CLIENTE-TELEFONO
               DISPLAY "Presione cualquier tecla para continuar.."
               ACCEPT SI-NO
             END-IF
           END-IF.

       ELIMINAR-CLIENTE.
           PERFORM BUSCAR-CLIENTE
           IF SQLCODE = 0
              EXEC SQL
                 DELETE FROM clientes
                 WHERE id_cliente = :CLIENTE-ID
              END-EXEC
           END-IF.

       ACTUALIZAR-CLIENTE.
           PERFORM BUSCAR-CLIENTE
           MOVE SPACES TO CLIENTES-REGISTRO-A
           IF SQLCODE = 0
              DISPLAY NOMBRE
              ACCEPT CLIENTE-NOMBRE-A

              DISPLAY DIRECCION
              ACCEPT CLIENTE-DIRECCION-A

              DISPLAY TELEFONO
              ACCEPT CLIENTE-TELEFONO-A
           END-IF

           IF CLIENTE-NOMBRE-A NOT = SPACES
              MOVE CLIENTE-NOMBRE-A TO CLIENTE-NOMBRE
           END-IF

           IF CLIENTE-DIRECCION-A NOT = SPACES
              MOVE CLIENTE-DIRECCION-A TO CLIENTE-DIRECCION
           END-IF

           IF CLIENTE-TELEFONO-A NOT = SPACES
              MOVE CLIENTE-TELEFONO-A TO CLIENTE-TELEFONO
           END-IF

           EXEC SQL
              UPDATE clientes
              SET    nombre_cliente    = :CLIENTE-NOMBRE,
                     direccion_cliente = :CLIENTE-DIRECCION,
                     telefono_cliente  = :CLIENTE-TELEFONO
              WHERE id_cliente = :CLIENTE-ID
           END-EXEC

           IF SQLCODE NOT = 0
              DISPLAY "Error al Actualizar Cliente: " SQLCODE " - " SQLSTATE
           ELSE
             DISPLAY "Cliente Actualizado correctamente..."

             EXEC SQL
                COMMIT
             END-EXEC
           END-IF





       DESCONECTAR-SQL.
           EXEC SQL
              COMMIT
           END-EXEC

           EXEC SQL
              DISCONNECT
           END-EXEC

           STOP RUN.





       END PROGRAM crear-clientes-sql.




      *Explicación del Código
      * Conexión: Se realiza una conexión a la base de datos y se revisa SQLCODE. Si es distinto de 0, se muestra un mensaje de error.
      * SELECT: Realiza una consulta SQL y guarda el resultado en NOMBRE-CLIENTE. Luego:
      * Si SQLCODE = 100, significa que no encontró el cliente.
      * Si SQLCODE es negativo, significa que ocurrió un error en la consulta, y se muestra el error.
      * Si SQLCODE es 0, la operación fue exitosa.