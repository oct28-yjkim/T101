# ref 

* https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-docker.html
* create user : https://docs.aws.amazon.com/cli/latest/reference/iam/create-user.html
* create bucket : https://docs.aws.amazon.com/cli/latest/reference/s3api/create-bucket.html
* dynamoDB or table? : https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/cli-services-dynamodb.html

# run aws cli 

```

docker run --rm -it amazon/aws-cli 

alias aws='docker run -it -rm amazon/aws-cli'

[yjkim1@yjkim1-mi 02.cloud]$ sudo docker run --rm -it amazon/aws-cli --version
aws-cli/2.7.12 Python/3.9.11 Linux/5.15.49-1-MANJARO docker/x86_64.amzn.2 prompt/off

```

# install with pip 

```sh 
[yjkim1@yjkim1-mi 02.cloud]$ pip install awscli --user --upgrade 

Linux and macOS	~/.aws/config ~/.aws/credentials

[yjkim1@yjkim1-mi 02.cloud]$ aws configure 
AWS Access Key ID [None]: **
AWS Secret Access Key [None]: **
Default region name [None]: ap-southeast-1
Default output format [None]: 

```

# create bucket 

```sh 
aws s3api create-bucket \
  --bucket yjkim1.terraform.state \
  --region ap-southeast-1 \
  --create-bucket-configuration LocationConstraint=ap-southeast-1

```

# create dynamoDB table with aws cli 

```sh 
 aws dynamodb create-table \
    --table-name terraform-lock \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=2,WriteCapacityUnits=2
```

# remove rds 

```sh 
# no snapshot 

aws rds delete-db-instance \
    --db-instance-identifier database-1 \
    --skip-final-snapshot \
    --no-delete-automated-backups

```

# search ami 

```sh 
aws ssm get-parameters-by-path --path /aws/service/ami-amazon-linux-latest --query "Parameters[].Name"
```

# search avliablity zone 

```sh 
aws ec2 describe-availability-zones --region ap-southeast-1

aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=c5.xlarge --region ap-southeast-1 --output table

[yjkim1@yjkim1-mi terraform]$ aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=c5.xlarge --region ap-southeast-1 --output table
------------------------------------------------------------
|               DescribeInstanceTypeOfferings              |
+----------------------------------------------------------+
||                  InstanceTypeOfferings                 ||
|+--------------+-------------------+---------------------+|
|| InstanceType |     Location      |    LocationType     ||
|+--------------+-------------------+---------------------+|
||  c5.xlarge   |  ap-southeast-1a  |  availability-zone  ||
||  c5.xlarge   |  ap-southeast-1c  |  availability-zone  ||
||  c5.xlarge   |  ap-southeast-1b  |  availability-zone  ||
|+--------------+-------------------+---------------------+|
[yjkim1@yjkim1-mi terraform]$ aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=t2.micro --region ap-southeast-1 --output table
------------------------------------------------------------
|               DescribeInstanceTypeOfferings              |
+----------------------------------------------------------+
||                  InstanceTypeOfferings                 ||
|+--------------+-------------------+---------------------+|
|| InstanceType |     Location      |    LocationType     ||
|+--------------+-------------------+---------------------+|
||  t2.micro    |  ap-southeast-1b  |  availability-zone  ||
||  t2.micro    |  ap-southeast-1a  |  availability-zone  ||
||  t2.micro    |  ap-southeast-1c  |  availability-zone  ||
|+--------------+-------------------+---------------------+|
[yjkim1@yjkim1-mi terraform]$ aws ec2 describe-availability-zones --region ap-southeast-1
{
    "AvailabilityZones": [
        {
            "State": "available",
            "OptInStatus": "opt-in-not-required",
            "Messages": [],
            "RegionName": "ap-southeast-1",
            "ZoneName": "ap-southeast-1a",
            "ZoneId": "apse1-az1",
            "GroupName": "ap-southeast-1",
            "NetworkBorderGroup": "ap-southeast-1",
            "ZoneType": "availability-zone"
        },
        {
            "State": "available",
            "OptInStatus": "opt-in-not-required",
            "Messages": [],
            "RegionName": "ap-southeast-1",
            "ZoneName": "ap-southeast-1b",
            "ZoneId": "apse1-az2",
            "GroupName": "ap-southeast-1",
            "NetworkBorderGroup": "ap-southeast-1",
            "ZoneType": "availability-zone"
        },
        {
            "State": "available",
            "OptInStatus": "opt-in-not-required",
            "Messages": [],
            "RegionName": "ap-southeast-1",
            "ZoneName": "ap-southeast-1c",
            "ZoneId": "apse1-az3",
            "GroupName": "ap-southeast-1",
            "NetworkBorderGroup": "ap-southeast-1",
            "ZoneType": "availability-zone"
        }
    ]
}


aws ec2 describe-availability-zones --zone-names ap-southeast-1c --output json --query ‘AvailabilityZones[0].ZoneId’
```