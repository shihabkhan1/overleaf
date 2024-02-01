# Step-by-Step
## Overview

1. Install docker
2. Install overleaf community edition
3. Edit `docker-compose.yml`.

    This will enable users within the same network to access overleaf

4. Change directory to downloaded overleaf directory
5. Run `docker-compose up`

    This will download all the libraries required for your overleaf instance

6. Create users

## Docker

### Installation

```
 sudo apt-get install docker-compose
```

### List of useful docker commands

- List all docker containers:

    ```
    docker ps
    ```
- Kill running docker process

    ```
    docker kill <container ID>
    ```
    Note: Use docker ps to obtain container IDs

- Remove all docker containers:

    ```
    docker rm -f $\$($ docker ps $-a-q)$
    ```
    
- Remove all docker images:

    ```
    docker rmi -f $(docker images -q)
    ```
    
- Open up a bash session inside sharelatex container:

    ```
    docker exec -it sharelatex bash    
    ```
    
- Display container images:

    ```
    sudo docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}'
    ```

## Setting up Overleaf community edition

NOTE: Overleaf is still referred to as sharelatex in the containers, images, and directories created.

### Download Overleaf

```
git clone https://github.com/overleaf/overleaf.git
```
    
Or download the repository from [HERE](https://github.com/overleaf/overleaf.git)

### Edit `docker-compose.yml`

`docker-compose.yml` contains instructions for docker to run your overleaf instance with. In case you want to enable access to your overleaf instance for other users on the same network, uncomment the following lines from your docker-compose.yml:
    
```
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
    

Note: In case there are other applications using your port 80 and 443 , there maybe some conflicts with your overleaf instance.

### Accessing overleaf

To access overleaf, go to http://localhost/launchpad on your overleaf host machine.

![](https://cdn.mathpix.com/cropped/2023_11_07_076a939ab2d3ecbe9f96g-5.jpg?height=55&width=1694&top_left_y=652&top_left_x=181)
host machine.

### Creating users

### Create admin user

1. Create new user with the following command

\$ docker exec sharelatex/bin/bash -c "cd/var/www/sharelatex; grunt $\hookrightarrow$ user:create-admin --email=abc@xyz.com"

2. Edit password token by substituting localhost with <ip>
3. Share edited token with user to create password

## Create regular user

1. Create new user with the following command

\$ docker exec sharelatex/bin/bash -c "cd/var/www/sharelatex; grunt $\rightarrow$ user:create --email=abc@xyz.com"

2. Edit password token by substituting localhost with <ip>
3. Share edited token with user to create password

NOTE: (Alternatively) Admins can create regular users can also be created from the Overleaf launchpad.

### Delete users

![](https://cdn.mathpix.com/cropped/2023_11_07_076a939ab2d3ecbe9f96g-6.jpg?height=113&width=1483&top_left_y=369&top_left_x=275)

NOTE: For more help on user management refer to THIS link.

### Upgrading TeXLive

Overleaf comes with TeXLive-basic preinstalled. In case you want to make any changes to the LaTeX packages, you can:

1. Open up a bash session in Overleaf container:

$\$$ docker exec -it sharelatex bash

2. Make changes through tlmgr:

\$ tlmgr -gui

3. (Optional) A good strategy would be to upgrade the TeXlive installation to the full scheme as follows:

$$
\text { \$ sudo docker exec sharelatex tlmgr install scheme-full }
$$

4. Make a commit to the Overleaf container:

\$ docker commit sharelatex sharelatex/sharelatex:<commit-message>

5. Edit docker-compose.yml to use that image:

![](https://cdn.mathpix.com/cropped/2023_11_07_076a939ab2d3ecbe9f96g-6.jpg?height=257&width=1152&top_left_y=2258&top_left_x=469)

6. Check new sharelatex image exists using:

$\$$ sudo docker images --format 'table

$\hookrightarrow\{\{$.Repository $\}\} \backslash t\{\{$.Tag $\}\} \backslash t\{\{$. Size $\}\}\}^{\prime}$

### Backing up overleaf data

Backing up Overleaf data essentially boils down to backing up three directories:

1. /sharelatex_data
2. / /mongo_data
3. /redis_databackup-new/

For the recommended process of backing up Overleaf, check THIS link.
