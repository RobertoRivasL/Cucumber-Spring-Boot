package com.rrivasl.servicio.impl;

import com.rrivasl.modelo.Producto;
import com.rrivasl.servicio.ServicioProducto;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementación del Servicio Producto
 * @author Roberto Rivas López
 */
@Service
public class ServicioProductoImpl implements ServicioProducto {
    
    // Simulación de base de datos en memoria para las pruebas
    private List<Producto> productos = new ArrayList<>();
    private Long siguienteId = 1L;
    
    @Override
    public Producto crearProducto(Producto producto) {
        producto.setId(siguienteId++);
        productos.add(producto);
        return producto;
    }
    
    @Override
    public Producto buscarPorCodigo(String codigo) {
        return productos.stream()
                .filter(p -> p.getCodigoProducto().equals(codigo))
                .findFirst()
                .orElse(null);
    }
    
    @Override
    public List<Producto> obtenerProductosPaginados(int pagina, int tamaño) {
        int inicio = pagina * tamaño;
        int fin = Math.min(inicio + tamaño, productos.size());
        
        if (inicio >= productos.size()) {
            return new ArrayList<>();
        }
        
        return productos.subList(inicio, fin);
    }
    
    @Override
    public void crearProductosDePrueba(int cantidad) {
        for (int i = 1; i <= cantidad; i++) {
            Producto producto = Producto.builder()
                    .nombre("Producto " + i)
                    .descripcion("Descripción del producto " + i)
                    .precio(new BigDecimal("100.00"))
                    .categoria("CATEGORIA_" + (i % 3 + 1))
                    .stock(10)
                    .codigoProducto("PROD-" + String.format("%03d", i))
                    .build();
            crearProducto(producto);
        }
    }
    
    @Override
    public Producto actualizarProducto(Long id, Producto producto) {
        for (int i = 0; i < productos.size(); i++) {
            if (productos.get(i).getId().equals(id)) {
                producto.setId(id);
                productos.set(i, producto);
                return producto;
            }
        }
        return null;
    }
    
    @Override
    public void eliminarProducto(Long id) {
        productos.removeIf(p -> p.getId().equals(id));
    }
    
    @Override
    public List<Producto> buscarTodos() {
        return new ArrayList<>(productos);
    }
}
