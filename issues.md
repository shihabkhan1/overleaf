# Issues

## Could not connect to docker

![](https://cdn.mathpix.com/cropped/2023_11_07_076a939ab2d3ecbe9f96g-7.jpg?height=156&width=1515&top_left_y=1421&top_left_x=248)

Solution :

Give user permissions to docker

\$ sudo usermod -a -G docker \$USER

## Port 80 unavailable

ERROR: for sharelatex Cannot start service sharelatex: driver failed programming external connectivity on endpoint sharelatex (742 e41424927f1729ac27b28aa852248f059514beefdbaac19422bb05689adce): Bind for 0.0.0.0:80 failed: port is already allocated

Solution : Check for applications/processes using port 80 and get process id $\langle$ pid>

\$ sudo lsof -i -P -n I grep LISTEN

Kill process:

$\$$ kill $-9<$ pid $>$

Note: If nothing works, remove all images and containers, close all processes, and reinstall overleaf.
