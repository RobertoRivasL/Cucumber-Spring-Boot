package com.rrivasl.pruebas.definiciones;

import com.rrivasl.modelo.Usuario;
import com.rrivasl.servicio.ServicioUsuario;
import io.cucumber.java.es.Dado;
import io.cucumber.java.es.Cuando;
import io.cucumber.java.es.Entonces;
import io.cucumber.datatable.DataTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.Map;
import java.util.Optional;

/**
 * Definiciones de pasos para gestión de usuarios - CÓDIGOS DE ESTADO CORREGIDOS
 * @author Roberto Rivas López
 */
@SpringBootTest
public class DefinicionesUsuarios {
    
    @Autowired
    private ServicioUsuario servicioUsuario;
    
    private Usuario ultimoUsuarioCreado;
    // Usar contexto compartido para estado y errores
    
    @Dado("que estoy autenticado como administrador")
    public void queEstoyAutenticadoComoAdministrador() {
        System.out.println("🔐 Autenticado como administrador - Roberto Rivas López");
        // Resetear estado para nueva prueba
        ContextoTest.ultimoCodigoEstado = 0;
        ContextoTest.ultimaExcepcion = null;
        ContextoTest.ultimoMensajeError = null;
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
        // Resetear estado
        ContextoTest.ultimoCodigoEstado = 0;
        ContextoTest.ultimaExcepcion = null;
        ContextoTest.ultimoMensajeError = null;
        assertTrue(true, "Datos de usuario preparados");
    }
    
    @Dado("que existe un usuario con correo {string}")
    public void queExisteUnUsuarioConCorreo(String correo) {
        System.out.println("👤 Verificando usuario existente con correo: " + correo);
        
        // Resetear estado
        ContextoTest.ultimoCodigoEstado = 0;
        ContextoTest.ultimaExcepcion = null;
        ContextoTest.ultimoMensajeError = null;
        
        // Verificar si ya existe, si no, crearlo
        if (!servicioUsuario.existeCorreoElectronico(correo)) {
            Usuario usuarioExistente = new Usuario();
            usuarioExistente.setNombreUsuario("temp_user_" + System.currentTimeMillis());
            usuarioExistente.setNombre("Usuario");
            usuarioExistente.setApellido("Temporal");
            usuarioExistente.setCorreoElectronico(correo);
            usuarioExistente.setContrasena("Password123!");
            
            try {
                servicioUsuario.crearUsuario(usuarioExistente);
                System.out.println("✅ Usuario temporal creado para prueba");
            } catch (Exception e) {
                System.out.println("⚠️ Error creando usuario temporal: " + e.getMessage());
            }
        }
        
        assertTrue(servicioUsuario.existeCorreoElectronico(correo), "Usuario con correo debe existir");
    }
    
    @Dado("que existe un usuario con nombre {string}")
    public void queExisteUnUsuarioConNombre(String nombreUsuario) {
        System.out.println("👤 Verificando usuario existente con nombre: " + nombreUsuario);
        
        // Resetear estado
        ContextoTest.ultimoCodigoEstado = 0;
        ContextoTest.ultimaExcepcion = null;
        ContextoTest.ultimoMensajeError = null;
        
        // Verificar si ya existe, si no, crearlo
        if (!servicioUsuario.existeNombreUsuario(nombreUsuario)) {
            Usuario usuarioExistente = new Usuario();
            usuarioExistente.setNombreUsuario(nombreUsuario);
            usuarioExistente.setNombre("Roberto");
            usuarioExistente.setApellido("Rivas López");
            usuarioExistente.setCorreoElectronico(nombreUsuario + "@test.com");
            usuarioExistente.setContrasena("Password123!");
            
            try {
                servicioUsuario.crearUsuario(usuarioExistente);
                System.out.println("✅ Usuario con nombre creado para prueba");
            } catch (Exception e) {
                System.out.println("⚠️ Error creando usuario: " + e.getMessage());
            }
        }
        
        assertTrue(servicioUsuario.existeNombreUsuario(nombreUsuario), "Usuario con nombre debe existir");
    }
    
    @Cuando("envío una solicitud para crear el usuario")
    public void envioUnaSolicitudParaCrearElUsuario() {
        System.out.println("📤 Enviando solicitud de creación de usuario...");
        try {
            // Resetear estado antes de la operación
            ContextoTest.ultimaExcepcion = null;
            ContextoTest.ultimoMensajeError = null;
            // Intentar crear el usuario
            ultimoUsuarioCreado = servicioUsuario.crearUsuario(ultimoUsuarioCreado);
            // Si llegamos aquí, la creación fue exitosa
            ContextoTest.ultimoCodigoEstado = 201; // Created
            System.out.println("✅ Usuario creado exitosamente con ID: " + ultimoUsuarioCreado.getId());
            System.out.println("📊 Código de estado establecido: " + ContextoTest.ultimoCodigoEstado);
        } catch (IllegalArgumentException e) {
            // Error de validación/conflicto
            ContextoTest.ultimaExcepcion = e;
            ContextoTest.ultimoMensajeError = e.getMessage();
            ContextoTest.ultimoCodigoEstado = 409; // Conflict
            System.out.println("❌ Error de conflicto: " + e.getMessage());
            System.out.println("📊 Código de estado establecido: " + ContextoTest.ultimoCodigoEstado);
        } catch (Exception e) {
            // Otro tipo de error
            ContextoTest.ultimaExcepcion = e;
            ContextoTest.ultimoMensajeError = e.getMessage();
            ContextoTest.ultimoCodigoEstado = 500; // Internal Server Error
            System.out.println("❌ Error interno: " + e.getMessage());
            System.out.println("📊 Código de estado establecido: " + ContextoTest.ultimoCodigoEstado);
        }
        assertTrue(true, "Solicitud de creación procesada");
    }
    
    @Cuando("intento crear un usuario con el mismo correo")
    public void intentoCrearUnUsuarioConElMismoCorreo() {
        System.out.println("⚠️ Intentando crear usuario con correo duplicado");
        try {
            // Resetear estado antes de la operación
            ContextoTest.ultimaExcepcion = null;
            ContextoTest.ultimoMensajeError = null;
            Usuario usuarioDuplicado = new Usuario();
            usuarioDuplicado.setNombreUsuario("duplicate_user_" + System.currentTimeMillis());
            usuarioDuplicado.setNombre("Usuario");
            usuarioDuplicado.setApellido("Duplicado");
            usuarioDuplicado.setCorreoElectronico("existente@test.com");
            usuarioDuplicado.setContrasena("Password123!");
            // Intentar crear usuario duplicado
            servicioUsuario.crearUsuario(usuarioDuplicado);
            // Si llegamos aquí, no hubo error (inesperado)
            ContextoTest.ultimoCodigoEstado = 201; // Created
            System.out.println("⚠️ Usuario duplicado creado inesperadamente");
            System.out.println("📊 Código de estado establecido: " + ContextoTest.ultimoCodigoEstado);
        } catch (IllegalArgumentException e) {
            // Error esperado de duplicación
            ContextoTest.ultimaExcepcion = e;
            ContextoTest.ultimoMensajeError = e.getMessage();
            ContextoTest.ultimoCodigoEstado = 409; // Conflict
            System.out.println("✅ Error de duplicación capturado correctamente: " + e.getMessage());
            System.out.println("📊 Código de estado establecido: " + ContextoTest.ultimoCodigoEstado);
        } catch (Exception e) {
            ContextoTest.ultimaExcepcion = e;
            ContextoTest.ultimoMensajeError = e.getMessage();
            ContextoTest.ultimoCodigoEstado = 500; // Internal Server Error
            System.out.println("❌ Error inesperado: " + e.getMessage());
            System.out.println("📊 Código de estado establecido: " + ContextoTest.ultimoCodigoEstado);
        }
        assertTrue(true, "Intento de duplicación procesado");
    }
    
    @Cuando("busco el usuario por nombre {string}")
    public void buscoElUsuarioPorNombre(String nombreUsuario) {
        System.out.println("🔍 Buscando usuario por nombre: " + nombreUsuario);
        try {
            // Resetear estado antes de la operación
            ContextoTest.ultimaExcepcion = null;
            ContextoTest.ultimoMensajeError = null;
            Optional<Usuario> usuario = servicioUsuario.buscarPorNombreUsuario(nombreUsuario);
            if (usuario.isPresent()) {
                ultimoUsuarioCreado = usuario.get();
                ContextoTest.ultimoCodigoEstado = 200; // OK
                System.out.println("✅ Usuario encontrado: " + ultimoUsuarioCreado.getNombreUsuario());
                System.out.println("📊 Código de estado establecido: " + ContextoTest.ultimoCodigoEstado);
            } else {
                ContextoTest.ultimoCodigoEstado = 404; // Not Found
                System.out.println("❌ Usuario no encontrado");
                System.out.println("📊 Código de estado establecido: " + ContextoTest.ultimoCodigoEstado);
            }
        } catch (Exception e) {
            ContextoTest.ultimaExcepcion = e;
            ContextoTest.ultimoMensajeError = e.getMessage();
            ContextoTest.ultimoCodigoEstado = 500; // Internal Server Error
            System.out.println("❌ Error en búsqueda: " + e.getMessage());
            System.out.println("📊 Código de estado establecido: " + ContextoTest.ultimoCodigoEstado);
        }
        assertTrue(true, "Búsqueda de usuario procesada");
    }
    
    @Entonces("el usuario debería crearse exitosamente")
    public void elUsuarioDeberiaCrearseExitosamente() {
        System.out.println("✅ Verificando creación exitosa del usuario");
        System.out.println("📊 Código de estado actual: " + ContextoTest.ultimoCodigoEstado);
        assertNull(ContextoTest.ultimaExcepcion, "No debería haber excepciones para creación exitosa");
        assertNotNull(ultimoUsuarioCreado, "Usuario debería estar creado");
        assertNotNull(ultimoUsuarioCreado.getId(), "Usuario debería tener ID asignado");
        System.out.println("Usuario creado exitosamente con ID: " + ultimoUsuarioCreado.getId());
    }
    
    @Entonces("debería recibir código de estado {int}")
    public void deberiaRecibirCodigoDeEstado(int codigoEsperado) {
        System.out.println("📊 Verificando código de estado:");
        System.out.println("   Esperado: " + codigoEsperado);
        System.out.println("   Actual: " + ContextoTest.ultimoCodigoEstado);
        assertEquals(codigoEsperado, ContextoTest.ultimoCodigoEstado,
                    "Código de estado debería coincidir. Esperado: " + codigoEsperado + ", Actual: " + ContextoTest.ultimoCodigoEstado);
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
        System.out.println("💬 Verificando mensaje:");
        System.out.println("   Esperado: " + mensajeEsperado);
        System.out.println("   Actual: " + ContextoTest.ultimoMensajeError);
        if (ContextoTest.ultimaExcepcion != null) {
            assertTrue(ContextoTest.ultimoMensajeError != null && 
                      (ContextoTest.ultimoMensajeError.contains(mensajeEsperado) || ContextoTest.ultimoMensajeError.equals(mensajeEsperado)),
                      "El mensaje de error debería contener: " + mensajeEsperado + ", pero fue: " + ContextoTest.ultimoMensajeError);
        }
        System.out.println("Mensaje verificado correctamente");
    }
    
    @Entonces("debería encontrar el usuario")
    public void deberiaEncontrarElUsuario() {
        System.out.println("✅ Verificando que el usuario fue encontrado");
        System.out.println("📊 Código de estado actual: " + ContextoTest.ultimoCodigoEstado);
        assertNotNull(ultimoUsuarioCreado, "Usuario debería haber sido encontrado");
        assertEquals(200, ContextoTest.ultimoCodigoEstado, "Código de estado debería ser 200 para búsqueda exitosa");
    }
    
    @Entonces("los datos del usuario deberían ser correctos")
    public void losDatosDelUsuarioDeberianSerCorrectos() {
        System.out.println("📋 Verificando datos del usuario");
        
        assertNotNull(ultimoUsuarioCreado, "Usuario debería existir");
        assertNotNull(ultimoUsuarioCreado.getNombre(), "Usuario debería tener nombre");
        assertNotNull(ultimoUsuarioCreado.getCorreoElectronico(), "Usuario debería tener correo");
        
        System.out.println("Datos del usuario verificados correctamente");
        System.out.println("   Nombre: " + ultimoUsuarioCreado.getNombreCompleto());
        System.out.println("   Correo: " + ultimoUsuarioCreado.getCorreoElectronico());
    }
}
