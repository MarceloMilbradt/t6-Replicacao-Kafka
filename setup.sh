docker exec -it postgres-sink psql -U postgres -d dbestudantes -c "delete from estudantes;"

echo "Waiting for Kafka Connect to start up..."
sleep 5


echo "Creating Kafka Connect connectors..."
curl -X POST -H "Content-Type: application/json" --data @postgres-sink.json http://localhost:8083/connectors
curl -X POST -H "Content-Type: application/json" --data @postgres-connector.json http://localhost:8083/connectors

echo "Registering Avro schema..."
curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" --data '{"schema": "{\"type\":\"record\",\"name\":\"estudantes\",\"namespace\":\"estudantes\",\"fields\":[{\"name\":\"id\",\"type\":\"int\"},{\"name\":\"nome\",\"type\":\"string\"}]}" }' http://localhost:8081/subjects/estudantes/versions
docker-compose stop 
docker-compose up -d
echo "Done!"
docker-compose logs kafka-connect -f 
