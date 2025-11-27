@echo off
echo ========================================
echo   CONFIGURANDO PARA MOBILE
echo ========================================
echo.

echo [1/5] Parando processos anteriores...
taskkill /f /im node.exe 2>nul
timeout /t 2 >nul

echo [2/5] Verificando IP da maquina...
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do set IP=%%a
set IP=%IP: =%
echo IP encontrado: %IP%

echo [3/5] Configurando backend...
echo NODE_ENV=development > backend\.env
echo PORT=3002 >> backend\.env
echo DB_HOST=localhost >> backend\.env
echo DB_PORT=3306 >> backend\.env
echo DB_NAME=sistema_logistica >> backend\.env
echo DB_USER=root >> backend\.env
echo DB_PASS=Biel2004?? >> backend\.env
echo JWT_SECRET=sua_chave_secreta_super_segura_aqui_min_32_caracteres >> backend\.env
echo JWT_EXPIRES_IN=7d >> backend\.env
echo MAX_FILE_SIZE=5242880 >> backend\.env
echo UPLOAD_PATH=./uploads >> backend\.env
echo FRONTEND_URL=http://%IP%:3000 >> backend\.env
echo EMAIL_HOST=smtp.gmail.com >> backend\.env
echo EMAIL_PORT=587 >> backend\.env
echo EMAIL_USER=gabrielotv23@gmail.com >> backend\.env
echo EMAIL_PASS=gpzr dcgb xwrw tqco >> backend\.env
echo EMAIL_FROM=Sistema de Logística ^<gabrielotv23@gmail.com^> >> backend\.env
echo MAINTENANCE_EMAIL=thiagomarcell88@gmail.com >> backend\.env

echo [4/5] Configurando frontend...
echo REACT_APP_API_URL=http://%IP%:3002/api > sistema-logistica\.env
echo REACT_APP_ENV=development >> sistema-logistica\.env
echo REACT_APP_MAX_FILE_SIZE=5242880 >> sistema-logistica\.env
echo REACT_APP_API_TIMEOUT=60000 >> sistema-logistica\.env

echo [5/5] Iniciando servidores...
start "Backend-Mobile" cmd /k "cd backend && npm run dev"
timeout /t 5 >nul
start "Frontend-Mobile" cmd /k "cd sistema-logistica && set HOST=0.0.0.0 && set PORT=3000 && npm start"

echo.
echo ========================================
echo   MOBILE CONFIGURADO COM SUCESSO!
echo ========================================
echo.
echo TESTE NO NAVEGADOR PRIMEIRO:
echo http://%IP%:3002/health
echo http://%IP%:3000
echo.
echo NO SEU CELULAR, ACESSE:
echo http://%IP%:3000
echo.
echo Certifique-se que o celular esta na mesma rede WiFi!
echo.
pause