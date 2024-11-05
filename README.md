# Desafio Técnico de Infraestrutura como Código - Ambiente Seguro

Este repositório contém a configuração para um ambiente seguro utilizando infraestrutura como código (IaC). O projeto abrange contêineres Docker, configuração de redes internas e externas, um proxy reverso com Nginx, e variáveis de ambiente, visando a implantação de uma aplicação com frontend, backend e banco de dados desenvolvidos em JavaScript.

Acesse o repositório no GitHub: [cubos-devops/desafio-tecnico](https://github.com/cubos-devops/desafio-tecnico)

## Tecnologias

- Docker
- Node.js
- Express
- MongoDB
- Nginx

## Instruções de Configuração e Execução

### 1. Clonar o Repositório

Primeiro, clone o repositório para sua máquina local com o seguinte comando:

```bash
git clone https://github.com/cubos-devops/desafio-tecnico

##2. Instalar Dependências##
Navegue até o diretório do projeto e instale as dependências com o seguinte comando:

cd desafio-tecnico
npm install

3.Configurar Variáveis ​​de Ambiente
FRONTEND_URL=http://frontend:3000
BACKEND_URL=http://backend:5000
POSTGRES_USER=seu_usuario
POSTGRES_PASSWORD=sua_senha
POSTGRES_DB=seu_banco
DATABASE_URL=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db:5432/${POSTGRES_DB}
DB_HOST=banco
DB_PORT=5432

4.  Iniciar a Aplicação
npm start


