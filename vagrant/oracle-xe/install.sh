sudo fallocate -l 1G /swap
sudo mkswap /swap
sudo swapon /swap
echo '/swap swap swap defaults 0 0' | sudo tee -a /etc/fstab
echo 127.0.0.1 $(hostname) | sudo tee -a /etc/hosts

# sysctl
sudo cp /vagrant/60-oracle.conf /etc/sysctl.d/
sudo service procps start

# /dev/shm
sudo cp /vagrant/oracle-shm /etc/init.d/
sudo chmod 755 /etc/init.d/oracle-shm
sudo update-rc.d oracle-shm defaults 01 99
sudo service oracle-shm start

sudo apt-get update
sudo apt-get install -y libaio1 alien language-pack-ru unrar
sudo ln -s /usr/bin/awk /bin/awk
sudo mkdir /var/lock/subsys
sudo touch /var/lock/subsys/listener
sudo alien -i --scripts /vagrant/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm
sudo /etc/init.d/oracle-xe confugure responseFile=/vagrant/xe.rsp
sudo update-rc.d oracle-xe defaults 99

echo . /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh >> ./.profile
source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh

# change database language
sudo -u oracle ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe ORACLE_SID=XE /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "/ as sysdba" @/vagrant/dropdb.sql
cp /vagrant/initXE.ora /u01/app/oracle/product/11.2.0/xe/dbs
unrar x /vagrant/xsl.rar /u01/app/oracle/product/11.2.0/xe/rdbms
echo exit | sudo -u oracle ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe ORACLE_SID=XE /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "/ as sysdba" @/vagrant/createdb.sql
echo exit | sudo -u oracle ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe ORACLE_SID=XE /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "/ as sysdba" @/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catalog.sql
echo exit | sudo -u oracle ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe ORACLE_SID=XE /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "/ as sysdba" @/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catblock.sql
echo exit | sudo -u oracle ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe ORACLE_SID=XE /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "/ as sysdba" @/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catproc.sql
echo exit | sudo -u oracle ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe ORACLE_SID=XE /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "/ as sysdba" @/u01/app/oracle/product/11.2.0/xe/rdbms/admin/catoctk.sql
echo exit | sudo -u oracle ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe ORACLE_SID=XE /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "/ as sysdba" @/u01/app/oracle/product/11.2.0/xe/sqlplus/admin/pupbld.sql
echo exit | sudo -u oracle ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe ORACLE_SID=XE /u01/app/oracle/product/11.2.0/xe/bin/sqlplus "/ as sysdba" @/vagrant/restart.sql

exit

