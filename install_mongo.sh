#!/bin/bash

curl -OL https://downloads.mongodb.com/compass/mongosh-0.2.2-linux.tgz
tar -zxvf mongosh-0.2.2-linux.tgz
chmod +x mongosh
sudo cp mongosh /usr/local/bin/