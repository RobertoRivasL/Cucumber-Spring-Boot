package com.rrivasl.pruebas.configuracion;

import io.cucumber.spring.CucumberContextConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.TestPropertySource;
import com.rrivasl.AplicacionPrincipal;

import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureWebMvc;
import org.springframework.transaction.annotation.Transactional;

/**
 * Configuración de contexto para Cucumber + Spring Boot
 * 
 * @author Roberto Rivas López
 * @version 1.0.0
 * @since 2025-01-01
 * 
 * Esta clase es OBLIGATORIA para integrar Cucumber con Spring Boot.
 * Establece el contexto de Spring que será compartido por todos los step definitions.
 * 
 * Principios aplicados:
 * - Configuración centralizada
 * - Separación de responsabilidades  
 * - Inyección de dependencias
 * - Configuración por convención
 */
@CucumberContextConfiguration
@SpringBootTest(
    classes = AplicacionPrincipal.class,
    webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT
)
@ActiveProfiles("test")
@TestPropertySource(
    properties = {
        "spring.datasource.url=jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE",
        "spring.jpa.hibernate.ddl-auto=create-drop",
        "spring.jpa.show-sql=false",
        "logging.level.org.springframework=WARN",
        "logging.level.com.rrivasl=DEBUG",
        "spring.main.banner-mode=off",
        "cucumber.publish.quiet=true"
    }
)
@AutoConfigureWebMvc
@Transactional
public class CucumberSpringConfiguration {
    
    /**
     * Esta clase configura el contexto de Spring Boot para las pruebas Cucumber.
     * 
     * Características configuradas:
     * 
     * 1. **Contexto de Spring Boot completo:**
     *    - Carga la aplicación principal (AplicacionPrincipal.class)
     *    - Configura puerto aleatorio para evitar conflictos
     *    - Habilita todas las funcionalidades de Spring Boot
     * 
     * 2. **Perfil de pruebas:**
     *    - Activa el perfil "test" automáticamente
     *    - Configuración específica para testing
     *    - Base de datos H2 en memoria
     * 
     * 3. **Configuración de base de datos:**
     *    - H2 en memoria para pruebas aisladas
     *    - Esquema recreado en cada ejecución
     *    - Sin persistencia entre pruebas
     * 
     * 4. **Configuración de logging:**
     *    - Logs de Spring en nivel WARN para reducir ruido
     *    - Logs de aplicación en DEBUG para troubleshooting
     *    - Banner de Spring Boot desactivado
     * 
     * 5. **Transacciones:**
     *    - Rollback automático después de cada escenario
     *    - Aislamiento entre pruebas
     *    - Estado limpio para cada test
     * 
     * **Uso:**
     * Esta configuración es utilizada automáticamente por Cucumber cuando
     * los step definitions están marcados con @SpringBootTest y utilizan
     * inyección de dependencias de Spring.
     * 
     * **Ejemplo de step definition que usa esta configuración:**
     * ```java
     * @SpringBootTest
     * public class DefinicionesUsuarios {
     *     @Autowired
     *     private ServicioUsuario servicioUsuario;
     *     
     *     @Dado("que existe un usuario")
     *     public void queExisteUnUsuario() {
     *         // El servicioUsuario está disponible por DI
     *     }
     * }
     * ```
     * 
     * **Notas importantes:**
     * - NO agregar métodos a esta clase
     * - NO modificar las anotaciones sin conocer el impacto
     * - Esta clase DEBE estar en el package de configuración
     * - Debe tener acceso a la clase principal de la aplicación
     */
    
    // Esta clase no necesita métodos, solo las anotaciones de configuración
    // El contexto de Spring Boot es manejado automáticamente por el framework
}