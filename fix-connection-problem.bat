@echo off
echo ========================================
echo  CORRIGINDO PROBLEMA DE CONEXÃO
echo ========================================

echo [1] Verificando backend...
curl -s http://localhost:3002/health > nul
if %errorlevel% neq 0 (
    echo ❌ Backend não está respondendo
    echo Iniciando backend...
    cd backend
    start "Backend" cmd /k "npm run dev"
    cd ..
    timeout /t 5 >nul
) else (
    echo ✅ Backend OK
)

echo.
echo [2] Parando frontend para aplicar correções...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3000') do taskkill /F /PID %%a 2>nul
timeout /t 3 >nul

echo [3] Verificando configuração do frontend...
findstr "localhost" sistema-logistica\.env > nul
if %errorlevel% neq 0 (
    echo ❌ Frontend ainda está configurado com IP da rede
    echo Aplicando correção...
    echo # URL da API do backend > sistema-logistica\.env.new
    echo REACT_APP_API_URL=http://localhost:3002/api >> sistema-logistica\.env.new
    echo. >> sistema-logistica\.env.new
    echo # Configurações de desenvolvimento >> sistema-logistica\.env.new
    echo REACT_APP_ENV=development >> sistema-logistica\.env.new
    echo. >> sistema-logistica\.env.new
    echo # Configurações de upload >> sistema-logistica\.env.new
    echo REACT_APP_MAX_FILE_SIZE=5242880 >> sistema-logistica\.env.new
    echo. >> sistema-logistica\.env.new
    echo # Configurações de timeout >> sistema-logistica\.env.new
    echo REACT_APP_API_TIMEOUT=30000 >> sistema-logistica\.env.new
    
    move sistema-logistica\.env.new sistema-logistica\.env
    echo ✅ Configuração corrigida
) else (
    echo ✅ Frontend já configurado corretamente
)

echo.
echo [4] Iniciando frontend com configurações corretas...
cd sistema-logistica
start "Frontend" cmd /k "npm start"
cd ..

echo.
echo [5] Aguardando inicialização...
timeout /t 10 >nul

echo.
echo ========================================
echo  ✅ CORREÇÃO APLICADA COM SUCESSO!
echo ========================================
echo.
echo 🌐 Frontend: http://localhost:3000
echo 📡 Backend:  http://localhost:3002
echo 🏥 Health:   http://localhost:3002/health
echo.
echo Agora tente fazer o cadastro novamente!
echo.
pause