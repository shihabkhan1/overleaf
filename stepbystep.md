# Step-by-Step
## Overview

1. Install docker
2. Clone Overleaf Community Edition
3. Change directory to downloaded overleaf directory
4. Edit `docker-compose.yml`.

    This will enable users within the same network to access overleaf using
    Nginx server.

5. Run `docker-compose up`

    This will download all the libraries required for your overleaf instance

6. Create and Manage users

## Docker
Docker is a containerization platform that allows you to package applications
and their dependencies into isolated containers. Each container runs as a 
lightweight, standalone, and executable package that includes everything needed
to run the application, such as code, runtime, system tools, libraries, and settings.

In the context of self-hosting Overleaf, Docker simplifies the deployment and 
management of the Overleaf Community Edition application. Instead of installing
Overleaf and its dependencies directly on the host system, Docker allows you to
run Overleaf within a container. This container encapsulates the Overleaf 
application and its dependencies, ensuring consistency and portability across 
different environments. Docker also provides mechanisms for managing 
containerized applications, including starting, stopping, scaling, and 
updating containers.

### Installation

```
 sudo apt-get install docker-compose
```

### List of useful docker commands

- List all docker containers:

    ```bash
    docker ps
    ```
- Kill running docker process

    ```bash
    docker kill <container ID>
    ```
    Note: Use docker ps to obtain container IDs

- Remove all docker containers:

    ```bash
    docker rm -f $\$($ docker ps $-a-q)$
    ```
    
- Remove all docker images:

    ```bash
    docker rmi -f $(docker images -q)
    ```

- Open up a bash session inside sharelatex container:

    ```bash
    docker exec -it sharelatex bash    
    ```

- Display container images:

    ```bash
    sudo docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}'
    ```

## Setting up Overleaf community edition

NOTE: Overleaf is still referred to as sharelatex in the containers, images, and directories created.

### Download Overleaf

```bash
git clone https://github.com/overleaf/overleaf.git
```
    
Or download the repository from [HERE](https://github.com/overleaf/overleaf.git)

### Edit `docker-compose.yml`

`docker-compose.yml` contains instructions for docker to run your overleaf 
instance with. It is contained inside the cloned Overleaf Git repository. 
In case you want to enable access to your overleaf instance for other users 
on the same network via a Nginx, uncomment the following lines from 
your `docker-compose.yml`:
    
```yaml
nginx-proxy:
    image: jwilder/nginx-proxy
    container_name: nginx-proxy
    ports:
        #- "80:80"
        - "443:443"
    volumes:
        - /var/run/docker.sock:/tmp/docker.sock:ro
        - /home/sharelatex/tmp:/etc/nginx/certs
```

In the context of self-hosting Overleaf, Nginx is often used as a reverse proxy 
server to forward incoming HTTP requests to the Overleaf application running 
within Docker containers. Nginx acts as a gateway between external Overleaf
users and the Overleaf application, providing an additional layer of security, 
performance optimization, and flexibility in managing web traffic.

Note: In case there are other applications using your port 80 and 443 , there maybe some conflicts with your overleaf instance.

### Accessing overleaf

To access overleaf, go to [http://localhost/launchpad](http://localhost/launchpad) on your overleaf host machine.

For users within the same network, go to `http://<ip>`, where `<ip>` is the IP of overleaf host machine.

## Managing Users

### Create admin user

1. Create new user with the following command

    ```bash
    docker exec sharelatex /bin/bash -c "cd/var/www/sharelatex; grunt user:create-admin --email=abc@xyz.com"
    ```

2. Edit password token by substituting `localhost` with `<ip>`
3. Share edited token with user to create password

## Create regular user

1. Create new user with the following command

    ```bash
    docker exec sharelatex /bin/bash -c "cd/var/www/sharelatex; grunt user:create --email=abc@xyz.com"
    ```

2. Edit password token by substituting `localhost` with `<ip>`
3. Share edited token with user to create password

NOTE: (Alternatively) Admins can create regular users can also be created from the Overleaf launchpad.

### Delete users

Similarly, you can delete a user with the following command:

```bash
docker exec sharelatex /bin/bash -c "cd /var/www/sharelatex; grunt user:delete --email=abc@xyz.com"
```

NOTE: For more help on user management refer to [THIS](https://github.com/overleaf/overleaf/wiki/Creating-and-managing-users) link.

## Upgrading TeXLive

Overleaf comes with TeXLive-basic preinstalled. In case you want to make any changes to the LaTeX packages, you can:

1. Open up a bash session in Overleaf container:

    ```bash
    docker exec -it sharelatex bash
    ```

2. Make changes through tlmgr:

    ```bash
    tlmgr -gui
    ```

3. (Optional) A good strategy would be to upgrade the TeXlive installation to the full scheme as follows:

    ```bash
    sudo docker exec sharelatex tlmgr install scheme-full
    ```

4. Make a commit to the Overleaf container:

    ```bash
    docker commit sharelatex sharelatex/sharelatex:<commit-message>
    ```

5. Edit docker-compose.yml to use that image:

    ```yaml
    # ...
    services:
        sharelatex:
            image: sharelatex/sharelatex:<commit-message>
    # ...
    ```

6. Check new sharelatex image exists using:

    ```bash
    sudo docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}'
    ```

## Backing up overleaf data

Backing up Overleaf data essentially boils down to backing up three directories:

1. `~/sharelatex_data`
2. `~/mongo_data`
3. `~/redis_databackup-new/`

For the recommended process of backing up Overleaf, check [THIS](https://github.com/overleaf/overleaf/wiki/Backup-of-Data)
