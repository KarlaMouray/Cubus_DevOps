# Especifica o provedor Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "docker" {}

# Variáveis principais para facilitar a configuração e reutilização
variable "db_user" {
  description = "Nome de usuário do banco de dados"
  type        = string
}

variable "db_pass" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "Endereço do host do banco de dados"
  type        = string
  default     = "database"
}

variable "db_port" {
  description = "Porta do banco de dados"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

# Módulo de rede: cria redes internas e externas para isolamento
module "network" {
  source = "./modules/network"
}

# Módulo do banco de dados: container do banco com configuração inicial
module "database" {
  source            = "./modules/database"
  db_user           = var.db_user
  db_pass           = var.db_pass
  network_name      = module.network.internal_net_name
  init_script_path  = "../sql/script.sql"
}

# Módulo de backend: configura o container do backend com variáveis do banco
module "backend" {
  source         = "./modules/backend"
  image          = "desafio-tecnico-backend:latest"
  container_name = "backend"
  db_user        = var.db_user
  db_pass        = var.db_pass
  db_host        = var.db_host
  db_port        = var.db_port
  db_name        = var.db_name
  network_name   = module.network.internal_net_name
  depends_on     = [module.database]
}

# Módulo de frontend: configura o container do frontend com redes interna e externa
module "frontend" {
  source                = "./modules/frontend"
  image                 = "desafio-tecnico-frontend:latest"
  container_name        = "frontend"
  external_network_name = module.network.external_net_name
  internal_network_name = module.network.internal_net_name
  depends_on            = [module.backend]
}

# Módulo de Prometheus: configura o monitoramento do Prometheus
module "prometheus" {
  source         = "./modules/prometheus"
  image          = "prom/prometheus:latest"
  container_name = "prometheus"
  config_path    = "../prometheus.yml"
  network_name   = module.network.internal_net_name
}

# Módulo de Grafana: conecta ao Prometheus para visualizações
module "grafana" {
  source         = "./modules/grafana"
  image          = "grafana/grafana:latest"
  container_name = "grafana"
  network_name   = module.network.internal_net_name
  depends_on     = [module.prometheus]
}

# Output opcional para facilitar a visualização das redes e containers
output "internal_network_name" {
  description = "Nome da rede interna criada"
  value       = module.network.internal_net_name
}

output "external_network_name" {
  description = "Nome da rede externa criada"
  value       = module.network.external_net_name
}

output "backend_container" {
  description = "Nome do container do backend"
  value       = module.backend.container_name
}

output "frontend_container" {
  description = "Nome do container do frontend"
  value       = module.frontend.container_name
}
