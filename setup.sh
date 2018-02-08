#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



base=/opt/farm/ext/rssh/templates/$OSVER

if [ ! -f $base/rssh.tpl ]; then
	echo "skipping rssh setup, unsupported operating system version"
	exit 1
fi

/opt/farm/ext/repos/utils/install.sh rsync rssh

save_original_config /etc/rssh.conf
install_copy $base/rssh.tpl /etc/rssh.conf

mkdir -p /srv/rsync
