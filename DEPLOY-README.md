# 🚀 GUIA DE DEPLOY - SISTEMA DE LOGÍSTICA

## ⚡ INÍCIO RÁPIDO (5 MINUTOS)

### 1. Verificar Pré-requisitos
```bash
check-deploy.bat
```

### 2. Escolher Opção de Deploy
```bash
deploy-quick.bat
```

### 3. Opções Disponíveis
- **Railway + Vercel**: GRATUITO ⭐ (Recomendado)
- **VPS**: $6/mês (Controle total)
- **Heroku**: $7/mês (Simples)

## 🎯 OPÇÃO 1: RAILWAY + VERCEL (GRATUITO)

### ✅ Vantagens
- 100% gratuito
- Deploy automático
- SSL incluído
- Fácil configuração

### 📋 Passo a Passo
1. Execute: `deploy-quick.bat` → Opção 1
2. Siga o guia: `deploy-railway.md`
3. URLs necessárias:
   - [Railway](https://railway.app) - Backend
   - [Vercel](https://vercel.com) - Frontend
   - [PlanetScale](https://planetscale.com) - Banco (opcional)

### ⏱️ Tempo: 5-10 minutos

## 🖥️ OPÇÃO 2: VPS ($6/mês)

### ✅ Vantagens
- Controle total
- Performance dedicada
- Customização completa

### 📋 Passo a Passo
1. Execute: `deploy-quick.bat` → Opção 3
2. Siga o guia: `deploy-vps.md`
3. Provedores recomendados:
   - [DigitalOcean](https://digitalocean.com) - $6/mês
   - [Vultr](https://vultr.com) - $6/mês
   - [Linode](https://linode.com) - $5/mês

### ⏱️ Tempo: 30-45 minutos

## 🔧 ARQUIVOS DE DEPLOY

### Scripts Automatizados
- `check-deploy.bat` - Verificar pré-requisitos
- `deploy-quick.bat` - Menu interativo
- `deploy-production.bat` - Preparar arquivos

### Guias Detalhados
- `deploy-railway.md` - Railway + Vercel (gratuito)
- `deploy-vps.md` - VPS completo
- `deploy-guide.md` - Todas as opções

### Configurações
- `backend/.env.production` - Backend produção
- `sistema-logistica/.env.production` - Frontend produção

## 🌐 URLs FINAIS

### Railway + Vercel
- **Backend**: `https://seu-app.up.railway.app`
- **Frontend**: `https://seu-app.vercel.app`
- **Custo**: R$ 0,00/mês

### VPS
- **Sistema**: `http://SEU_IP_VPS`
- **API**: `http://SEU_IP_VPS/api`
- **Custo**: R$ 30-35/mês

## 🔐 CONFIGURAÇÕES IMPORTANTES

### Variáveis de Ambiente (Backend)
```env
NODE_ENV=production
PORT=3002
DB_HOST=seu_host_banco
DB_USER=seu_usuario
DB_PASS=sua_senha
JWT_SECRET=chave_super_segura_32_caracteres
FRONTEND_URL=https://seu-frontend-url
```

### Variáveis de Ambiente (Frontend)
```env
REACT_APP_API_URL=https://seu-backend-url/api
REACT_APP_ENV=production
```

## ✅ VERIFICAÇÃO PÓS-DEPLOY

### 1. Testar Backend
```
GET https://seu-backend-url/health
Resposta: {"status": "OK"}
```

### 2. Testar Frontend
- Acessar URL do frontend
- Fazer login: `gerente` / `123`
- Verificar dashboard

### 3. Testar Funcionalidades
- ✅ Login/Logout
- ✅ Cadastro de veículos
- ✅ Manutenções
- ✅ Upload de CT-e
- ✅ Dashboard

## 🆘 SOLUÇÃO DE PROBLEMAS

### Erro de CORS
```env
# Backend
FRONTEND_URL=https://url-correta-frontend

# Frontend
REACT_APP_API_URL=https://url-correta-backend/api
```

### Erro de Banco
1. Verificar credenciais
2. Testar conexão
3. Verificar firewall

### Build Error
```bash
# Limpar cache
npm cache clean --force
rm -rf node_modules
npm install
```

## 📞 SUPORTE

### Documentação
- [Railway Docs](https://docs.railway.app)
- [Vercel Docs](https://vercel.com/docs)
- [DigitalOcean Docs](https://docs.digitalocean.com)

### Comunidade
- [Railway Discord](https://discord.gg/railway)
- [Vercel Discord](https://discord.gg/vercel)

## 🎉 PRÓXIMOS PASSOS

### Após Deploy
1. ✅ Configurar domínio personalizado
2. ✅ Configurar SSL (se VPS)
3. ✅ Configurar backup automático
4. ✅ Monitoramento de performance
5. ✅ Configurar alertas

### Melhorias Futuras
- CDN para arquivos estáticos
- Cache Redis
- Load balancer
- Monitoramento avançado

---

**🚀 Deploy realizado com sucesso!**

*Para suporte adicional, consulte os guias detalhados ou abra uma issue no repositório.*