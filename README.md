# Projeto kube-news

### Objetivo
O projeto Kube-news é uma aplicação escrita em NodeJS e tem como objetivo ser uma aplicação de exemplo pra trabalhar com o uso de containers.

### Configuração
Pra configurar a aplicação, é preciso ter um banco de dados Postgre e pra definir o acesso ao banco, configure as variáveis de ambiente abaixo:

DB_DATABASE => Nome do banco de dados que vai ser usado.

DB_USERNAME => Usuário do banco de dados.

DB_PASSWORD => Senha do usuário do banco de dados.

DB_HOST => Endereço do banco de dados.

### Executando localmente via Docker CLI
* Criando a rede
```
docker network create kubenews --driver bridge
```
* Criando volume
```
docker volume create postgres_data 
```
* Executando banco de dados
```
docker container run -d -p 5432:5432 --name dbnews --memory 128MB --cpus 0.25 --mount type=volume,src=postgres_data,dst=/var/lib/postgresql/data --restart always --network kubenews --env POSTGRES_DB=kubenews --env POSTGRES_USER=admin --env POSTGRES_PASSWORD=kub3n3w$ postgres:15.1-alpine
```
* Executando aplicação na pasta src
```
docker container run -d -p 8080:8080 --name appnews --memory 128MB --cpus 0.5 --mount type=bind,src=$PWD,dst=/kube-news --workdir /kube-news --restart always --network kubenews --env DB_HOST=dbnews --env DB_DATABASE=kubenews --env DB_USERNAME=admin --env DB_PASSWORD=kub3n3w$ node:18-alpine sh -c 'npm install && node server.js'

### Executando localmente via Docker Compose
* Instalar dependências
```
npm install
```
* Exportando variáveis
```
export POSTGRES_VERSION=15.1-alpine
export NODE_VERSION=19-alpine
export TAG=v1
```
* Subindo ambiente de desenvolvimento
```
docker-compose up -d
```
### Compose File

```bash
version: "3.9"

services:
  
  dbnews:
    image: postgres:${POSTGRES_VERSION}
    container_name: dbnews
    deploy:
      mode: replicated
      replicas: 1
      resources:
        limits:
          cpus: '0.50'
          memory: '128M'
        reservations:
          cpus: '0.25'
          memory: '64M'  
      restart_policy: 
        condition: always
    ports:
      - 5432:5432
    volumes:
      - postgres_data:/var/lib/postgresql/data  
    environment:
      POSTGRES_DB: kubenews
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: kub3n3w$
    networks:
      - kubenews

  appnews:
    image: mganalistati/kube-news:${TAG}
    build:
      context: ./src
      dockerfile: Dockerfile
      args:
        VERSION: ${NODE_VERSION}   
    container_name: appnews
    depends_on:
      - dbnews
    deploy:
      mode: replicated
      replicas: 1
      resources:
        limits:
          cpus: '0.50'
          memory: '128M'
        reservations:
          cpus: '0.25'
          memory: '64M'
      restart_policy:
        condition: always
    ports:
      - 8080:8080
    volumes:
      - ${PWD}/src:/kube-news
    working_dir: /kube-news
    entrypoint: ["node", "server.js"]  
    environment:
      DB_HOST: dbnews
      DB_DATABASE: kubenews
      DB_USERNAME: admin
      DB_PASSWORD: kub3n3w$
    networks:
      - kubenews

volumes:
  postgres_data:

networks:
  kubenews:
```
