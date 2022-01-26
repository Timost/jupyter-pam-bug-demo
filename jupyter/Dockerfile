FROM node:lts-bullseye AS npm-install

RUN npm install -g configurable-http-proxy

from python:3.9-bullseye

COPY --from=npm-install /usr/local/bin/ /usr/local/bin/
COPY --from=npm-install /usr/local/lib/node_modules /usr/local/lib/node_modules


RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    rsyslog \
    libpam-mount \
    sshfs && \
    pam-auth-update --force --enable libpam-mount --enable mkhomedir --enable systemd --enable unix

RUN pip install jupyterhub jupyterlab

# Uncomment this to get working mount setup
# RUN sed -E -i '/.*PAM_SETCRED\(handle, resetcred\).*/a     # open_session before the handle gets destroyed with pam_end\n    # (ex: pam_mount needs state info stored previously in the auth facility)\n    if retval == 0:\n        retval = PAM_OPEN_SESSION(handle, 0)\n' /usr/local/lib/python3.9/site-packages/pamela.py
COPY pam_mount.conf.xml /etc/security/pam_mount.conf.xml
COPY jupyterhub_config.py /jupyterhub_config.py
COPY entrypoint.sh /entrypoint.sh
RUN cp /etc/pam.d/other /etc/pam.d/jupyterhub
ENTRYPOINT ["/entrypoint.sh"]