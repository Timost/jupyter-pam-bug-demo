# Demo for jupyterhub pam issues

This repo tries to illustrate pam issues with jupyterhub.

The setup is as minimal as possible, there are two docker containers:
- one open-ssh server with one valid user/password (jupyterhub/admin) and a `/shared-sshfs-data/` volume.
- one custom jupyterhub container on port `8000`

The custom container sets up `sshfs` and `pam_mount` to mount a sshfs volume on user login.

## requirements

You need a working docker and docker-compose setup.

## Running the demo

```shell
docker-compose build
docker-compose up -d
```

In your favorite browser `localhost:8000`, login using `jupyterhub` and `admin`.
Confirm that the `test_mount` folder is **not** present in the user home `/home/jupyterhub/test_mount`.

## Activating the hack

If you want to make the mount work successfully, you can uncomment the `sed` line in `jupyter/Dockerfile`.

Then run:
```shell
docker-compose build
docker-compose up -d
```
Login again on `localhost:8000` and see that the folder is present in the home of the user.