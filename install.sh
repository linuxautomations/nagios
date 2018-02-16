#!/bin/bash

## Source Common Functions
curl -s "https://raw.githubusercontent.com/linuxautomations/scripts/master/common-functions.sh" >/tmp/common-functions.sh
#source /root/scripts/common-functions.sh
source /tmp/common-functions.sh

## Checking Root User or not.
CheckRoot

## Checking SELINUX Enabled or not.
CheckSELinux

## Checking Firewall on the Server.
CheckFirewall

Stat() {
    if [ $1 -eq 0 ]; then 
        success "$2 -- SUCCESS"
    else 
        error "$2 -- FAILURE"
        exit 1
    fi
}

curl -x https://assets.nagios.com/downloads/nagiosxi/install.sh | bash

exit 
VERSION=$(curl -s https://assets.nagios.com/downloads/nagiosxi/versions.php | html2text | grep tar.gz | awk -F '|' '{print $2}' | head -1 | awk -F '[(,)]' '{print $2}')
URL=https://assets.nagios.com/downloads/nagiosxi/$VERSION
FILE="/opt/$(echo $URL|awk -F / '{print $NF}')"
#DIR="/opt/$(echo $URL|awk -F / '{print $NF}' | sed -e 's/.tar.gz//')"
DIR=/opt/nagiosxi
### Downlaod
wget -q $URL -O $FILE &>/dev/null
Stat $? "Downloading Nagios-XI"

## Extract 
cd /opt
tar xf $FILE &>/dev/null
Stat $? "Extracting Nagios-XI"

## Install
cd $DIR 



