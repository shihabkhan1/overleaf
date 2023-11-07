# How to setup Overleaf community edition

## 1 Introduction

## 2 Procedure

1. Install docker
2. Install overleaf community edition
3. Edit docker-compose.yml

This will enable users within the same network to access overleaf

4. Change directory to downloaded overleaf directory
5. Run docker-compose up

This will download all the libraries required for your overleaf instance

6. Create users

## 3 Docker

### 3.1 Installation

$\$$ sudo apt-get install docker-compose

### 3.2 List of useful docker commands

- List all docker containers:

$\$$ docker ps

- Kill running docker process

$\$$ docker kill <container ID>

Note: Use docker ps to obtain container IDs

- Remove all docker containers:

$\$$ docker rm -f $\$($ docker ps $-a-q)$

- Remove all docker images:

$$
\$ \text { docker rmi -f } \$ \text { (docker images }-q)
$$

- Open up a bash session inside sharelatex container:

\$ docker exec -it sharelatex bash

- Display container images:

$\$$ sudo docker images --format 'table

$\hookrightarrow \quad\{\{$. Repository $\}\} \backslash t\{\{$.Tag $\}\} \backslash t\{\{$.Size $\}\}\}^{\prime}$

## 4 Setting up overleaf community edition

NOTE: Overleaf is still referred to as sharelatex in the containers, images, and directories created.

### 4.1 Download overleaf

\$ git clone https://github.com/overleaf/overleaf.git

Or download the repository from HERE

### 4.2 Edit docker-compose.yml

docker-compose.yml contains instructions for docker to run your overleaf instance with. In case you want to enable access to your overleaf instance for other users on the same network, uncomment the following lines from your docker-compose.yml:

![](https://cdn.mathpix.com/cropped/2023_11_07_076a939ab2d3ecbe9f96g-4.jpg?height=459&width=1055&top_left_y=2252&top_left_x=296)

Note: In case there are other applications using your port 80 and 443 , there maybe some conflicts with your overleaf instance.

### 4.3 Accessing overleaf

To access overleaf, go to http://localhost/launchpad on your overleaf host machine.

![](https://cdn.mathpix.com/cropped/2023_11_07_076a939ab2d3ecbe9f96g-5.jpg?height=55&width=1694&top_left_y=652&top_left_x=181)
host machine.

### 4.4 Creating users

### 4.4.1 Create admin user

1. Create new user with the following command

\$ docker exec sharelatex/bin/bash -c "cd/var/www/sharelatex; grunt $\hookrightarrow$ user:create-admin --email=abc@xyz.com"

2. Edit password token by substituting localhost with <ip>
3. Share edited token with user to create password

### 4.4.2 Create regular user

1. Create new user with the following command

\$ docker exec sharelatex/bin/bash -c "cd/var/www/sharelatex; grunt $\rightarrow$ user:create --email=abc@xyz.com"

2. Edit password token by substituting localhost with <ip>
3. Share edited token with user to create password

NOTE: (Alternatively) Admins can create regular users can also be created from the Overleaf launchpad.

### 4.4.3 Delete users

![](https://cdn.mathpix.com/cropped/2023_11_07_076a939ab2d3ecbe9f96g-6.jpg?height=113&width=1483&top_left_y=369&top_left_x=275)

NOTE: For more help on user management refer to THIS link.

### 4.5 Upgrading TeXLive

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

### 4.6 Backing up overleaf data

Backing up Overleaf data essentially boils down to backing up three directories:

1. /sharelatex_data
2. / /mongo_data
3. /redis_databackup-new/

For the recommended process of backing up Overleaf, check THIS link.

## 5 Issues

### 5.1 Could not connect to docker

![](https://cdn.mathpix.com/cropped/2023_11_07_076a939ab2d3ecbe9f96g-7.jpg?height=156&width=1515&top_left_y=1421&top_left_x=248)

Solution :

Give user permissions to docker

\$ sudo usermod -a -G docker \$USER

### 5.2 Port 80 unavailable

ERROR: for sharelatex Cannot start service sharelatex: driver failed programming external connectivity on endpoint sharelatex (742 e41424927f1729ac27b28aa852248f059514beefdbaac19422bb05689adce): Bind for 0.0.0.0:80 failed: port is already allocated

Solution : Check for applications/processes using port 80 and get process id $\langle$ pid>

\$ sudo lsof -i -P -n I grep LISTEN

Kill process:

$\$$ kill $-9<$ pid $>$

Note: If nothing works, remove all images and containers, close all processes, and reinstall overleaf.

## References

