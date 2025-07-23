package com.rrivasl.repositorio;

import com.rrivasl.modelo.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repositorio para la entidad Usuario
 * @author Roberto Rivas López
 * Principios aplicados: Abstracción, Separación de Intereses
 */
@Repository
public interface RepositorioUsuario extends JpaRepository<Usuario, Long> {
    
    /**
     * Buscar usuario por nombre de usuario
     * @param nombreUsuario nombre único del usuario
     * @return usuario encontrado o Optional.empty()
     */
    Optional<Usuario> findByNombreUsuario(String nombreUsuario);
    
    /**
     * Buscar usuario por correo electrónico
     * @param correoElectronico email del usuario
     * @return usuario encontrado o Optional.empty()
     */
    Optional<Usuario> findByCorreoElectronico(String correoElectronico);
    
    /**
     * Verificar si existe un usuario con el correo dado
     * @param correoElectronico email a verificar
     * @return true si existe, false si no
     */
    boolean existsByCorreoElectronico(String correoElectronico);
    
    /**
     * Verificar si existe un usuario con el nombre de usuario dado
     * @param nombreUsuario nombre a verificar
     * @return true si existe, false si no
     */
    boolean existsByNombreUsuario(String nombreUsuario);
    
    /**
     * Buscar usuarios por estado
     * @param estado estado del usuario (ACTIVO, INACTIVO, BLOQUEADO)
     * @return lista de usuarios con el estado especificado
     */
    List<Usuario> findByEstado(Usuario.EstadoUsuario estado);
    
    /**
     * Buscar usuarios que contengan el nombre especificado
     * @param nombre parte del nombre a buscar
     * @return lista de usuarios que coinciden
     */
    @Query("SELECT u FROM Usuario u WHERE u.nombre LIKE %:nombre%")
    List<Usuario> findByNombreContaining(@Param("nombre") String nombre);
    
    /**
     * Contar usuarios activos
     * @return número de usuarios con estado ACTIVO
     */
    @Query("SELECT COUNT(u) FROM Usuario u WHERE u.estado = 'ACTIVO'")
    long countUsuariosActivos();
}
