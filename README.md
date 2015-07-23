# boundary-vagrant-redis
Boundary Redis
==============

Configures an virtual machine with an ElasticSearch instance for testing Boundary Plugin for Redis

Prerequistes
------------

- Vagrant 1.72. or later, download [here](https://www.vagrantup.com/downloads.html)
- Virtual Box 4.3.26 or later, download [here](https://www.virtualbox.org/wiki/Downloads)
- git 1.7 or later

Installation
------------

Prior to installation you need to obtain in your Boundary API Token.

1. Clone the GitHub Repository:
```bash
$ git clone https://github.com/boundary/boundary-vagrant-redis
```

2. Start the virtual machine using your Boundary API Token:
```bash
$ BOUNDARY_API_TOKEN=<Boundary API Token> vagrant up <virtual machine name>
```
NOTE: Run `vagrant status` to list the name of the virtual machines.

3. Login to the virtual machine
```bash
$ vagrant ssh <virtual machine name>
```

Post Install
------------

After the virtual machine starts you can then login and use the `install_server.sh` script located in `/opt/redis-3.0.3/utils` to install Redis as a daemon.

1. Change directory to `/opt/redis-3.0.3`
```bash
$ cd /opt/redis-3.0.3/utils
```
2. Run the install script:
```bash
$ sudo ./install_server.sh
```
3. Accept the defaults by pressing enter
4. After the script executes you now start stop using the following:
```bash
sudo service redis_6379 start
sudo service redis_6379 stop
```

To Do
-----

Remove the need for the post install



