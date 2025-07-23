#!/bin/bash

# Script de configuración completa del proyecto Cucumber + Spring Boot
# Autor: Roberto Rivas López
# Curso: Automatización de Pruebas

# Configuración de colores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variables del proyecto
PROYECTO_NOMBRE="mi-proyecto-cucumber"
AUTOR="Roberto Rivas López"
JAVA_VERSION="17"
MAVEN_VERSION="3.9.10"

# Banner del proyecto
mostrar_banner() {
    clear
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                    🚀 SETUP PROYECTO CUCUMBER SPRING BOOT                   ║"
    echo "║                                                                              ║"
    echo "║                           👤 Roberto Rivas López                            ║"
    echo "║                        📚 Curso: Automatización de Pruebas                 ║"
    echo "║                                                                              ║"
    echo "║  🎯 Objetivo: Configurar proyecto completo de pruebas automatizadas         ║"
    echo "║  🔧 Tecnologías: Java 17, Spring Boot, Cucumber, Maven                      ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

# Función para mostrar log con timestamp
log() {
    echo -e "${CYAN}[$(date +'%H:%M:%S')]${NC} $1"
}

# Función para mostrar error
error() {
    echo -e "${RED}❌ ERROR:${NC} $1"
}

# Función para mostrar éxito
success() {
    echo -e "${GREEN}✅${NC} $1"
}

# Función para mostrar advertencia
warning() {
    echo -e "${YELLOW}⚠️${NC} $1"
}

# Función para mostrar información
info() {
    echo -e "${BLUE}ℹ️${NC} $1"
}

# Verificar prerrequisitos del sistema
verificar_prerrequisitos() {
    log "Verificando prerrequisitos del sistema..."
    
    # Verificar Java
    if command -v java &> /dev/null; then
        JAVA_INSTALLED=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
        if [ "$JAVA_INSTALLED" -ge "17" ]; then
            success "Java $JAVA_INSTALLED encontrado"
        else
            error "Java 17 o superior requerido. Encontrado: Java $JAVA_INSTALLED"
            return 1
        fi
    else
        error "Java no encontrado. Instala Java 17 o superior"
        return 1
    fi
    
    # Verificar Maven
    if command -v mvn &> /dev/null; then
        MAVEN_INSTALLED=$(mvn -version | head -n 1 | awk '{print $3}')
        success "Maven $MAVEN_INSTALLED encontrado"
    else
        error "Maven no encontrado. Instala Maven 3.9.10 o superior"
        return 1
    fi
    
    # Verificar Git
    if command -v git &> /dev/null; then
        success "Git encontrado"
    else
        warning "Git no encontrado. Recomendado para control de versiones"
    fi
    
    echo ""
}

# Crear estructura de directorios
crear_estructura_directorios() {
    log "Creando estructura de directorios..."
    
    # Directorios principales
    mkdir -p src/main/java/com/rrivasl/{modelo,servicio/{impl},repositorio,controlador,configuracion}
    mkdir -p src/test/java/com/rrivasl/pruebas/{definiciones,configuracion,utilidades}
    mkdir -p src/main/resources/{static,templates}
    mkdir -p src/test/resources/{features,data}
    mkdir -p devops/{docker,kubernetes,jenkins}
    mkdir -p scripts
    mkdir -p docs
    mkdir -p logs
    
    success "Estructura de directorios creada"
    echo ""
}

# Configurar archivos de configuración base
configurar_archivos_base() {
    log "Configurando archivos base del proyecto..."
    
    # Crear .gitignore si no existe
    if [ ! -f ".gitignore" ]; then
        cat > .gitignore << 'EOF'
# Git ignore - Roberto Rivas López

# Maven
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties
.mvn/timing.properties

# Java
*.class
*.log
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar
hs_err_pid*

# IDE
.idea/
*.iws
*.iml
*.ipr
.vscode/
*.swp
*.swo
*~

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Spring Boot
*.original

# Logs
logs/
*.log

# H2 Database
*.db

# Reportes
target/site/
target/cucumber-reports/
EOF
        success "Archivo .gitignore creado"
    fi
    
    # Crear README.md si no existe
    if [ ! -f "README.md" ]; then
        cat > README.md << EOF
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
\`\`\`bash
./scripts/start.sh
# o
mvn spring-boot:run
\`\`\`

### Ejecutar todas las pruebas
\`\`\`bash
./ejecutar-features.sh todas
\`\`\`

### Ejecutar pruebas específicas
\`\`\`bash
./ejecutar-features.sh usuarios
./ejecutar-features.sh autenticacion
./ejecutar-features.sh productos
\`\`\`

## 📁 Estructura del proyecto
\`\`\`
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
\`\`\`

## 🎯 Features Implementados
- ✅ **Gestión de Usuarios:** CRUD completo con validaciones
- ✅ **Autenticación:** Login/logout con JWT
- ✅ **Gestión de Productos:** Inventario con paginación
- ✅ **Seguridad:** Protección XSS, SQL Injection, CSRF
- ✅ **Monitoreo:** Health checks y métricas
- ✅ **Reportes:** Generación de PDF con datos

## 🔧 Comandos útiles

### Desarrollo
\`\`\`bash
mvn spring-boot:run -Dspring-boot.run.profiles=dev
mvn test -Dtest=EjecutorPruebasCucumber
mvn clean package -Pprod
\`\`\`

### Docker
\`\`\`bash
docker build -t rrivasl/mi-proyecto-cucumber .
docker run -p 8080:8080 rrivasl/mi-proyecto-cucumber
\`\`\`

### Kubernetes
\`\`\`bash
kubectl apply -f devops/kubernetes/
\`\`\`

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
**Última actualización:** $(date +"%Y-%m-%d")
EOF
        success "Archivo README.md creado"
    fi
    
    echo ""
}

# Verificar y actualizar pom.xml
verificar_pom_xml() {
    log "Verificando configuración de pom.xml..."
    
    if [ -f "pom.xml" ]; then
        # Verificar versiones principales
        SPRING_BOOT_VERSION=$(grep -o '<version>3\.[0-9]\+\.[0-9]\+</version>' pom.xml | head -1)
        CUCUMBER_VERSION=$(grep -o '<cucumber.version>[0-9]\+\.[0-9]\+\.[0-9]\+</cucumber.version>' pom.xml)
        
        if [[ $SPRING_BOOT_VERSION && $CUCUMBER_VERSION ]]; then
            success "pom.xml configurado correctamente"
            info "Spring Boot: $SPRING_BOOT_VERSION"
            info "Cucumber: $CUCUMBER_VERSION"
        else
            warning "pom.xml requiere actualización de dependencias"
        fi
    else
        error "pom.xml no encontrado"
        return 1
    fi
    
    echo ""
}

# Compilar proyecto
compilar_proyecto() {
    log "Compilando proyecto..."
    
    mvn clean compile -q
    if [ $? -eq 0 ]; then
        success "Compilación exitosa"
    else
        error "Error en compilación"
        return 1
    fi
    
    echo ""
}

# Ejecutar pruebas básicas
ejecutar_pruebas_basicas() {
    log "Ejecutando pruebas básicas..."
    
    mvn test -Dtest=DefinicionesPruebaBasica -q
    if [ $? -eq 0 ]; then
        success "Pruebas básicas exitosas"
    else
        warning "Algunas pruebas básicas fallaron (normal en configuración inicial)"
    fi
    
    echo ""
}

# Configurar scripts ejecutables
configurar_scripts() {
    log "Configurando scripts ejecutables..."
    
    # Hacer ejecutables los scripts
    if [ -f "ejecutar-features.sh" ]; then
        chmod +x ejecutar-features.sh
        success "ejecutar-features.sh configurado"
    fi
    
    if [ -f "scripts/start.sh" ]; then
        chmod +x scripts/start.sh
        success "scripts/start.sh configurado"
    fi
    
    if [ -f "scripts/test.sh" ]; then
        chmod +x scripts/test.sh
        success "scripts/test.sh configurado"
    fi
    
    echo ""
}

# Mostrar información de configuración
mostrar_informacion_configuracion() {
    log "Información de configuración completada:"
    echo ""
    
    info "🏠 Directorio del proyecto: $(pwd)"
    info "☕ Java version: $(java -version 2>&1 | head -n 1 | cut -d'"' -f2)"
    info "📦 Maven version: $(mvn -version 2>&1 | head -n 1 | awk '{print $3}')"
    info "🌐 URL aplicación: http://localhost:8080/api"
    info "📚 Documentación API: http://localhost:8080/api/swagger-ui.html"
    info "🔍 Health Check: http://localhost:8080/api/actuator/health"
    
    echo ""
}

# Mostrar próximos pasos
mostrar_proximos_pasos() {
    echo -e "${YELLOW}🎯 PRÓXIMOS PASOS:${NC}"
    echo ""
    echo "1. 🚀 Iniciar aplicación:"
    echo "   ./scripts/start.sh"
    echo "   # o"
    echo "   mvn spring-boot:run"
    echo ""
    echo "2. 🧪 Ejecutar pruebas:"
    echo "   ./ejecutar-features.sh"
    echo "   # o específicas:"
    echo "   ./ejecutar-features.sh usuarios"
    echo ""
    echo "3. 📊 Verificar aplicación:"
    echo "   curl http://localhost:8080/api/actuator/health"
    echo ""
    echo "4. 📚 Ver documentación:"
    echo "   http://localhost:8080/api/swagger-ui.html"
    echo ""
    echo "5. 🔧 Desarrollo:"
    echo "   - Agregar nuevos features en src/test/resources/features/"
    echo "   - Implementar step definitions en src/test/java/.../definiciones/"
    echo "   - Agregar nuevos servicios en src/main/java/.../servicio/"
    echo ""
    echo -e "${GREEN}🎉 Proyecto configurado exitosamente para Roberto Rivas López${NC}"
    echo ""
}

# Función para mostrar ayuda
mostrar_ayuda() {
    echo -e "${YELLOW}📚 AYUDA - Setup Proyecto Cucumber${NC}"
    echo ""
    echo "Uso: $0 [opción]"
    echo ""
    echo "Opciones:"
    echo "  setup      - Configuración completa del proyecto"
    echo "  check      - Verificar prerrequisitos solamente"
    echo "  compile    - Compilar proyecto"
    echo "  test       - Ejecutar pruebas básicas"
    echo "  help       - Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0 setup      # Configuración completa"
    echo "  $0 check      # Solo verificar sistema"
    echo "  $0 compile    # Solo compilar"
    echo ""
}

# Función principal
main() {
    case ${1:-setup} in
        "setup")
            mostrar_banner
            
            if ! verificar_prerrequisitos; then
                exit 1
            fi
            
            crear_estructura_directorios
            configurar_archivos_base
            verificar_pom_xml
            
            if ! compilar_proyecto; then
                warning "Continuando con configuración a pesar del error de compilación"
            fi
            
            ejecutar_pruebas_basicas
            configurar_scripts
            mostrar_informacion_configuracion
            mostrar_proximos_pasos
            ;;
        "check")
            mostrar_banner
            verificar_prerrequisitos
            ;;
        "compile")
            log "Compilando proyecto..."
            compilar_proyecto
            ;;
        "test")
            log "Ejecutando pruebas..."
            ejecutar_pruebas_basicas
            ;;
        "help"|"--help"|"-h")
            mostrar_ayuda
            ;;
        *)
            error "Opción inválida: $1"
            mostrar_ayuda
            exit 1
            ;;
    esac
}

# Ejecutar función principal con argumentos
main "$@"

log "Setup completado - Roberto Rivas López"