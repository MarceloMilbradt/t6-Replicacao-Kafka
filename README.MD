# Utilizando o Kafka Connect para replicação de dados com PostgreSQL

Este Docker Compose foi criado para configurar e executar um ambiente de teste com o PostgreSQL e Kafka Connect. Os containers do postgres-source e postgres-sink e  serão iniciados com uma tabela chamada "estudantes", com duas colunas: "id" (inteiro) e "nome" (varchar).

Os dados inseridos no banco source, serão replicados no banco sink

Para executar o Docker Compose, siga as etapas abaixo:
## Instalação

1. Certifique-se de que o Docker e o Docker Compose estão instalados em seu sistema.

1. Abra o terminal ou prompt de comando e navegue até o diretório onde o arquivo "docker-compose.yml" está salvo.

1. Execute o seguinte comando para iniciar os containers a primeira vez:
```
start.sh
```
- Caso já tenha rodado o start:
```
run.sh
```
- O arquivo ``start.sh`` cria as imagens, e configura o kafka, por isso só precisa ser rodado 1 vez




1. Aguarde até que todos os containers sejam iniciados e configurados. Isso pode levar alguns minutos.

1. Depois que os containers estiverem prontos, você pode testar a conexão com os bancos PostgreSQL usando o cliente de banco de dados de sua preferência.

- Para se conectar ao PostgreSQL - source, use as seguintes informações de conexão:
```
        Host: postgres-source
        Porta: 5432
        Usuário: postgres
        Senha: postgres
        Banco de dados: dbestudantes
```
Ou
```
docker exec -it postgres-source psql -U postgres dbestudantes
```

- Para se conectar ao PostgreSQL - sink, use as seguintes informações de conexão:
``` 
        Host: postgres-sink
        Porta: 5432
        Usuário: postgres
        Senha: postgres
        Banco de dados: dbestudantes
```
Ou
```
docker exec -it postgres-sink psql -U postgres dbestudantes
```
## Testando

1. Conecte-se ao banco de dados PostgreSQL source

1. Crie uma nova linha na tabela estudantes executando o seguinte comando SQL:
```
INSERT INTO estudantes (id, nome) VALUES (1, 'Gian');
INSERT INTO estudantes (id, nome) VALUES (2, 'Marcelo');
INSERT INTO estudantes (id, nome) VALUES (3, 'Diogo');
```

1. Conecte-se ao banco de dados PostgreSQL sink 

1. Consulte a tabela estudantes para verificar se a nova linha foi replicada do banco de dados source para o banco de dados sink. Execute o seguinte comando:
- Pode levar alguns segundos para o dado ser replicado, caso não seja pare os containers com o arquivo ``stop.sh`` e execute o ``run.sh`` novamente.
```
SELECT * FROM estudantes;
```
