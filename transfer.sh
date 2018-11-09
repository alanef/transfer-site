#!/bin/bash  
read -er -p  "From Account /home/account, without /home/: " account
read -er -p "From Database ( blank for none ): " db1
if [ -n "$db1" ] 
then
  read -er -p "From Database User ( blank for sames as account ): " user1
  read -er -p "DB Pasword ( same on both): " pass
  read -er -p "To db name: " database2
  read -er -p "To db user: " user2
  read -er -p "Wordpress and wp cli on remote(y/n): " wp
fi
read -er -p "To server account@host: "  server
read -er -p "To target directory e.g. subdomain or public_html: " dir

if [ -n "$user1" ]
then
  user1 = "$account"
fi

if [ -n "$db1" ] 
then
  mysqldump --add-drop-table --user="$user1" --password="${pass}" "$db1" > /tmp/"${account}_db.sql"
  ssh "$server" "mysql --user=\"$user2\" --password=\"${pass}\" \"$database2\" --" < "/tmp/${account}_db.sql"
  rm -rf /tmp/"${account}_db.sql"
fi

tar -czf /tmp/"${account}.tar.gz" -C "/home/$account/public_html" .
ssh "$server" "cd ${dir};tar -zxf -" < "/tmp/${account}.tar.gz"


rm -rf "/tmp/$account.tar.gz"

if [[ $wp =~ [yY](es)* ]]
then 
  ssh "$server" "cd \"${dir}\"; wp config set DB_NAME \"${database2}\""
  ssh "$server" "cd \"${dir}\"; wp config set DB_USER \"${user2}\""
fi

