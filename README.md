# transfer site
Simple basic script to move a website across servers with SSH
## Pre-requistes and assumptions
* you have shell access to the sending system
* you have set up ssh access to the receiving server, and added the public_key
* the sending website is located in /home
* the website has a single mysql database  which has a user the same name as the directoryin /home
## Installation
Download and install thescript on your path
```sudo wget https://raw.githubusercontent.com/alanef/transfer-site/master/transfer.sh -O /usr/local/sbin/transfer.sh|sudo chmod +x /usr/local/sbin/transfer.sh```
