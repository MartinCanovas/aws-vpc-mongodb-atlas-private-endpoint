# Overview

Terraform script that creates an AWS VPC with an Endpoint that connects with an Atlas Private Endpoint. This script will also create a bastion instance with a public IP address in the public subnet and another instance in the private subnet with `mongosh` installed where the Atlas Private Endpoint can be used.

Resources that will be created:
- AWS VPC with 2 Public and 2 Private subnets.
- NAT, routing tables and security groups.
- VPC Endpoint and Atlas Private Endpoint.
- Bastion instance in the public subnet.
- Client instance in the private subnet with `mongosh` installed.
- Atlas cluster with several configuration options.

<br/><br/>

# Requirements

- [Terraform](https://www.terraform.io/downloads.html) 0.12+
- An MongoDB Atlas account
- Environment variables:
    ```
    $ export MONGODB_ATLAS_PUBLIC_KEY="xxxx"
    $ export MONGODB_ATLAS_PRIVATE_KEY="xxxx"
    ```

- An AWS account with Access Key and Secret Access Key
    ```
    $ export AWS_ACCESS_KEY_ID=”xxxx”
    $ export AWS_SECRET_ACCESS_KEY=”xxxx”
    $ export AWS_DEFAULT_REGION="xxxx"
    ```

- Add your AWS .pem key to the SSH agent in order to connect the the instance in the private subnet.
    ```
    $ ssh-add <your-pairkey.pem>
    ```

Documentation to create an Atlas API keys: https://docs.atlas.mongodb.com/configure-api-access/#programmatic-api-keys

<br/><br/>
# Usage

Edit the following variables in the variables.tf file according to your needs:
- `project_id` (Atlas Project ID)
- `email_address`
- `whitelist_ip`
- `mongo_db_major_version`
- `provider_instance_size_name`
- `provider_region_name`
- `region`
- `az1`
- `az2`
- `cidr_block`
- `stage`
- `ami`
- `namespace`
- `ssh_key_pair`
- `access_logs_region`
- `vpc_tags`
- `instance_tags`


Create an execution plan:
```
$ terraform plan
```

Execute Terraform plan:
```
$ terraform apply
```

Destroy the Terraform-managed infrastructure:
```
$ terraform destroy
```

# Connecting to the instance in the private subnet

```
$ ssh-add <your-pairkey.pem>
$ ssh-add -l
$ ssh -A -i "<you-pairkey.pem>" ec2-user@<bastion-public-ip>
```
Notice the `-A` option used on macOS to forward <your-pairkey.pem> to the bastion instance.
Once connected to the bastion instance, verify that your key was forwarded:
```
$ ssh-add -l
```

Connect to the instance in the private subnet:
```
$ ssh <instance-private-ip>
```


# Related Projects

- [MongoDB Atlas Cluster](https://github.com/MartinCanovas/mongodb-atlas)
- [AWS VPC with Atlas Private Endpoint](https://github.com/MartinCanovas/aws-vpc-atlas-private-endpoint)

<br/><br/>
# License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.


<br/><br/>
# Terraform Provider

Website: https://www.terraform.io

<img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" width="600px">
