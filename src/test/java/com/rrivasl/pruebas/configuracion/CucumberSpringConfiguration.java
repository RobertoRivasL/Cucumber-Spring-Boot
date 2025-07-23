package com.rrivasl.pruebas.configuracion;

import io.cucumber.spring.CucumberContextConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

/**
 * Configuración de contexto para Cucumber + Spring Boot
 * @author Roberto Rivas López
 * Esta clase conecta Cucumber con Spring Boot correctamente
 */
@CucumberContextConfiguration
@SpringBootTest(classes = com.rrivasl.AplicacionPrincipal.class)
@ActiveProfiles("test")
public class CucumberSpringConfiguration {
    // Esta clase conecta Cucumber con Spring Boot
    // Spring Boot ya se está iniciando correctamente (11.184 segundos)
}
