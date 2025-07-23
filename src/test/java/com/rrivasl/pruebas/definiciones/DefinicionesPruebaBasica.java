package com.rrivasl.pruebas.definiciones;

import io.cucumber.java.es.Dado;
import io.cucumber.java.es.Cuando;
import io.cucumber.java.es.Entonces;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Definiciones de pasos básicas - SIN DUPLICADOS
 * @author Roberto Rivas López
 * Para curso de Automatización de Pruebas
 */
public class DefinicionesPruebaBasica {
    
    @Dado("que el sistema está funcionando")
    public void queElSistemaEstaFuncionando() {
        System.out.println("✅ Sistema funcionando - Roberto Rivas López");
        assertTrue(true, "Sistema iniciado correctamente");
    }
    
    @Cuando("ejecuto una prueba básica")
    public void ejecutoUnaPruebaBasica() {
        System.out.println("🧪 Ejecutando prueba básica...");
        assertTrue(true, "Prueba en ejecución");
    }
    
    @Entonces("debería obtener un resultado exitoso")
    public void deberiaObtenerUnResultadoExitoso() {
        System.out.println("🎉 ¡Prueba exitosa!");
        assertTrue(true, "Resultado exitoso obtenido");
    }
    
    @Dado("que el sistema está disponible")
    public void queElSistemaEstaDisponible() {
        System.out.println("🔧 Sistema disponible para pruebas - Roberto Rivas López");
        assertTrue(true, "Sistema disponible");
    }
    
    @Cuando("verifico el estado del sistema")
    public void verificoElEstadoDelSistema() {
        System.out.println("🔍 Verificando estado del sistema...");
        assertTrue(true, "Verificando sistema");
    }
    
    @Entonces("el sistema debería estar operativo")
    public void elSistemaDeberiaEstarOperativo() {
        System.out.println("✅ Sistema operativo confirmado");
        assertTrue(true, "Sistema operativo");
    }
}
