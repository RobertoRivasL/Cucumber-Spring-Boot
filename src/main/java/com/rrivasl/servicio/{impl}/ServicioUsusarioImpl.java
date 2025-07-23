package com.rrivasl.servicio.impl;

import com.rrivasl.modelo.Usuario;
import com.rrivasl.servicio.ServicioUsuario;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Implementación del Servicio Usuario
 * Principios aplicados: Encapsulación, Separación de Responsabilidades
 * @author Roberto Rivas López
 */
@Service
public class ServicioUsuarioImpl implements ServicioUsuario {
    
    // Simulación de base de datos en memoria para pruebas
    private List<Usuario> usuarios = new ArrayList<>();
    private Long siguienteId = 1L;
    
    public ServicioUsuarioImpl() {
        inicializarUsuariosDePrueba();
    }
    
    @Override
    public Usuario crearUsuario(Usuario usuario) {
        // Validar correo duplicado
        if (existeCorreoElectronico(usuario.getCorreoElectronico())) {
            throw new RuntimeException("El correo electrónico ya está registrado");
        }
        
        // Validar contraseña
        validarContrasena(usuario.getContrasena());
        
        usuario.setId(siguienteId++);
        usuario.setEstado(Usuario.EstadoUsuario.ACTIVO);
        usuarios.add(usuario);
        return usuario;
    }
    
    @Override
    public boolean existeCorreoElectronico(String correo) {
        return usuarios.stream()
                .anyMatch(u -> u.getCorreoElectronico().equals(correo));
    }
    
    @Override
    public Optional<Usuario> buscarPorId(Long id) {
        return usuarios.stream()
                .filter(u -> u.getId().equals(id))
                .findFirst();
    }
    
    @Override
    public Optional<Usuario> buscarPorNombreUsuario(String nombreUsuario) {
        return usuarios.stream()
                .filter(u -> u.getNombreUsuario().equals(nombreUsuario))
                .findFirst();
    }
    
    @Override
    public List<Usuario> buscarConFiltros(String nombre, String rol, Boolean estadoActivo) {
        return usuarios.stream()
                .filter(u -> nombre == null || u.getNombre().contains(nombre))
                .filter(u -> estadoActivo == null || 
                    (estadoActivo && u.getEstado() == Usuario.EstadoUsuario.ACTIVO) ||
                    (!estadoActivo && u.getEstado() != Usuario.EstadoUsuario.ACTIVO))
                .sorted((u1, u2) -> u1.getApellido().compareTo(u2.getApellido()))
                .collect(Collectors.toList());
    }
    
    @Override
    public Usuario actualizarUsuario(Long id, Usuario usuarioActualizado) {
        Optional<Usuario> usuarioExistente = buscarPorId(id);
        if (usuarioExistente.isPresent()) {
            Usuario usuario = usuarioExistente.get();
            usuario.setCorreoElectronico(usuarioActualizado.getCorreoElectronico());
            usuario.setTelefono(usuarioActualizado.getTelefono());
            usuario.setEstado(usuarioActualizado.getEstado());
            return usuario;
        }
        throw new RuntimeException("Usuario no encontrado");
    }
    
    @Override
    public void desactivarUsuario(Long id) {
        Optional<Usuario> usuario = buscarPorId(id);
        if (usuario.isPresent()) {
            usuario.get().setEstado(Usuario.EstadoUsuario.INACTIVO);
        } else {
            throw new RuntimeException("Usuario no encontrado");
        }
    }
    
    @Override
    public List<Usuario> obtenerTodos() {
        return new ArrayList<>(usuarios);
    }
    
    @Override
    public boolean validarCredenciales(String nombreUsuario, String contrasena) {
        return buscarPorNombreUsuario(nombreUsuario)
                .map(u -> u.getContrasena().equals(contrasena) && 
                         u.getEstado() == Usuario.EstadoUsuario.ACTIVO)
                .orElse(false);
    }
    
    /**
     * Inicializa usuarios de prueba
     * Principio: Separación de Responsabilidades
     */
    private void inicializarUsuariosDePrueba() {
        // Usuario administrador
        Usuario admin = new Usuario();
        admin.setId(siguienteId++);
        admin.setNombreUsuario("rrivasl");
        admin.setNombre("Roberto");
        admin.setApellido("Rivas López");
        admin.setCorreoElectronico("rrivasl@test.com");
        admin.setContrasena("MiClave123!");
        admin.setEstado(Usuario.EstadoUsuario.ACTIVO);
        usuarios.add(admin);
        
        // Usuario existente para pruebas de duplicados
        Usuario existente = new Usuario();
        existente.setId(siguienteId++);
        existente.setNombreUsuario("existente");
        existente.setNombre("Usuario");
        existente.setApellido("Existente");
        existente.setCorreoElectronico("existente@test.com");
        existente.setContrasena("Password123!");
        existente.setEstado(Usuario.EstadoUsuario.ACTIVO);
        usuarios.add(existente);
    }
    
    /**
     * Valida la fortaleza de la contraseña
     * Principio: Encapsulación de lógica de negocio
     */
    private void validarContrasena(String contrasena) {
        List<String> errores = new ArrayList<>();
        
        if (contrasena == null || contrasena.length() < 8) {
            errores.add("La contraseña debe tener al menos 8 caracteres");
        }
        
        if (contrasena != null && !contrasena.matches(".*[A-Z].*")) {
            errores.add("Debe contener al menos una letra mayúscula");
        }
        
        if (contrasena != null && !contrasena.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            errores.add("Debe contener al menos un carácter especial");
        }
        
        if (!errores.isEmpty()) {
            throw new RuntimeException("Errores de validación: " + String.join(", ", errores));
        }
    }
}