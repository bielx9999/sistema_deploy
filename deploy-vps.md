# 🖥️ DEPLOY EM VPS - GUIA COMPLETO

## 🎯 OPÇÕES DE VPS

### 💰 Custos Mensais
- **DigitalOcean**: $6/mês (1GB RAM)
- **Vultr**: $6/mês (1GB RAM)
- **Linode**: $5/mês (1GB RAM)
- **AWS EC2**: $8-12/mês (t3.micro)

## 🚀 PASSO 1: CRIAR VPS

### 1.1 DigitalOcean (Recomendado)
1. Acesse: https://digitalocean.com
2. Crie conta → "Create Droplet"
3. Configurações:
   - **OS**: Ubuntu 22.04 LTS
   - **Plan**: Basic $6/mês (1GB RAM)
   - **Region**: New York ou São Paulo
   - **Authentication**: SSH Key (recomendado)

### 1.2 Configurar SSH
```bash
# Gerar chave SSH (Windows)
ssh-keygen -t rsa -b 4096 -C "seu-email@exemplo.com"

# Copiar chave pública
type %USERPROFILE%\.ssh\id_rsa.pub
```

## 🔧 PASSO 2: CONFIGURAR SERVIDOR

### 2.1 Conectar via SSH
```bash
ssh root@SEU_IP_VPS
```

### 2.2 Atualizar Sistema
```bash
apt update && apt upgrade -y
```

### 2.3 Instalar Node.js
```bash
# Instalar Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get install -y nodejs

# Verificar instalação
node --version
npm --version
```

### 2.4 Instalar MySQL
```bash
# Instalar MySQL
apt install mysql-server -y

# Configurar MySQL
mysql_secure_installation

# Criar banco
mysql -u root -p
CREATE DATABASE sistema_logistica;
CREATE USER 'logistica'@'localhost' IDENTIFIED BY 'senha_forte_123';
GRANT ALL PRIVILEGES ON sistema_logistica.* TO 'logistica'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 2.5 Instalar PM2
```bash
npm install -g pm2
```

### 2.6 Instalar Nginx
```bash
apt install nginx -y
systemctl start nginx
systemctl enable nginx
```

## 📁 PASSO 3: DEPLOY DA APLICAÇÃO

### 3.1 Clonar Repositório
```bash
cd /var/www
git clone https://github.com/SEU_USUARIO/sistema-logistica.git
cd sistema-logistica
```

### 3.2 Configurar Backend
```bash
cd backend
npm install --production

# Criar arquivo .env
nano .env
```

**Conteúdo do .env:**
```env
NODE_ENV=production
PORT=3002

# MySQL Local
DB_HOST=localhost
DB_PORT=3306
DB_NAME=sistema_logistica
DB_USER=logistica
DB_PASS=senha_forte_123

# JWT
JWT_SECRET=sua_chave_secreta_super_segura_aqui_min_32_caracteres_production_2024
JWT_EXPIRES_IN=7d

# Upload
MAX_FILE_SIZE=5242880
UPLOAD_PATH=./uploads

# Frontend URL
FRONTEND_URL=http://SEU_IP_VPS

# Email
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER=gabrielotv23@gmail.com
EMAIL_PASS=gpzr dcgb xwrw tqco
EMAIL_FROM=Sistema de Logística <gabrielotv23@gmail.com>
MAINTENANCE_EMAIL=thiagomarcell88@gmail.com
```

### 3.3 Inicializar Banco
```bash
npm run init-rds
```

### 3.4 Iniciar Backend com PM2
```bash
pm2 start server.js --name "logistica-backend"
pm2 startup
pm2 save
```

### 3.5 Configurar Frontend
```bash
cd ../sistema-logistica
npm install

# Criar .env
nano .env
```

**Conteúdo do .env:**
```env
REACT_APP_API_URL=http://SEU_IP_VPS:3002/api
```

### 3.6 Build Frontend
```bash
npm run build
```

## 🌐 PASSO 4: CONFIGURAR NGINX

### 4.1 Criar Configuração
```bash
nano /etc/nginx/sites-available/sistema-logistica
```

**Conteúdo:**
```nginx
server {
    listen 80;
    server_name SEU_IP_VPS;

    # Frontend
    location / {
        root /var/www/sistema-logistica/sistema-logistica/build;
        index index.html index.htm;
        try_files $uri $uri/ /index.html;
    }

    # Backend API
    location /api {
        proxy_pass http://localhost:3002;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }

    # Uploads
    location /uploads {
        proxy_pass http://localhost:3002;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### 4.2 Ativar Site
```bash
ln -s /etc/nginx/sites-available/sistema-logistica /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
nginx -t
systemctl reload nginx
```

## 🔒 PASSO 5: CONFIGURAR FIREWALL

```bash
# Configurar UFW
ufw allow ssh
ufw allow 'Nginx Full'
ufw --force enable
```

## 🔐 PASSO 6: SSL (OPCIONAL)

### 6.1 Instalar Certbot
```bash
apt install certbot python3-certbot-nginx -y
```

### 6.2 Configurar SSL (se tiver domínio)
```bash
certbot --nginx -d seudominio.com
```

## ✅ PASSO 7: VERIFICAÇÃO

### 7.1 Verificar Serviços
```bash
# Status PM2
pm2 status

# Status Nginx
systemctl status nginx

# Status MySQL
systemctl status mysql

# Logs do backend
pm2 logs logistica-backend
```

### 7.2 Testar Aplicação
1. Acesse: `http://SEU_IP_VPS`
2. Teste login: `gerente` / `123`

## 🔄 PASSO 8: SCRIPTS DE MANUTENÇÃO

### 8.1 Script de Backup
```bash
nano /root/backup.sh
```

```bash
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
mysqldump -u logistica -p sistema_logistica > /root/backup_$DATE.sql
find /root -name "backup_*.sql" -mtime +7 -delete
```

### 8.2 Script de Atualização
```bash
nano /root/update.sh
```

```bash
#!/bin/bash
cd /var/www/sistema-logistica
git pull origin main
cd backend
npm install --production
cd ../sistema-logistica
npm install
npm run build
pm2 restart logistica-backend
systemctl reload nginx
```

### 8.3 Tornar Scripts Executáveis
```bash
chmod +x /root/backup.sh
chmod +x /root/update.sh

# Agendar backup diário
crontab -e
# Adicionar: 0 2 * * * /root/backup.sh
```

## 📊 MONITORAMENTO

### 9.1 PM2 Monitoring
```bash
pm2 install pm2-server-monit
```

### 9.2 Logs
```bash
# Ver logs em tempo real
pm2 logs logistica-backend --lines 100

# Logs do Nginx
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log
```

## 🆘 SOLUÇÃO DE PROBLEMAS

### Backend não inicia
```bash
pm2 logs logistica-backend
# Verificar erros de conexão com banco
```

### Frontend não carrega
```bash
nginx -t
systemctl status nginx
# Verificar configuração do Nginx
```

### Erro de permissão
```bash
chown -R www-data:www-data /var/www/sistema-logistica
chmod -R 755 /var/www/sistema-logistica
```

## 💰 CUSTOS FINAIS
- **VPS**: $6/mês
- **Domínio**: $12/ano (opcional)
- **SSL**: Gratuito (Let's Encrypt)
- **Total**: ~$6-7/mês