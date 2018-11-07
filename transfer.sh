#!/bin/bash  
read -er -p  "From Account /home/account, without /home/: " account
read -er -p "From Database ( blank for none ): " db1
if [ ! -z "$db1" ] 
then
  read -er -p "DB Pasword ( same on both): " pass
  read -er -p "To db name: " database2
  read -er -p "To db user: " user2
  read -er -p "Wordpress and wp cli on remote(y/n): " wp
fi
read -er -p "To server account@host:  server
read -er -p "To target directory e.g. subdomain or public_html: " dir

if [ ! -z "$db1" ] 
then
  mysqldump --add-drop-table --user=$account --password="${pass}" $db1 > /tmp/${account}_db.sql
  cat /tmp/${account}_db.sql|ssh $server "mysql --user=$user2 --password="${pass}" $database2  --"
  rm -rf /tmp/${account}_db.sql
fi

tar -czf /tmp/${account}.tar.gz -C /home/$account/public_html .
cat /tmp/${account}.tar.gz | ssh $server "cd ${dir};tar -zxf -"


rm -rf /tmp/$account.tar.gz

if [[ "$wp" =~ ^([yY][eE][sS]|[yY])+$ ]] 
then
  ssh $server "cd ${dir}; wp config set DB_NAME \"${database2}i\""
  ssh $server "cd ${dir}; wp config set DB_USER \"${user2}\""
fi

