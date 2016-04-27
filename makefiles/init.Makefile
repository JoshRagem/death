

startup.success: consul.service.log btsync.service.log

consul.service.log: /lib/systemd/system/consul.service
	systemctl enable consul
	syntemctl start consul
btsync.service.log: /lib/systemd/system/btsync.service
	systemctl enable btsync
	syntemctl start btsync
/lib/systemd/system/consul.service:
  cp ../files/consul.service /lib/systemd/system/consul.service
/lib/systemd/system/btsync.service:
  cp ../files/btsync.service /lib/systemd/system/btsync.service
/usr/local/bin/consul:
	cp ../bin/consul /usr/local/bin/consul
/usr/local/bin/btsync:
	cp ../bin/btsync /usr/local/bin/btsync
