# language: es
Característica: Generación de reportes del sistema
  Como usuario administrativo
  Quiero generar reportes del sistema
  Para analizar el uso y rendimiento

  Antecedentes:
    Dado que estoy autenticado con permisos de reportes
    Y que existen datos suficientes en el sistema

  @reportes @usuarios
  Escenario: Generar reporte de usuarios activos
    Cuando solicito un reporte de usuarios activos
    Entonces debería recibir un archivo PDF
    Y el reporte debería contener:
      | seccion           | contenido                    |
      | Total usuarios    | Número total de usuarios     |
      | Usuarios activos  | Usuarios con estado ACTIVO   |
      | Última conexión   | Fecha de última conexión     |
      | Distribución roles| Gráfico de roles asignados   |

  @reportes @productos @inventario
  Escenario: Reporte de inventario de productos
    Cuando genero un reporte de inventario
    Entonces debería incluir:
      | campo             | descripcion                |
      | Stock bajo        | Productos con stock < 10   |
      | Más vendidos      | Top 10 productos vendidos  |
      | Sin movimiento    | Productos sin ventas 30d   |
      | Valor inventario  | Valor total del inventario |

  @reportes @ventas
  Escenario: Reporte de ventas mensuales
    Dado que solicito el reporte de ventas del mes actual
    Cuando el reporte se genera exitosamente
    Entonces debería contener gráficos de:
      | tipo              | periodo    |
      | Ventas diarias    | Mes actual |
      | Productos top     | Mes actual |
      | Ingresos totales  | Mes actual |
      | Comparativa       | Mes anterior |
