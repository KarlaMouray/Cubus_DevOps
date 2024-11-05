# Desafio Técnico - Cubos DevOps

Este repositório contém um setup containerizado para um ambiente seguro e isolado utilizando Docker, Docker Compose e Terraform. O projeto inclui um frontend, backend, banco de dados PostgreSQL, além de ferramentas de monitoramento como Prometheus e Grafana. Todos os componentes estão configurados para operar em redes separadas, garantindo que o backend seja acessível apenas pelo frontend e pelo banco de dados.

## Estrutura do Repositório

CUBOS_DevOps/
├── backend/               # Código fonte do backend
│   ├── Dockerfile         # Configuração do contêiner do backend
│   └── ...
├── frontend/              # Código fonte do frontend
│   ├── Dockerfile         # Configuração do contêiner do frontend
│   └── ...
├── database/              # Scripts de configuração do banco de dados
│   ├── init.sql           # Script de inicialização do banco de dados
│   └── ...
├── terraform/             # Configurações do Terraform
│   ├── main.tf            # Arquivo principal de configuração do Terraform
│   └── ...
├── prometheus.yml         # Configuração do Prometheus
└── docker-compose.yml     # Configuração do Docker Compose


## Tecnologias Utilizadas

- **Docker**: Para criar e gerenciar contêineres.
- **Docker Compose**: Para orquestrar múltiplos contêineres.
- **Terraform**: Para provisionar e gerenciar a infraestrutura como código.
- **PostgreSQL**: Banco de dados relacional.
- **Prometheus**: Sistema de monitoramento e alerta.
- **Grafana**: Plataforma de visualização e análise de dados.

## Instalação

Para configurar o ambiente localmente, siga os passos abaixo:

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/KarlaMouray/CUBOS_DevOps.git
   cd CUBOS_DevOps

 2.**Configuração de Ambiente Crie um arquivo .envna raiz do projeto e adicione as variáveis ​​de ambiente necessárias**:

texto simples

Copiar código
DB_USER=username
DB_PASS=password
DB_HOST=postgres
DB_PORT=5432
DB_NAME=desafio
⚠️ Certifique-se de que esses valores correspondem aos usados ​​em variables.tf.

3.**Construa as Imagens Docker Antes de iniciar a orquestração com o Terraform, construa as imagens Docker com o Docker Compose**:



Copiar código
docker-compose build
Esse comando garantirá que as imagens frontend-imagee backend-imageestejam prontas para serem utilizadas pelo Terraform.

4.**Setup da Infraestrutura com Terraform Navegue até a pasta terraforme inicialize o Terraform para configurar as redes, volumes e contêineres**:



Copiar código
cd terraform
terraform init
terraform apply
Este comando irá configurar:

5.**Redes : external-nete internal-netpara isolamento seguro**.

Containers : Containers para frontend, backend e PostgreSQL conectados às redes especificadas.
Acesse a aplicação A aplicação estará disponível nos seguintes endereços:

Frontend : http ://localhost
Backend : Acessível apenas via rota /apiatravés do frontend.

6.**Monitoramento e Observabilidade As ferramentas de monitoramento estão definidas da seguinte forma**:

Prometheus : Acesse em http ://localhost :9090 . O Prometheus está configurado para coleta de análises do backend.
Grafana : Acesse em http ://localhost :3000 . Utilize as seguintes credenciais padrão para login:
Usuário:admin
Senha:admin

7.**Verifique a Inicialização do Banco de Dados O banco de dados PostgreSQL será inicializado com o init.sql, que criará uma tabela userscom um usuário admin pré-configurado**.

8.**Reinicialização Automática Os contêineres estão configurados com restart: always, garantindo que sejam reiniciados automaticamente em caso de falhas inesperadas**.

9.**Verifique as Métricas no Prometheus e Grafana**

**Prometheus** : Verifique se as métricas estão sendo coletadas acessando a interface do Prometheus e consultando as métricas ajustadas.
Digite na barra de pesquisa do Prometheus upe clique em "Execute".

**Grafana** : Configure um dashboard no Grafana adicionando Prometheus como datasource e crie visualizações para monitorar o desempenho dos serviços.
Abra o menu hambúrguer "Home" caso não esteja aberto.
Selecione "Conexões", depois "Adicionar nova conexão", onde você adicionará o Prometheus.
Em Fontes de dados, certifique-se de incluir em "Conexão" uma URL http://prometheus:9090.
Não é necessário criar autenticação ou configurações avançadas, desça até o botão Save & Teste pode salvar.
Você será informado de que agora pode visualizar os dados criando um dashboard ou consultando dados na visualização Explore!

10.**Importando um Dashboard no Grafana Para facilitar a visualização das métricas coletadas pelo Prometheus, você pode importar um Dashboard imediatamente no Grafana**.

No Grafana, no canto superior direito, clique no ícone +e selecione "Import dashboard".
Insira um URL ou o ID de um painel da comunidade.
Clique em “Carregar” e aguarde a importação.
Selecione a fonte de dados configurada (neste caso, Prometheus) e clique em "Importar".
lua



### Dicas de Uso

- Certifique-se de que todos os serviços estejam funcionando corretamente antes de acessar a aplicação.
- Para problemas com a conexão, verifique os logs dos contêineres usando:
  ```bash
  docker-compose logs
