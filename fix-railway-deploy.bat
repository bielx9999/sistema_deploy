@echo off
echo ========================================
echo   CORRIGINDO ERRO NPM CI - RAILWAY
echo ========================================
echo.

echo [1/4] Limpando cache npm...
cd backend
call npm cache clean --force
echo ✅ Cache limpo

echo [2/4] Removendo node_modules e package-lock...
if exist node_modules rmdir /s /q node_modules
if exist package-lock.json del package-lock.json
echo ✅ Arquivos removidos

echo [3/4] Reinstalando dependencias...
call npm install
if %errorlevel% neq 0 (
    echo ❌ Erro na instalacao
    pause
    exit /b 1
)
echo ✅ Dependencias instaladas

echo [4/4] Criando package-lock.json limpo...
call npm install --package-lock-only
echo ✅ package-lock.json criado

echo.
echo ========================================
echo   CORRECAO CONCLUIDA!
echo ========================================
echo.
echo Agora faça o commit e push:
echo   git add .
echo   git commit -m "fix: corrige package-lock para Railway"
echo   git push origin main
echo.
echo O Railway fara o redeploy automaticamente.
echo.
pause