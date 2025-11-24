const os = require('os');
const fs = require('fs');
const path = require('path');

function getLocalIP() {
    const interfaces = os.networkInterfaces();
    for (const name of Object.keys(interfaces)) {
        for (const iface of interfaces[name]) {
            if (iface.family === 'IPv4' && !iface.internal) {
                return iface.address;
            }
        }
    }
    return 'localhost';
}

function updateEnvFiles() {
    const localIP = getLocalIP();
    console.log(`🌐 IP detectado: ${localIP}`);
    
    // Backend .env
    const backendEnv = `# ============================================
# CONFIGURAÇÃO - SISTEMA DE LOGÍSTICA (AUTO)
# ============================================

# Ambiente
NODE_ENV=development

# Servidor
PORT=3002

# MySQL Local
DB_HOST=localhost
DB_PORT=3306
DB_NAME=sistema_logistica
DB_USER=root
DB_PASS=Biel2004??

# JWT
JWT_SECRET=sua_chave_secreta_super_segura_aqui_min_32_caracteres
JWT_EXPIRES_IN=7d

# Upload
MAX_FILE_SIZE=5242880
UPLOAD_PATH=./uploads

# Frontend URL (CORS) - Auto configurado
FRONTEND_URL=http://localhost:3000

# Email
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER=gabrielotv23@gmail.com
EMAIL_PASS=gpzr dcgb xwrw tqco
EMAIL_FROM=Sistema de Logística <gabrielotv23@gmail.com>
MAINTENANCE_EMAIL=thiagomarcell88@gmail.com`;

    // Frontend .env
    const frontendEnv = `# URL da API do backend - Auto configurado
REACT_APP_API_URL=http://localhost:3002/api

# Configurações de desenvolvimento
REACT_APP_ENV=development

# Configurações de upload
REACT_APP_MAX_FILE_SIZE=5242880

# Configurações de timeout
REACT_APP_API_TIMEOUT=30000`;

    // Escrever arquivos
    fs.writeFileSync(path.join(__dirname, 'backend', '.env'), backendEnv);
    fs.writeFileSync(path.join(__dirname, 'sistema-logistica', '.env'), frontendEnv);
    
    console.log('✅ Arquivos .env atualizados para localhost');
}

updateEnvFiles();