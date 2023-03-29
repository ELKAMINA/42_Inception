# Introdution to "Inception" project 
TO UPDATE


Main steps.
=================================
  1.  **Writing Dockerfile**

    - *Getting Alpine* before latest version : **APK** is the package manager for Alpine Linux (while APT is the one from Debian. Be careful commands are differents from one another)
    
    - *Getting SSL package* : briefly, SSL stand for **Secure Socket Layer** is software kinda toolkit for general-purpose cryptography and secure communication. Makes communication between server and client very sure and secure.
    
    - *Configuration nginx file* (making the server communication with outside on defined ports).
    
   2. **Writing docker-compose.yml or docker-compose.yaml file**
   
   *What is the docker-compose.yml or docker-compose.yaml file?*
   
    The Compose file is a YAML file defining :
    - services : contains configuration that is applied to each container started for taht service (equivalent to options passed to the docker run cmd)
    - networks
    - volumes : 
      . Specify a list of options as key-value pairs to pass to the driver for this network. Those options are driver-dependent
  
   3. Launching docker compose to test that everything is alright
  
*Main difficulties*:
  1. Undestanding Docker environement 
  2. Many error msges du to configuration file :
  3. Understanding difference between Dockerfile and Docker-Compose 
  4. Understanding while writing a Docker-compose, the difference between Expose and Ports
  5. What is TCP ? TLS ? SSL ? 
  6. How to get our specific name and tag for an image ( while building, nginx:for_inception)
  7.What is www-data user in nginx?
  8. What is front-tier Network ?
  9. Why launching Nginx in the foreground and not background ? What's the purpose ?
  10.  PID 1 zombie reaping problem.

  ###### Errors encountered and their solution :
    a. getpwnam("www") failed in /etc/nginx/nginx.conf
      - Solution : removing the first line concerning "user www-data" in configuration file bc docker, at creation, know where to find it or use root ??
    b. 

**Step Three**: Installing Maria Database

1. **Writing a Dockerfile**

  - Installing Alpine with APK
  - Intalling VIM
  - Installing mariadb client/server/common
  - Getting the configuration file
  *Good to know*
    --> mysql_install_db : This program initializes the MySQL data directory, creates the mysql database and initializes its grant tables with default    privileges, and sets up the InnoDB system tablespace. It is usually executed only once, when first installing MySQL on a system

**Main commands for mariaDB

  *mysqlshow* : Shows the structure of a MariaDB database (databases, tables, columns and indexes).
  or
  *mariadb-show*
  
  *mysql_install_db*  initializes the MariaDB data directory and creates the system tables in the mysql database, if they do not exist. MariaDB uses these tables to manage privileges, roles, and plugins. It also uses them to provide the data for the help command in the mysql client.


**Errors encountered for mariaDB**

1. "“Error response from daemon: Container $$$$ is restarting, wait until the container is running.”
  
  *Solution* : /* docker logs --details CONTAINER_ID */ made me understand, that the pb came from INNODB: unknown/unstarted service. INNODB is a storage engine for Mysql and Mariadb. This made me, obviously, think about "Volumes". Effectively, i checked my file supposed to host my data from mariadb and it was suppressed so i recreated. Everything worked fine then.

2. Feels like the script written to do configs in mariaDB isn't read so passwords, users and dbs are not created.
   
   *Solution* : 
      - Launched the mariaDB terminal
      - checked if the script was created in the directory i configured and launched it 
      Error encountered : " mysqld: Got error 'Could not get an exclusive lock; file is probably in use by another process' when trying to use aria control file '/var/lib/mysql/aria_log_control' "

Links that helped
-----------
| Subject | Link |
|:--------------|:----------------|
| Tutorial about inception : | https://tuto.grademe.fr/inception/|
| Building Nginx Container from scratch | https://medium.com/@sudarshan_10/building-nginx-web-server-from-scratch-docker-image-53165b7dc130|
| Docker Documentation  |https://docs.docker.com/|
| Difference between ENTRYPOINT & CMD in Dockerfile  |https://www.bmc.com/blogs/docker-cmd-vs-entrypoint/|
| Didnt get everything but will make sens maybe later |https://stackoverflow.com/questions/57554703/why-use-nginx-with-daemon-off-in-background-with-docker|
| CMD in Dockerfiles |https://nickjanetakis.com/blog/docker-tip-63-difference-between-an-array-and-string-based-cmd |
| MariaDb Documentation | https://dev.mysql.com/doc/refman/5.6/en/mysql-install-db.html |
| MariaDb Script to launch : Inspo from Docker Hub| https://github.com/yobasystems/alpine-mariadb/blob/master/alpine-mariadb-amd64/Dockerfile |
| Volumes on Docker| https://medium.com/techmormo/how-do-docker-volumes-enable-persistence-for-containers-docker-made-easy-4-2093a1783b87 |
| Commands in Docker | Default parameters that cannot be overridden when Docker Containers run with CLI parameters.|
| PID 1 | https://hasgeek.com/rootconf/2017/sub/what-should-be-pid-1-in-a-container-JQ6nkBv13XeZzR6zAiFsip  && https://man7.org/linux/man-pages/man1/init.1.html && https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/ && https://daveiscoding.com/why-do-you-need-an-init-process-inside-your-docker-container-pid-1 |  
| docker-compose.yaml specifications | https://github.com/compose-spec/compose-spec/blob/master/spec.md |
| Tuto pour WP from scratch | [https://github.com/compose-spec/compose-spec/blob/master/spec.md](https://codingwithmanny.medium.com/custom-wordpress-docker-setup-8851e98e6b8) |


Main Docker commands : 
----------------------

| Command | Purpose |
|:--------------|:----------------|
| **docker build** | For building images |
| **docker run**  | For running a container from an image |
| **docker pull** | For pulling a Docker image from the Docker repository|
| **docker push** | For updating an image in Docker repo |
| **docker ps** | Listing all active containers (PS : referring to Processes) |
| **docker container ls -a** | Listing all active and non active containers |
| **docker rmi -f IMAGE_ID** | Forcing the delete of a certain image |
| **docker rm -f CONTAINER_ID** | Forcing the delete of a certain container |
| **docker images** | Listing all images |
| **docker compose up** | Launching docker-compose.yml |
| **docker stop CONTAINER_ID** | Stoping a container  |
| **docker start CONTAINER_ID** | Restarting a container  |
| **docker image -prune** | Removing all unused images  |
| **docker exec -it nginx sh** | Launching a shell from a container|
| **docker volume ls** | lists all the volumes created by the container|
| **docker attach [Options] CONTAINER_ID** | Give the opportunity to attach a container to a terminal and follow its steps|
| **docker network ls** | |
| **docker exec CONTAINER_NAME ps -eaf** | print out the processes running |
| **docker logs ** | print out the processes running |


templates
| **docker attach [Options] CONTAINER_ID** | Give the opportunity to attach a container to a terminal and follow its steps|
| **docker attach [Options] CONTAINER_ID** | Give the opportunity to attach a container to a terminal and follow its steps|
| **docker attach [Options] CONTAINER_ID** | Give the opportunity to attach a container to a terminal and follow its steps|
| **docker attach [Options] CONTAINER_ID** | Give the opportunity to attach a container to a terminal and follow its steps|


Sideways: TO UPDATE
-----------
Some cool new command line learnt : 
  - ps -ef | grep -i nginx => *to know which user is used by the server nginx*
  
  - apk list : to launch inside the container terminal to list all the packages installed
  



Intersting concepts to develop : TO UPDATE
----------
1a. Load Balancing

2a. Reverse proxy

3a. CGI script : CGI stands for Common Gateway Interface and provides an interface between the HTTP server and programs generating web content. These programs are better known as CGI scripts. They are written in a scripting language.

4a. /!\ *docker stop* command sends a SIGTERM to the init process and then SIGKILL

Glossary
----------

**Daemon** : is a program that runs continuously as a background process and wakes up to handle periodic service requests, which often come from remote processes. The daemon program is alerted to the request by the operating system (OS), and it either responds to the request itself or forwards the request to another program or process as appropriate.

**mysqld** : is the mysql server.

**data directory** : contains databases and tables. It is also the default location for other information such as log files and status files.

**InnoDB** : is a storage engine for MySql and Mariadb. It stores the data on a disk or keeps it in the main memory for quick access.

**Bridge networks** : a bridge network is a Link Layer device which forwards traffic between network segments. A bridge can be a hardware device or a software device running within a host machine’s kernel. In terms of Docker, a bridge network uses a software bridge which allows containers connected to the same bridge network to communicate, while providing isolation from containers which are not connected to that bridge network. The Docker bridge driver automatically installs rules in the host machine so that containers on different bridge networks cannot communicate directly with each other.Bridge networks apply to containers running on the same Docker daemon host. TO MAKE COMMUNICATIONS BETWEEN CONTAINERS not belongign to the same network, we use OVERLAY network
/!\ When you start Docker, a default bridge network (also called bridge) is created automatically, and newly-started containers connect to it unless otherwise specified. You can also create user-defined custom bridge networks. User-defined bridge networks are superior to the default bridge network.

**Reaping a process **
  Process of eliminating zombie processes. /!\ Using has caveats : it blocks parent process if the child hasn`t terminated


Existencial questions 
----------
1. What is the difference between Docker run and Docker exec ?

*Answer* : 
  In short, docker run is the command you use to create a new container from an image, whilst docker exec lets you run commands on an already running container

2. What is the use of "--no-cache" in Dockerfiles (someetimes replaced by rm /var/cache/apk/*.) ?

*Answer* : 
  Briefly, to have the packages available during boot, apk can keep **a cache** of installed packages on a local disk. Added packages can then be automatically (re-)installed from local media into RAM when booting, without requiring, and even before there is a network connection.
The APKINDEX file is a text file containing records for each package in the repository in a text-based format. Each record is separated by a newline.
So, the option "--no-cache" allow us to not cache the index locally, which is useful for keeping containers small.

*https://stackoverflow.com/questions/49118579/alpine-dockerfile-advantages-of-no-cache-vs-rm-var-cache-apk#:~:text=The%20%2D%2Dno%2Dcache%20option,add%20nginx%20WARNING%3A%20Ignoring%20APKINDEX.*

3. Why do we need **volumes** ?

*Answer* : 
 The data living through a container doesn't have durability. So, we need volumes to store data in a perennial way.

4. Difference between ENTRYPOINT and CMD ?

*Answer* : 
  **CMD**         : Sets default parameters that can be overridden from the Docker Command Line Interface (CLI) when a container is running
  **ENTRYPOINT**  : Default parameters that cannot be overridden when Docker Containers run with CLI parameters.
  
5. What is PID=1 in containers (look to sysvinit) ?

*Answer*
  Usually, PID 1 is the init/systemd process. But what is systemd process and init ?
  It's a system designed for Linux Kernel and is the first process with PID = 1, which gets executed in user space during the Linux start-up process.
  *Sysvinit* : is the first process started by the kernel when you boot up any Linux or Unix computer. This means that all the other processes are their    child in one way or the other. Systemd replaced Sysvinit which became a bit obsolete for modern day-computer.
  
 6. What is the difference between EXPOSE and PORTS in DOCKERFILE ?
 
 **The expose section** allows us to expose specific ports from our container only to other services on the same network. We can do this simply by specifying the container ports.

**The ports** section also exposes specified ports from containers. Unlike the previous section, ports are open not only for other services on the same network, but also to the host. The configuration is a bit more complex, where we can configure the exposed port, local binding address, and restricted protocol.
