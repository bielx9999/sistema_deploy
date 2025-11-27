@echo off
echo ========================================
echo   TESTANDO CONEXAO MOBILE
echo ========================================
echo.

echo [1/3] Verificando IP da maquina...
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do set IP=%%a
set IP=%IP: =%
echo IP: %IP%

echo [2/3] Testando backend...
curl -s http://%IP%:3002/health
if %errorlevel% equ 0 (
    echo ✅ Backend OK
) else (
    echo ❌ Backend com problema
)

echo [3/3] Testando frontend...
curl -s -o nul -w "%%{http_code}" http://%IP%:3000
if %errorlevel% equ 0 (
    echo ✅ Frontend OK
) else (
    echo ❌ Frontend com problema
)

echo.
echo ========================================
echo   URLs PARA MOBILE:
echo ========================================
echo Backend: http://%IP%:3002/health
echo Frontend: http://%IP%:3000
echo.
pause
