About this container
---
This container runs a NZBGet Usenet downloader on [Alpine Linux](https://alpinelinux.org/). More about NZBGet can be found at:

  http://nzbget.net/


If you're running this container for the first time, the default login details are:

 * user: `nzbget`
 * pass: `tegbzn6789`


Running from Docker Hub
---
Pull and run -- it's this simple.

```
# pull from docker hub
$> docker pull cturra/nzbget

# run nzbget
$> docker run --name=nzbget                                 \
              --restart=always                              \
              --detach=true                                 \
              --env=NZBGET_TRACK=stable                     \
              --publish=6789:6789                           \
              --volume=/path/to/data/:/data                 \
              --volume=/path/to/downloads/:/data/downloads  \
              cturra/nzbget
```

Building and Running with Docker Compose
---
Using the docker-compose.yml file included in this git repo, you can build the container yourself (should you choose to).

```
# build nzbget
$> docker-compose build nzbget

# run nzbget
$> docker-compose up -d nzbget

# (optional) check the logs
$> docker-compose logs nzbget
```

Building and Running with Docker Engine
---
Using the vars file in this git repo, you can update any of the variables to reflect your environment. Once updated, simply execute the build then run scripts.

```
# build nzbget
$> ./build.sh

# run nzbget
$> ./run.sh
```
