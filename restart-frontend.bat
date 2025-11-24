@echo off
echo ========================================
echo  REINICIANDO FRONTEND COM CORREÇÕES
echo ========================================

echo [1] Parando frontend atual...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3000') do taskkill /F /PID %%a 2>nul
timeout /t 3 >nul

echo [2] Iniciando frontend...
cd sistema-logistica
start "Frontend" cmd /k "npm start"

echo [3] Aguardando inicialização...
timeout /t 10 >nul

echo ✅ Frontend reiniciado!
echo 🌐 URL: http://localhost:3000
echo 📡 API: http://localhost:3002/api
echo.
pause