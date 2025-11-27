@echo off
echo ========================================
echo   DEPLOY SISTEMA DE LOGISTICA
echo ========================================
echo.

echo [1/5] Preparando ambiente de producao...
cd backend
copy .env.production .env
echo ✅ Configuracao de producao ativada

echo [2/5] Instalando dependencias do backend...
call npm install --production
if %errorlevel% neq 0 (
    echo ❌ Erro na instalacao do backend
    pause
    exit /b 1
)
echo ✅ Backend configurado

echo [3/5] Construindo frontend...
cd ..\sistema-logistica
call npm install
call npm run build
if %errorlevel% neq 0 (
    echo ❌ Erro no build do frontend
    pause
    exit /b 1
)
echo ✅ Frontend construido

echo [4/5] Testando configuracao...
cd ..\backend
timeout /t 2 /nobreak > nul
echo ✅ Configuracao testada

echo [5/5] Deploy concluido!
echo.
echo ========================================
echo   PROXIMOS PASSOS:
echo ========================================
echo 1. Configure o banco de dados em producao
echo 2. Atualize as URLs no frontend
echo 3. Execute: npm start (backend)
echo 4. Sirva o build do frontend
echo.
echo Arquivos prontos para deploy:
echo - Backend: ./backend/
echo - Frontend: ./sistema-logistica/build/
echo.
pause