#mbeddr.build.docker

This repository contains the source code for the docker images used to build mbeddr and other MPS based projects.
It is basically a teamcity build agent with some additional packages for compiling.

Using the image is fairly simple:

```
docker pull coolya/mbeddr.build.docker
docker run --name buildAgent1 -v /path/to/agent/workdir:/build -d --restart=always -e AGENT_NAME=awesomeAgent coolya/mbeddr.build.docker
```

The image takes a volume `/build` which is used as a working directory for the agent.
The agent gets its name from the environment variable `AGENT_NAME`. This name will showup in the teamcity web ui. If you don't set
the name you will endup with a agent called `placeholder`.
