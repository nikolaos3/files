sudo fallocate -l 1G /swap
sudo mkswap /swap
sudo swapon /swap
echo '/swap swap swap defaults 0 0' | sudo tee -a /etc/fstab
echo 127.0.0.1 $(hostname) | sudo tee -a /etc/hosts
sudo rm -rf /dev/shm
sudo mkdir /dev/shm
sudo mount -t tmpfs shmfs -o size=4096m /dev/shm
sudo cp /vagrant/60-oracle.conf /etc/sysctl.d/
sudo service procps start

sudo apt-get update
sudo apt-get install -y htop mc libaio1 alien language-pack-ru
sudo ln -s /usr/bin/awk /bin/awk
sudo mkdir /var/lock/subsys
sudo touch /var/lock/subsys/listener
sudo alien -i --scripts /vagrant/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm
sudo /etc/init.d/oracle-xe confugure responseFile=/vagrant/xe.rsp

echo . /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh >> ./.profile
source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh

sudo -i -u oracle
source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
sqlplus "/ as sysdba" @/vagrant/lng.sql

