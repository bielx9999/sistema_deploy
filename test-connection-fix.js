const axios = require('axios');

// URLs para testar
const BACKEND_URL = 'http://192.168.2.81:3002';
const API_URL = 'http://192.168.2.81:3002/api';

console.log('🔍 TESTANDO CONEXÃO BACKEND...\n');

async function testConnection() {
    try {
        // 1. Testar Health Check
        console.log('1️⃣ Testando Health Check...');
        const healthResponse = await axios.get(`${BACKEND_URL}/health`, { timeout: 5000 });
        console.log('✅ Health Check OK:', healthResponse.data);
        
        // 2. Testar rota de login
        console.log('\n2️⃣ Testando rota de login...');
        try {
            const loginResponse = await axios.post(`${API_URL}/auth/login`, {
                matricula: 'motorista',
                senha: '123'
            }, { timeout: 5000 });
            console.log('✅ Login OK:', loginResponse.data);
        } catch (loginError) {
            if (loginError.response) {
                console.log('⚠️ Rota de login acessível, mas credenciais podem estar incorretas:', loginError.response.status);
            } else {
                console.log('❌ Erro ao acessar rota de login:', loginError.message);
            }
        }
        
        // 3. Testar CORS
        console.log('\n3️⃣ Testando CORS...');
        const corsResponse = await axios.options(`${API_URL}/auth/login`, {
            headers: {
                'Origin': 'http://192.168.2.81:3000',
                'Access-Control-Request-Method': 'POST',
                'Access-Control-Request-Headers': 'Content-Type'
            },
            timeout: 5000
        });
        console.log('✅ CORS OK');
        
    } catch (error) {
        console.log('❌ ERRO DE CONEXÃO:');
        if (error.code === 'ECONNREFUSED') {
            console.log('   - O servidor backend não está rodando na porta 3002');
            console.log('   - Execute: cd backend && npm run dev');
        } else if (error.code === 'ETIMEDOUT') {
            console.log('   - Timeout na conexão');
            console.log('   - Verifique se o IP 192.168.2.81 está correto');
        } else {
            console.log('   - Erro:', error.message);
        }
    }
}

testConnection();