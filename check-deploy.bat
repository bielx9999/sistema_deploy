@echo off
echo ========================================
echo   VERIFICACAO PRE-DEPLOY
echo ========================================
echo.

echo [1/6] Verificando Node.js...
node --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Node.js instalado
    node --version
) else (
    echo ❌ Node.js nao encontrado
    echo Instale: https://nodejs.org
)

echo [2/6] Verificando npm...
npm --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ npm instalado
    npm --version
) else (
    echo ❌ npm nao encontrado
)

echo [3/6] Verificando Git...
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git instalado
    git --version
) else (
    echo ❌ Git nao encontrado
    echo Instale: https://git-scm.com
)

echo [4/6] Verificando dependencias do backend...
cd backend
if exist package.json (
    echo ✅ package.json encontrado
    if exist node_modules (
        echo ✅ node_modules existe
    ) else (
        echo ⚠️  node_modules nao encontrado - execute: npm install
    )
) else (
    echo ❌ package.json nao encontrado
)

echo [5/6] Verificando dependencias do frontend...
cd ..\sistema-logistica
if exist package.json (
    echo ✅ package.json encontrado
    if exist node_modules (
        echo ✅ node_modules existe
    ) else (
        echo ⚠️  node_modules nao encontrado - execute: npm install
    )
) else (
    echo ❌ package.json nao encontrado
)

echo [6/6] Verificando configuracoes...
cd ..\backend
if exist .env.production (
    echo ✅ .env.production encontrado
) else (
    echo ❌ .env.production nao encontrado
)

cd ..\sistema-logistica
if exist .env.production (
    echo ✅ .env.production encontrado (frontend)
) else (
    echo ⚠️  .env.production nao encontrado (frontend)
)

cd ..
echo.
echo ========================================
echo   RESUMO DA VERIFICACAO
echo ========================================
echo.
echo Se todos os itens estao ✅, voce pode prosseguir com o deploy.
echo Se algum item esta ❌, corrija antes de continuar.
echo.
echo Para iniciar o deploy, execute:
echo   deploy-quick.bat
echo.
pause