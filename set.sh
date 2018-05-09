#!/bin/bash
set -e

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
export PATH


#for new system install everythin


get_distribution() {
        lsb_dist=""
        # Every system that we officially support has /etc/os-release
        if [ -r /etc/os-release ]; then
                lsb_dist="$(. /etc/os-release && echo "$ID")"
        fi
        # Returning an empty string here should be alright since the
        # case statements don't act unless you provide an actual value
        echo "$lsb_dist"
}
get_apk() {
apk_install=""
if [ "$lsb_dist" == "centos" ]; then
apk_install="yum"
elif [ "$lsb_dist" == "ubuntu" ];then
apk_install="apt-get"
else
echo -e "i can not lean this system!!"&&exit 1
fi
}
get_distribution
get_apk
######install depend
depend="lrzsz screen iftop htop wget git curl "
$apk_install update&&$apk_install upgrade
$apk_install install -y depend
#######install lnmp
wget http://soft.vpser.net/lnmp/lnmp1.5beta.tar.gz -cO lnmp1.5beta.tar.gz && tar zxf lnmp1.5beta.tar.gz && cd lnmp1.5 && LNMP_Auto="y" DBSelect="2" DB_Root_Password="icui4cu" InstallInnodb="y" PHPSelect="8" SelectMalloc="1" ./install.sh lnmp


#####get docker and docker-compose
curl -sSL https://get.docker.com/ | sh
service docker start
curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
######
#####docker-get GDlist
git clone https://github.com/reruin/gdlist.git&&cd gdlist
docker-compose up -d
#####get aria2-h5ai
git clone https://github.com/wahyd4/aria2-ariang-docker.git&&cd aria2-ariang-x-docker-compose/h5ai/
docker-compose up -d
#####
echo -e "that is all done!!!"



