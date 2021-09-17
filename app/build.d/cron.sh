#!/bin/bash
set -Eeuo pipefail

CRON_DIR="/eramba_community/cron"

# CP TO CRON DIRECTORY
mkdir -p ${CRON_DIR} && cp eramba_community/cron/*.sh ${CRON_DIR}/

# ADD TIMER TO SYSTEMD
cp eramba_community/cron/*.timer /etc/systemd/system/
# ADD SERVICES
cp eramba_community/cron/*.service /etc/systemd/system/

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