# 🔧 CORREÇÃO ERRO NPM CI - RAILWAY

## ❌ PROBLEMA
Railway retorna erro ao executar `npm ci` durante o deploy.

## ✅ SOLUÇÕES (Execute em ordem)

### SOLUÇÃO 1: Script Automático
```bash
fix-railway-deploy.bat
```

### SOLUÇÃO 2: Manual
```bash
cd backend
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
git add .
git commit -m "fix: corrige package-lock para Railway"
git push origin main
```

### SOLUÇÃO 3: Configurar Railway
No painel do Railway:

1. **Settings** → **Environment**
2. Adicionar variável:
```
NPM_CONFIG_PRODUCTION=false
```

3. **Settings** → **Build**
4. Configurar:
   - **Build Command**: `npm install --only=production`
   - **Start Command**: `npm start`

### SOLUÇÃO 4: Usar Dockerfile
Criar `backend/Dockerfile`:
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3002
CMD ["npm", "start"]
```

## 🎯 CONFIGURAÇÃO RAILWAY OTIMIZADA

### Variáveis de Ambiente Essenciais
```env
NODE_ENV=production
PORT=3002
NPM_CONFIG_PRODUCTION=false
```

### Build Settings
- **Root Directory**: `backend`
- **Build Command**: `npm install --only=production`
- **Start Command**: `npm start`

## 🔍 VERIFICAR LOGS
1. Railway Dashboard → Seu projeto
2. **Deployments** → Último deploy
3. **View Logs** → Verificar erros

## 🆘 ERROS COMUNS

### "Cannot find module"
```bash
# Limpar tudo e reinstalar
rm -rf node_modules package-lock.json
npm install
```

### "ENOENT: no such file"
```bash
# Verificar se todos os arquivos estão no Git
git status
git add .
git commit -m "fix: adiciona arquivos faltantes"
```

### "Permission denied"
```bash
# No Railway, adicionar variável:
NPM_CONFIG_UNSAFE_PERM=true
```

## ✅ TESTE FINAL
Após correção, verificar:
1. Deploy sem erros
2. Acessar: `https://sua-url.up.railway.app/health`
3. Resposta: `{"status": "OK"}`