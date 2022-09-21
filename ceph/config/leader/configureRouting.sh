#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run using sudo"
    exit 1
fi

apt install iptables-persistent

iptables -t nat -A POSTROUTING -j MASQUERADE
iptables-save > /etc/iptables/rules.v4



