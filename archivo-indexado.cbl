******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GestionEmpleados.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT empleados-archivo
            ASSIGN TO "C:\\Users\\anton\\CobolSql\\empleados.dat"
            ORGANIZATION IS INDEXED
            ACCESS MODE IS DYNAMIC
            RECORD KEY IS emp-id
            FILE STATUS IS fs-empleados.

           SELECT error-log
            ASSIGN TO "C:\\Users\\anton\\CobolSql\\error-log.txt"
            ORGANIZATION IS LINE SEQUENTIAL
            FILE STATUS IS file-status.

       DATA DIVISION.
       FILE SECTION.
       FD  empleados-archivo.
       01  empleado-registro.
           05 emp-id           PIC 9(4).        *> ID del empleado, clave primaria
           05 emp-nombre       PIC X(30).       *> Nombre del empleado
           05 emp-departamento PIC X(15).       *> Departamento
           05 emp-salario      PIC 9(7)V99.     *> Salario con 2 decimales

       FD  error-log.
       01  error-registro.
           05 fecha-error   PIC X(10).   *> Fecha del error
           05 hora-error    PIC X(8).    *> Hora del error
           05 mensaje-error PIC X(80).   *> Mensaje de error

       WORKING-STORAGE SECTION.

       01  fs-empleados        PIC XX.          *> Código de estado del archivo
       01  file-status         PIC XX.          *> Código de estado del archivo
       01  opcion              PIC 9.           *> Opción para el menú de usuario
       01  emp-id-busqueda     PIC 9(4).        *> ID para búsqueda de empleado
       01  continuar           PIC X VALUE 'S'. *> Controla si el usuario sigue o sale
       01  mensaje-error1      PIC X(60).       *> Mensaje de error en pantalla

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

           PERFORM ACEPTAR-FECHA-HORA.
           PERFORM ABRIR-ARCHIVO.
           PERFORM PROCESAR
              UNTIL continuar = "N".
           PERFORM CERRAR-ARCHIVO.


       PROCESAR.
           *> Limpiar la pantalla
           *> DISPLAY X"1B" "[2J"
           DISPLAY "--------------------"
           DISPLAY "1. Agregar empleado"
           DISPLAY "2. Buscar empleado"
           DISPLAY "3. Eliminar empleado"
           DISPLAY "4. Actualizar empleado"
           DISPLAY "5. Salir"
           DISPLAY "--------------------"
           DISPLAY "Elija una opción: "
            ACCEPT opcion
           EVALUATE opcion
               WHEN 1
                  PERFORM AGREGAR-EMPLEADO
               WHEN 2
                  PERFORM BUSCAR-EMPLEADO
               WHEN 3
                  PERFORM ELIMINAR-EMPLEADO
                WHEN 4
                  PERFORM ACTUALIZAR-EMPLEADO
                WHEN 5
                  MOVE 'N' TO continuar
                WHEN OTHER
                  DISPLAY "Opción inválida."
           END-EVALUATE.

       ACEPTAR-FECHA-HORA.
      *     CALL "CURRENT-DATE" GIVING fecha-error(1:10) hora-error(1:8)
            *> Obtener la fecha en formato YYYYMMDD
           ACCEPT fecha-error FROM DATE YYYYMMDD

           *> Obtener la hora en formato HHMMSS
           ACCEPT hora-error FROM TIME.

           *> Mostrar la fecha y hora actuales
           *>DISPLAY "Fecha actual: " fecha-error
           *>DISPLAY "Hora actual: " hora-error.

       ABRIR-ARCHIVO.
           OPEN EXTEND error-log
           IF file-status = "35" THEN
              MOVE "El archivo ERROR-LOG no existe, creando el archivo."
                 TO mensaje-error1
              PERFORM MOSTRAR-ERROR
              OPEN OUTPUT error-log
              CLOSE error-log
              OPEN EXTEND error-log
           END-IF

           OPEN I-O empleados-archivo
           IF fs-empleados = "35" THEN
              MOVE
              "El archivo EMPLEADOS no existe, creando nuevo archivo..."
                TO mensaje-error1
              PERFORM MOSTRAR-ERROR
              OPEN OUTPUT empleados-archivo
              CLOSE empleados-archivo
              OPEN I-O empleados-archivo
           ELSE
             IF fs-empleados NOT = "00" THEN
                MOVE "Error inesperado al abrir archivo empleados"
                   TO mensaje-error
                PERFORM ESCRIBIR-ERROR-LOG
             END-IF
           END-IF.

       AGREGAR-EMPLEADO.
           DISPLAY "Ingrese ID del empleado (4 dígitos):"
           ACCEPT emp-id
           DISPLAY "Ingrese nombre del empleado:"
           ACCEPT emp-nombre
           DISPLAY "Ingrese departamento del empleado:"
           ACCEPT emp-departamento
           DISPLAY "Ingrese salario del empleado:"
           ACCEPT emp-salario

           WRITE empleado-registro INVALID KEY
              DISPLAY "Error: Ya existe un empleado con ese ID."
              MOVE "Error: Ya existe un empleado con ese ID."
                 TO mensaje-error
              PERFORM ACEPTAR-FECHA-HORA
              PERFORM ESCRIBIR-ERROR-LOG
           NOT INVALID
               DISPLAY "Empleado creado con exito..."
           END-WRITE.

       BUSCAR-EMPLEADO.
           DISPLAY "Ingrese ID del empleado a buscar:"
           ACCEPT emp-id-busqueda
           MOVE emp-id-busqueda TO emp-id

           IF opcion = 2
              READ empleados-archivo KEY IS emp-id INVALID KEY
                MOVE "Error: Empleado a buscar, No existe."
                   TO mensaje-error
                PERFORM ACEPTAR-FECHA-HORA
                PERFORM ESCRIBIR-ERROR-LOG
                DISPLAY "Empleado no encontrado."
              NOT INVALID KEY
                  DISPLAY "ID: " emp-id
                  DISPLAY "Nombre: " emp-nombre
                  DISPLAY "Departamento: " emp-departamento
                  DISPLAY "Salario: " emp-salario
                  DISPLAY "Presiona Enter para Continuar.."
                  ACCEPT opcion
              END-READ
           END-IF.

       ELIMINAR-EMPLEADO.
           PERFORM BUSCAR-EMPLEADO
           DELETE empleados-archivo INVALID KEY
              MOVE "Error: Empleado no encontrado para eliminar."
                 TO mensaje-error
              PERFORM ACEPTAR-FECHA-HORA
              PERFORM ESCRIBIR-ERROR-LOG
              DISPLAY "Empleado no encontrado."
              DISPLAY "Presiona Enter para Continuar.."
              ACCEPT opcion
           NOT INVALID KEY
              DISPLAY "Empleado eliminado correctamente...", emp-id
           END-DELETE.

       ACTUALIZAR-EMPLEADO.
           PERFORM BUSCAR-EMPLEADO.
           READ empleados-archivo KEY IS emp-id
           INVALID KEY
              MOVE "Error: Empleado no encontrado para actualizar."
                 TO mensaje-error
              PERFORM ACEPTAR-FECHA-HORA
              PERFORM ESCRIBIR-ERROR-LOG
              DISPLAY "Empleado no encontrado."
           NOT INVALID KEY
              DISPLAY "Ingrese el nuevo nombre del empleado:"
              ACCEPT emp-nombre
              DISPLAY "Ingrese el nuevo departamento del empleado:"
              ACCEPT emp-departamento
              DISPLAY "Ingrese el nuevo salario del empleado:"
              ACCEPT emp-salario

              REWRITE empleado-registro
              DISPLAY "Empleado actualizado correctamente."
           END-READ.

       MOSTRAR-ERROR.
           DISPLAY mensaje-error1.

       ESCRIBIR-ERROR-LOG.
           WRITE error-registro *>FROM mensaje-error
            AFTER ADVANCING 1 LINE.



       CERRAR-ARCHIVO.
           CLOSE empleados-archivo.
           CLOSE error-log.
           STOP RUN.