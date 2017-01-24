#Hadoop VM
Vagrant project with Puppet provisioning to have development VM for Hadoop and Flume.
This is part of a school project.

##Prerequisites
Virtualbox
Vagrant

Install the following plugins for Vagrant:
```
vagrant plugin install vagrant-r10k
vagrant plugin install puppet
```
##Usage

After you cloned the repsitory:
```
cd hadoop
vagrant up
vagrant ssh
sudo su hadoop
```
You can find hadoop and flume in the hadoop user home directory. Use the Hadoop shell scripts in sbin directory to start HDFS and Yarn.

From the host machine you can use the following urls to reach Hadoop:

Resource Manager: http://localhost:8088
Web UI of the NameNode daemon: http://localhost:50070
HDFS NameNode web interface: http://localhost:8042
