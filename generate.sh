#!/bin/sh
MONGODB_BIN=/opt/mongodb/mongodb-linux-x86_64-enterprise-ubuntu1604-3.6.3/bin

# Clean up any old environment
killall mongod && sleep 3
rm -rf env/r0 env/r1 env/r2

# Create DB file & log directories for each replica
mkdir -p env/r0/log env/r1/log env/r2/log

# Start the 3 MongoDB replicas then just wait for a few secs for servers to start
$MONGODB_BIN/mongod --replSet TestRS --port 27000 --dbpath env/r0 --fork --logpath env/r0/log/mongod.log
$MONGODB_BIN/mongod --replSet TestRS --port 27001 --dbpath env/r1 --fork --logpath env/r1/log/mongod.log
$MONGODB_BIN/mongod --replSet TestRS --port 27002 --dbpath env/r2 --fork --logpath env/r2/log/mongod.log
sleep 3

# Connect to first replica with Mongo Shell and configre the Replica Set containing the 3 replicas
$MONGODB_BIN/mongo --port 27000 <<EOF
    rs.initiate({_id: "TestRS", members: [
        {_id: 0, host: "localhost:27000"},
        {_id: 1, host: "localhost:27001"},
        {_id: 2, host: "localhost:27002"}
    ], settings: {electionTimeoutMillis: 2000}});
EOF

echo
echo "Mongo Shell command to connect to replica set:"
echo
echo "$MONGODB_BIN/mongo mongodb://localhost:27000,localhost:27001,localhost:27002/?replicaSet=TestRS"
echo
