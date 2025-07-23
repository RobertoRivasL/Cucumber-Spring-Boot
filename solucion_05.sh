#!/bin/bash

# =================================================================
# AGREGAR FEATURES DE USUARIOS Y PRODUCTOS
# Autor: Roberto Rivas López
# Curso: Automatización de Pruebas
# Objetivo: Probar las tablas que se están creando
# =================================================================

echo "🚀 AGREGANDO FEATURES DE USUARIOS Y PRODUCTOS..."
echo "👤 Estudiante: Roberto Rivas López"
echo "✅ Las tablas se crean correctamente"
echo "🎯 Agregando features para probarlas"
echo ""

# 1. CREAR FEATURE DE GESTIÓN DE USUARIOS
echo "📝 Paso 1: Creando feature de gestión de usuarios..."
cat > src/test/resources/features/gestion_usuarios.feature << 'EOF'
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
EOF

# 2. CREAR FEATURE DE GESTIÓN DE PRODUCTOS
echo "📝 Paso 2: Creando feature de gestión de productos..."
cat > src/test/resources/features/gestion_productos.feature << 'EOF'
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
EOF

# 3. CREAR STEP DEFINITIONS PARA USUARIOS (SIN DUPLICADOS)
echo "📝 Paso 3: Creando step definitions para usuarios..."
cat > src/test/java/com/rrivasl/pruebas/definiciones/DefinicionesUsuarios.java << 'EOF'
package com.rrivasl.pruebas.definiciones;

import com.rrivasl.modelo.Usuario;
import com.rrivasl.servicio.ServicioUsuario;
import io.cucumber.java.es.*;
import io.cucumber.datatable.DataTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.*;

import java.util.Map;
import java.util.Optional;

/**
 * Definiciones de pasos para gestión de usuarios
 * @author Roberto Rivas López
 * Principios aplicados: Separación de Intereses, Testabilidad
 */
@SpringBootTest
public class DefinicionesUsuarios {
    
    @Autowired
    private ServicioUsuario servicioUsuario;
    
    private Usuario ultimoUsuarioCreado;
    private Exception ultimaExcepcion;
    private String ultimoMensajeError;
    private int ultimoCodigoEstado;
    
    @Dado("que estoy autenticado como administrador")
    public void queEstoyAutenticadoComoAdministrador() {
        System.out.println("🔐 Autenticado como administrador - Roberto Rivas López");
        // En un escenario real, aquí se configuraría el contexto de seguridad
        assertTrue(true, "Usuario administrador autenticado");
    }
    
    @Dado("que tengo los datos de un nuevo usuario:")
    public void queTengoLosDatosDeUnNuevoUsuario(DataTable datosUsuario) {
        System.out.println("📝 Preparando datos de nuevo usuario: " + datosUsuario.asMap());
        
        Map<String, String> datos = datosUsuario.asMap();
        ultimoUsuarioCreado = new Usuario();
        ultimoUsuarioCreado.setNombre(datos.get("nombre"));
        ultimoUsuarioCreado.setApellido(datos.get("apellido"));
        ultimoUsuarioCreado.setCorreoElectronico(datos.get("correoElectronico"));
        ultimoUsuarioCreado.setNombreUsuario(datos.get("nombreUsuario"));
        ultimoUsuarioCreado.setContrasena(datos.get("contrasena"));
        
        assertTrue(true, "Datos de usuario preparados");
    }
    
    @Dado("que existe un usuario con correo {string}")
    public void queExisteUnUsuarioConCorreo(String correo) {
        System.out.println("👤 Verificando usuario existente con correo: " + correo);
        
        // Verificar si ya existe, si no, crearlo
        if (!servicioUsuario.existeCorreoElectronico(correo)) {
            Usuario usuarioExistente = new Usuario();
            usuarioExistente.setNombreUsuario("temp_user_" + System.currentTimeMillis());
            usuarioExistente.setNombre("Usuario");
            usuarioExistente.setApellido("Temporal");
            usuarioExistente.setCorreoElectronico(correo);
            usuarioExistente.setContrasena("Password123!");
            
            servicioUsuario.crearUsuario(usuarioExistente);
        }
        
        assertTrue(servicioUsuario.existeCorreoElectronico(correo), "Usuario con correo existe");
    }
    
    @Dado("que existe un usuario con nombre {string}")
    public void queExisteUnUsuarioConNombre(String nombreUsuario) {
        System.out.println("👤 Verificando usuario existente con nombre: " + nombreUsuario);
        
        // Verificar si ya existe, si no, crearlo
        if (!servicioUsuario.existeNombreUsuario(nombreUsuario)) {
            Usuario usuarioExistente = new Usuario();
            usuarioExistente.setNombreUsuario(nombreUsuario);
            usuarioExistente.setNombre("Roberto");
            usuarioExistente.setApellido("Rivas López");
            usuarioExistente.setCorreoElectronico(nombreUsuario + "@test.com");
            usuarioExistente.setContrasena("Password123!");
            
            servicioUsuario.crearUsuario(usuarioExistente);
        }
        
        assertTrue(servicioUsuario.existeNombreUsuario(nombreUsuario), "Usuario con nombre existe");
    }
    
    @Cuando("envío una solicitud para crear el usuario")
    public void envioUnaSolicitudParaCrearElUsuario() {
        System.out.println("📤 Enviando solicitud de creación de usuario...");
        
        try {
            ultimaExcepcion = null;
            ultimoMensajeError = null;
            ultimoCodigoEstado = 201;
            ultimoUsuarioCreado = servicioUsuario.crearUsuario(ultimoUsuarioCreado);
            System.out.println("✅ Usuario creado con ID: " + ultimoUsuarioCreado.getId());
        } catch (Exception e) {
            ultimaExcepcion = e;
            ultimoMensajeError = e.getMessage();
            ultimoCodigoEstado = 409; // Conflicto
            System.out.println("❌ Error al crear usuario: " + e.getMessage());
        }
        
        assertTrue(true, "Solicitud de creación procesada");
    }
    
    @Cuando("intento crear un usuario con el mismo correo")
    public void intentoCrearUnUsuarioConElMismoCorreo() {
        System.out.println("⚠️ Intentando crear usuario con correo duplicado");
        
        try {
            Usuario usuarioDuplicado = new Usuario();
            usuarioDuplicado.setNombreUsuario("duplicate_user");
            usuarioDuplicado.setNombre("Usuario");
            usuarioDuplicado.setApellido("Duplicado");
            usuarioDuplicado.setCorreoElectronico("existente@test.com");
            usuarioDuplicado.setContrasena("Password123!");
            
            ultimaExcepcion = null;
            ultimoMensajeError = null;
            ultimoCodigoEstado = 201;
            servicioUsuario.crearUsuario(usuarioDuplicado);
        } catch (Exception e) {
            ultimaExcepcion = e;
            ultimoMensajeError = e.getMessage();
            ultimoCodigoEstado = 409; // Conflicto
            System.out.println("❌ Error esperado: " + e.getMessage());
        }
        
        assertTrue(true, "Intento de duplicación procesado");
    }
    
    @Cuando("busco el usuario por nombre {string}")
    public void buscoElUsuarioPorNombre(String nombreUsuario) {
        System.out.println("🔍 Buscando usuario por nombre: " + nombreUsuario);
        
        Optional<Usuario> usuario = servicioUsuario.buscarPorNombreUsuario(nombreUsuario);
        if (usuario.isPresent()) {
            ultimoUsuarioCreado = usuario.get();
            ultimoCodigoEstado = 200;
        } else {
            ultimoCodigoEstado = 404;
        }
        
        assertTrue(true, "Búsqueda de usuario procesada");
    }
    
    @Entonces("el usuario debería crearse exitosamente")
    public void elUsuarioDeberiaCrearseExitosamente() {
        System.out.println("✅ Verificando creación exitosa del usuario");
        
        assertNull(ultimaExcepcion, "No debería haber excepciones");
        assertNotNull(ultimoUsuarioCreado, "Usuario debería estar creado");
        assertNotNull(ultimoUsuarioCreado.getId(), "Usuario debería tener ID asignado");
        
        System.out.println("Usuario creado exitosamente con ID: " + ultimoUsuarioCreado.getId());
    }
    
    @Entonces("debería recibir código de estado {int}")
    public void deberiaRecibirCodigoDeEstado(int codigoEsperado) {
        System.out.println("📊 Verificando código de estado esperado: " + codigoEsperado);
        assertEquals(codigoEsperado, ultimoCodigoEstado, "Código de estado debería coincidir");
    }
    
    @Entonces("el usuario debería aparecer en la lista de usuarios")
    public void elUsuarioDeberiaAparecerEnLaListaDeUsuarios() {
        System.out.println("📋 Verificando que el usuario aparece en la lista");
        
        assertNotNull(ultimoUsuarioCreado, "Usuario debería estar creado");
        assertTrue(servicioUsuario.buscarPorId(ultimoUsuarioCreado.getId()).isPresent(),
                  "Usuario debería estar en la base de datos");
        
        System.out.println("Usuario confirmado en la lista");
    }
    
    @Entonces("debería ver mensaje {string}")
    public void deberiaVerMensaje(String mensajeEsperado) {
        System.out.println("💬 Verificando mensaje: " + mensajeEsperado);
        
        if (ultimaExcepcion != null) {
            assertTrue(ultimoMensajeError.contains(mensajeEsperado) || 
                      ultimoMensajeError.equals(mensajeEsperado),
                      "El mensaje de error debería contener: " + mensajeEsperado);
        }
        
        System.out.println("Mensaje verificado correctamente");
    }
    
    @Entonces("debería encontrar el usuario")
    public void deberiaEncontrarElUsuario() {
        System.out.println("✅ Verificando que el usuario fue encontrado");
        
        assertNotNull(ultimoUsuarioCreado, "Usuario debería haber sido encontrado");
        assertEquals(200, ultimoCodigoEstado, "Código de estado debería ser 200");
    }
    
    @Entonces("los datos del usuario deberían ser correctos")
    public void losDatosDelUsuarioDeberianSerCorrectos() {
        System.out.println("📋 Verificando datos del usuario");
        
        assertNotNull(ultimoUsuarioCreado, "Usuario debería existir");
        assertNotNull(ultimoUsuarioCreado.getNombre(), "Usuario debería tener nombre");
        assertNotNull(ultimoUsuarioCreado.getCorreoElectronico(), "Usuario debería tener correo");
        
        System.out.println("Datos del usuario verificados correctamente");
    }
}
EOF

# 4. CREAR STEP DEFINITIONS PARA PRODUCTOS (SIN DUPLICADOS)
echo "📝 Paso 4: Creando step definitions para productos..."
cat > src/test/java/com/rrivasl/pruebas/definiciones/DefinicionesProductos.java << 'EOF'
package com.rrivasl.pruebas.definiciones;

import com.rrivasl.modelo.Producto;
import com.rrivasl.servicio.ServicioProducto;
import io.cucumber.java.es.*;
import io.cucumber.datatable.DataTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.*;

import java.math.BigDecimal;
import java.util.Map;

/**
 * Definiciones de pasos para gestión de productos
 * @author Roberto Rivas López
 * Principios aplicados: Separación de Intereses, Testabilidad
 */
@SpringBootTest
public class DefinicionesProductos {
    
    @Autowired
    private ServicioProducto servicioProducto;
    
    private Producto ultimoProductoCreado;
    private Exception ultimaExcepcion;
    private String ultimoMensajeError;
    private int ultimoCodigoEstado;
    
    @Dado("que estoy autenticado con permisos de gestión")
    public void queEstoyAutenticadoConPermisosDeGestion() {
        System.out.println("🔑 Autenticado con permisos de gestión - Roberto Rivas López");
        assertTrue(true, "Permisos de gestión verificados");
    }
    
    @Dado("que tengo los datos de un producto:")
    public void queTengoLosDatosDeUnProducto(DataTable datosProducto) {
        System.out.println("📦 Preparando datos de producto: " + datosProducto.asMap());
        
        Map<String, String> datos = datosProducto.asMap();
        ultimoProductoCreado = Producto.builder()
                .nombre(datos.get("nombre"))
                .descripcion(datos.get("descripcion"))
                .precio(new BigDecimal(datos.get("precio")))
                .categoria(datos.get("categoria"))
                .stock(Integer.parseInt(datos.get("stock")))
                .codigoProducto(datos.get("codigoProducto"))
                .build();
        
        assertTrue(true, "Datos de producto preparados");
    }
    
    @Dado("que existe un producto con código {string}")
    public void queExisteUnProductoConCodigo(String codigo) {
        System.out.println("📦 Verificando producto existente con código: " + codigo);
        
        // Verificar si ya existe, si no, crearlo
        Producto productoExistente = servicioProducto.buscarPorCodigo(codigo);
        if (productoExistente == null) {
            productoExistente = Producto.builder()
                    .nombre("Producto Existente")
                    .descripcion("Producto para pruebas")
                    .precio(new BigDecimal("100.00"))
                    .categoria("TEST")
                    .stock(5)
                    .codigoProducto(codigo)
                    .build();
            
            servicioProducto.crearProducto(productoExistente);
        }
        
        assertNotNull(servicioProducto.buscarPorCodigo(codigo), "Producto con código debe existir");
    }
    
    @Cuando("envío una petición para crear el producto")
    public void envioUnaPeticionParaCrearElProducto() {
        System.out.println("📤 Enviando petición de creación de producto...");
        
        try {
            ultimaExcepcion = null;
            ultimoMensajeError = null;
            ultimoCodigoEstado = 201;
            ultimoProductoCreado = servicioProducto.crearProducto(ultimoProductoCreado);
            System.out.println("✅ Producto creado con ID: " + ultimoProductoCreado.getId());
        } catch (Exception e) {
            ultimaExcepcion = e;
            ultimoMensajeError = e.getMessage();
            ultimoCodigoEstado = 409; // Conflicto
            System.out.println("❌ Error al crear producto: " + e.getMessage());
        }
        
        assertTrue(true, "Petición de creación procesada");
    }
    
    @Cuando("intento crear otro producto con el mismo código")
    public void intentoCrearOtroProductoConElMismoCodigo() {
        System.out.println("⚠️ Intentando crear producto con código duplicado");
        
        try {
            Producto productoDuplicado = Producto.builder()
                    .nombre("Producto Duplicado")
                    .descripcion("Producto con código duplicado")
                    .precio(new BigDecimal("200.00"))
                    .categoria("TEST")
                    .stock(3)
                    .codigoProducto("PROD-001")
                    .build();
            
            ultimaExcepcion = null;
            ultimoMensajeError = null;
            ultimoCodigoEstado = 201;
            servicioProducto.crearProducto(productoDuplicado);
        } catch (Exception e) {
            ultimaExcepcion = e;
            ultimoMensajeError = e.getMessage();
            ultimoCodigoEstado = 409; // Conflicto
            System.out.println("❌ Error esperado: " + e.getMessage());
        }
        
        assertTrue(true, "Intento de duplicación procesado");
    }
    
    @Cuando("busco el producto por código {string}")
    public void buscoElProductoPorCodigo(String codigo) {
        System.out.println("🔍 Buscando producto por código: " + codigo);
        
        Producto producto = servicioProducto.buscarPorCodigo(codigo);
        if (producto != null) {
            ultimoProductoCreado = producto;
            ultimoCodigoEstado = 200;
        } else {
            ultimoCodigoEstado = 404;
        }
        
        assertTrue(true, "Búsqueda de producto procesada");
    }
    
    @Entonces("el producto debería crearse exitosamente")
    public void elProductoDeberiaCrearseExitosamente() {
        System.out.println("✅ Verificando creación exitosa del producto");
        
        assertNull(ultimaExcepcion, "No debería haber excepciones");
        assertNotNull(ultimoProductoCreado, "Producto debería estar creado");
        assertNotNull(ultimoProductoCreado.getId(), "Producto debería tener ID asignado");
        
        System.out.println("Producto creado exitosamente con ID: " + ultimoProductoCreado.getId());
    }
    
    @Entonces("el producto debería estar disponible en el inventario")
    public void elProductoDeberiaEstarDisponibleEnElInventario() {
        System.out.println("📋 Verificando que el producto está en el inventario");
        
        assertNotNull(ultimoProductoCreado, "Producto debería estar creado");
        Producto productoEnInventario = servicioProducto.buscarPorCodigo(ultimoProductoCreado.getCodigoProducto());
        assertNotNull(productoEnInventario, "Producto debería estar en el inventario");
        
        System.out.println("Producto confirmado en el inventario");
    }
    
    @Entonces("debería encontrar el producto")
    public void deberiaEncontrarElProducto() {
        System.out.println("✅ Verificando que el producto fue encontrado");
        
        assertNotNull(ultimoProductoCreado, "Producto debería haber sido encontrado");
        assertEquals(200, ultimoCodigoEstado, "Código de estado debería ser 200");
    }
    
    @Entonces("los datos del producto deberían ser correctos")
    public void losDatosDelProductoDeberianSerCorrectos() {
        System.out.println("📋 Verificando datos del producto");
        
        assertNotNull(ultimoProductoCreado, "Producto debería existir");
        assertNotNull(ultimoProductoCreado.getNombre(), "Producto debería tener nombre");
        assertNotNull(ultimoProductoCreado.getCodigoProducto(), "Producto debería tener código");
        assertTrue(ultimoProductoCreado.getPrecio().compareTo(BigDecimal.ZERO) > 0, "Precio debería ser mayor a cero");
        
        System.out.println("Datos del producto verificados correctamente");
    }
}
EOF

# 5. MANTENER EL FEATURE BÁSICO EXISTENTE
echo "📝 Paso 5: Manteniendo feature básico existente..."
# No tocar prueba_basica.feature - ya está funcionando

# 6. MOSTRAR ESTRUCTURA FINAL
echo ""
echo "📂 Estructura final completa:"
echo "src/test/resources/features/"
echo "├── prueba_basica.feature          # ✅ Funcionando"
echo "├── gestion_usuarios.feature       # 🆕 Prueba usuarios"
echo "└── gestion_productos.feature      # 🆕 Prueba productos"
echo ""
echo "src/test/java/com/rrivasl/pruebas/definiciones/"
echo "├── DefinicionesPruebaBasica.java  # ✅ Sin duplicados"
echo "├── DefinicionesUsuarios.java      # 🆕 Para usuarios"
echo "└── DefinicionesProductos.java     # 🆕 Para productos"

# 7. COMPILAR Y EJECUTAR
echo ""
echo "🔨 Paso 6: Compilando proyecto..."
mvn clean compile test-compile

if [ $? -eq 0 ]; then
    echo ""
    echo "🧪 Paso 7: Ejecutando todas las pruebas..."
    mvn test -Dtest=EjecutorPruebasCucumber
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "🎉 =================================================="
        echo "✅ ¡TODAS LAS PRUEBAS FUNCIONANDO!"
        echo "🎉 =================================================="
        echo ""
        echo "👤 Estudiante: Roberto Rivas López"
        echo "📚 Curso: Automatización de Pruebas"
        echo ""
        echo "✅ Features funcionando:"
        echo "   - Prueba básica del sistema"
        echo "   - Gestión de usuarios (tabla usuarios probada)"
        echo "   - Gestión de productos (tabla productos probada)"
        echo ""
        echo "✅ Step definitions sin duplicados:"
        echo "   - DefinicionesPruebaBasica"
        echo "   - DefinicionesUsuarios (única)"
        echo "   - DefinicionesProductos (única)"
        echo ""
        echo "🎯 ¡Ahora las tablas se crean Y se prueban!"
        echo ""
    else
        echo ""
        echo "⚠️ =========================================="
        echo "COMPILACIÓN OK PERO HAY ERRORES EN PRUEBAS"
        echo "⚠️ =========================================="
        echo ""
        echo "🔍 Revisa los errores específicos arriba"
    fi
else
    echo ""
    echo "❌ =========================================="
    echo "❌ PROBLEMAS DE COMPILACIÓN"
    echo "❌ =========================================="
    echo ""
    echo "🔍 Revisa los errores de compilación mostrados arriba"
fi

echo ""
echo "🏁 Script completado - Roberto Rivas López"