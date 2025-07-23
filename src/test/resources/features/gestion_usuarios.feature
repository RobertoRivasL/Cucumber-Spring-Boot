# language: es
Característica: Gestión de usuarios del sistema
  Como administrador del sistema
  Quiero gestionar los usuarios de la aplicación
  Para mantener la seguridad y organización del sistema

  Antecedentes:
    Dado que el sistema está disponible
    Y que estoy autenticado como administrador

  @usuarios @creacion
  Escenario: Crear un nuevo usuario exitosamente
    Dado que tengo los datos de un nuevo usuario:
      | nombre           | Roberto Pérez    |
      | apellido         | González         |
      | correoElectronico| rperez@test.com  |
      | nombreUsuario    | rperez           |
      | contrasena       | MiClave123!      |
    Cuando envío una solicitud para crear el usuario
    Entonces el usuario debería crearse exitosamente
    Y debería recibir código de estado 201
    Y el usuario debería aparecer en la lista de usuarios

  @usuarios @validacion
  Escenario: Error al crear usuario con correo duplicado
    Dado que existe un usuario con correo "existente@test.com"
    Cuando intento crear un usuario con el mismo correo
    Entonces debería recibir código de estado 409
    Y debería ver mensaje "El correo electrónico ya está registrado"

  @usuarios @busqueda
  Escenario: Buscar usuario por nombre de usuario
    Dado que existe un usuario con nombre "rrivasl"
    Cuando busco el usuario por nombre "rrivasl"
    Entonces debería encontrar el usuario
    Y los datos del usuario deberían ser correctos
