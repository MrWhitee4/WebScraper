#!/bin/bash
set -e

echo "Installing repo"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list


echo "Installing binaries"
apt-get update
apt-get install -y mongodb-org
service mongod stop


echo "Setting up default settings"
rm -rf /var/lib/mongodb/*
cat > /etc/mongod.conf <<'EOF'
storage:
  dbPath: /var/lib/mongodb
  directoryPerDB: true
  journal:
    enabled: true
  engine: "wiredTiger"

systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

net:
  port: 27017
  bindIp: 0.0.0.0
  maxIncomingConnections: 100

replication:
  oplogSizeMB: 128
  replSetName: "rs1"

security:
  authorization: enabled

EOF

service mongod start
sleep 5

mongo admin <<'EOF'
use admin
rs.initiate()
exit
EOF

sleep 5

echo "Adding admin user"
mongo admin <<'EOF'
use admin
rs.initiate()
var user = {
  "user" : "admin",
  "pwd" : "admin",
  roles : [
      {
          "role" : "dbAdmin",
          "db" : "admin"
      }
  ]
}
db.createUser(user);
exit
EOF

echo "Mongo DB successfully installed with an Admin user"