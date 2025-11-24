@echo off
echo ========================================
echo  SISTEMA LOGÍSTICA - INÍCIO AUTOMÁTICO
echo ========================================

echo [1] Configurando IPs automaticamente...
node auto-config.js

echo.
echo [2] Parando processos anteriores...
taskkill /F /IM node.exe 2>nul
timeout /t 2 >nul

echo [3] Iniciando Backend...
cd backend
start "Backend" cmd /k "npm run dev"
cd ..

echo [4] Aguardando backend...
timeout /t 8 >nul

echo [5] Iniciando Frontend...
cd sistema-logistica
start "Frontend" cmd /k "npm start"
cd ..

echo.
echo ✅ Sistema iniciado com configuração automática!
echo 🌐 Frontend: http://localhost:3000
echo 📡 Backend: http://localhost:3002
echo.
pause