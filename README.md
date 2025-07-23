# Proyecto Cucumber Spring Boot

**Autor:** Roberto Rivas López  
**Curso:** Automatización de Pruebas  
**Tecnologías:** Java 17, Spring Boot 3.1.5, Cucumber 7.18.0, Maven 3.9.10

## 📋 Descripción
Proyecto de automatización de pruebas usando Cucumber con Spring Boot, implementando BDD (Behavior Driven Development) para pruebas de alta calidad.

## 🏗️ Arquitectura
- **Backend:** Spring Boot con arquitectura en capas
- **Pruebas:** Cucumber con features en español
- **Base de datos:** H2 (desarrollo), PostgreSQL (producción)
- **Documentación:** OpenAPI/Swagger
- **CI/CD:** Jenkins, Docker, Kubernetes

## 🚀 Ejecución Rápida

### Ejecutar aplicación
```bash
./scripts/start.sh
# o
mvn spring-boot:run
```

### Ejecutar todas las pruebas
```bash
./ejecutar-features.sh todas
```

### Ejecutar pruebas específicas
```bash
./ejecutar-features.sh usuarios
./ejecutar-features.sh autenticacion
./ejecutar-features.sh productos
```

## 📁 Estructura del proyecto
```
src/
├── main/java/com/rrivasl/          # Código fuente principal
│   ├── modelo/                     # Entidades JPA
│   ├── servicio/                   # Lógica de negocio
│   ├── repositorio/                # Acceso a datos
│   ├── controlador/                # APIs REST
│   └── configuracion/              # Configuraciones Spring
├── test/java/com/rrivasl/pruebas/  # Pruebas automatizadas
│   ├── definiciones/               # Step definitions Cucumber
│   ├── configuracion/              # Configuración de pruebas
│   └── utilidades/                 # Utilidades de testing
└── test/resources/features/        # Archivos .feature (Gherkin)
```

## 🎯 Features Implementados
- ✅ **Gestión de Usuarios:** CRUD completo con validaciones
- ✅ **Autenticación:** Login/logout con JWT
- ✅ **Gestión de Productos:** Inventario con paginación
- ✅ **Seguridad:** Protección XSS, SQL Injection, CSRF
- ✅ **Monitoreo:** Health checks y métricas
- ✅ **Reportes:** Generación de PDF con datos

## 🔧 Comandos útiles

### Desarrollo
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=dev
mvn test -Dtest=EjecutorPruebasCucumber
mvn clean package -Pprod
```

### Docker
```bash
docker build -t rrivasl/mi-proyecto-cucumber .
docker run -p 8080:8080 rrivasl/mi-proyecto-cucumber
```

### Kubernetes
```bash
kubectl apply -f devops/kubernetes/
```

## 📊 Reportes y Documentación
- **API Docs:** http://localhost:8080/api/swagger-ui.html
- **Health Check:** http://localhost:8080/api/actuator/health
- **Métricas:** http://localhost:8080/api/actuator/metrics
- **H2 Console:** http://localhost:8080/api/h2-console

## 🧪 Principios Aplicados
- **SOLID:** Separación de responsabilidades
- **DRY:** No repetir código
- **Clean Code:** Código limpio y legible
- **BDD:** Desarrollo guiado por comportamiento
- **TDD:** Desarrollo guiado por pruebas

## 👥 Contribución
Este es un proyecto académico para el curso de Automatización de Pruebas.

## 📝 Licencia
Proyecto educativo - Roberto Rivas López

---
**Última actualización:** 2025-07-23
