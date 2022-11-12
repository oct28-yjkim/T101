# build terraform 

* download 
```sh 

[yjkim1@yjkim1-mi 02.cloud]$ git clone https://github.com/hashicorp/terraform.git .tf-tmp 

[yjkim1@yjkim1-mi 02.cloud]$ cat .tf-tmp/Dockerfile  | grep -v "#"

FROM docker.mirror.hashicorp.services/golang:alpine
LABEL maintainer="HashiCorp Terraform Team <terraform@hashicorp.com>"

RUN apk add --no-cache git bash openssh

ENV TF_DEV=true
ENV TF_RELEASE=1

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
COPY . .
RUN /bin/bash ./scripts/build.sh

WORKDIR $GOPATH
ENTRYPOINT ["/bin/bash"] # add line 


[yjkim1@yjkim1-mi 02.cloud]$ sudo docker build -t yjkim1-terraform -f .tf-tmp/Dockerfile  .tf-tmp 

# image size too big
[yjkim1@yjkim1-mi 02.cloud]$ sudo docker images 
REPOSITORY                                TAG                 IMAGE ID       CREATED          SIZE
yjkim1-terraform                          latest              d9c8bdefbed8   5 minutes ago    2.85GB
hashicorp/terraform                       latest              8304274bc80d   37 hours ago     88.9MB
docker.mirror.hashicorp.services/golang   alpine              155ead2e66ca   4 weeks ago      328MB

cat << EOF > .tf-tmp/Dockerfile.slim 
FROM docker.mirror.hashicorp.services/golang:alpine AS builder
LABEL maintainer="HashiCorp Terraform Team <terraform@hashicorp.com>"

RUN apk add --no-cache git bash openssh

ENV TF_DEV=true
ENV TF_RELEASE=1

WORKDIR /src/github.com/hashicorp/terraform
COPY . .
RUN /bin/bash ./scripts/build.sh

FROM alpine:3.14

RUN apk --no-cache add ca-certificates git && mkdir /workspace

COPY --from=builder /go/bin/terraform /usr/local/bin/

WORKDIR /workspace

ENTRYPOINT ["/bin/sh"] 
EOF

sudo docker build -t yjkim1-terraform:slim -f .tf-tmp/Dockerfile.slim  .tf-tmp

[yjkim1@yjkim1-mi 02.cloud]$ sudo docker images 
REPOSITORY                                TAG                 IMAGE ID       CREATED          SIZE
yjkim1-terraform                          slim                b9cf1dd33f0a   16 seconds ago   69.5MB

sudo docker run -it --rm yjkim1-terraform:slim 

~ # terraform --version
Terraform v1.3.0-dev
on linux_amd64

exit 

[yjkim1@yjkim1-mi 02.cloud]$ echo $PWD
/home/yjkim1/workspace/terraform/02.cloud

sudo docker run -it --rm --net=host -v $PWD:/workspace yjkim1-terraform:slim 

terraform init
terraform plan
terraform apply 
terraform destroy 
```
