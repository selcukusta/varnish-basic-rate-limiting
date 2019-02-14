#!/bin/sh
echo "running apt-get update and installing some packages"
sudo apt-get update 
sudo apt-get install -y language-pack-en
sudo locale-gen en_US.UTF-8
echo "install varnish"
sudo apt-get install -y pkg-config \
    libvarnishapi-dev \
    libtool \
    python-docutils \
    automake \
    varnish \
    git
echo "copy required files & create directories"
sudo cp -f /vagrant/configurations/default.vcl /etc/varnish/default.vcl
sudo mkdir -p /var/lib/cache
sudo cp -f /vagrant/configurations/ip-list.dict /var/lib/cache/ip-list.dict
echo "install tbf module"
cd /tmp
sudo wget ftp://download.gnu.org.ua/release/vmod-tbf/vmod-tbf-2.3.tar.gz
sudo tar -xvzf vmod-tbf-2.3.tar.gz
cd vmod-tbf-2.3/
sudo autoconf &&\
    ./configure &&\
    make install
echo "install dict module"
cd /tmp
sudo wget ftp://download.gnu.org.ua/release/vmod-dict/vmod-dict-latest.tar.gz
sudo tar -xvzf vmod-dict-latest.tar.gz
cd vmod-dict-1.2
sudo sed -i 's/rst2man.py/rst2man/g' src/Makefile.in
sudo sed -i 's/rst2man.py/rst2man/g' src/Makefile.am
sudo autoconf &&\
    ./configure &&\
    make install
sudo systemctl restart varnish
sudo echo 'PKG_CONFIG_PATH=$(pkg-config --variable pc_path pkg-config)' >> ~/.bashrc