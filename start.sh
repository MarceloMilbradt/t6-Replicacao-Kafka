#!/bin/bash

# Start the services in detached mode

docker-compose rm -f
docker-compose pull
./run.sh

# Wait until Kafka Connect is available
echo "Waiting for Kafka Connect to become available..."
until curl -X GET -i http://localhost:8083/ &> /dev/null; do
    sleep 1
done

# Run the create_connectors.sh script
./setup.sh