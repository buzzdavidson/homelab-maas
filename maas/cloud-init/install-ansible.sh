#!/bin/bash

export LOGFILE=/var/log/cloud-init-ansible.log
echo "--- Executing Custom Homelab MAAS Bootstrap ---" >> $LOGFILE

echo "--- Environment ---" > $LOGFILE
set | tee -a $LOGFILE

echo "--- Install Ansible and Git ---" >> $LOGFILE
apt-get install ansible git --assume-yes -q | tee -a $LOGFILE

echo "--- Cloning Ansible Bootstrap ---" >> $LOGFILE
git clone https://github.com/buzzdavidson/homelab-maas.git /tmp/homelab-maas | tee -a $LOGFILE

echo "--- Executing Ansible Bootstrap ---" >> $LOGFILE
(
    ansible-playbook /tmp/homelab-maas/ansible/site.yml
) | tee -a $LOGFILE

echo "--- Custom Homelab MAAS Bootstrap Complete ---" >> $LOGFILE
