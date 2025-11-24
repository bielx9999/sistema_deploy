# 🚀 GUIA DE DEPLOY - SISTEMA DE LOGÍSTICA

## OPÇÃO 1: Railway (RECOMENDADO - GRATUITO)

### 1. Backend
1. Acesse: https://railway.app
2. Conecte sua conta GitHub
3. Clique "New Project" → "Deploy from GitHub repo"
4. Selecione este repositório
5. Escolha a pasta `backend`
6. Configure as variáveis de ambiente:
   ```
   NODE_ENV=production
   PORT=3002
   JWT_SECRET=sua_chave_secreta_super_segura_aqui_min_32_caracteres_production_2024
   JWT_EXPIRES_IN=7d
   MAX_FILE_SIZE=5242880
   UPLOAD_PATH=./uploads
   EMAIL_HOST=smtp.gmail.com
   EMAIL_PORT=587
   EMAIL_USER=gabrielotv23@gmail.com
   EMAIL_PASS=gpzr dcgb xwrw tqco
   EMAIL_FROM=Sistema de Logística <gabrielotv23@gmail.com>
   MAINTENANCE_EMAIL=thiagomarcell88@gmail.com
   ```

### 2. Banco de Dados (PlanetScale - Gratuito)
1. Acesse: https://planetscale.com
2. Crie conta gratuita
3. Crie database "sistema-logistica"
4. Copie as credenciais e adicione no Railway:
   ```
   DB_HOST=seu_host_planetscale
   DB_PORT=3306
   DB_NAME=sistema_logistica
   DB_USER=seu_usuario
   DB_PASS=sua_senha
   ```

### 3. Frontend (Vercel - Gratuito)
1. Acesse: https://vercel.com
2. Conecte GitHub
3. Importe o repositório
4. Selecione pasta `sistema-logistica`
5. Configure variável:
   ```
   REACT_APP_API_URL=https://seu-backend-railway.up.railway.app/api
   ```

## OPÇÃO 2: Heroku (Pago - $7/mês)

### 1. Backend
```bash
# Instalar Heroku CLI
npm install -g heroku

# Login
heroku login

# Criar app
heroku create seu-app-logistica-backend

# Configurar variáveis
heroku config:set NODE_ENV=production
heroku config:set JWT_SECRET=sua_chave_secreta

# Deploy
git push heroku main
```

### 2. Frontend (Netlify)
1. Acesse: https://netlify.com
2. Arraste a pasta `build` após executar `npm run build`

## OPÇÃO 3: VPS (DigitalOcean - $6/mês)

### 1. Criar Droplet
- Ubuntu 22.04
- $6/mês (1GB RAM)

### 2. Configurar servidor
```bash
# Conectar via SSH
ssh root@seu_ip

# Instalar Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get install -y nodejs

# Instalar PM2
npm install -g pm2

# Clonar repositório
git clone https://github.com/seu-usuario/seu-repo.git
cd seu-repo

# Backend
cd backend
npm install
cp .env.production .env
# Editar .env com suas configurações
pm2 start server.js --name "logistica-backend"

# Frontend
cd ../sistema-logistica
npm install
npm run build
# Servir com nginx ou PM2
```

## ⚡ DEPLOY RÁPIDO (5 MINUTOS)

1. **Railway**: https://railway.app → Deploy backend
2. **PlanetScale**: https://planetscale.com → Criar DB
3. **Vercel**: https://vercel.com → Deploy frontend
4. **Configurar URLs** entre frontend e backend

## 📱 URLs Finais
- **Backend**: `https://seu-app.up.railway.app`
- **Frontend**: `https://seu-app.vercel.app`
- **Banco**: PlanetScale (gerenciado)

## 🔧 Após Deploy
1. Testar: `https://seu-backend/health`
2. Criar usuários de teste
3. Configurar domínio personalizado (opcional)

## 💰 Custos
- **Railway**: Gratuito (500h/mês)
- **PlanetScale**: Gratuito (1GB)
- **Vercel**: Gratuito
- **Total**: R$ 0,00/mês