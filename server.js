const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000; // Corrigido para 3000, não 3.000

// Middleware
app.use(cors());
app.use(express.json());

// Conectar ao MongoDB (substitua 'sua_string_de_conexão' pela sua string de conexão do MongoDB)
mongoose.connect('sua_string_de_conexão', { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Conectado ao MongoDB'))
    .catch(err => console.error('Erro ao conectar ao MongoDB', err));

// Rota de teste
app.get('/', (req, res) => {
    res.send('API está funcionando!');
});

// Iniciar o servidor
app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`); // Corrigido para usar crase
});
