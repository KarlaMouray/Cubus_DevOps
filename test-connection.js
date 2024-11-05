import pkg from 'pg';
const { Client } = pkg;


const client = new Client({
  user: process.env.POSTGRES_USER,
  host: process.env.DB_HOST || 'banco',
  database: process.env.POSTGRES_DB,
  password: process.env.POSTGRES_PASSWORD,
  port: 5432,
});

// Função para conectar ao banco de dados
const connectToDatabase = async () => {
  try {
    await client.connect();
    console.log('Conectado ao banco de dados com sucesso');
  } catch (err) {
    console.error('Erro de conexão ao banco de dados:', err.stack);
  } finally {
    await client.end(); // Garantir que a conexão seja encerrada
  }
};

// Executar a função de conexão
connectToDatabase();
