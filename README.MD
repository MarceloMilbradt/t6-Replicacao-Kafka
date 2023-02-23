# Utilizando o Kafka Connect para replicação de dados com PostgreSQL

- Marcelo 
- Gian
- Diogo

Este Docker Compose foi criado para configurar e executar um ambiente de teste com o PostgreSQL e Kafka Connect. Os containers do postgres-source e postgres-sink e  serão iniciados com uma tabela chamada "estudantes", com duas colunas: "id" (inteiro) e "nome" (varchar).

Os dados inseridos no banco source, serão replicados no banco sink

# Tecnologias e serviços

1. postgres-source: Este serviço é um banco de dados PostgreSQL que serve como a fonte de dados para os dados que serão enviados para o Kafka. Ele é criado usando um Dockerfile personalizado que estende a imagem padrão do PostgreSQL. Ele usa uma série de variáveis ​​de ambiente para definir o nome de usuário, senha, nome do banco de dados e argumentos de inicialização. Ele também mapeia dois volumes para persistir os dados e inicializa o banco de dados com scripts SQL armazenados em uma pasta local.

1. postgres-sink: Este serviço é outro banco de dados PostgreSQL que serve como o destino para os dados que serão consumidos do Kafka. É criado usando o mesmo Dockerfile personalizado que o serviço postgres-source e usa as mesmas variáveis ​​de ambiente. Ele também mapeia dois volumes e inicializa o banco de dados com os mesmos scripts SQL.

1. zookeeper: Este serviço é um servidor do Apache ZooKeeper, que é usado para coordenar e gerenciar clusters do Kafka. Ele é criado a partir de uma imagem oficial do Kafka e expõe a porta 2181 para que outros serviços possam se conectar a ele.

1. kafka: Este serviço é um cluster do Apache Kafka, que é criado a partir da mesma imagem do kafka e depende do serviço zookeeper. Ele usa variáveis ​​de ambiente para configurar vários aspectos do cluster, como o ID do corretor, o endereço do ZooKeeper e as portas nas quais o cluster escuta. Ele expõe a porta 9092 para que outros serviços possam se conectar ao cluster.

1. schemaregistry: Este serviço é um esquema do Confluent Schema Registry, que é usado para armazenar e gerenciar esquemas para mensagens do Kafka. Ele é criado a partir de uma imagem oficial do Confluent e depende do serviço zookeeper. Ele expõe a porta 8081 e usa variáveis ​​de ambiente para configurar sua conexão com o serviço zookeeper e seu nome de host.

1. kafka-connect: Este serviço é o Kafka Connect, que é usado para enviar dados do banco de dados de origem para o tópico do Kafka e de lá para o banco de dados de destino. Ele é criado a partir de um Dockerfile personalizado que inclui uma série de plug-ins necessários. Ele depende dos serviços Kafka, Zookeeper, postgres-source, postgres-sink e schemaregistry e expõe a porta 8083. Ele usa várias variáveis ​​de ambiente para configurar a conexão com o Kafka, o grupo de conexão, o tópico de armazenamento de configuração e os conversores de chave e valor, entre outras coisas. Ele também mapeia uma pasta local que contém arquivos de configuração para conectores.

## Instalação

Para executar o Docker Compose, siga as etapas abaixo:

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
