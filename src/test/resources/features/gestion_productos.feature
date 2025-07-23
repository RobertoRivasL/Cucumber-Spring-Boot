# language: es
Característica: Gestión de productos del inventario
  Como usuario autorizado
  Quiero gestionar productos a través de la API
  Para mantener actualizado el inventario

  Antecedentes:
    Dado que estoy autenticado con permisos de gestión
    Y que la API está disponible en "/api/productos"

  @regresion @productos @creacion
  Escenario: Registrar nuevo producto exitosamente
    Dado que tengo los datos de un producto:
      | campo           | valor                    |
      | nombre          | Laptop Dell Inspiron    |
      | descripcion     | Laptop para oficina     |
      | precio          | 599990                   |
      | categoria       | ELECTRONICA             |
      | stock           | 10                      |
      | codigoProducto  | DELL-INSP-001           |
    Cuando envío una petición POST a "/api/productos"
    Entonces debería recibir un código de respuesta 201
    Y la respuesta debería contener el ID del producto
    Y el producto debería estar disponible en el inventario

  @productos @validacion @duplicados
  Escenario: Error al registrar producto con código duplicado
    Dado que existe un producto con código "PROD-001"
    Cuando intento crear otro producto con el mismo código
    Entonces debería recibir un código de respuesta 409
    Y el mensaje debería ser "El código del producto ya existe"

  @productos @validacion @datos
  Escenario: Validación de datos de producto
    Dado que envío datos incompletos del producto:
      | campo  | valor | error                              |
      | nombre |       | El nombre es obligatorio           |
      | precio | -100  | El precio debe ser mayor a cero    |
      | stock  | -5    | El stock no puede ser negativo     |
    Cuando envío la petición de creación
    Entonces debería recibir un código de respuesta 400
    Y debería ver todos los errores de validación

  @productos @consulta @paginacion
  Escenario: Obtener lista de productos con paginación
    Dado que existen 50 productos en el sistema
    Cuando solicito la página 2 con 10 productos por página
    Entonces debería recibir 10 productos
    Y la información de paginación debería ser:
      | totalElementos  | 50 |
      | totalPaginas    | 5  |
      | paginaActual    | 2  |
      | elementos       | 10 |

  @productos @consulta @filtros
  Escenario: Filtrar productos por categoría
    Dado que existen productos de diferentes categorías
    Cuando filtro por categoría "ELECTRONICA"
    Entonces solo debería ver productos de esa categoría
    Y los resultados deberían estar ordenados por nombre

  @productos @actualizacion @stock
  Escenario: Actualizar stock de producto
    Dado que existe un producto con ID 1 y stock 10
    Cuando actualizo el stock a 25
    Entonces el stock debería reflejarse correctamente
    Y debería recibir una confirmación de actualización
    Y el historial de movimientos debería registrar el cambio

  @productos @eliminacion
  Escenario: Eliminar producto del inventario
    Dado que existe un producto con ID 5
    Y que no tiene ventas asociadas
    Cuando envío una petición DELETE
    Entonces el producto debería marcarse como inactivo
    Y no debería aparecer en las búsquedas activas
    Y debería mantenerse en el historial
