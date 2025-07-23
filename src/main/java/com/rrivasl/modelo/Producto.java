package com.rrivasl.modelo;

import jakarta.persistence.*;
import java.math.BigDecimal;

/**
 * Entidad Producto
 * @author Roberto Rivas López
 */
@Entity
@Table(name = "productos")
public class Producto {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String nombre;
    
    private String descripcion;
    
    @Column(nullable = false)
    private BigDecimal precio;
    
    private String categoria;
    
    @Column(nullable = false)
    private Integer stock;
    
    @Column(unique = true, nullable = false)
    private String codigoProducto;
    
    // Constructor vacío
    public Producto() {}
    
    // Constructor con builder pattern
    private Producto(Builder builder) {
        this.nombre = builder.nombre;
        this.descripcion = builder.descripcion;
        this.precio = builder.precio;
        this.categoria = builder.categoria;
        this.stock = builder.stock;
        this.codigoProducto = builder.codigoProducto;
    }
    
    // Método builder estático
    public static Builder builder() {
        return new Builder();
    }
    
    // Getters y Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    
    public BigDecimal getPrecio() { return precio; }
    public void setPrecio(BigDecimal precio) { this.precio = precio; }
    
    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }
    
    public Integer getStock() { return stock; }
    public void setStock(Integer stock) { this.stock = stock; }
    
    public String getCodigoProducto() { return codigoProducto; }
    public void setCodigoProducto(String codigoProducto) { this.codigoProducto = codigoProducto; }
    
    // Clase Builder interna
    public static class Builder {
        private String nombre;
        private String descripcion;
        private BigDecimal precio;
        private String categoria;
        private Integer stock;
        private String codigoProducto;
        
        public Builder nombre(String nombre) {
            this.nombre = nombre;
            return this;
        }
        
        public Builder descripcion(String descripcion) {
            this.descripcion = descripcion;
            return this;
        }
        
        public Builder precio(BigDecimal precio) {
            this.precio = precio;
            return this;
        }
        
        public Builder categoria(String categoria) {
            this.categoria = categoria;
            return this;
        }
        
        public Builder stock(Integer stock) {
            this.stock = stock;
            return this;
        }
        
        public Builder codigoProducto(String codigoProducto) {
            this.codigoProducto = codigoProducto;
            return this;
        }
        
        public Producto build() {
            return new Producto(this);
        }
    }
}
