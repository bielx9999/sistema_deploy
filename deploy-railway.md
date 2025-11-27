# 🚀 DEPLOY NO RAILWAY - PASSO A PASSO

## ✅ PRÉ-REQUISITOS
- Conta no GitHub
- Repositório do projeto no GitHub

## 🎯 PASSO 1: PREPARAR REPOSITÓRIO

### 1.1 Subir código para GitHub
```bash
git init
git add .
git commit -m "Deploy: Sistema de Logística v1.0"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/sistema-logistica.git
git push -u origin main
```

## 🚂 PASSO 2: DEPLOY BACKEND NO RAILWAY

### 2.1 Acessar Railway
1. Vá para: https://railway.app
2. Clique em "Login" → "Login with GitHub"
3. Autorize o Railway

### 2.2 Criar Projeto
1. Clique "New Project"
2. Selecione "Deploy from GitHub repo"
3. Escolha seu repositório
4. Selecione a pasta `backend`

### 2.3 Configurar Variáveis de Ambiente
No painel do Railway, vá em "Variables" e adicione:

```env
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

### 2.4 Aguardar Deploy
- O Railway fará o build automaticamente
- Anote a URL gerada (ex: `https://sistema-logistica-production.up.railway.app`)

## 🗄️ PASSO 3: CONFIGURAR BANCO DE DADOS

### 3.1 Opção A: Railway MySQL (Recomendado)
1. No Railway, clique "New" → "Database" → "MySQL"
2. Copie as credenciais geradas
3. Adicione as variáveis no backend:
```env
DB_HOST=containers-us-west-xxx.railway.app
DB_PORT=6543
DB_NAME=railway
DB_USER=root
DB_PASS=senha_gerada_pelo_railway
```

### 3.2 Opção B: PlanetScale (Gratuito)
1. Acesse: https://planetscale.com
2. Crie conta → "Create database" → "sistema-logistica"
3. Vá em "Connect" → Copie as credenciais
4. Adicione no Railway:
```env
DB_HOST=aws.connect.psdb.cloud
DB_PORT=3306
DB_NAME=sistema-logistica
DB_USER=usuario_gerado
DB_PASS=senha_gerada
```

### 3.3 Inicializar Banco
1. No Railway, vá em "Deployments"
2. Clique nos "..." → "View Logs"
3. Aguarde a inicialização automática

## 🌐 PASSO 4: DEPLOY FRONTEND

### 4.1 Opção A: Vercel (Recomendado)
1. Acesse: https://vercel.com
2. "Login with GitHub"
3. "New Project" → Selecione seu repositório
4. Configure:
   - **Root Directory**: `sistema-logistica`
   - **Build Command**: `npm run build`
   - **Output Directory**: `build`

### 4.2 Configurar Variável de Ambiente
```env
REACT_APP_API_URL=https://sua-url-railway.up.railway.app/api
```

### 4.3 Opção B: Netlify
1. Acesse: https://netlify.com
2. Arraste a pasta `sistema-logistica/build` após executar `npm run build`

## 🔗 PASSO 5: CONECTAR FRONTEND E BACKEND

### 5.1 Atualizar CORS no Backend
No Railway, adicione a variável:
```env
FRONTEND_URL=https://sua-url-vercel.vercel.app
```

### 5.2 Testar Conexão
1. Acesse: `https://sua-url-railway.up.railway.app/health`
2. Deve retornar: `{"status": "OK", "timestamp": "..."}`

## ✅ PASSO 6: VERIFICAÇÃO FINAL

### 6.1 URLs Finais
- **Backend**: `https://sistema-logistica-production.up.railway.app`
- **Frontend**: `https://sistema-logistica.vercel.app`
- **Banco**: Railway MySQL ou PlanetScale

### 6.2 Testes
1. Acesse o frontend
2. Teste login com usuários padrão:
   - **Gerente**: `gerente` / `123`
   - **Assistente**: `assistente` / `123`
   - **Motorista**: `motorista` / `123`

## 💰 CUSTOS
- **Railway**: Gratuito (500h/mês)
- **Vercel**: Gratuito
- **PlanetScale**: Gratuito (1GB)
- **Total**: R$ 0,00/mês

## 🆘 SOLUÇÃO DE PROBLEMAS

### Build Error
```bash
# Limpar cache
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

### Erro de CORS
- Verificar FRONTEND_URL no backend
- Verificar REACT_APP_API_URL no frontend

### Erro de Banco
- Verificar credenciais
- Testar conexão: `npm run test-connection`

## 📞 SUPORTE
- Railway: https://railway.app/help
- Vercel: https://vercel.com/support
- PlanetScale: https://planetscale.com/docs