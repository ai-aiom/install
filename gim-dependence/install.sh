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

rpm -Uvh mysql-libs-5.1.73-5.el6_6.x86_64.rpm
rpm -ivh apr-1.3.9-5.el6_2.x86_64.rpm
rpm -ivh dejavu-lgc-sans-mono-fonts-2.30-2.el6.noarch.rpm
rpm -ivh dejavu-sans-mono-fonts-2.30-2.el6.noarch.rpm
rpm -ivh erlang-17.4-1.el6.x86_64.rpm
rpm -ivh libconfuse-2.7-4.el6.x86_64.rpm
rpm -ivh ganglia-3.7.1-2.el6.x86_64.rpm
rpm -ivh rrdtool-1.3.8-7.el6.x86_64.rpm
rpm -ivh ganglia-gmetad-3.7.1-2.el6.x86_64.rpm
rpm -ivh mysql-5.1.73-5.el6_6.x86_64.rpm
rpm -ivh perl-DBD-MySQL-4.013-3.el6.x86_64.rpm
rpm -ivh mysql-server-5.1.73-5.el6_6.x86_64.rpm
rpm -ivh rabbitmq-server-3.5.3-1.noarch.rpm

cp my.cnf /etc

service mysqld start

rabbitmq-plugins enable rabbitmq_management
service rabbitmq-server start
rabbitmqctl add_user gim gim
rabbitmqctl set_user_tags gim administrator
rabbitmqctl add_vhost gim
rabbitmqctl set_permissions -p gim gim '.*' '.*' '.*'

mysql_secure_installation

rm -rf $install_dir

exit 0
