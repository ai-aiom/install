# cat install.sh 
#!/bin/bash
install_dir=/home/gim-dependence-install
if [[ -e $install_dir ]];then
    rm -rf $install_dir/*
else
    mkdir -p $install_dir
fi
sed -n '1,/^exit 0$/!p' $0 >$install_dir/gim-dependence.tar.gz

cd $install_dir
tar -xzvf gim-dependence.tar.gz

rm -rf /etc/yum.repos.d/*
yum install -y mysql/*.rpm
yum install -y rabbitmq/*.rpm
yum install -y ganglia/*.rpm
yum install -y xcat/*.rpm

cp my.cnf /etc

service mysqld start

rabbitmq-plugins enable rabbitmq_management
service rabbitmq-server start
rabbitmqctl add_user gim gim
rabbitmqctl set_user_tags gim administrator
rabbitmqctl add_vhost gim
rabbitmqctl set_permissions -p gim gim '.*' '.*' '.*'

mysql_secure_installation

source /etc/profile.d/xcat.sh
tabch key=master site.value=127.0.0.1
tabch key=nameservers site.value=127.0.0.1
tabch key=domain site.value=aiom
tabch key=xcat passwd.username="root" passwd.password="123456"
tabch key=system passwd.username="root" passwd.password="123456"

rm -rf $install_dir

exit 0
