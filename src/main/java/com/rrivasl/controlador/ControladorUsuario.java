package com.rrivasl.controlador;

import com.rrivasl.modelo.Usuario;
import com.rrivasl.servicio.ServicioUsuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jakarta.validation.Valid;
import java.util.List;
import java.util.Optional;

/**
 * Controlador REST para gestión de usuarios
 * @author Roberto Rivas López
 * Principios aplicados: Separación de Intereses, Responsabilidad Única
 */
@RestController
@RequestMapping("/usuarios")
@CrossOrigin(origins = "*")
public class ControladorUsuario {
    
    private static final Logger logger = LoggerFactory.getLogger(ControladorUsuario.class);
    
    @Autowired
    private ServicioUsuario servicioUsuario;
    
    /**
     * Crear un nuevo usuario
     * @param usuario datos del usuario a crear
     * @return ResponseEntity con el usuario creado
     */
    @PostMapping
    public ResponseEntity<?> crearUsuario(@Valid @RequestBody Usuario usuario) {
        try {
            logger.info("Creando nuevo usuario: {}", usuario.getNombreUsuario());
            Usuario usuarioCreado = servicioUsuario.crearUsuario(usuario);
            return new ResponseEntity<>(usuarioCreado, HttpStatus.CREATED);
        } catch (IllegalArgumentException e) {
            logger.error("Error al crear usuario: {}", e.getMessage());
            return new ResponseEntity<>(e.getMessage(), HttpStatus.CONFLICT);
        } catch (Exception e) {
            logger.error("Error interno al crear usuario", e);
            return new ResponseEntity<>("Error interno del servidor", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * Obtener todos los usuarios
     * @return lista de todos los usuarios
     */
    @GetMapping
    public ResponseEntity<List<Usuario>> obtenerTodosLosUsuarios() {
        try {
            List<Usuario> usuarios = servicioUsuario.obtenerTodosLosUsuarios();
            return new ResponseEntity<>(usuarios, HttpStatus.OK);
        } catch (Exception e) {
            logger.error("Error al obtener usuarios", e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * Buscar usuario por ID
     * @param id identificador del usuario
     * @return usuario encontrado o 404 si no existe
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarUsuarioPorId(@PathVariable Long id) {
        try {
            Optional<Usuario> usuario = servicioUsuario.buscarPorId(id);
            if (usuario.isPresent()) {
                return new ResponseEntity<>(usuario.get(), HttpStatus.OK);
            } else {
                return new ResponseEntity<>("Usuario no encontrado", HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            logger.error("Error al buscar usuario por ID: {}", id, e);
            return new ResponseEntity<>("Error interno del servidor", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * Actualizar usuario existente
     * @param id identificador del usuario
     * @param usuario nuevos datos del usuario
     * @return usuario actualizado
     */
    @PutMapping("/{id}")
    public ResponseEntity<?> actualizarUsuario(@PathVariable Long id, @Valid @RequestBody Usuario usuario) {
        try {
            Usuario usuarioActualizado = servicioUsuario.actualizarUsuario(id, usuario);
            return new ResponseEntity<>(usuarioActualizado, HttpStatus.OK);
        } catch (IllegalArgumentException e) {
            logger.error("Error al actualizar usuario: {}", e.getMessage());
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            logger.error("Error interno al actualizar usuario", e);
            return new ResponseEntity<>("Error interno del servidor", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * Desactivar usuario
     * @param id identificador del usuario
     * @return confirmación de desactivación
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> desactivarUsuario(@PathVariable Long id) {
        try {
            servicioUsuario.desactivarUsuario(id);
            return new ResponseEntity<>("Usuario desactivado exitosamente", HttpStatus.OK);
        } catch (IllegalArgumentException e) {
            logger.error("Error al desactivar usuario: {}", e.getMessage());
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            logger.error("Error interno al desactivar usuario", e);
            return new ResponseEntity<>("Error interno del servidor", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * Buscar usuario por nombre de usuario
     * @param nombreUsuario nombre del usuario a buscar
     * @return usuario encontrado o 404 si no existe
     */
    @GetMapping("/buscar/nombreUsuario/{nombreUsuario}")
    public ResponseEntity<?> buscarPorNombreUsuario(@PathVariable String nombreUsuario) {
        try {
            Optional<Usuario> usuario = servicioUsuario.buscarPorNombreUsuario(nombreUsuario);
            if (usuario.isPresent()) {
                return new ResponseEntity<>(usuario.get(), HttpStatus.OK);
            } else {
                return new ResponseEntity<>("Usuario no encontrado", HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            logger.error("Error al buscar usuario por nombre: {}", nombreUsuario, e);
            return new ResponseEntity<>("Error interno del servidor", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * Endpoint de salud para verificar que el controlador funciona
     * @return estado del controlador
     */
    @GetMapping("/salud")
    public ResponseEntity<String> verificarSalud() {
        return new ResponseEntity<>("Controlador de usuarios funcionando correctamente - Roberto Rivas López", HttpStatus.OK);
    }
}
