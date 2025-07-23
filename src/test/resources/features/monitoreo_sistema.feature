# language: es
Característica: Monitoreo y health checks del sistema
  Como equipo de operaciones
  Quiero monitorear el estado del sistema
  Para asegurar disponibilidad y rendimiento

  @regresion @monitoreo @health
  Escenario: Verificación de salud básica
    Cuando consulto el endpoint "/actuator/health"
    Entonces debería recibir un código de respuesta 200
    Y el estado general debería ser "UP"
    Y debería incluir información de:
      | componente    | estado |
      | baseDatos     | UP     |
      | discoLocal    | UP     |
      | memoria       | UP     |

  @monitoreo @health @base-datos
  Escenario: Health check de base de datos
    Dado que la base de datos está disponible
    Cuando consulto "/actuator/health/baseDatos"
    Entonces el estado debería ser "UP"
    Y debería mostrar el tiempo de respuesta
    Y debería incluir información de conexiones

  @monitoreo @metricas
  Escenario: Métricas de rendimiento del sistema
    Cuando consulto "/actuator/metrics"
    Entonces debería obtener métricas del sistema:
      | metrica                     | disponible |
      | jvm.memory.used            | Sí         |
      | http.server.requests       | Sí         |
      | system.cpu.usage           | Sí         |
      | database.connections.active | Sí         |

  @monitoreo @alertas
  Escenario: Alertas por bajo rendimiento
    Dado que el uso de CPU supera el 80%
    Cuando el sistema monitorea las métricas
    Entonces debería enviarse una alerta al equipo
    Y debería registrarse en los logs de sistema

  @monitoreo @logs
  Escenario: Verificación de logs de aplicación
    Dado que ocurre un error en el sistema
    Cuando reviso los logs de aplicación
    Entonces debería encontrar:
      | nivel | contenido                    |
      | ERROR | Stack trace completo         |
      | INFO  | Información del usuario      |
      | DEBUG | Detalles técnicos (modo dev) |
