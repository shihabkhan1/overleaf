# Issues

## Could not connect to docker

> ERROR: Couldn't connect to Docker daemon at http+docker://localhost -
is it running? If it's at a non-standard location, specify the URL with the
DOCKER_HOST environment variable.

**Solution:**

Give user permissions to docker

```bash
sudo usermod -a -G docker $USER
```

## Port 80 unavailable

> ERROR: for sharelatex Cannot start service sharelatex: driver failed programming external connectivity on endpoint sharelatex (742 e41424927f1729ac27b28aa852248f059514beefdbaac19422bb05689adce): Bind for 0.0.0.0:80 failed: port is already allocated

**Solution:**

First, check for applications/processes using port 80 and get process id $\langle$ pid>

```bash
sudo lsof -i -P -n I grep LISTEN
```

Then kill the process:

```bash
kill -9 <pid>
```

**NOTE:** If nothing works, remove all images and containers, close all processes, and reinstall overleaf.
