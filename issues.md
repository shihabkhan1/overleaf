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


## Not be able to complie after first installation

> ERROR: Server Error: Sorry, something went wrong and your project could not be compiled. Please try again in a few moments

**Solution**
Disable Sandbox compilation by commenting lines 81-88 in `docker-compose.yml` file. They look like these.
```yml 
    SANDBOXED_COMPILES: 'true'
    ### Bind-mount source for /var/lib/overleaf/data/compiles inside the container.
    SANDBOXED_COMPILES_HOST_DIR_COMPILES: '/home/user/sharelatex_data/data/compiles'
    ### Bind-mount source for /var/lib/overleaf/data/output inside the container.
    SANDBOXED_COMPILES_HOST_DIR_OUTPUT: '/home/user/sharelatex_data/data/output'
    ### Backwards compatibility (before Server Pro 5.5)
    DOCKER_RUNNER: 'true'
    SANDBOXED_COMPILES_SIBLING_CONTAINERS: 'true' 
```
Possibly re-run with `docker-compose up -d` command.

Source: https://github.com/overleaf/overleaf/issues/1354#issuecomment-2885290997


## Packages are not found while compliing

>ERROR: Unable to find package <your_package_name>

**Solution**

Need to update `tlmgr` and install all the packeges for compiling on `sharelatex` container by running following commands.

```bash
 docker exec sharelatex tlmgr update --self  
 docker exec sharelatex tlmgr install scheme-full
```

source: https://github.com/overleaf/overleaf/issues/1301#issuecomment-2569093230
