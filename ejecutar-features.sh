#!/bin/bash

# Script de ejecución selectiva de features Cucumber
# Autor: Roberto Rivas López
# Curso: Automatización de Pruebas

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Banner del proyecto
mostrar_banner() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════════╗"
    echo "║              🧪 CUCUMBER SPRING BOOT - FEATURES RUNNER           ║"
    echo "║                     👤 Roberto Rivas López                       ║"
    echo "║                  📚 Curso: Automatización de Pruebas             ║"
    echo "╚══════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Mostrar menú de opciones
mostrar_menu() {
    echo -e "${YELLOW}🎯 OPCIONES DE EJECUCIÓN:${NC}"
    echo ""
    echo "1. 🧪 Ejecutar TODAS las pruebas"
    echo "2. 👤 Ejecutar pruebas de USUARIOS"
    echo "3. 🔐 Ejecutar pruebas de AUTENTICACIÓN"
    echo "4. 📦 Ejecutar pruebas de PRODUCTOS"
    echo "5. 🔒 Ejecutar pruebas de SEGURIDAD"
    echo "6. 📊 Ejecutar pruebas de MONITOREO"
    echo "7. 📋 Ejecutar pruebas de REPORTES"
    echo "8. ✅ Ejecutar pruebas BÁSICAS"
    echo "9. 🏷️  Ejecutar por TAGS específicos"
    echo "10. 📄 Ver features disponibles"
    echo "11. 🧹 Limpiar y recompilar proyecto"
    echo "0. ❌ Salir"
    echo ""
}

# Función para ejecutar feature específico
ejecutar_feature() {
    local feature_file=$1
    local descripcion=$2
    
    echo -e "${BLUE}🚀 Ejecutando: ${descripcion}${NC}"
    echo "📁 Archivo: ${feature_file}"
    echo ""
    
    # Verificar si el feature existe
    if [ ! -f "src/test/resources/features/${feature_file}" ]; then
        echo -e "${RED}❌ Error: Feature '${feature_file}' no encontrado${NC}"
        return 1
    fi
    
    # Ejecutar el feature específico
    mvn test -Dtest=EjecutorPruebasCucumber -Dcucumber.filter.name="${feature_file%.*}"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ ${descripcion} - EXITOSO${NC}"
    else
        echo -e "${RED}❌ ${descripcion} - FALLÓ${NC}"
    fi
    echo ""
}

# Función para ejecutar por tags
ejecutar_por_tags() {
    local tags=$1
    local descripcion=$2
    
    echo -e "${BLUE}🚀 Ejecutando por tags: ${descripcion}${NC}"
    echo "🏷️ Tags: ${tags}"
    echo ""
    
    mvn test -Dtest=EjecutorPruebasCucumber -Dcucumber.filter.tags="${tags}"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Pruebas con tags '${tags}' - EXITOSAS${NC}"
    else
        echo -e "${RED}❌ Pruebas con tags '${tags}' - FALLARON${NC}"
    fi
    echo ""
}

# Función para mostrar features disponibles
mostrar_features() {
    echo -e "${YELLOW}📄 FEATURES DISPONIBLES:${NC}"
    echo ""
    
    if [ -d "src/test/resources/features" ]; then
        find src/test/resources/features -name "*.feature" -type f | while read feature; do
            nombre=$(basename "$feature" .feature)
            echo "  📝 ${nombre}.feature"
        done
    else
        echo -e "${RED}❌ Directorio de features no encontrado${NC}"
    fi
    echo ""
}

# Función para limpiar y recompilar
limpiar_proyecto() {
    echo -e "${BLUE}🧹 Limpiando y recompilando proyecto...${NC}"
    
    mvn clean
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Error en limpieza${NC}"
        return 1
    fi
    
    mvn compile
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Error en compilación${NC}"
        return 1
    fi
    
    mvn test-compile
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Error en compilación de tests${NC}"
        return 1
    fi
    
    echo -e "${GREEN}✅ Proyecto limpio y compilado exitosamente${NC}"
    echo ""
}

# Función para ejecutar todas las pruebas
ejecutar_todas() {
    echo -e "${BLUE}🚀 Ejecutando TODAS las pruebas Cucumber${NC}"
    echo ""
    
    mvn test -Dtest=EjecutorPruebasCucumber
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ TODAS las pruebas - EXITOSAS${NC}"
    else
        echo -e "${RED}❌ Algunas pruebas FALLARON${NC}"
    fi
    echo ""
}

# Función para solicitar tags personalizados
solicitar_tags() {
    echo -e "${YELLOW}🏷️ Ingresa los tags a ejecutar:${NC}"
    echo "Ejemplos:"
    echo "  @regresion"
    echo "  @usuarios and @creacion"
    echo "  @regresion or @monitoreo"
    echo "  not @lento"
    echo ""
    read -p "Tags: " tags_input
    
    if [ -n "$tags_input" ]; then
        ejecutar_por_tags "$tags_input" "Tags personalizados"
    else
        echo -e "${RED}❌ No se ingresaron tags${NC}"
    fi
}

# Función principal
main() {
    mostrar_banner
    
    # Verificar que estamos en el directorio correcto
    if [ ! -f "pom.xml" ]; then
        echo -e "${RED}❌ Error: No se encontró pom.xml. Ejecuta desde la raíz del proyecto.${NC}"
        exit 1
    fi
    
    while true; do
        mostrar_menu
        read -p "Selecciona una opción (0-11): " opcion
        
        case $opcion in
            1)
                ejecutar_todas
                ;;
            2)
                ejecutar_feature "gestion_usuarios.feature" "Gestión de Usuarios"
                ;;
            3)
                ejecutar_feature "autenticacion.feature" "Autenticación y Autorización"
                ;;
            4)
                ejecutar_feature "gestion_productos.feature" "Gestión de Productos"
                ;;
            5)
                ejecutar_feature "seguridad_sistema.feature" "Seguridad del Sistema"
                ;;
            6)
                ejecutar_feature "monitoreo_sistema.feature" "Monitoreo del Sistema"
                ;;
            7)
                ejecutar_feature "reportes_sistema.feature" "Reportes del Sistema"
                ;;
            8)
                ejecutar_feature "prueba_basica.feature" "Pruebas Básicas"
                ;;
            9)
                solicitar_tags
                ;;
            10)
                mostrar_features
                ;;
            11)
                limpiar_proyecto
                ;;
            0)
                echo -e "${GREEN}👋 ¡Hasta luego! - Roberto Rivas López${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Opción inválida. Selecciona 0-11.${NC}"
                echo ""
                ;;
        esac
        
        read -p "Presiona Enter para continuar..."
        clear
        mostrar_banner
    done
}

# Verificar si se pasaron argumentos
if [ $# -gt 0 ]; then
    case $1 in
        "todas"|"all")
            mostrar_banner
            ejecutar_todas
            ;;
        "usuarios")
            mostrar_banner
            ejecutar_feature "gestion_usuarios.feature" "Gestión de Usuarios"
            ;;
        "auth"|"autenticacion")
            mostrar_banner
            ejecutar_feature "autenticacion.feature" "Autenticación"
            ;;
        "productos")
            mostrar_banner
            ejecutar_feature "gestion_productos.feature" "Gestión de Productos"
            ;;
        "seguridad")
            mostrar_banner
            ejecutar_feature "seguridad_sistema.feature" "Seguridad"
            ;;
        "monitoreo")
            mostrar_banner
            ejecutar_feature "monitoreo_sistema.feature" "Monitoreo"
            ;;
        "reportes")
            mostrar_banner
            ejecutar_feature "reportes_sistema.feature" "Reportes"
            ;;
        "basico"|"basic")
            mostrar_banner
            ejecutar_feature "prueba_basica.feature" "Pruebas Básicas"
            ;;
        "clean"|"limpiar")
            mostrar_banner
            limpiar_proyecto
            ;;
        "help"|"ayuda")
            mostrar_banner
            echo -e "${YELLOW}📚 AYUDA - Uso del script:${NC}"
            echo ""
            echo "Ejecución interactiva:"
            echo "  ./ejecutar-features.sh"
            echo ""
            echo "Ejecución directa:"
            echo "  ./ejecutar-features.sh todas"
            echo "  ./ejecutar-features.sh usuarios"
            echo "  ./ejecutar-features.sh auth"
            echo "  ./ejecutar-features.sh productos"
            echo "  ./ejecutar-features.sh seguridad"
            echo "  ./ejecutar-features.sh monitoreo"
            echo "  ./ejecutar-features.sh reportes"
            echo "  ./ejecutar-features.sh basico"
            echo "  ./ejecutar-features.sh clean"
            echo ""
            ;;
        *)
            echo -e "${RED}❌ Argumento inválido: $1${NC}"
            echo "Usa: ./ejecutar-features.sh help"
            exit 1
            ;;
    esac
else
    # Ejecutar menú interactivo
    main
fi

echo -e "${BLUE}🏁 Script completado - Roberto Rivas López${NC}"