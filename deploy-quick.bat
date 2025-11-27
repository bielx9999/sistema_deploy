@echo off
echo ========================================
echo   DEPLOY RAPIDO - ESCOLHA UMA OPCAO
echo ========================================
echo.
echo 1. Railway + Vercel (GRATUITO - 5 min)
echo 2. Heroku (PAGO - $7/mes)
echo 3. VPS DigitalOcean (PAGO - $6/mes)
echo 4. Preparar arquivos para deploy manual
echo 5. Ver guias detalhados
echo.
set /p choice="Escolha uma opcao (1-5): "

if "%choice%"=="1" goto railway
if "%choice%"=="2" goto heroku
if "%choice%"=="3" goto vps
if "%choice%"=="4" goto manual
if "%choice%"=="5" goto guides
goto invalid

:railway
echo.
echo ========================================
echo   DEPLOY RAILWAY + VERCEL (GRATUITO)
echo ========================================
echo.
echo PASSO 1: Preparando arquivos...
call deploy-production.bat
echo.
echo PASSO 2: Siga o guia detalhado:
echo - Abra: deploy-railway.md
echo - Ou acesse: https://railway.app
echo.
echo URLs necessarias:
echo - Railway: https://railway.app
echo - Vercel: https://vercel.com
echo - GitHub: https://github.com
echo.
pause
goto end

:heroku
echo.
echo ========================================
echo   DEPLOY HEROKU ($7/mes)
echo ========================================
echo.
echo Instalando Heroku CLI...
npm install -g heroku
echo.
echo Comandos para executar:
echo 1. heroku login
echo 2. heroku create seu-app-logistica
echo 3. git push heroku main
echo.
echo Veja o guia completo em: deploy-guide.md
echo.
pause
goto end

:vps
echo.
echo ========================================
echo   DEPLOY VPS ($6/mes)
echo ========================================
echo.
echo Preparando arquivos para VPS...
call deploy-production.bat
echo.
echo Proximo passo:
echo - Abra: deploy-vps.md
echo - Siga o guia passo a passo
echo.
echo Opcoes de VPS:
echo - DigitalOcean: $6/mes
echo - Vultr: $6/mes
echo - Linode: $5/mes
echo.
pause
goto end

:manual
echo.
echo ========================================
echo   PREPARACAO MANUAL
echo ========================================
echo.
echo Executando preparacao...
call deploy-production.bat
echo.
echo Arquivos prontos em:
echo - Backend: ./backend/
echo - Frontend: ./sistema-logistica/build/
echo.
echo Configure seu servidor com estes arquivos.
echo.
pause
goto end

:guides
echo.
echo ========================================
echo   GUIAS DISPONIVEIS
echo ========================================
echo.
echo 1. deploy-railway.md - Railway + Vercel (GRATUITO)
echo 2. deploy-vps.md - VPS completo ($6/mes)
echo 3. deploy-guide.md - Todas as opcoes
echo.
echo Abra os arquivos .md para ver os guias detalhados.
echo.
pause
goto end

:invalid
echo.
echo ❌ Opcao invalida! Escolha entre 1-5.
echo.
pause
goto end

:end
echo.
echo ========================================
echo   DEPLOY CONCLUIDO!
echo ========================================
echo.
echo Proximos passos:
echo 1. Configure o banco de dados
echo 2. Teste a aplicacao
echo 3. Configure dominio (opcional)
echo.
echo Para suporte, consulte os guias .md
echo.
pause