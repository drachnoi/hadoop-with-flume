#Hadoop VM
Vagrant project with Puppet provisioning to have development VM for Hadoop and Flume.
This is part of a school project.

##Prerequisites
* Virtualbox
* Vagrant

###Install the following plugins for Vagrant:
```
vagrant plugin install vagrant-r10k
vagrant plugin install puppet
```
##Usage

###After you cloned the repsitory:
```
cd hadoop
vagrant up
vagrant ssh
sudo su hadoop
```
You can find hadoop and flume in the hadoop user home directory. Use the Hadoop shell scripts in sbin directory to start HDFS and Yarn.

###From the host machine you can use the following urls to reach Hadoop:

* Resource Manager: http://localhost:8088
* Web UI of the NameNode daemon: http://localhost:50070
* HDFS NameNode web interface: http://localhost:8042

##Known issues

* You might get the following error message when firing up the VM:

```
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["startvm", "85551b94-669b-4139-a0ef-7e51e69a1e5f", "--type", "headless"]

Stderr: VBoxManage: error: AMD-V is disabled in the BIOS (or by the host OS) (VERR_SVM_DISABLED)
VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component ConsoleWrap, interface IC
```

This happens because this project uses a 64 bit VM and for that having a 64 bit host is not enough, hardware level virtualisation is required too. Basically it is a limitation coming from Vitrualbox.
