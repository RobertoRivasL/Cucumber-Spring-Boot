package com.rrivasl.configuracion;

import org.springframework.context.annotation.Configuration;

/**
 * Configuración de Base de Datos
 * @author Roberto Rivas López
 */
@Configuration
public class ConfiguracionBaseDatos {
    
    private String url;
    
    public ConfiguracionBaseDatos() {}
    
    public ConfiguracionBaseDatos(String url) {
        this.url = url;
    }
    
    public String getUrl() {
        return url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }
}
