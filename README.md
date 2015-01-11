# Cloud Server Provisioning Scripts
***
## EC2 Ubuntu Node.js Provisioner (ec2-ubuntu-nodejs.sh)
This bash script will provision a new EC2 instance with the following:
  - Node.js (cloned from the Node.js Github repository)
  - NPM
  - Forever (installed globally via NPM)
  - Git

The provisioner also updates `apt-get` and updates the /etc/hosts file to resolve the machine's hostname to 127.0.0.1 in order to avoid subsequent errors with hostname lookups.

### Usage
You can run this script as soon as new EC2 instances come up:
```sh
$ ssh ubuntu@EC2_IP_ADDRESS 'bash -' < ec2-ubuntu-nodejs.sh
```
Where `EC2_IP_ADDRESS` is the public IP address of the new EC2 instance.

### Node.js Installation
The provisioner installs Node.js into /opt/node.  The ubuntu user's `$PATH` is updated to include this, and the new `$PATH` is also saved to ~/.bashrc

### Port Forwarding
Since we run Node.js apps on port 8888, this script also updates iptables to redirect port 8888 to port 80.  The redirect rule is added to /etc/rc.local so it is applied at startup.
