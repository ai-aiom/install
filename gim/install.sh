# cat install.sh 
#!/bin/bash
install_dir=/home/gim--install
if [[ -e $install_dir ]];then
    rm -rf $install_dir/*
else
    mkdir -p $install_dir
fi
sed -n '1,/^exit 0$/!p' $0 >$install_dir/gim.tar.gz

cd $install_dir
tar -xzvf gim.tar.gz

path=$(pwd)
mysql -uroot << EOF
source $path/sql/create_database.sql;
EOF

chmod 755 *.bin
./gim-auth.bin
./gim-deploy.bin
./gim-monitor.bin
./gim-site.bin
./gim-server-manager.bin

rm -rf $install_dir

exit 0
