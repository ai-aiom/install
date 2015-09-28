# cat install.sh 
#!/bin/bash
install_dir=/home/aiom-install-all
if [[ -e $install_dir ]];then
    rm -rf $install_dir/*
else
    mkdir -p $install_dir
fi
sed -n '1,/^exit 0$/!p' $0 >$install_dir/aiom-install-all.tar.gz

cd $install_dir
tar -xzvf aiom-install-all.tar.gz

chmod 755 *.bin
./gim-dependence.bin
./gim.bin
./aiom-dependence.bin
./aiom.bin

rm -rf $install_dir

exit 0
