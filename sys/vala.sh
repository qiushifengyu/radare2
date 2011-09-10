#!/bin/sh

# find root
cd `dirname $PWD/$0`

mkdir -p _work
cd _work

valac --help 2>&1 >/dev/null
if [ ! $? = 0 ]; then
	# must install from tarball
	VV=0.13.4
	SV=$(echo ${VV}|cut -d . -f 1,2)
	if [ ! -d vala-${VV} ]; then
		wget http://download.gnome.org/sources/vala/${SV}/vala-${VV}.tar.bz2
		tar xjvf vala-${VV}.tar.bz2
	fi
	cd vala-${VV}
	./configure --prefix=/usr && \
	make && \
	sudo make install
	cd ..
fi

if [ -d vala ]; then
	cd vala
	sudo make uninstall
	git pull
else
	git clone git://git.gnome.org/vala
fi
sh autogen.sh --prefix=/usr && \
make -j 4 && \
sudo make install
cd ..
