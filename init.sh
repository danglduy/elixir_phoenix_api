#!/bin/bash

set -e

# Install necessary packages for compiling guardian
echo "Installing necessary erlang packages"
sudo apt-get -y install erlang-dev erlang-parsetools > /dev/null

# Copy template
cp config/guardian.secret.exs.example.exs config/guardian.secret.exs
cp config/dev.exs.example.exs config/dev.exs
cp config/test.exs.example.exs config/test.exs

# Get packages
echo "Getting mix packages"
mix deps.get > /dev/null

# Generate secret and put it to guardian.secret.exs file
GUARDIAN_SECRET=$(mix guardian.gen.secret | tail -1)
head -n -1 config/guardian.secret.exs > temp.exs ; mv temp.exs config/guardian.secret.exs
echo "  secret_key: \"$GUARDIAN_SECRET\"" >> config/guardian.secret.exs

# Config database
echo "Config your postgres database:"
read -p "DB username: " db_username
read -s -p "DB password: " db_password
printf "\n"
read -p "DB name (dev): " db_name_dev
read -p "DB name (test): " db_name_test

sed -i "s/MY_USERNAME/$db_username/g" config/dev.exs
sed -i "s/MY_USERNAME/$db_username/g" config/test.exs
sed -i "s/MY_PASSWORD/$db_password/g" config/dev.exs
sed -i "s/MY_PASSWORD/$db_password/g" config/test.exs
sed -i "s/MY_DATABASE/$db_name_dev/g" config/dev.exs
sed -i "s/MY_DATABASE/$db_name_test/g" config/test.exs

echo "Creating databases"
mix ecto.create $db_name > /dev/null
MIX_ENV=test mix ecto.create $db_name > /dev/null

echo "Migrating database..."
mix ecto.migrate > /dev/null
MIX_ENV=test mix ecto.migrate > /dev/null

echo "Everything done. Start coding!"
