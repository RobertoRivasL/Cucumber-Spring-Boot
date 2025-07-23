package com.rrivasl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.TimeZone;

/**
 * Clase principal de la aplicación Spring Boot
 * Proyecto: Sistema de Automatización de Pruebas con Cucumber
 * 
 * @author Roberto Rivas López
 * @version 1.0.0
 * @since 2025-01-01
 * 
 * Principios aplicados:
 * - Configuración centralizada
 * - Inversión de dependencias
 * - Separación de responsabilidades
 * - Configuración por convención
 */
@SpringBootApplication(
    scanBasePackages = {
        "com.rrivasl.servicio",
        "com.rrivasl.repositorio", 
        "com.rrivasl.controlador",
        "com.rrivasl.configuracion",
        "com.rrivasl.modelo"
    }
)
@EnableJpaRepositories(basePackages = "com.rrivasl.repositorio")
@EnableTransactionManagement
@EnableCaching
@EnableAsync
@EnableScheduling
@EnableConfigurationProperties
public class AplicacionPrincipal {
    
    private static final Logger logger = LoggerFactory.getLogger(AplicacionPrincipal.class);
    
    /**
     * Método principal de la aplicación
     * 
     * @param args Argumentos de línea de comandos
     */
    public static void main(String[] args) {
        // Configurar timezone por defecto
        TimeZone.setDefault(TimeZone.getTimeZone("America/Santiago"));
        
        logger.info("🚀 Iniciando aplicación Cucumber Spring Boot - Roberto Rivas López");
        logger.info("☕ Java Version: {}", System.getProperty("java.version"));
        logger.info("🌍 TimeZone: {}", TimeZone.getDefault().getID());
        
        try {
            SpringApplication app = new SpringApplication(AplicacionPrincipal.class);
            
            // Configuraciones adicionales de SpringApplication
            app.setAdditionalProfiles(obtenerPerfilesAdicionales(args));
            app.setLogStartupInfo(true);
            app.setRegisterShutdownHook(true);
            
            // Ejecutar aplicación
            var context = app.run(args);
            
            // Log información de contexto
            String[] activeProfiles = context.getEnvironment().getActiveProfiles();
            logger.info("✅ Aplicación iniciada exitosamente");
            logger.info("🔧 Perfiles activos: {}", String.join(", ", activeProfiles));
            logger.info("🌐 Aplicación disponible en: http://localhost:{}/api", 
                       context.getEnvironment().getProperty("server.port", "8080"));
            logger.info("📚 Documentación API: http://localhost:{}/api/swagger-ui.html",
                       context.getEnvironment().getProperty("server.port", "8080"));
            logger.info("🔍 Health Check: http://localhost:{}/api/actuator/health",
                       context.getEnvironment().getProperty("server.port", "8080"));
            
        } catch (Exception e) {
            logger.error("❌ Error al iniciar la aplicación: {}", e.getMessage(), e);
            System.exit(1);
        }
    }
    
    /**
     * Configuraciones post-construcción
     * Principio: Separación de responsabilidades
     */
    @PostConstruct
    public void configuracionPostInicio() {
        logger.info("🔧 Ejecutando configuraciones post-inicio...");
        
        // Configurar zona horaria de la aplicación
        TimeZone.setDefault(TimeZone.getTimeZone("America/Santiago"));
        
        // Log de información del sistema
        logger.info("💾 Memoria disponible: {} MB", 
                   Runtime.getRuntime().maxMemory() / 1024 / 1024);
        logger.info("🖥️ Procesadores disponibles: {}", 
                   Runtime.getRuntime().availableProcessors());
        
        logger.info("✅ Configuración post-inicio completada");
    }
    
    /**
     * Determina perfiles adicionales basado en argumentos
     * Principio: Configuración flexible
     * 
     * @param args Argumentos de línea de comandos
     * @return Array de perfiles adicionales
     */
    private static String[] obtenerPerfilesAdicionales(String[] args) {
        // Lógica para determinar perfiles adicionales según argumentos
        for (String arg : args) {
            if (arg.startsWith("--spring.profiles.active=")) {
                return new String[0]; // Ya especificado en argumentos
            }
        }
        
        // Determinar perfil por variable de entorno
        String perfilEntorno = System.getenv("SPRING_PROFILES_ACTIVE");
        if (perfilEntorno != null && !perfilEntorno.isEmpty()) {
            return perfilEntorno.split(",");
        }
        
        // Perfil por defecto
        return new String[]{"dev"};
    }
}