package com.rrivasl.pruebas;

import org.junit.platform.suite.api.ConfigurationParameter;
import org.junit.platform.suite.api.IncludeEngines;
import org.junit.platform.suite.api.SelectClasspathResource;
import org.junit.platform.suite.api.Suite;

import static io.cucumber.junit.platform.engine.Constants.*;

/**
 * Ejecutor principal de pruebas Cucumber
 * Integración completa Cucumber + Spring Boot
 * 
 * @author Roberto Rivas López
 * @version 1.0.0
 * @since 2025-01-01
 * 
 * Principios aplicados:
 * - Configuración centralizada
 * - Separación de responsabilidades
 * - Integración con Spring Boot
 */
@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("features")
@ConfigurationParameter(
    key = PLUGIN_PROPERTY_NAME, 
    value = "pretty, html:target/cucumber-reports/cucumber.html, " +
           "json:target/cucumber-reports/cucumber.json, " +
           "junit:target/cucumber-reports/cucumber.xml"
)
@ConfigurationParameter(
    key = GLUE_PROPERTY_NAME, 
    value = "com.rrivasl.pruebas.definiciones"
)
@ConfigurationParameter(
    key = FEATURES_PROPERTY_NAME, 
    value = "src/test/resources/features"
)
@ConfigurationParameter(
    key = FILTER_TAGS_PROPERTY_NAME, 
    value = "not @ignorar"
)
@ConfigurationParameter(
    key = SNIPPET_TYPE_PROPERTY_NAME, 
    value = "camelcase"
)
@ConfigurationParameter(
    key = EXECUTION_DRY_RUN_PROPERTY_NAME, 
    value = "false"
)
@ConfigurationParameter(
    key = EXECUTION_STRICT_PROPERTY_NAME, 
    value = "true"
)
public class EjecutorPruebasCucumber {
    
    /**
     * Esta clase configura la ejecución de todas las pruebas Cucumber
     * 
     * Características configuradas:
     * - Reportes en HTML, JSON y XML
     * - Integración con Spring Boot mediante CucumberSpringConfiguration
     * - Ejecución estricta (falla si hay steps indefinidos)
     * - Filtrado de tags para control granular
     * - Generación automática de snippets
     * 
     * Para ejecutar:
     * mvn test -Dtest=EjecutorPruebasCucumber
     * 
     * Para ejecutar con tags específicos:
     * mvn test -Dtest=EjecutorPruebasCucumber -Dcucumber.filter.tags="@usuarios"
     * 
     * Para ejecutar excluyendo tests lentos:
     * mvn test -Dtest=EjecutorPruebasCucumber -Dcucumber.filter.tags="not @lento"
     */
    
    // Esta clase no necesita métodos, solo las anotaciones de configuración
    // La ejecución es manejada por JUnit Platform y Cucumber Engine
}