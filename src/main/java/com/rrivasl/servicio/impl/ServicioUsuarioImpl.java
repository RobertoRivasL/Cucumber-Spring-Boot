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
