#!/bin/bash

#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

#!/bin/bash

sudo systemctl enable httpd
sudo systemctl start httpd
sudo yum -y install httpd
sudo service httpd start

sudo mkdir /var/www/html/mount-point
mount -t efs fs-12345678:/ /var/www/html/efs-mount-point

cd /var/www/html/efs-mount-point

sudo mkdir sampledir
sudo chown  ec2-user sampledir
sudo chmod -R o+r sampledir
cd sampledir

echo "<html><h1> TEST APPACHE WEB SERVER </h1></html>" > index.html

export HOSTNAME=$(curl -s http://169.254.169.254/metadata/v1/hostname)
export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
echo Hello from Droplet $HOSTNAME, with IP Address: $PUBLIC_IPV4 > /var/www/html/index.html

