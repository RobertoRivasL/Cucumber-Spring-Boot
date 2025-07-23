#!/bin/bash

# Script para configurar permisos ejecutables
# Autor: Roberto Rivas López
# Curso: Automatización de Pruebas

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔧 Configurando permisos ejecutables - Roberto Rivas López${NC}"
echo ""

# Lista de archivos que deben ser ejecutables
archivos_ejecutables=(
    "setup-proyecto.sh"
    "ejecutar-features.sh"
    "configurar-permisos.sh"
    "scripts/start.sh"
    "scripts/test.sh"
    "final.sh"
)

# Función para hacer ejecutable un archivo
hacer_ejecutable() {
    local archivo=$1
    
    if [ -f "$archivo" ]; then
        chmod +x "$archivo"
        echo -e "${GREEN}✅${NC} $archivo - Permisos configurados"
    else
        echo -e "${YELLOW}⚠️${NC} $archivo - Archivo no encontrado"
    fi
}

echo "📋 Configurando permisos para scripts..."
echo ""

# Configurar permisos para cada archivo
for archivo in "${archivos_ejecutables[@]}"; do
    hacer_ejecutable "$archivo"
done

echo ""
echo -e "${BLUE}📊 Verificación final:${NC}"

# Verificar que los archivos principales existan y sean ejecutables
archivos_principales=(
    "setup-proyecto.sh"
    "ejecutar-features.sh"
)

todo_ok=true

for archivo in "${archivos_principales[@]}"; do
    if [ -f "$archivo" ] && [ -x "$archivo" ]; then
        echo -e "${GREEN}✅${NC} $archivo - OK"
    else
        echo -e "${RED}❌${NC} $archivo - PROBLEMA"
        todo_ok=false
    fi
done

echo ""

if [ "$todo_ok" = true ]; then
    echo -e "${GREEN}🎉 Todos los permisos configurados correctamente${NC}"
    echo ""
    echo -e "${YELLOW}Próximos pasos:${NC}"
    echo "1. ./setup-proyecto.sh        # Configurar proyecto completo"
    echo "2. ./ejecutar-features.sh     # Ejecutar pruebas Cucumber"
    echo ""
else
    echo -e "${RED}❌ Algunos archivos requieren atención${NC}"
    echo ""
fi

echo -e "${BLUE}🏁 Configuración de permisos completada${NC}"