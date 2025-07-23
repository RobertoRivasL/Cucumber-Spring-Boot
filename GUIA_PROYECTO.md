# 🚀 GUÍA COMPLETA DEL PROYECTO CUCUMBER SPRING BOOT

**Autor:** Roberto Rivas López  
**Curso:** Automatización de Pruebas  
**Fecha:** Enero 2025

---

## 📋 RESUMEN EJECUTIVO

Este proyecto implementa un sistema completo de automatización de pruebas usando **Cucumber** con **Spring Boot**, siguiendo las mejores prácticas de desarrollo y los principios **SOLID**. 

### 🎯 Objetivos Logrados
- ✅ Implementación completa de BDD con Cucumber
- ✅ Integración perfecta con Spring Boot 3.1.5
- ✅ Features en español para mejor comprensión
- ✅ Cobertura completa: usuarios, autenticación, productos, seguridad, monitoreo y reportes
- ✅ Scripts de ejecución automatizada
- ✅ Arquitectura limpia y escalable

---

## 🏗️ ARQUITECTURA DEL PROYECTO

### Estructura de Directorios
```
mi-proyecto-cucumber/
├── 📁 src/main/java/com/rrivasl/
│   ├── 🗂️ modelo/                    # Entidades JPA
│   ├── 🗂️ servicio/impl/             # Implementaciones de servicios
│   ├── 🗂️ repositorio/               # Interfaces de datos
│   ├── 🗂️ controlador/               # APIs REST
│   └── 🗂️ configuracion/             # Configuraciones Spring
├── 📁 src/test/java/com/rrivasl/pruebas/
│   ├── 🗂️ definiciones/              # Step definitions Cucumber
│   ├── 🗂️ configuracion/             # Config pruebas
│   └── 🗂️ utilidades/                # Herramientas testing
├── 📁 src/test/resources/features/   # Archivos .feature
├── 📁 devops/                        # Docker, Kubernetes, Jenkins
├── 📁 scripts/                       # Scripts automatización
└── 📄 ejecutar-features.sh           # Script principal de ejecución
```

### Principios Aplicados
- **🎯 Single Responsibility:** Cada clase tiene una responsabilidad específica
- **🔓 Open/Closed:** Abierto para extensión, cerrado para modificación
- **🔄 Liskov Substitution:** Subtipos sustituibles por tipos base
- **🎭 Interface Segregation:** Interfaces específicas y cohesivas
- **🔌 Dependency Inversion:** Dependencias hacia abstracciones

---

## 🎪 FEATURES IMPLEMENTADOS

### 1. 👥 Gestión de Usuarios (`gestion_usuarios.feature`)
**Funcionalidades:**
- Crear usuarios con validaciones completas
- Manejar errores de duplicados
- Validar contraseñas seguras
- Búsqueda con filtros
- Actualización de datos
- Desactivación de usuarios

**Step Definitions:** `DefinicionesUsuarios.java`
**Servicio:** `ServicioUsuarioImpl.java`

### 2. 🔐 Autenticación (`autenticacion.feature`)
**Funcionalidades:**
- Login con JWT tokens
- Manejo de credenciales incorrectas
- Bloqueo por intentos fallidos
- Control de acceso por roles
- Logout seguro

**Step Definitions:** `DefinicionesAutenticacion.java`
**Características especiales:**
- Simulación completa de autenticación
- Validación de tokens JWT
- Control de sesiones

### 3. 📦 Gestión de Productos (`gestion_productos.feature`)
**Funcionalidades:**
- CRUD completo de productos
- Validaciones de datos
- Paginación y filtros
- Control de stock
- Gestión de inventario

**Step Definitions:** `DefinicionesProductos.java`
**Servicio:** `ServicioProductoImpl.java`

### 4. 🔒 Seguridad del Sistema (`seguridad_sistema.feature`)
**Funcionalidades:**
- Protección SQL Injection
- Sanitización XSS
- Rate limiting
- Headers de seguridad
- Encriptación de datos

**Step Definitions:** `DefinicionesSeguridad.java`

### 5. 📊 Monitoreo del Sistema (`monitoreo_sistema.feature`)
**Funcionalidades:**
- Health checks
- Métricas del sistema
- Alertas automáticas
- Logs estructurados
- Monitoreo de BD

**Step Definitions:** `DefinicionesMonitoreo.java`

### 6. 📋 Reportes del Sistema (`reportes_sistema.feature`)
**Funcionalidades:**
- Reportes de usuarios
- Reportes de inventario
- Reportes de ventas
- Generación de PDF
- Gráficos dinámicos

**Step Definitions:** `DefinicionesReportes.java`

### 7. ✅ Pruebas Básicas (`prueba_basica.feature`)
**Funcionalidades:**
- Verificación del sistema
- Pruebas de conectividad
- Validación de configuración

**Step Definitions:** `DefinicionesPruebaBasica.java`

---

## 🛠️ CONFIGURACIÓN Y EJECUCIÓN

### ⚡ Configuración Inicial
```bash
# 1. Configurar proyecto completo
chmod +x setup-proyecto.sh
./setup-proyecto.sh

# 2. Verificar prerrequisitos
./setup-proyecto.sh check

# 3. Solo compilar
./setup-proyecto.sh compile
```

### 🚀 Ejecución de Pruebas

#### Script Principal - `ejecutar-features.sh`
```bash
# Hacer ejecutable
chmod +x ejecutar-features.sh

# Ejecución interactiva (menú)
./ejecutar-features.sh

# Ejecución directa
./ejecutar-features.sh todas          # Todas las pruebas
./ejecutar-features.sh usuarios       # Solo usuarios
./ejecutar-features.sh autenticacion  # Solo autenticación  
./ejecutar-features.sh productos      # Solo productos
./ejecutar-features.sh seguridad      # Solo seguridad
./ejecutar-features.sh monitoreo      # Solo monitoreo
./ejecutar-features.sh reportes       # Solo reportes
./ejecutar-features.sh basico         # Solo básicas
```

#### Comandos Maven Directos
```bash
# Todas las pruebas
mvn test -Dtest=EjecutorPruebasCucumber

# Por tags específicos
mvn test -Dtest=EjecutorPruebasCucumber -Dcucumber.filter.tags="@usuarios"
mvn test -Dtest=EjecutorPruebasCucumber -Dcucumber.filter.tags="@regresion"
mvn test -Dtest=EjecutorPruebasCucumber -Dcucumber.filter.tags="@regresion and @usuarios"
```

### 🎮 Aplicación
```bash
# Iniciar aplicación
mvn spring-boot:run

# Con perfil específico
mvn spring-boot:run -Dspring-boot.run.profiles=dev

# Usando script
./scripts/start.sh
```

---

## 🎯 TAGS Y ORGANIZACIÓN

### Tags Implementados
- `@regresion` - Pruebas de regresión críticas
- `@usuarios` - Funcionalidades de usuarios
- `@autenticacion` - Funcionalidades de login/logout
- `@productos` - Gestión de inventario
- `@seguridad` - Pruebas de seguridad
- `@monitoreo` - Health checks y métricas
- `@reportes` - Generación de reportes
- `@validacion` - Pruebas de validación
- `@creacion` - Pruebas de creación
- `@actualizacion` - Pruebas de actualización
- `@eliminacion` - Pruebas de eliminación

### Combinaciones Útiles
```bash
# Pruebas críticas
@regresion

# Pruebas de usuarios completas
@usuarios and @regresion

# Pruebas rápidas (excluir lentas)
not @lento

# Solo validaciones
@validacion

# Funcionalidades específicas
@productos and @creacion
```

---

## 🌐 ENDPOINTS Y SERVICIOS

### URLs de la Aplicación
- **Aplicación:** http://localhost:8080/api
- **Swagger/OpenAPI:** http://localhost:8080/api/swagger-ui.html
- **Health Check:** http://localhost:8080/api/actuator/health
- **Métricas:** http://localhost:8080/api/actuator/metrics
- **H2 Console:** http://localhost:8080/api/h2-console

### APIs Implementadas (Conceptual)
```
GET    /api/usuarios              # Listar usuarios
POST   /api/usuarios              # Crear usuario
GET    /api/usuarios/{id}         # Obtener usuario
PUT    /api/usuarios/{id}         # Actualizar usuario
DELETE /api/usuarios/{id}         # Eliminar usuario

GET    /api/productos             # Listar productos
POST   /api/productos             # Crear producto
GET    /api/productos/{id}        # Obtener producto
PUT    /api/productos/{id}        # Actualizar producto

POST   /api/auth/login            # Iniciar sesión
POST   /api/auth/logout           # Cerrar sesión
GET    /api/auth/profile          # Perfil usuario

GET    /api/reportes/usuarios     # Reporte usuarios
GET    /api/reportes/inventario   # Reporte inventario
GET    /api/reportes/ventas       # Reporte ventas
```

---

## 🔧 CONFIGURACIÓN AVANZADA

### Perfiles de Spring
```yaml
# application.yml configurado para:
- dev      # Desarrollo (por defecto)
- test     # Pruebas automatizadas  
- prod     # Producción
```

### Base de Datos
```yaml
# Desarrollo/Pruebas: H2 en memoria
# Producción: PostgreSQL

# H2 Console: http://localhost:8080/api/h2-console
# URL: jdbc:h2:mem:devdb
# Usuario: sa
# Password: (vacío)
```

### Variables de Entorno
```bash
# Para producción
export DATABASE_URL=jdbc:postgresql://localhost:5432/mi_proyecto
export DATABASE_USERNAME=rrivasl
export DATABASE_PASSWORD=password123
export JWT_SECRET=clave-super-secreta-produccion
```

---

## 🐳 CONTAINERIZACIÓN Y DESPLIEGUE

### Docker
```bash
# Construir imagen
docker build -t rrivasl/mi-proyecto-cucumber .

# Ejecutar contenedor
docker run -p 8080:8080 rrivasl/mi-proyecto-cucumber

# Con Docker Compose
docker-compose up -d
```

### Kubernetes
```bash
# Desplegar en Kubernetes
kubectl apply -f devops/kubernetes/

# Verificar despliegue
kubectl get pods -n desarrollo
kubectl get services -n desarrollo
```

### Jenkins CI/CD
```bash
# Pipeline configurado en devops/jenkins/Jenkinsfile
# Stages:
# 1. Checkout código
# 2. Compilar proyecto  
# 3. Ejecutar pruebas Cucumber
# 4. Generar reportes
# 5. Desplegar (opcional)
```

---

## 📊 REPORTES Y MÉTRICAS

### Reportes Cucumber
```bash
# Los reportes se generan automáticamente en:
target/cucumber-reports/

# Formatos disponibles:
- HTML (principal)
- JSON (para CI/CD)
- JUnit XML (para Jenkins)
```

### Cobertura de Código
```bash
# Generar reporte de cobertura
mvn jacoco:report

# Ver reporte en:
target/site/jacoco/index.html
```

### Métricas de Calidad
```bash
# Verificar dependencias
mvn dependency-check:check

# Generar sitio del proyecto
mvn site
```

---

## 🚨 TROUBLESHOOTING

### Problemas Comunes

#### 1. Error de Compilación
```bash
# Limpiar y recompilar
mvn clean compile

# Verificar versión Java
java -version  # Debe ser 17+
```

#### 2. Pruebas Fallan
```bash
# Verificar configuración Spring
mvn test -Dspring.profiles.active=test

# Ejecutar prueba específica
mvn test -Dtest=DefinicionesPruebaBasica

# Ver logs detallados
mvn test -Dtest=EjecutorPruebasCucumber -X
```

#### 3. Cucumber No Encuentra Steps
```bash
# Verificar package scanning en EjecutorPruebasCucumber.java
@ConfigurationParameter(key = GLUE_PROPERTY_NAME, value = "com.rrivasl.pruebas.definiciones")

# Verificar CucumberSpringConfiguration.java existe
```

#### 4. Base de Datos
```bash
# Verificar H2 disponible
curl http://localhost:8080/api/h2-console

# Reiniciar con BD limpia
mvn clean spring-boot:run
```

#### 5. Puerto en Uso
```bash
# Encontrar proceso usando puerto 8080
lsof -i :8080

# Matar proceso
kill -9 <PID>

# Usar puerto diferente
mvn spring-boot:run -Dserver.port=8081
```

---

## 📚 RECURSOS Y REFERENCIAS

### Documentación Oficial
- **Spring Boot:** https://spring.io/projects/spring-boot
- **Cucumber:** https://cucumber.io/docs/cucumber/
- **Maven:** https://maven.apache.org/guides/

### Herramientas Utilizadas
- **Java 17:** OpenJDK o Oracle JDK
- **Maven 3.9.10:** Gestión de dependencias
- **Spring Boot 3.1.5:** Framework principal
- **Cucumber 7.18.0:** BDD testing
- **H2 Database:** Base de datos en memoria
- **JUnit 5:** Framework de testing
- **Jackson:** Procesamiento JSON

### Patrones y Principios
- **BDD (Behavior Driven Development)**
- **TDD (Test Driven Development)**
- **SOLID Principles**
- **Clean Code**
- **Repository Pattern**
- **Service Layer Pattern**

---

## 🎓 APRENDIZAJES DEL CURSO

### Conceptos Aplicados
1. **Automatización de Pruebas**
   - BDD con Cucumber
   - Gherkin en español
   - Step definitions reutilizables

2. **Integración Continua**
   - Maven para build automation
   - Jenkins para CI/CD
   - Docker para containerización

3. **Arquitectura de Software**
   - Principios SOLID
   - Separación de responsabilidades
   - Inyección de dependencias

4. **Testing Strategies**
   - Pruebas unitarias
   - Pruebas de integración
   - Pruebas end-to-end
   - Cobertura de código

---

## 👤 INFORMACIÓN DEL AUTOR

**Roberto Rivas López**
- **Curso:** Automatización de Pruebas
- **Especialidades:** Java, Spring Boot, DevOps, Kubernetes, Jenkins
- **Lenguajes:** Java, HTML, JavaScript
- **Herramientas:** Docker, Kubernetes, Jenkins, JMeter, SonarQube, AWS

---

## 🎉 CONCLUSIONES

Este proyecto demuestra la implementación exitosa de un sistema completo de automatización de pruebas utilizando las mejores prácticas de la industria. La combinación de **Cucumber** con **Spring Boot** proporciona una base sólida para el desarrollo de software de calidad.

### Beneficios Logrados
- ✅ **Pruebas legibles:** Features en español comprensibles por todos
- ✅ **Automatización completa:** Scripts para todas las tareas
- ✅ **Arquitectura escalable:** Fácil agregar nuevas funcionalidades
- ✅ **CI/CD ready:** Preparado para integración continua
- ✅ **Documentación completa:** Guías y ejemplos detallados

### Próximos Pasos Sugeridos
1. Implementar más features de negocio
2. Agregar pruebas de rendimiento con JMeter
3. Integrar análisis de código con SonarQube
4. Desplegar en AWS o similar
5. Implementar monitoreo avanzado

---

**¡Proyecto completado exitosamente! 🚀**

*Roberto Rivas López - Enero 2025*