FROM confluentinc/cp-kafka-connect:6.2.1

# Install JDBC connectors for MySQL and Postgres
RUN confluent-hub install --no-prompt debezium/debezium-connector-postgresql:1.7.0 \
                        && confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.6.3