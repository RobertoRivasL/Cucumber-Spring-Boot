# language: es
Característica: Gestión de productos del inventario
  Como usuario autorizado
  Quiero gestionar productos a través del sistema
  Para mantener actualizado el inventario

  Antecedentes:
    Dado que el sistema está disponible
    Y que estoy autenticado con permisos de gestión

  @productos @creacion
  Escenario: Registrar nuevo producto exitosamente
    Dado que tengo los datos de un producto:
      | nombre          | Laptop Dell Inspiron |
      | descripcion     | Laptop para oficina  |
      | precio          | 599990               |
      | categoria       | ELECTRONICA          |
      | stock           | 10                   |
      | codigoProducto  | DELL-INSP-001        |
    Cuando envío una petición para crear el producto
    Entonces el producto debería crearse exitosamente
    Y debería recibir código de estado 201
    Y el producto debería estar disponible en el inventario

  @productos @validacion
  Escenario: Error al registrar producto con código duplicado
    Dado que existe un producto con código "PROD-001"
    Cuando intento crear otro producto con el mismo código
    Entonces debería recibir código de estado 409
    Y debería ver mensaje "El código del producto ya existe"

  @productos @consulta
  Escenario: Buscar producto por código
    Dado que existe un producto con código "LAPTOP-001"
    Cuando busco el producto por código "LAPTOP-001"
    Entonces debería encontrar el producto
    Y los datos del producto deberían ser correctos
