#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
# CRON_DIR="/eramba_community/cron"
# mkdir -p ${CRON_DIR} && cp eramba_community/cron/*.sh ${CRON_DIR}/


# ADD TIMER TO SYSTEMD AND ADD SERVICES
cat >/etc/systemd/system/eramaba-daily.service <<EOF
[Unit]
Description=Eramaba daily job runner

[Service]
Type=oneshot
ExecStart=/usr/bin/sh /data/eramba/cron/eramba_daily.sh

[Install]
WantedBy=multi-user.target
EOF


cat >/etc/systemd/system/eramaba-daily.timer <<EOF
[Unit]
Description=Run eramaba-daily.service every day

[Timer]
OnCalendar=*-*-* 00:30:00

[Install]
WantedBy=multi-user.target
EOF


cat >/etc/systemd/system/eramaba-hourly.service <<EOF
[Unit]
Description=Eramaba hourly job runner

[Service]
Type=oneshot
ExecStart=/usr/bin/sh /data/eramba/cron/eramba_hourly.sh

[Install]
WantedBy=multi-user.target

EOF

cat >/etc/systemd/system/eramaba-hourly.timer <<EOF
[Unit]
Description=Run eramaba-hourly.service every hour

[Timer]
OnCalendar=hourly

[Install]
WantedBy=multi-user.target

EOF


cat >/etc/systemd/system/eramaba-yearly.service <<EOF
[Unit]
Description=Eramaba yearly job runner

[Service]
Type=oneshot
ExecStart=/usr/bin/sh /data/eramba/cron/eramba_yearly.sh

[Install]
WantedBy=multi-user.target

EOF


cat >/etc/systemd/system/eramaba-yearly.timer <<EOF
[Unit]
Description=Run eramaba-yearly.service every year

[Timer]
OnCalendar=yearly

[Install]
WantedBy=multi-user.target
EOF


wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py
cp /usr/bin/systemctl /usr/bin/systemctl.bak    # Keep a backup of systemctl in case we mess up
yes | cp -f systemctl.py /usr/bin/systemctl
chmod a+x /usr/bin/systemctl
test -L /bin/systemctl || ln -sf /usr/bin/systemctl /bin/systemctl


systemctl start eramba-hourly.timer
systemctl start eramba-daily.timer
systemctl start eramba-yearly.timer
systemctl start eramba-hourly.service
systemctl start eramba-daily.service
systemctl start eramba-yearly.service

systemctl enable eramba-hourly.timer
systemctl enable eramba-daily.timers
systemctl enable eramba-yearly.timer
systemctl enable eramba-hourly.service
systemctl enable eramba-daily.service
systemctl enable eramba-yearly.service

systemctl daemon-reload
