#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
export LOCAL_IP=$(hostname -I)
sudo echo "<H1>welcome to the private page !! IP : $LOCAL_IP </H1>" > /var/www/html/index.html
systemctl restart apache2
