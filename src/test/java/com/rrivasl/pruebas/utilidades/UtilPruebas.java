package com.rrivasl.pruebas.utilidades;

import org.springframework.stereotype.Component;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Random;
import java.util.regex.Pattern;

/**
 * Utilidades comunes para pruebas Cucumber
 * 
 * @author Roberto Rivas López
 * @version 1.0.0
 * 
 * Principios aplicados:
 * - DRY (Don't Repeat Yourself)
 * - Separación de Responsabilidades
 * - Reutilización de código
 * - Encapsulación de lógica común
 */
@Component
public class UtilPruebas {
    
    private final ObjectMapper mapeadorJson;
    private final Random generadorAleatorio;
    private final DateTimeFormatter formateadorFecha;
    
    // Patrones de validación
    private static final Pattern PATRON_EMAIL = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );
    
    private static final Pattern PATRON_JWT = Pattern.compile(
        "^[A-Za-z0-9-_]+\\.[A-Za-z0-9-_]+\\.[A-Za-z0-9-_]*$"
    );
    
    public UtilPruebas() {
        this.mapeadorJson = new ObjectMapper();
        this.mapeadorJson.registerModule(new JavaTimeModule());
        this.generadorAleatorio = new Random();
        this.formateadorFecha = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    }
    
    // ==================== GESTIÓN DE USUARIOS DE PRUEBA ====================
    
    /**
     * Crea usuarios de prueba predefinidos
     * Principio: Abstracción de preparación de datos
     */
    public Map<String, Object> crearUsuarioDePrueba(String tipo) {
        Map<String, Object> usuario = new HashMap<>();
        
        switch (tipo.toLowerCase()) {
            case "admin":
                usuario.put("nombreUsuario", "admin_test");
                usuario.put("nombre", "Administrador");
                usuario.put("apellido", "Test");
                usuario.put("correoElectronico", "admin@test.com");
                usuario.put("contrasena", "Admin123!");
                usuario.put("rol", "ADMIN");
                break;
                
            case "usuario":
                usuario.put("nombreUsuario", "usuario_test");
                usuario.put("nombre", "Usuario");
                usuario.put("apellido", "Prueba");
                usuario.put("correoElectronico", "usuario@test.com");
                usuario.put("contrasena", "Usuario123!");
                usuario.put("rol", "USUARIO");
                break;
                
            case "aleatorio":
                String sufijo = String.valueOf(generadorAleatorio.nextInt(1000));
                usuario.put("nombreUsuario", "user_" + sufijo);
                usuario.put("nombre", "Usuario" + sufijo);
                usuario.put("apellido", "Test" + sufijo);
                usuario.put("correoElectronico", "user" + sufijo + "@test.com");
                usuario.put("contrasena", "Password123!");
                usuario.put("rol", "USUARIO");
                break;
                
            default:
                throw new IllegalArgumentException("Tipo de usuario no válido: " + tipo);
        }
        
        usuario.put("fechaCreacion", LocalDateTime.now().format(formateadorFecha));
        usuario.put("estado", "ACTIVO");
        
        return usuario;
    }
    
    /**
     * Genera datos de usuario con campos específicos inválidos
     * Principio: Generación controlada de casos de prueba
     */
    public Map<String, Object> crearUsuarioInvalido(String tipoError) {
        Map<String, Object> usuario = crearUsuarioDePrueba("usuario");
        
        switch (tipoError.toLowerCase()) {
            case "correo_invalido":
                usuario.put("correoElectronico", "correo-invalido");
                break;
            case "contrasena_debil":
                usuario.put("contrasena", "123");
                break;
            case "nombre_vacio":
                usuario.put("nombre", "");
                break;
            case "correo_duplicado":
                usuario.put("correoElectronico", "existente@test.com");
                break;
            default:
                throw new IllegalArgumentException("Tipo de error no válido: " + tipoError);
        }
        
        return usuario;
    }
    
    // ==================== GESTIÓN DE PRODUCTOS DE PRUEBA ====================
    
    /**
     * Crea productos de prueba predefinidos
     * Principio: Factory Method para datos de prueba
     */
    public Map<String, Object> crearProductoDePrueba(String categoria) {
        Map<String, Object> producto = new HashMap<>();
        
        switch (categoria.toLowerCase()) {
            case "electronica":
                producto.put("nombre", "Laptop Dell Inspiron");
                producto.put("descripcion", "Laptop para uso profesional");
                producto.put("precio", 999990);
                producto.put("categoria", "ELECTRONICA");
                producto.put("stock", 15);
                producto.put("codigoProducto", "DELL-INSP-" + generarCodigoAleatorio());
                break;
                
            case "muebles":
                producto.put("nombre", "Silla Ergonómica");
                producto.put("descripcion", "Silla de oficina ergonómica");
                producto.put("precio", 199990);
                producto.put("categoria", "MUEBLES");
                producto.put("stock", 8);
                producto.put("codigoProducto", "SILLA-ERG-" + generarCodigoAleatorio());
                break;
                
            case "ropa":
                producto.put("nombre", "Camisa Formal");
                producto.put("descripcion", "Camisa formal para trabajo");
                producto.put("precio", 49990);
                producto.put("categoria", "ROPA");
                producto.put("stock", 25);
                producto.put("codigoProducto", "CAM-FORM-" + generarCodigoAleatorio());
                break;
                
            default:
                producto.put("nombre", "Producto Genérico");
                producto.put("descripcion", "Producto para pruebas");
                producto.put("precio", 10000);
                producto.put("categoria", "GENERAL");
                producto.put("stock", 10);
                producto.put("codigoProducto", "GEN-PROD-" + generarCodigoAleatorio());
                break;
        }
        
        producto.put("fechaCreacion", LocalDateTime.now().format(formateadorFecha));
        producto.put("activo", true);
        
        return producto;
    }
    
    // ==================== VALIDACIONES ====================
    
    /**
     * Valida si un token JWT tiene formato válido
     * Principio: Encapsulación de lógica de validación
     */
    public boolean esTokenJwtValido(String token) {
        if (token == null || token.trim().isEmpty()) {
            return false;
        }
        
        // Validar formato JWT básico (header.payload.signature)
        return PATRON_JWT.matcher(token).matches();
    }
    
    /**
     * Valida formato de correo electrónico
     * Principio: Reutilización de validaciones
     */
    public boolean esCorreoElectronicoValido(String correo) {
        if (correo == null || correo.trim().isEmpty()) {
            return false;
        }
        
        return PATRON_EMAIL.matcher(correo).matches();
    }
    
    /**
     * Valida fortaleza de contraseña
     * Principio: Separación de responsabilidades
     */
    public List<String> validarContrasena(String contrasena) {
        List<String> errores = new ArrayList<>();
        
        if (contrasena == null || contrasena.length() < 8) {
            errores.add("La contraseña debe tener al menos 8 caracteres");
        }
        
        if (contrasena != null && !contrasena.matches(".*[A-Z].*")) {
            errores.add("Debe contener al menos una letra mayúscula");
        }
        
        if (contrasena != null && !contrasena.matches(".*[a-z].*")) {
            errores.add("Debe contener al menos una letra minúscula");
        }
        
        if (contrasena != null && !contrasena.matches(".*\\d.*")) {
            errores.add("Debe contener al menos un número");
        }
        
        if (contrasena != null && !contrasena.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            errores.add("Debe contener al menos un carácter especial");
        }
        
        return errores;
    }
    
    // ==================== UTILIDADES JSON ====================
    
    /**
     * Extrae token JWT de la respuesta HTTP
     * Principio: Separación de responsabilidades
     */
    public String extraerTokenDeRespuesta(String cuerpoRespuesta) {
        try {
            @SuppressWarnings("unchecked")
            Map<String, Object> mapa = mapeadorJson.readValue(cuerpoRespuesta, Map.class);
            return (String) mapa.get("token");
        } catch (Exception e) {
            return null;
        }
    }
    
    /**
     * Convierte objeto a JSON string
     * Principio: Abstracción de conversión de datos
     */
    public String convertirAJson(Object objeto) {
        try {
            return mapeadorJson.writeValueAsString(objeto);
        } catch (Exception e) {
            throw new RuntimeException("Error al convertir objeto a JSON", e);
        }
    }
    
    /**
     * Convierte JSON string a Map
     * Principio: Encapsulación de deserialización
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> convertirJsonAMapa(String json) {
        try {
            return mapeadorJson.readValue(json, Map.class);
        } catch (Exception e) {
            throw new RuntimeException("Error al convertir JSON a Map", e);
        }
    }
    
    // ==================== UTILIDADES DE TIEMPO ====================
    
    /**
     * Genera timestamp actual formateado
     * Principio: Consistencia en formato de fechas
     */
    public String obtenerTimestampActual() {
        return LocalDateTime.now().format(formateadorFecha);
    }
    
    /**
     * Simula pausa en ejecución (para pruebas de timing)
     * Principio: Control de timing en pruebas
     */
    public void esperarSegundos(int segundos) {
        try {
            Thread.sleep(segundos * 1000L);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new RuntimeException("Interrupción en espera", e);
        }
    }
    
    // ==================== UTILIDADES DE DATOS ALEATORIOS ====================
    
    /**
     * Genera código alfanumérico aleatorio
     * Principio: Generación de datos únicos para pruebas
     */
    public String generarCodigoAleatorio() {
        return String.format("%03d", generadorAleatorio.nextInt(1000));
    }
    
    /**
     * Genera número aleatorio en rango
     * Principio: Utilidad de generación controlada
     */
    public int generarNumeroAleatorio(int min, int max) {
        return generadorAleatorio.nextInt(max - min + 1) + min;
    }
    
    /**
     * Genera string aleatorio para pruebas
     * Principio: Generación de datos únicos
     */
    public String generarStringAleatorio(int longitud) {
        String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder resultado = new StringBuilder();
        
        for (int i = 0; i < longitud; i++) {
            resultado.append(caracteres.charAt(generadorAleatorio.nextInt(caracteres.length())));
        }
        
        return resultado.toString();
    }
    
    // ==================== UTILIDADES DE RESPUESTA HTTP ====================
    
    /**
     * Simula respuesta HTTP exitosa
     * Principio: Abstracción de respuestas de prueba
     */
    public Map<String, Object> crearRespuestaExitosa(Object datos) {
        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("status", "success");
        respuesta.put("codigo", 200);
        respuesta.put("mensaje", "Operación exitosa");
        respuesta.put("datos", datos);
        respuesta.put("timestamp", obtenerTimestampActual());
        return respuesta;
    }
    
    /**
     * Simula respuesta HTTP de error
     * Principio: Consistencia en manejo de errores
     */
    public Map<String, Object> crearRespuestaError(int codigo, String mensaje) {
        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("status", "error");
        respuesta.put("codigo", codigo);
        respuesta.put("mensaje", mensaje);
        respuesta.put("timestamp", obtenerTimestampActual());
        return respuesta;
    }
    
    // ==================== UTILIDADES DE LOG ====================
    
    /**
     * Formatea mensaje de log para pruebas
     * Principio: Consistencia en logging de pruebas
     */
    public String formatearMensajeLog(String nivel, String mensaje) {
        return String.format("[%s] %s - %s - Roberto Rivas López", 
                           obtenerTimestampActual(), nivel, mensaje);
    }
    
    /**
     * Log específico para inicio de escenario
     * Principio: Trazabilidad en pruebas
     */
    public void logInicioEscenario(String nombreEscenario) {
        System.out.println(formatearMensajeLog("SCENARIO", 
                          "🎬 Iniciando: " + nombreEscenario));
    }
    
    /**
     * Log específico para fin de escenario
     * Principio: Trazabilidad en pruebas
     */
    public void logFinEscenario(String nombreEscenario, boolean exitoso) {
        String estado = exitoso ? "✅ EXITOSO" : "❌ FALLIDO";
        System.out.println(formatearMensajeLog("SCENARIO", 
                          estado + ": " + nombreEscenario));
    }
}