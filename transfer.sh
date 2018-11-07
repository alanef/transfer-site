#!/bin/bash  
printf "From Account /home/account, without /home/: "
read -e account
printf "From Database: "
read -e db1
printf "DB Pasword ( same on both): "
read -e  pass
printf "To db name: "
read -e database2
printf "To db user: "
read -e user2
printf "To server account:host: "
read -e server
printf "To target directory e.g. subdomain or public_html: "
read -e dir

mysqldump --add-drop-table --user=$account --password="${pass}" $db1 > /tmp/${account}_db.sql
cat /tmp/${account}_db.sql|ssh $server "mysql --user=$user2 --password="${pass}" $database2  --"

tar -czf /tmp/${account}.tar.gz -C /home/$account/public_html .
cat /tmp/${account}.tar.gz | ssh $server "cd ${dir};tar -zxf -"


rm -rf /tmp/$account.tar.gz
rm -rf /tmp/${account}_db.sql

ssh $server "cd ${dir}; wp config set DB_NAME \"${database2}i\""
ssh $server "cd ${dir}; wp config set DB_USER \"${user2}\""

