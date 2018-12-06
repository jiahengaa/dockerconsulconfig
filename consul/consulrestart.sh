sudo docker network create --subnet=172.18.0.0/24 staticnet
echo "staticnet: 172.18.0.0/24"

echo "start remove all servers and clients"

sudo docker rm consul_sa1 -f
sudo docker rm consul_sa2 -f
sudo docker rm consul_sa3 -f
sudo docker rm consul_sa4 -f
sudo docker rm consul_sa5 -f
sudo docker rm consul_ca1 -f
sudo docker rm consul_ca2 -f
sudo docker rm consul_ca3 -f
sudo docker rm consul_ca4 -f
sudo docker rm consul_ca5 -f
sudo docker rm consul_ca6 -f

sudo docker rm consul_sb1 -f
sudo docker rm consul_sb2 -f
sudo docker rm consul_sb3 -f
sudo docker rm consul_cb1 -f
sudo docker rm consul_cb2 -f
sudo docker rm consul_cb3 -f
sudo docker rm consul_cb4 -f

echo "start restart all servers and clients"

sudo docker run -d  --name consul_sa1 --net staticnet  --ip 172.18.0.2   -v /opt/config/consul/consul_server_config/basic_config_a1.json:/consul/config/basic_config_a1.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_sa2 --net staticnet  --ip 172.18.0.3   -v /opt/config/consul/consul_server_config/basic_config_a2.json:/consul/config/basic_config_a2.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_sa3 --net staticnet  --ip 172.18.0.4   -v /opt/config/consul/consul_server_config/basic_config_a3.json:/consul/config/basic_config_a3.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_sa4 --net staticnet  --ip 172.18.0.5   -v /opt/config/consul/consul_server_config/basic_config_a4.json:/consul/config/basic_config_a4.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_sa5 --net staticnet  --ip 172.18.0.6   -v /opt/config/consul/consul_server_config/basic_config_a5.json:/consul/config/basic_config_a5.json  consul agent -config-dir /consul/config

sudo docker run -d  --name consul_ca1 --net staticnet  --ip 172.18.0.10   -v /opt/config/consul/consul_client_config/basic_config_a1.json:/consul/config/basic_config_a1.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_ca2 --net staticnet  --ip 172.18.0.11   -v /opt/config/consul/consul_client_config/basic_config_a2.json:/consul/config/basic_config_a2.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_ca3 --net staticnet  --ip 172.18.0.12   -v /opt/config/consul/consul_client_config/basic_config_a3.json:/consul/config/basic_config_a3.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_ca4 --net staticnet  --ip 172.18.0.13   -v /opt/config/consul/consul_client_config/basic_config_a4.json:/consul/config/basic_config_a4.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_ca5 --net staticnet  --ip 172.18.0.14   -v /opt/config/consul/consul_client_config/basic_config_a5.json:/consul/config/basic_config_a5.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_ca6 --net staticnet  --ip 172.18.0.15   -v /opt/config/consul/consul_client_config/basic_config_a6.json:/consul/config/basic_config_a6.json  consul agent -config-dir /consul/config

sudo docker run -d  --name consul_sb1 --net staticnet  --ip 172.18.0.21   -v /opt/config/consul/consul_server_config/basic_config_b1.json:/consul/config/basic_config_b1.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_sb2 --net staticnet  --ip 172.18.0.22   -v /opt/config/consul/consul_server_config/basic_config_b2.json:/consul/config/basic_config_b2.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_sb3 --net staticnet  --ip 172.18.0.23   -v /opt/config/consul/consul_server_config/basic_config_b3.json:/consul/config/basic_config_b3.json  consul agent -config-dir /consul/config

sudo docker run -d  --name consul_cb1 --net staticnet  --ip 172.18.0.24   -v /opt/config/consul/consul_client_config/basic_config_b1.json:/consul/config/basic_config_b1.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_cb2 --net staticnet  --ip 172.18.0.25   -v /opt/config/consul/consul_client_config/basic_config_b2.json:/consul/config/basic_config_b2.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_cb3 --net staticnet  --ip 172.18.0.26   -v /opt/config/consul/consul_client_config/basic_config_b3.json:/consul/config/basic_config_b3.json  consul agent -config-dir /consul/config
sudo docker run -d  --name consul_cb4 --net staticnet  --ip 172.18.0.27   -v /opt/config/consul/consul_client_config/basic_config_b4.json:/consul/config/basic_config_b4.json  consul agent -config-dir /consul/config

echo "start connect dt1,dt2"

sudo docker exec consul_sb1 consul join -wan 172.18.0.2
sleep 3s
sudo docker exec consul_sb1 consul join -wan 172.18.0.2
sleep 3s
sudo docker exec consul_sb1 consul join -wan 172.18.0.2
sleep 3s
sudo docker exec consul_sb1 consul join -wan 172.18.0.2

echo "completed!"
echo "visit websit:http://172.18.0.2:8500/ui/dc1/services"

sleep 10s
