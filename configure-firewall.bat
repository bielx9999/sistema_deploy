@echo off
echo ========================================
echo  CONFIGURANDO FIREWALL PARA ACESSO MOBILE
echo ========================================
echo.

echo ⚠️  Este script precisa ser executado como Administrador!
echo.

echo [1] Adicionando regra para porta 3000 (Frontend)...
netsh advfirewall firewall add rule name="Sistema Logistica Frontend" dir=in action=allow protocol=TCP localport=3000

echo.
echo [2] Adicionando regra para porta 3002 (Backend)...
netsh advfirewall firewall add rule name="Sistema Logistica Backend" dir=in action=allow protocol=TCP localport=3002

echo.
echo [3] Verificando regras criadas...
netsh advfirewall firewall show rule name="Sistema Logistica Frontend"
netsh advfirewall firewall show rule name="Sistema Logistica Backend"

echo.
echo ========================================
echo  FIREWALL CONFIGURADO!
echo ========================================
echo.
echo Agora você pode acessar o sistema pelo mobile:
echo 📱 http://192.168.2.85:3000
echo.
echo Pressione qualquer tecla para continuar...
pause > nul