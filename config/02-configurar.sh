#!/usr/bin/env bash
set -euo pipefail

install -o root -g root -m 644 \
    /vagrant/files/named /etc/default/named

install -o root -g bind -m 644 \
    /vagrant/files/named.conf.options /etc/bind/named.conf.options

install -o root -g bind -m 644 \
    /vagrant/files/named.conf.local /etc/bind/named.conf.local

install -d -o root -g bind -m 775 /var/lib/bind

install -o root -g bind -m 644 \
    /vagrant/files/tunombre.test.dns /var/lib/bind/tunombre.test.dns

install -o root -g bind -m 644 \
    /vagrant/files/tunombre.test.rev /var/lib/bind/tunombre.test.rev

named-checkconf -z

systemctl enable named
systemctl restart named
systemctl is-active --quiet named