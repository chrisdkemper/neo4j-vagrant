wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
apt-get -qqy update --fix-missing
apt-get -qqy install neo4j

sudo service neo4j-service stop
sudo cat /vagrant/env/neo4j-server.properties > /etc/neo4j/neo4j-server.properties
sudo service neo4j-service start