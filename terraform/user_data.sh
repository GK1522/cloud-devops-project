#!/bin/bash

apt update -y

apt install -y docker.io

systemctl start docker

systemctl enable docker

docker run -d -p 80:80 nginx