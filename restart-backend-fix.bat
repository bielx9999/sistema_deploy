@echo off
echo ========================================
echo  REINICIANDO BACKEND COM CORREÇÕES
echo ========================================

echo [1] Parando processo atual...
taskkill /F /IM node.exe 2>nul
timeout /t 2 >nul

echo [2] Limpando porta 3002...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3002') do taskkill /F /PID %%a 2>nul
timeout /t 2 >nul

echo [3] Iniciando backend...
cd backend
start "Backend" cmd /k "npm run dev"

echo [4] Aguardando inicialização...
timeout /t 5 >nul

echo [5] Testando conexão...
curl http://localhost:3002/health

echo.
echo ✅ Backend reiniciado!
echo 🌐 URL: http://localhost:3002
echo 🏥 Health: http://localhost:3002/health
echo.
pause