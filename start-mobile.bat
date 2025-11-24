@echo off
echo ========================================
echo   SISTEMA DE LOGISTICA - MODO MOBILE
echo ========================================
echo.

echo [1/3] Copiando configuracao mobile...
copy "sistema-logistica\.env.mobile" "sistema-logistica\.env" >nul

echo [2/3] Iniciando backend...
start "Backend" cmd /k "cd backend && npm run dev"

timeout /t 3 >nul

echo [3/3] Iniciando frontend...
start "Frontend" cmd /k "cd sistema-logistica && set HOST=0.0.0.0 && npm start"

echo.
echo ========================================
echo   ACESSO MOBILE CONFIGURADO!
echo ========================================
echo.
echo Backend: http://192.168.2.81:3002
echo Frontend: http://192.168.2.81:3000
echo.
echo No seu dispositivo mobile, acesse:
echo http://192.168.2.81:3000
echo.
pause