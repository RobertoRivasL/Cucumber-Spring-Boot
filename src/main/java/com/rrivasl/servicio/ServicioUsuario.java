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
