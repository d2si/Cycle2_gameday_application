#/bin/sh
set -e
set -x

# Install required packages
export DEBIAN_FRONTEND=noninteractive
apt-get update -q
apt-get install -y apache2 php curl wget libyaml-dev python2.7-dev git zip unzip

# Install AWS CloudWatch agent
wget https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py
python ./awslogs-agent-setup.py --region eu-west-1 --non-interactive --configfile=/tmp/awslogs.conf

# Install composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install composer packages
cp /tmp/composer.json /var/www
cd /var/www
composer require guzzlehttp/guzzle
composer install
chown -R www-data:www-data /var/www/vendor /var/www/composer.json

#Install SSM
mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl enable amazon-ssm-agent

## Clear unneeded binaries
apt-get autoclean
apt-get --purge -y autoremove
