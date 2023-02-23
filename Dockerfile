FROM confluentinc/cp-kafka-connect:6.2.1

# Install JDBC connectors for MySQL and Postgres
RUN confluent-hub install --no-prompt debezium/debezium-connector-mysql:1.7.0 \
                          && confluent-hub install --no-prompt debezium/debezium-connector-postgresql:1.7.0