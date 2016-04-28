

startup.success: consul.service.log btsync.service.log
	echo "success $(date)" > startup.success

consul.service.log: /lib/systemd/system/consul.service /usr/local/bin/consul /etc/consul.d /var/run/consul
	systemctl enable consul
	systemctl start consul
	{ \
	set -e; \
	LOGS=$($(journalctl --no-pager -n 1 -u consul.service)); \
	[ -z "$$LOGS" ]; \
	echo $$LOGS > consul.service.log; \
	}
btsync.service.log: /lib/systemd/system/btsync.service /usr/local/bin/btsync
	systemctl enable btsync
	systemctl start btsync
	{ \
	set -e; \
	LOGS=$($(journalctl --no-pager -n 1 -u btsync.service)); \
	[ -z "$$LOGS" ]; \
	echo $$LOGS > btsync.service.log; \
	}
/lib/systemd/system/consul.service:
	cp resources/consul.service /lib/systemd/system/consul.service
/lib/systemd/system/btsync.service: /etc/btsync.conf
	cp resources/btsync.service /lib/systemd/system/btsync.service
/etc/btsync.conf:
	bin/variables.sh bin/templater.sh templates/btsyncrc.template /etc/btsync.conf
/etc/consul.d:
	mkdir -p /etc/consul.d
/var/run/consul:
	mkdir -p /var/run/consul
/usr/local/bin/consul:
	cp bin/consul /usr/local/bin/consul
/usr/local/bin/btsync:
	cp bin/btsync /usr/local/bin/btsync
