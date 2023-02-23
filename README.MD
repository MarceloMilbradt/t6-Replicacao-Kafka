# Utilizando o Kafka Connect para replicação de dados com PostgreSQL e MySQL

Este Docker Compose foi criado para configurar e executar um ambiente de teste com o PostgreSQL, MySQL e Kafka Connect. Os containers do PostgreSQL e MySQL serão iniciados com uma tabela chamada "estudantes", com duas colunas: "id" (inteiro) e "nome" (varchar).

Para executar o Docker Compose, siga as etapas abaixo:
## Instalação

1. Certifique-se de que o Docker e o Docker Compose estão instalados em seu sistema.

1. Abra o terminal ou prompt de comando e navegue até o diretório onde o arquivo "docker-compose.yml" está salvo.

1. Execute o seguinte comando para iniciar os containers:
```
docker-compose up
```

1. Aguarde até que todos os containers sejam iniciados e configurados. Isso pode levar alguns minutos.

1. Depois que os containers estiverem prontos, você pode testar a conexão com o PostgreSQL e o MySQL usando o cliente de banco de dados de sua preferência.

- Para se conectar ao PostgreSQL, use as seguintes informações de conexão:
``
        Host: localhost
        Porta: 5432
        Usuário: myuser
        Senha: mypassword
        Banco de dados: mydb
``
Ou
```
docker exec -it postgres-container psql -U myuser mydb
```

- Para se conectar ao MySQL, use as seguintes informações de conexão:
`` 
        Host: localhost
        Porta: 3306
        Usuário: root
        Senha: rootpassword
        Banco de dados: mysql
``
Ou
```
docker exec -it mysql-container mysql -u root -p
```
## Testando

1. Conecte-se ao banco de dados PostgreSQL

1. Crie uma nova linha na tabela estudantes executando o seguinte comando SQL:
```
INSERT INTO estudantes (id, nome) VALUES (1, 'Gian');
INSERT INTO estudantes (id, nome) VALUES (2, 'Marcelo');
INSERT INTO estudantes (id, nome) VALUES (3, 'Diogo');
```

1. Conecte-se ao banco de dados MySQL 

1. Consulte a tabela estudantes para verificar se a nova linha foi replicada do banco de dados PostgreSQL para o banco de dados MySQL. Execute o seguinte comando:

```
SELECT * FROM estudantes;
```
