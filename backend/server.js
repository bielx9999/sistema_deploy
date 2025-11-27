require('dotenv').config();
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const compression = require('compression');
const path = require('path');
const db = require('./config/database');

// Importar rotas
const authRoutes = require('./routes/auth.routes');
const userRoutes = require('./routes/user.routes');
const vehicleRoutes = require('./routes/vehicle.routes');
const maintenanceRoutes = require('./routes/maintenance.routes');
const maintenanceHistoryRoutes = require('./routes/maintenanceHistory');
const cteRoutes = require('./routes/ctes.routes');
const dashboardRoutes = require('./routes/dashboard.routes');
const mensagemRoutes = require('./routes/mensagem.routes');

// Middleware de erro
const errorHandler = require('./middleware/errorHandler');

const app = express();
const PORT = process.env.PORT || 3002;

// ============================================
// MIDDLEWARES GLOBAIS
// ============================================

// Segurança - Configurado para mobile
app.use(helmet({
  crossOriginEmbedderPolicy: false,
  contentSecurityPolicy: false
}));

// CORS
// CORS para mobile
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With');
  if (req.method === 'OPTIONS') {
    res.sendStatus(200);
  } else {
    next();
  }
});

// Compressão de respostas
app.use(compression());

// Body parser
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Logger HTTP (apenas em desenvolvimento)
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'));
}

// Servir arquivos estáticos (uploads)
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// ============================================
// HEALTH CHECK
// ============================================

app.get('/health', (req, res) => {
  res.json({
    status: 'OK',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV
  });
});

// ============================================
// ROTAS DA API
// ============================================

app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/vehicles', vehicleRoutes);
app.use('/api/maintenances', maintenanceRoutes);
app.use('/api/maintenance-history', maintenanceHistoryRoutes);
app.use('/api/ctes', cteRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/mensagens', mensagemRoutes);

// Rota 404
app.use('*', (req, res) => {
  res.status(404).json({
    success: false,
    message: 'Rota não encontrada'
  });
});

// ============================================
// MIDDLEWARE DE ERRO (deve ser o último)
// ============================================

app.use(errorHandler);

// ============================================
// CONEXÃO COM BANCO E INICIALIZAÇÃO
// ============================================

const startServer = async () => {
  try {
    // Testar conexão com banco
    await db.authenticate();
    console.log('✅ Conexão com MySQL estabelecida com sucesso');

    // Sincronizar models
    if (process.env.NODE_ENV === 'development') {
      await db.sync({ alter: false });
      console.log('✅ Models sincronizados com o banco de dados');
    } else {
      // Em produção, apenas verificar se as tabelas existem
      await db.sync({ alter: false });
      console.log('✅ Banco de dados verificado');
    }

    // Criar pasta de uploads se não existir
    const fs = require('fs');
    const uploadsDir = path.join(__dirname, 'uploads');
    if (!fs.existsSync(uploadsDir)) {
      fs.mkdirSync(uploadsDir, { recursive: true });
      console.log('✅ Pasta de uploads criada');
    }

    // Iniciar servidor
    const host = process.env.NODE_ENV === 'production' ? '0.0.0.0' : '0.0.0.0';
    app.listen(PORT, host, () => {
      console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      console.log(`🚀 Servidor rodando na porta ${PORT}`);
      console.log(`📍 Ambiente: ${process.env.NODE_ENV || 'development'}`);
      console.log(`🌐 URL Local: http://localhost:${PORT}`);
      console.log(`🌐 URL Rede: http://192.168.2.81:${PORT}`);
      console.log(`🏥 Health: http://192.168.2.81:${PORT}/health`);
      console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    });

  } catch (error) {
    console.error('❌ Erro ao iniciar servidor:', error);
    process.exit(1);
  }
};

// Tratamento de erros não capturados
process.on('unhandledRejection', (err) => {
  console.error('❌ Erro não tratado:', err);
  process.exit(1);
});

process.on('uncaughtException', (err) => {
  console.error('❌ Exceção não capturada:', err);
  process.exit(1);
});

// Graceful shutdown
process.on('SIGTERM', async () => {
  console.log('🛑 SIGTERM recebido. Fechando servidor...');
  await db.close();
  process.exit(0);
});

process.on('SIGINT', async () => {
  console.log('🛑 SIGINT recebido. Fechando servidor...');
  await db.close();
  process.exit(0);
});

// Iniciar servidor
startServer();