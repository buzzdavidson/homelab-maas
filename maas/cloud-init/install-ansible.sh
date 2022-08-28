#!/bin/bash
(
    set
) | tee /install-ansible.log

(
    apt-get install ansible git --assume-yes -q
) | tee -a /install-ansible.log

(
    git clone https://github.com/buzzdavidson/homelab-maas.git
) | tee -a /install-ansible.log

(
    ansible-playbook homelab-maas/ansible/site.yml
) | tee -a /install-ansible.log

