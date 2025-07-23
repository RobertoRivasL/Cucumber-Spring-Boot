#!/bin/bash

# =================================================================
# SCRIPT DE SOLUCIÓN - ERROR DE COMPILACIÓN
# Autor: Roberto Rivas López
# Curso: Automatización de Pruebas
# =================================================================

echo "🔧 SOLUCIONANDO ERROR DE COMPILACIÓN..."
echo "👤 Proyecto de: Roberto Rivas López"
echo ""

# 1. LIMPIAR PROYECTO COMPLETAMENTE
echo "🧹 Paso 1: Limpieza completa del proyecto..."
mvn clean
rm -rf target/

# 2. VERIFICAR Y CORREGIR ESTRUCTURA DE DIRECTORIOS
echo "📁 Paso 2: Verificando estructura de directorios..."

# Crear directorios correctos si no existen
mkdir -p src/main/java/com/rrivasl/servicio/impl/
mkdir -p src/main/java/com/rrivasl/repositorio/
mkdir -p src/main/java/com/rrivasl/controlador/
mkdir -p src/main/java/com/rrivasl/modelo/
mkdir -p src/main/java/com/rrivasl/configuracion/

# 3. BUSCAR Y ELIMINAR ARCHIVOS PROBLEMÁTICOS
echo "🔍 Paso 3: Buscando archivos con nombres incorrectos..."

# Buscar archivos con nombres incorrectos
find . -name "*UsusarioImpl*" -type f
find . -name "*Ususuario*" -type f

# Eliminar archivos con nombres incorrectos si existen
find . -name "*UsusarioImpl*" -type f -delete
find . -name "*Ususuario*" -type f -delete

echo "✅ Archivos problemáticos eliminados"

# 4. RECREAR ARCHIVOS CORRECTOS
echo "📝 Paso 4: Recreando archivos con nombres correctos..."

# Crear ServicioUsuario.java (interfaz)
cat > src/main/java/com/rrivasl/servicio/ServicioUsuario.java << 'EOF'
package com.rrivasl.servicio;

import com.rrivasl.modelo.Usuario;
import java.util.List;
import java.util.Optional;

/**
 * Interfaz del Servicio de Usuarios
 * @author Roberto Rivas López
 * Principios aplicados: Abstracción, Separación de Intereses
 */
public interface ServicioUsuario {
    
    /**
     * Crear un nuevo usuario en el sistema
     * @param usuario datos del usuario a crear
     * @return usuario creado con ID asignado
     */
    Usuario crearUsuario(Usuario usuario);
    
    /**
     * Buscar usuario por su ID
     * @param id identificador del usuario
     * @return usuario encontrado o Optional.empty()
     */
    Optional<Usuario> buscarPorId(Long id);
    
    /**
     * Buscar usuario por nombre de usuario
     * @param nombreUsuario nombre único del usuario
     * @return usuario encontrado o Optional.empty()
     */
    Optional<Usuario> buscarPorNombreUsuario(String nombreUsuario);
    
    /**
     * Buscar usuario por correo electrónico
     * @param correoElectronico email del usuario
     * @return usuario encontrado o Optional.empty()
     */
    Optional<Usuario> buscarPorCorreoElectronico(String correoElectronico);
    
    /**
     * Obtener todos los usuarios del sistema
     * @return lista de todos los usuarios
     */
    List<Usuario> obtenerTodosLosUsuarios();
    
    /**
     * Actualizar datos de un usuario existente
     * @param id identificador del usuario
     * @param usuario nuevos datos del usuario
     * @return usuario actualizado
     */
    Usuario actualizarUsuario(Long id, Usuario usuario);
    
    /**
     * Desactivar un usuario (cambiar estado a INACTIVO)
     * @param id identificador del usuario
     */
    void desactivarUsuario(Long id);
    
    /**
     * Validar si un correo electrónico ya existe
     * @param correoElectronico email a validar
     * @return true si existe, false si no existe
     */
    boolean existeCorreoElectronico(String correoElectronico);
    
    /**
     * Validar si un nombre de usuario ya existe
     * @param nombreUsuario nombre a validar
     * @return true si existe, false si no existe
     */
    boolean existeNombreUsuario(String nombreUsuario);
}
EOF

# Crear ServicioUsuarioImpl.java (implementación)
cat > src/main/java/com/rrivasl/servicio/impl/ServicioUsuarioImpl.java << 'EOF'
package com.rrivasl.servicio.impl;

import com.rrivasl.servicio.ServicioUsuario;
import com.rrivasl.modelo.Usuario;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Implementación del Servicio de Usuarios
 * @author Roberto Rivas López
 * Principios aplicados: Encapsulación, Modularidad, Inyección de Dependencias
 */
@Service
public class ServicioUsuarioImpl implements ServicioUsuario {
    
    private static final Logger logger = LoggerFactory.getLogger(ServicioUsuarioImpl.class);
    
    // Simulación de base de datos en memoria para pruebas
    private final List<Usuario> usuarios = new ArrayList<>();
    private Long siguienteId = 1L;
    
    @Override
    public Usuario crearUsuario(Usuario usuario) {
        logger.info("Creando nuevo usuario: {}", usuario.getNombreUsuario());
        
        // Validaciones
        if (existeCorreoElectronico(usuario.getCorreoElectronico())) {
            throw new IllegalArgumentException("El correo electrónico ya está registrado");
        }
        
        if (existeNombreUsuario(usuario.getNombreUsuario())) {
            throw new IllegalArgumentException("El nombre de usuario ya existe");
        }
        
        // Asignar ID y agregar a la "base de datos"
        usuario.setId(siguienteId++);
        usuarios.add(usuario);
        
        logger.info("Usuario creado exitosamente con ID: {}", usuario.getId());
        return usuario;
    }
    
    @Override
    public Optional<Usuario> buscarPorId(Long id) {
        return usuarios.stream()
                .filter(usuario -> usuario.getId().equals(id))
                .findFirst();
    }
    
    @Override
    public Optional<Usuario> buscarPorNombreUsuario(String nombreUsuario) {
        return usuarios.stream()
                .filter(usuario -> usuario.getNombreUsuario().equals(nombreUsuario))
                .findFirst();
    }
    
    @Override
    public Optional<Usuario> buscarPorCorreoElectronico(String correoElectronico) {
        return usuarios.stream()
                .filter(usuario -> usuario.getCorreoElectronico().equals(correoElectronico))
                .findFirst();
    }
    
    @Override
    public List<Usuario> obtenerTodosLosUsuarios() {
        return new ArrayList<>(usuarios);
    }
    
    @Override
    public Usuario actualizarUsuario(Long id, Usuario usuarioActualizado) {
        Optional<Usuario> usuarioExistente = buscarPorId(id);
        
        if (usuarioExistente.isPresent()) {
            Usuario usuario = usuarioExistente.get();
            
            // Actualizar campos
            usuario.setNombre(usuarioActualizado.getNombre());
            usuario.setApellido(usuarioActualizado.getApellido());
            usuario.setTelefono(usuarioActualizado.getTelefono());
            usuario.setEstado(usuarioActualizado.getEstado());
            
            // Validar cambio de correo si es diferente
            if (!usuario.getCorreoElectronico().equals(usuarioActualizado.getCorreoElectronico())) {
                if (existeCorreoElectronico(usuarioActualizado.getCorreoElectronico())) {
                    throw new IllegalArgumentException("El correo electrónico ya está registrado");
                }
                usuario.setCorreoElectronico(usuarioActualizado.getCorreoElectronico());
            }
            
            logger.info("Usuario actualizado: {}", usuario.getId());
            return usuario;
        }
        
        throw new IllegalArgumentException("Usuario no encontrado con ID: " + id);
    }
    
    @Override
    public void desactivarUsuario(Long id) {
        Optional<Usuario> usuario = buscarPorId(id);
        
        if (usuario.isPresent()) {
            usuario.get().setEstado(Usuario.EstadoUsuario.INACTIVO);
            logger.info("Usuario desactivado: {}", id);
        } else {
            throw new IllegalArgumentException("Usuario no encontrado con ID: " + id);
        }
    }
    
    @Override
    public boolean existeCorreoElectronico(String correoElectronico) {
        return usuarios.stream()
                .anyMatch(usuario -> usuario.getCorreoElectronico().equals(correoElectronico));
    }
    
    @Override
    public boolean existeNombreUsuario(String nombreUsuario) {
        return usuarios.stream()
                .anyMatch(usuario -> usuario.getNombreUsuario().equals(nombreUsuario));
    }
    
    /**
     * Método auxiliar para crear usuarios de prueba
     * Principio: Separación de Intereses
     */
    public void crearUsuariosDePrueba() {
        if (usuarios.isEmpty()) {
            Usuario usuarioPrueba = new Usuario();
            usuarioPrueba.setNombreUsuario("rrivasl");
            usuarioPrueba.setNombre("Roberto");
            usuarioPrueba.setApellido("Rivas López");
            usuarioPrueba.setCorreoElectronico("rrivasl@test.com");
            usuarioPrueba.setContrasena("MiClave123!");
            usuarioPrueba.setEstado(Usuario.EstadoUsuario.ACTIVO);
            
            crearUsuario(usuarioPrueba);
            
            logger.info("Usuarios de prueba creados para desarrollo");
        }
    }
}
EOF

echo "✅ Archivos recreados correctamente"

# 5. VERIFICAR SINTAXIS DE OTROS ARCHIVOS IMPORTANTES
echo "🔍 Paso 5: Verificando otros archivos importantes..."

# Verificar que AplicacionPrincipal.java existe y es correcto
if [ ! -f "src/main/java/com/rrivasl/AplicacionPrincipal.java" ]; then
    echo "⚠️  Creando AplicacionPrincipal.java..."
    cat > src/main/java/com/rrivasl/AplicacionPrincipal.java << 'EOF'
package com.rrivasl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Clase principal de la aplicación Spring Boot
 * @author Roberto Rivas López
 */
@SpringBootApplication
public class AplicacionPrincipal {
    public static void main(String[] args) {
        SpringApplication.run(AplicacionPrincipal.class, args);
    }
}
EOF
fi

# 6. COMPILAR PARA VERIFICAR
echo "🔨 Paso 6: Compilando proyecto para verificar corrección..."
mvn compile

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 =============================================="
    echo "✅ ¡ERROR DE COMPILACIÓN SOLUCIONADO!"
    echo "🎉 =============================================="
    echo ""
    echo "👤 Proyecto de: Roberto Rivas López"
    echo "📚 Curso: Automatización de Pruebas"
    echo "✅ Estructura de directorios corregida"
    echo "✅ Archivos con nombres correctos"
    echo "✅ Compilación exitosa"
    echo ""
    echo "📝 Archivos principales verificados:"
    echo "   - ServicioUsuario.java (interfaz)"
    echo "   - ServicioUsuarioImpl.java (implementación)"
    echo "   - AplicacionPrincipal.java (clase main)"
    echo ""
    echo "🚀 Puedes continuar con el desarrollo del proyecto"
    echo ""
else
    echo ""
    echo "❌ =========================================="
    echo "❌ AÚN HAY PROBLEMAS DE COMPILACIÓN"
    echo "❌ =========================================="
    echo ""
    echo "🔍 Revisa los errores mostrados arriba"
    echo "📧 Comparte el nuevo mensaje de error para más ayuda"
    echo ""
fi

# 7. MOSTRAR ESTRUCTURA FINAL
echo "📁 Estructura final del proyecto:"
tree src/ -I target 2>/dev/null || find src/ -type f -name "*.java" | sort

echo ""
echo "🏁 Script completado - Roberto Rivas López"