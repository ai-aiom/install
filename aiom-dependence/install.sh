# cat install.sh 
#!/bin/bash
install_dir=/home/aiom-d-install
if [[ -e $install_dir ]];then
    rm -rf $install_dir/*
else
    mkdir -p $install_dir
fi
sed -n '1,/^exit 0$/!p' $0 >$install_dir/aiom-dependence.tar.gz

cd $install_dir
tar -xzvf aiom-dependence.tar.gz

rm -rf /usr/local/lib/tomcat
cp apache-tomcat-6.0.44.zip /usr/local/lib
cd /usr/local/lib
unzip apache-tomcat-6.0.44.zip
mv apache-tomcat-6.0.44 tomcat
chmod 755 tomcat/bin/*.sh
rm -rf apache-tomcat-6.0.44.zip

rm -rf $install_dir

chkconfig iptables off
chkconfig mysqld on
chkconfig rabbitmq-server on
chkconfig gmond on
chkconfig gmetad on

exit 0
