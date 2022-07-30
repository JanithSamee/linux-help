#! /usr/bin/bash

echo "Installing Webtop!!!!"

read -p "Enter distro name [ubuntu-mate]: " distroname
distroname=${distroname:-ubuntu-mate}
read -p "Enter port [8080]: " port
port=${port:-8080}
read -p "Enter directory [$(pwd)/webtop]: " dir
dir=${dir:-$(pwd)"/webtop"}
read -p "Enter shm_size [1gb]: " size
size=${size:-"1gb"}

mkdir "$dir"
mkdir "$dir/config"

echo "---"   >> "$dir/docker-compose.yml"
echo 'version: "2.1"'   >> "$dir/docker-compose.yml"
echo 'services:'   >> "$dir/docker-compose.yml"
echo '      webtop:'   >> "$dir/docker-compose.yml"
echo "            image: lscr.io/linuxserver/webtop:$distroname"   >> "$dir/docker-compose.yml"
echo '            container_name: webtop'   >> "$dir/docker-compose.yml"
echo '            security_opt:'   >> "$dir/docker-compose.yml"
echo '                  - seccomp:unconfined #optional'   >> "$dir/docker-compose.yml"
echo '            environment:'   >> "$dir/docker-compose.yml"
echo '                  - PUID=1000'   >> "$dir/docker-compose.yml"
echo '                  - PGID=1000'   >> "$dir/docker-compose.yml"
echo '                  - TZ=Europe/London'   >> "$dir/docker-compose.yml"
echo '                  - SUBFOLDER=/ #optional'   >> "$dir/docker-compose.yml"
echo '                  - KEYBOARD=en-us-qwerty #optional'   >> "$dir/docker-compose.yml"
echo '            volumes:'   >> "$dir/docker-compose.yml"
echo "                  - $dir/config:/config"   >> "$dir/docker-compose.yml"
echo '            ports:'   >> "$dir/docker-compose.yml"
echo "                  - $port:3000"   >> "$dir/docker-compose.yml"
echo "            shm_size: \"$size\" #optional"   >> "$dir/docker-compose.yml"
echo '            restart: unless-stopped'   >> "$dir/docker-compose.yml"

cd "$dir"
docker-compose up -d
echo "done"

