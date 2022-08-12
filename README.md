## Icecast2 Docker Image

Simple docker image build for running [icecast2](https://icecast.org/) in a container. 

Feel free to contribute or give some suggestions or feedback!

### Installation

- Pull image from Github Packages:
  1. `docker pull ghcr.io/lealoureiro/icecast2-docker/icecast2:latest`

- Build image yourself:
  1. `git clone git@github.com:lealoureiro/icecast2-docker.git`
  2. `cd icecast2-docker`
  2. `docker build -t icecast-docker2 .`


### Configuration

Icecast2 cannot and should not run as root user, so make sure your run your container with a specific user and group.

Mount folder counting your `icecast2.xml` to `/app/conf`. You can find sample `icecast2.xml` config file in conf folder. Make sure the file is readable by the run user.\
Mount folder for application to store logs to `/app/log`. Make sure the selected user can write on the folder.


## Docker Run

`docker run --name icecast2 --rm -u 1000:100 -v /your/conf/folder:/app/conf -v /your/log/folder:/app/log -p 8000:8000 ghcr.io/lealoureiro/icecast2-docker/icecast2:latest`

## docker-compose.yml

```
version: '3'
services:
  icecast2:
    image: ghcr.io/lealoureiro/icecast2-docker/icecast2:lastest
    container_name: icecast2
    user: '1000:100'
    volumes:
      - /your/conf/folder:/app/conf
      - /your/log/folder:/app/log
```
