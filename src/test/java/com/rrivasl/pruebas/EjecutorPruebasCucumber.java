package com.rrivasl.pruebas;

import org.junit.platform.suite.api.ConfigurationParameter;
import org.junit.platform.suite.api.IncludeEngines;
import org.junit.platform.suite.api.SelectClasspathResource;
import org.junit.platform.suite.api.Suite;

import static io.cucumber.junit.platform.engine.Constants.*;

/**
 * Ejecutor principal de pruebas Cucumber
 * @author Roberto Rivas López
 * Spring Boot + Cucumber funcionando correctamente
 */
@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("features")
@ConfigurationParameter(key = PLUGIN_PROPERTY_NAME, value = "pretty")
@ConfigurationParameter(key = GLUE_PROPERTY_NAME, value = "com.rrivasl.pruebas")
public class EjecutorPruebasCucumber {
    // Configuración limpia sin duplicados
}
