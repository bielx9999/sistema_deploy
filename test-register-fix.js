const axios = require('axios');

const API_URL = 'http://localhost:3002/api';

console.log('🔍 TESTANDO CADASTRO DE FUNCIONÁRIO...\n');

async function testRegister() {
    try {
        console.log('1️⃣ Testando conexão com backend...');
        const health = await axios.get('http://localhost:3002/health');
        console.log('✅ Backend OK:', health.data.status);
        
        console.log('\n2️⃣ Testando cadastro de funcionário...');
        const userData = {
            nome: 'João Teste',
            matricula: 'TEST' + Date.now(),
            senha: '123456',
            perfil: 'Motorista',
            telefone: '11999999999'
        };
        
        const response = await axios.post(`${API_URL}/auth/register`, userData);
        
        console.log('✅ CADASTRO REALIZADO COM SUCESSO!');
        console.log('Usuário:', response.data.data.user.nome);
        console.log('Matrícula:', response.data.data.user.matricula);
        console.log('Token:', response.data.data.token ? 'Gerado' : 'Não gerado');
        
        // Limpar usuário de teste
        console.log('\n3️⃣ Limpando usuário de teste...');
        // Aqui você pode adicionar código para remover o usuário de teste se necessário
        
    } catch (error) {
        console.log('❌ ERRO NO CADASTRO:');
        if (error.response) {
            console.log('Status:', error.response.status);
            console.log('Mensagem:', error.response.data.message || error.response.data);
            if (error.response.data.errors) {
                console.log('Erros de validação:', error.response.data.errors);
            }
        } else if (error.request) {
            console.log('❌ ERRO DE CONEXÃO - Frontend não consegue acessar o backend');
            console.log('Verifique se:');
            console.log('- Backend está rodando em http://localhost:3002');
            console.log('- Frontend está configurado para http://localhost:3002/api');
            console.log('- Não há bloqueio de firewall');
        } else {
            console.log('Erro:', error.message);
        }
    }
}

testRegister();