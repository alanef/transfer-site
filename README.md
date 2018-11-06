# transfer site
Simple basic script to move a website across servers with SSH
## Pre-requistes and assumptions
* you have shell access to the sending system
* you have set up ssh access to the receiving server, and added the public_key
* the sending website is located in /home
* the website has a single mysql database  which has a user the same name as the directory in /home and has the same password
## Installation
Download and install the script on your path
e.g.

```sudo wget https://raw.githubusercontent.com/alanef/transfer-site/master/transfer.sh -O /usr/local/sbin/transfer.sh|sudo chmod +x /usr/local/sbin/transfer.sh```

## Usage
* set up the account on the recieving system
* set up the private - public key and add the public_key to the recieving system

```ssh-keygen -t rsa```

* run the script `transfer.sh` and add the needed data
* for WordPress adjust the recieving system wp-config.php to reflect database user / name
