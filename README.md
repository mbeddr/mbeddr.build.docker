# mbeddr.build.docker

This repository contains the source code for the Docker images used to build mbeddr and other MPS-based projects. It is
basically a TeamCity build agent with some additional packages for compiling the generated Java and C code.

Using the image to run a TeamCity agent is fairly simple:

```
docker pull mbeddr/mbeddr.build.docker
docker run --name buildAgent1 -d --restart=always -e AGENT_NAME=awesomeAgent mbeddr/mbeddr.build.docker
```

If you run Docker on a storage backend that supports size limits for the volumes it makes sense to limit the available
disk space for the agent:

```
docker pull mbeddr/mbeddr.build.docker
docker run --name buildAgent1 -d --restart=always --storage-opt size=50G -e AGENT_NAME=awesomeAgent mbeddr/mbeddr.build.docker
```

The agent gets its name from the environment variable `AGENT_NAME`. This name will show up in the teamcity web ui. If
you don't set the name you will endup with a agent called `placeholder`.

## Runnning the agent locally for troubleshooting

Docker can be installed [locally](https://docs.docker.com/get-docker). After starting Docker, execute the two commands of the previous section on the command line. You can start a command line in the started container by executing:

```
docker exec -it your_container_id /bin/bash
```

You can clone your Git repository via `git` and edit your builds script with an editor (you might need to install vi or nano inside the container via `apt-get install`). Make sure to select the correct Java versions when executing your build.

Here is an example for a Gradle script to execute it with JDK 11:

```gradlew build -Dorg.gradle.java.home=$JB_JAVA11_HOME```

# Installed JDKs

These JDKs are installed:
- OpenJDK 8 at $JAVA_HOME (default, used by the TeamCity agent)
- JetBrains Runtime (JDK) 11 at $JB_JAVA11_HOME
- JetBrains Runtime (JDK) 17 at $JB_JAVA17_HOME

MPS requires JDK 8 up to version 2019.1 but requires JDK 11 since version 2019.2. Since 2022.2 MPS requires JDK 17.

You can configure a build step in TeamCity to use a specific non-default JDK.

Builds using a recent version of [`mps-gradle-plugin`](https://github.com/mbeddr/mps-gradle-plugin/) can specify the JVM
to use for a particular invocation of MPS by setting the `executable` parameter (see the [documentation of the
`RunAntScript` task](https://github.com/mbeddr/mps-gradle-plugin/#runantscript)). This makes it possible to build
different branches of the same project with different JDKs without having to duplicate build configurations.

# Information about package versions

The exact version of an installed package depends on the used Linux image. Example: Ubuntu bionic is used as the base image. That means that the installed Python3 version is the latest version that can be found in this ubuntu version's repository which would be Python [3.6.5](https://packages.ubuntu.com/bionic/python3) at the time of writing. [Check version of Installed Package on Ubuntu / Debian](https://computingforgeeks.com/check-version-of-installed-package-on-ubuntu-debian/) describes how you can check the installed package version in your local Docker container.

