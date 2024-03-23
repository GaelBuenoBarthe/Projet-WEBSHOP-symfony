#!/bin/bash

# Variables
SERVER_USERNAME="username"
SERVER_IP="your_server_ip"
SYMFONY_ENV="prod"
SYMFONY_CONSOLE="/path/to/symfony/bin/console"
GIT_REPO="https://github.com/NairoD34/Les-Maestros.git"
WWW_DIR="/path/to/your/www/dir"
DATABASE_URL="mysql://votreUserName:votrePassword@127.0.0.1:3306/maestro"

# Go to project directory
cd /path/to/your/local/project

# Pull latest changes from GitHub
git pull origin main

# Install dependencies
composer install --no-dev --optimize-autoloader

# Clear cache
php $SYMFONY_CONSOLE cache:clear --env=$SYMFONY_ENV --no-debug

# Update database schema if needed
php $SYMFONY_CONSOLE doctrine:migrations:migrate --env=$SYMFONY_ENV --no-debug --no-interaction

# Optionally, run other Symfony console commands as needed

# Transfer files to server using SSH
rsync -avz --delete --exclude-from='.gitignore' /path/to/your/local/project/ $SERVER_USERNAME@$SERVER_IP:$WWW_DIR

# Optionally, restart server services (e.g., Apache, PHP-FPM) if necessary
# ssh $SERVER_USERNAME@$SERVER_IP "sudo service apache2 restart"

echo "Deployment completed successfully."
