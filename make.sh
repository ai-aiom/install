#!/bin/bash

rm -rf packages
rm -rf aiom-install-all.bin

mkdir packages
cp aiom/aiom.bin packages

cd gim-dependence/packages
tar -czvf gim-dependence.tar.gz *
mv gim-dependence.tar.gz ../
cd ..
cat install.sh gim-dependence.tar.gz > gim-dependence.bin
rm -rf gim-dependence.tar.gz
cd ..
mv gim-dependence/gim-dependence.bin packages

cd gim/packages
tar -czvf gim.tar.gz *
mv gim.tar.gz ../
cd ..
cat install.sh gim.tar.gz > gim.bin
rm -rf gim.tar.gz
cd ..
mv gim/gim.bin packages

cd aiom-dependence/packages
tar -czvf aiom-dependence.tar.gz *
mv aiom-dependence.tar.gz ../
cd ..
cat install.sh aiom-dependence.tar.gz > aiom-dependence.bin
rm -rf aiom-dependence.tar.gz 
cd ..
mv aiom-dependence/aiom-dependence.bin packages

cd packages
tar -czvf aiom-install-all.tar.gz *
mv aiom-install-all.tar.gz ../
cd ..
cat install.sh aiom-install-all.tar.gz > aiom-install-all.bin
rm -rf aiom-install-all.tar.gz

