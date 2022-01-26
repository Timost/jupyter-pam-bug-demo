#!/usr/bin/env bash
set -e

# Add unix user for jupyterhub
useradd $USER_NAME
echo "$USER_NAME:$USER_PASSWORD" | chpasswd


service rsyslog start && jupyterhub