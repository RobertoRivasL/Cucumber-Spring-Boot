package com.rrivasl.servicio;

import com.rrivasl.modelo.Producto;
import java.util.List;

/**
 * Interfaz Servicio Producto
 * @author Roberto Rivas López
 */
public interface ServicioProducto {
    
    Producto crearProducto(Producto producto);
    
    Producto buscarPorCodigo(String codigo);
    
    List<Producto> obtenerProductosPaginados(int pagina, int tamaño);
    
    void crearProductosDePrueba(int cantidad);
    
    Producto actualizarProducto(Long id, Producto producto);
    
    void eliminarProducto(Long id);
    
    List<Producto> buscarTodos();
}
