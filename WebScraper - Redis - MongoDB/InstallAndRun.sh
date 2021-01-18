bash InstallMongoDB.sh
sudo apt-get python3
sudo apt-get install python3-pip

pip install bs4
pip install selenium
pip install pymongo
pip install pandas

mongo<<EOF
use admin;
db.createUser(
    {
        user: "admin",
        pwd: "admin",
        roles: ["readWrite", "dbAdmin"]
    }
);
EOF

python3 main.py

echo "Webscraper has been started"
