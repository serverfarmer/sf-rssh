#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



base=/opt/farm/ext/rssh/templates/$OSVER

if [ ! -f $base/rssh.tpl ]; then
	echo "skipping rssh setup, unsupported operating system version"
	exit 1
fi

/opt/farm/ext/packages/utils/install.sh rsync openssh-server

if [ "$OSVER" = "debian-buster" ]; then
	echo "checking for debian package rssh"
	if [ "`dpkg -l rssh 2>/dev/null |grep ^ii`" = "" ]; then
		echo "installing rssh from provided deb package"
		arch=`/opt/farm/ext/system/detect-architecture.sh`
		dpkg -i /opt/farm/ext/rssh/support/packages/rssh_2.3.4-5+deb9u4_$arch.deb
	fi
else
	/opt/farm/ext/packages/utils/install.sh rssh
fi

save_original_config /etc/rssh.conf
install_copy $base/rssh.tpl /etc/rssh.conf

mkdir -p /srv/rsync
