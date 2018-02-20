#/bin/sh
MONGODB_BIN=/opt/mongodb/mongodb-linux-x86_64-enterprise-ubuntu1604-3.6.2/bin

killall mongod && sleep 3
mv env/.gitignore ./_gitignore
rm -rf env
mkdir -p env/r0/log env/r1/log env/r2/log
$MONGODB_BIN/mongod --replSet TestRS --port 27000 --dbpath env/r0 --fork --logpath env/r0/log/mongod.log --smallfiles --oplogSize 128
$MONGODB_BIN/mongod --replSet TestRS --port 27001 --dbpath env/r1 --fork --logpath env/r1/log/mongod.log --smallfiles --oplogSize 128
$MONGODB_BIN/mongod --replSet TestRS --port 27002 --dbpath env/r2 --fork --logpath env/r2/log/mongod.log --smallfiles --oplogSize 128
mv _gitignore env/.gitignore
sleep 3

$MONGODB_BIN/mongo --port 27000 <<EOF
    rs.initiate({_id: "TestRS", members: [
        {_id: 0, host: "localhost:27000"},
        {_id: 1, host: "localhost:27001"},
        {_id: 2, host: "localhost:27002"}
    ]});
EOF

echo
echo "Mongo Shell command to connect to replica set:"
echo
echo "$MONGODB_BIN/mongo mongodb://localhost:27000,localhost:27001,localhost:27002/?replicaSet=TestRS"
echo 
