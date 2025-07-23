# language: es
Característica: Gestión de usuarios del sistema
  Como administrador del sistema
  Quiero gestionar los usuarios de la aplicación
  Para mantener la seguridad y organización del sistema

  Antecedentes:
    Dado que el sistema está disponible
    Y que estoy autenticado como administrador
    Y que la base de datos contiene usuarios de prueba

  @regresion @usuarios
  Escenario: Crear un nuevo usuario exitosamente
    Dado que tengo los datos de un nuevo usuario:
      | nombre           | Roberto Pérez    |
      | apellido         | González         |
      | correoElectronico| rperez@test.com  |
      | nombreUsuario    | rperez           |
      | contrasena       | MiClave123!      |
      | rol              | USUARIO          |
    Cuando envío una solicitud para crear el usuario
    Entonces el usuario debería crearse exitosamente
    Y debería recibir un código de respuesta 201
    Y el usuario debería aparecer en la lista de usuarios

  @regresion @usuarios @validacion
  Escenario: Error al crear usuario con correo duplicado
    Dado que existe un usuario con correo "existente@test.com"
    Cuando intento crear un usuario con el mismo correo
    Entonces debería recibir un código de respuesta 409
    Y debería ver el mensaje "El correo electrónico ya está registrado"

  @regresion @usuarios @validacion
  Escenario: Validación de contraseña insegura
    Dado que tengo los datos de un usuario con contraseña "123"
    Cuando envío la solicitud de creación
    Entonces debería recibir un código de respuesta 400
    Y debería ver los siguientes errores de validación:
      | campo      | mensaje                                      |
      | contrasena | La contraseña debe tener al menos 8 caracteres |
      | contrasena | Debe contener al menos una letra mayúscula   |
      | contrasena | Debe contener al menos un carácter especial  |

  @usuarios @consulta
  Escenario: Buscar usuarios con filtros
    Dado que existen usuarios en el sistema
    Cuando busco usuarios con los siguientes filtros:
      | campo         | valor     |
      | nombre        | Roberto   |
      | rol           | ADMIN     |
      | estadoActivo  | true      |
    Entonces debería obtener solo los usuarios que coincidan
    Y la lista debería estar ordenada por apellido

  @usuarios @actualizacion
  Escenario: Actualizar información de usuario
    Dado que existe un usuario con ID 1
    Cuando actualizo sus datos con:
      | campo             | valor                |
      | correoElectronico | nuevo@test.com       |
      | telefono          | +56912345678         |
      | estado            | ACTIVO               |
    Entonces los datos deberían actualizarse correctamente
    Y debería recibir una confirmación de actualización

  @usuarios @eliminacion
  Escenario: Desactivar usuario existente
    Dado que existe un usuario activo con ID 5
    Cuando solicito desactivar el usuario
    Entonces el usuario debería cambiar a estado INACTIVO
    Y no debería poder autenticarse en el sistema
    Y sus sesiones activas deberían invalidarse
