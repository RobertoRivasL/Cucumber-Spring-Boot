# language: es
Característica: Prueba básica del sistema
  Como desarrollador
  Quiero verificar que Cucumber funciona con Spring Boot
  Para asegurarme que las pruebas se ejecutan correctamente

  Escenario: Verificación básica del sistema
    Dado que el sistema está funcionando
    Cuando ejecuto una prueba básica
    Entonces debería obtener un resultado exitoso

  Escenario: Verificación de disponibilidad
    Dado que el sistema está disponible
    Cuando verifico el estado del sistema
    Entonces el sistema debería estar operativo
