# language: es
Característica: Protección de seguridad del sistema
  Como sistema seguro
  Quiero protegerme contra vulnerabilidades
  Para mantener la integridad de los datos

  @regresion @seguridad @sql-injection
  Escenario: Protección contra inyección SQL
    Dado que estoy en el endpoint de búsqueda
    Cuando envío un parámetro malicioso "'; DROP TABLE usuarios; --"
    Entonces debería recibir un código de respuesta 400
    Y las tablas de la base de datos deberían estar intactas
    Y el intento de ataque debería registrarse en los logs de seguridad

  @seguridad @xss
  Escenario: Protección contra XSS
    Dado que estoy creando un comentario
    Cuando envío contenido con script malicioso "<script>alert('XSS')</script>"
    Entonces el contenido debería ser sanitizado automáticamente
    Y debería guardarse como "&lt;script&gt;alert('XSS')&lt;/script&gt;"
    Y no debería ejecutarse código JavaScript

  @seguridad @rate-limiting
  Escenario: Limitación de velocidad para prevenir ataques
    Dado que tengo una dirección IP específica
    Cuando envío más de 10 peticiones por minuto
    Entonces debería recibir un código de respuesta 429
    Y el mensaje debería ser "Demasiadas peticiones"
    Y mi IP debería bloquearse por 10 minutos

  @seguridad @headers
  Escenario: Validación de headers de seguridad
    Cuando realizo cualquier petición HTTP
    Entonces la respuesta debería incluir headers de seguridad:
      | header                      | valor                 |
      | X-Content-Type-Options      | nosniff              |
      | X-Frame-Options             | DENY                 |
      | X-XSS-Protection            | 1; mode=block        |
      | Strict-Transport-Security   | max-age=31536000     |
      | Content-Security-Policy     | default-src 'self'   |

  @seguridad @csrf
  Escenario: Protección CSRF con tokens
    Dado que estoy en una sesión web autenticada
    Cuando intento realizar una acción sin token CSRF
    Entonces debería recibir un código de respuesta 403
    Y el mensaje debería ser "Token CSRF requerido"

  @seguridad @encriptacion
  Escenario: Encriptación de datos sensibles
    Dado que registro información personal de un usuario
    Cuando los datos se almacenan en la base de datos
    Entonces los campos sensibles deberían estar encriptados:
      | campo              | encriptado |
      | numeroTarjeta      | Sí         |
      | numeroDocumento    | Sí         |
      | contrasena         | Sí (hash)  |
      | correoElectronico  | No         |
