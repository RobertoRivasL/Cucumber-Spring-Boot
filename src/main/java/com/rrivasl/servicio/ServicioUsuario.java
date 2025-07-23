package com.rrivasl.servicio;

import com.rrivasl.modelo.Usuario;
import java.util.List;
import java.util.Optional;

/**
 * Interfaz Servicio Usuario
 * Principio aplicado: Abstracción, Inversión de Dependencias
 * @author Roberto Rivas López
 */
public interface ServicioUsuario {
    
    /**
     * Crea un nuevo usuario en el sistema
     * @param usuario Usuario a crear
     * @return Usuario creado con ID asignado
     * @throws RuntimeException si el correo ya existe o la contraseña es inválida
     */
    Usuario crearUsuario(Usuario usuario);
    
    /**
     * Verifica si un correo electrónico ya está registrado
     * @param correo Correo a verificar
     * @return true si el correo existe, false en caso contrario
     */
    boolean existeCorreoElectronico(String correo);
    
    /**
     * Busca un usuario por su ID
     * @param id ID del usuario
     * @return Optional con el usuario si existe
     */
    Optional<Usuario> buscarPorId(Long id);
    
    /**
     * Busca un usuario por su nombre de usuario
     * @param nombreUsuario Nombre de usuario
     * @return Optional con el usuario si existe
     */
    Optional<Usuario> buscarPorNombreUsuario(String nombreUsuario);
    
    /**
     * Busca usuarios aplicando filtros
     * @param nombre Filtro por nombre (parcial)
     * @param rol Filtro por rol
     * @param estadoActivo Filtro por estado activo
     * @return Lista de usuarios que coinciden con los filtros
     */
    List<Usuario> buscarConFiltros(String nombre, String rol, Boolean estadoActivo);
    
    /**
     * Actualiza los datos de un usuario existente
     * @param id ID del usuario a actualizar
     * @param usuarioActualizado Datos actualizados
     * @return Usuario actualizado
     * @throws RuntimeException si el usuario no existe
     */
    Usuario actualizarUsuario(Long id, Usuario usuarioActualizado);
    
    /**
     * Desactiva un usuario (cambio de estado)
     * @param id ID del usuario a desactivar
     * @throws RuntimeException si el usuario no existe
     */
    void desactivarUsuario(Long id);
    
    /**
     * Obtiene todos los usuarios del sistema
     * @return Lista de todos los usuarios
     */
    List<Usuario> obtenerTodos();
    
    /**
     * Valida las credenciales de un usuario
     * @param nombreUsuario Nombre de usuario
     * @param contrasena Contraseña
     * @return true si las credenciales son válidas
     */
    boolean validarCredenciales(String nombreUsuario, String contrasena);
}