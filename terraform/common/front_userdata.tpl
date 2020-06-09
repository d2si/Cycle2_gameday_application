#!/bin/bash
set -x

# Update hostname
echo "app_environment=${environment}" > /var/www/html/application.properties
echo "app_version=${version}" >> /var/www/html/application.properties
echo "ddbtable=${ddbtable}" >> /var/www/html/application.properties
echo "aws_sdk_version"=${aws_sdk_version} >> /var/www/html/application.properties
echo "aws_region=${aws_region}" >>   /var/www/html/application.properties
echo "api_url=${api_url}" >> /var/www/html/application.properties
sudo systemctl restart apache2.service
