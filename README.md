#mbeddr.build.docker

This repository contains the source code for the docker images used to build mbeddr and other MPS based projects.
It is basically a teamcity build agent with some additional packages for compiling.

Using the image is fairly simple:

```
docker pull mbeddr/mbeddr.build.docker
docker run --name buildAgent1 -d --restart=always -e AGENT_NAME=awesomeAgent mbeddr/mbeddr.build.docker
```

If you run docker on a storage backend that supports size limits for the volumes it makes sense to limit the available disk space for the agent:

```
docker pull mbeddr/mbeddr.build.docker
docker run --name buildAgent1 -d --restart=always --storage-opt size=50G -e AGENT_NAME=awesomeAgent mbeddr/mbeddr.build.docker
```


The agent gets its name from the environment variable `AGENT_NAME`. This name will showup in the teamcity web ui. If you don't set
the name you will endup with a agent called `placeholder`.
