docker build -t rabbitmq-ssl --build-arg ADMIN_PASSWORD=12345 .
docker run --restart=on-failure:5 --name rabbitmq-ssl -d -p 5671:5671 -p 15673:15672 -v /var/lib/rabbitmq-docker:/var/lib/rabbitmq -v /var/log/rabbitmq-docker:/var/log/rabbitmq rabbitmq-ssl
rabbitmqadmin -H 192.168.1.240 -P 15673 -u admin -p bDmUFSyD declare user name=agent password=agent tags=management
rabbitmqadmin -H 192.168.1.240 -P 15673 -u admin -p bDmUFSyD declare permission vhost=/ user=agent configure=".*" write=".*" read=".*"

