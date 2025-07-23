# language: es
Característica: Autenticación y autorización de usuarios
  Como usuario del sistema
  Quiero autenticarme de forma segura
  Para acceder a las funcionalidades según mis permisos

  Antecedentes:
    Dado que el sistema de autenticación está operativo
    Y que existen usuarios válidos en la base de datos

  @regresion @autenticacion @login
  Escenario: Inicio de sesión exitoso
    Dado que estoy en la página de inicio de sesión
    Cuando ingreso las credenciales:
      | nombreUsuario | rrivasl      |
      | contrasena    | MiClave123!  |
    Y hago clic en "Iniciar Sesión"
    Entonces debería ser redirigido al panel principal
    Y debería ver el mensaje "Bienvenido, Roberto Rivas López"
    Y debería recibir un token JWT válido
    Y el token debería tener una duración de 60 minutos

  @regresion @autenticacion @seguridad
  Escenario: Fallo de autenticación con credenciales incorrectas
    Dado que estoy en la página de inicio de sesión
    Cuando ingreso credenciales incorrectas:
      | nombreUsuario | rrivasl          |
      | contrasena    | contraseñaMala   |
    Y hago clic en "Iniciar Sesión"
    Entonces debería permanecer en la página de inicio
    Y debería ver el mensaje "Credenciales inválidas"
    Y no debería recibir ningún token
    Y el intento fallido debería registrarse en los logs

  @autenticacion @seguridad @bloqueo
  Escenario: Bloqueo por intentos fallidos
    Dado que un usuario ha fallado el login 3 veces
    Cuando intenta autenticarse nuevamente
    Entonces debería recibir el mensaje "Cuenta bloqueada temporalmente"
    Y debería esperar 15 minutos para intentar nuevamente
    Y se debería enviar una notificación de seguridad

  @autenticacion @autorizacion
  Escenario: Acceso denegado a recurso protegido
    Dado que no estoy autenticado
    Cuando intento acceder a "/api/administracion/usuarios"
    Entonces debería recibir un código de respuesta 401
    Y el mensaje debería ser "Autenticación requerida"

  @autenticacion @autorizacion @permisos
  Escenario: Acceso denegado por permisos insuficientes
    Dado que estoy autenticado como usuario con rol "USUARIO"
    Cuando intento acceder a funciones administrativas
    Entonces debería recibir un código de respuesta 403
    Y el mensaje debería ser "Permisos insuficientes"

  @autenticacion @logout
  Escenario: Cierre de sesión exitoso
    Dado que estoy autenticado en el sistema
    Cuando hago clic en "Cerrar Sesión"
    Entonces mi sesión debería invalidarse
    Y debería ser redirigido a la página de inicio
    Y el token JWT debería agregarse a la lista negra
