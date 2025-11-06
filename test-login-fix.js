const axios = require('axios');

const API_URL = 'http://localhost:3002/api';

console.log('🔍 TESTANDO LOGIN COM LOCALHOST...\n');

async function testLogin() {
    try {
        console.log('1️⃣ Testando Health Check...');
        const health = await axios.get('http://localhost:3002/health');
        console.log('✅ Backend OK:', health.data.status);
        
        console.log('\n2️⃣ Testando Login...');
        const response = await axios.post(`${API_URL}/auth/login`, {
            matricula: '003',
            senha: '123'
        });
        
        console.log('✅ LOGIN SUCESSO!');
        console.log('Token:', response.data.token ? 'Recebido' : 'Não recebido');
        console.log('Usuário:', response.data.user?.nome || 'N/A');
        
    } catch (error) {
        console.log('❌ ERRO NO LOGIN:');
        if (error.response) {
            console.log('Status:', error.response.status);
            console.log('Mensagem:', error.response.data.message || error.response.data);
        } else {
            console.log('Erro de conexão:', error.message);
        }
    }
}

testLogin();