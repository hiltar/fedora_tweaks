#!/bin/bash

cd $HOME
rpmdev-setuptree
dnf download --source mesa
sudo dnf builddep mesa
rpm --install *.src.rpm
cd $HOME/rpmbuild/SPECS

sed '/^%meson \\/a \ \ -Dvideo-codecs=h264dec,h264enc,h265dec,h265enc,vc1dec \\' mesa.spec

rpmbuild -bb mesa.spec

cd $HOME/rpmbuild/RPMS

sudo dnf install ./*.rpm