#!/bin/bash

curl -OL https://downloads.mongodb.com/compass/mongosh-0.1.0-linux.tgz
tar -zxvf mongosh-0.1.0-linux.tgz
chmod +x mongosh
sudo cp mongosh /usr/local/bin/