const axios = require('axios');

async function testBackend() {
    console.log('🔍 VERIFICANDO STATUS DO BACKEND...\n');
    
    try {
        // 1. Health Check
        console.log('1️⃣ Testando Health Check...');
        const health = await axios.get('http://localhost:3002/health', { timeout: 5000 });
        console.log('✅ Health OK:', health.data.status);
        
        // 2. Testar rota de registro
        console.log('\n2️⃣ Testando rota de registro...');
        try {
            const registerTest = await axios.post('http://localhost:3002/api/auth/register', {
                nome: 'Teste Usuario',
                matricula: 'TEST001',
                senha: '123456',
                perfil: 'Motorista',
                telefone: '11999999999'
            }, { timeout: 5000 });
            console.log('✅ Rota de registro acessível');
        } catch (regError) {
            if (regError.response) {
                console.log('⚠️ Rota acessível, resposta:', regError.response.status, regError.response.data.message);
            } else {
                console.log('❌ Erro na rota de registro:', regError.message);
            }
        }
        
        // 3. Testar CORS
        console.log('\n3️⃣ Testando CORS...');
        const corsHeaders = {
            'Origin': 'http://localhost:3000',
            'Access-Control-Request-Method': 'POST',
            'Access-Control-Request-Headers': 'Content-Type'
        };
        
        try {
            await axios.options('http://localhost:3002/api/auth/register', { 
                headers: corsHeaders,
                timeout: 5000 
            });
            console.log('✅ CORS configurado corretamente');
        } catch (corsError) {
            console.log('⚠️ Possível problema de CORS:', corsError.message);
        }
        
    } catch (error) {
        console.log('❌ BACKEND NÃO ESTÁ RESPONDENDO:');
        console.log('   Erro:', error.message);
        console.log('   Código:', error.code);
        
        if (error.code === 'ECONNREFUSED') {
            console.log('\n🔧 SOLUÇÕES:');
            console.log('   1. Reinicie o backend: cd backend && npm run dev');
            console.log('   2. Verifique se a porta 3002 está livre');
            console.log('   3. Verifique o arquivo .env');
        }
    }
}

testBackend();