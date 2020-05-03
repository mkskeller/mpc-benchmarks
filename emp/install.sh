#!/bin/bash

# get readme scripts
git clone https://github.com/emp-toolkit/emp-readme.git

# install tools
bash ./emp-readme/scripts/install_packages.sh
apt-get install -y libboost-{chrono,log,program-options,date-time,thread,system,filesystem,regex,test}1.58-dev

bash ./emp-readme/scripts/install_relic.sh
#EC STRING SIZE
sed -i "s/FB_POLYN:STRING=283/FB_POLYN:STRING=251/" ~/relic/CMakeCache.txt
bash ./emp-readme/scripts/install_emp-tool.sh
bash ./emp-readme/scripts/install_emp-ot.sh

# install semi-honest 2-party circuits
git clone https://github.com/emp-toolkit/emp-sh2pc.git

