# Java Wildfly Thorntail S2I Images Alpine Linux (DEPRECTAED)


DEPRECATED IN FAVOR OF https://github.com/mvilche/java-microservices-s2i

![Docker Stars](https://img.shields.io/docker/stars/mvilche/wildfly-thorntail-s21.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/mvilche/wildfly-thorntail-s21.svg)
![Docker Automated](https://img.shields.io/docker/cloud/automated/mvilche/wildfly-thorntail-s21)
![Docker Build](https://img.shields.io/docker/cloud/build/mvilche/wildfly-thorntail-s21)


# Features

- Non-root
- Openshift compatible
- S2i build images
- Maven
- Jolokia java monitoring

### Deploy Environments 


| Environment | Details |
| ------ | ------ |
| TIMEZONE | Set Timezone (America/Montevideo, America/El_salvador) |
| JAVA_OPTS | set JAVA_OPTS options|
| APP_OPTIONS | set extra arguments when applicattion start |
| WAITFOR_HOST | set name host |
| WAITFOR_PORT | set port for WAITFOR_HOST |



### Build Environments 


| Environment | Details |
| ------ | ------ |
| EXTRA_REPO | Compile extra repo  |
| TAG_VERSION | Project version  |
| MVN_OPTS | Maven options  |
| NEXUS_MIRROR_URL | Nexus repository override repository in pom.xml |




### How use in Openshift

```console

oc process -f https://raw.githubusercontent.com/mvilche/wildfly-thorntail/master/wildfly-thorntail-s2i-template-dev.yaml \ 
-p APP_NAME=myapp \
-p VERSION_JDK=11 \ 
-p REPO_GIT=https://github.com/myuser/java-sample-app.git
-p SOURCE_SECRET=github | oc create -f -

```


### Generate builder image

```console

 docker build -t wildfly-thorntail-s2i:openjdk11-jdk -f openjdk11/Dockerfile.jdk myapp

```

### Php application image use s2i

```console

s2i build https://github.com/myuser/java-sample-app.git wildfly-thorntail-s2i:openjdk11-jdk myapp:latest --incremental

```


### Run application

```console

docker run -p 8080:8080 myapp:latest

```

### How use s2i

```console

https://github.com/openshift/source-to-image

```

License
----

Martin vilche
