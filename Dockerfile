FROM alpine:3.10

ENV MAVEN_VERSION=3.5.4 \
JDK_VERSION=openjdk8

LABEL autor="Martin Vilche <mfvilche@gmail.com>" \
      io.k8s.description="Compilador de aplicaciones java con maven s2i" \
      io.k8s.display-name="Java Applications" \
      io.openshift.tags="builder,java,maven" \
      io.openshift.expose-services="8080" \
      org.jboss.deployments-dir="/opt/app-root" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

RUN apk add --update --no-cache $JDK_VERSION wget bash git busybox-extras which openssh shadow busybox-suid coreutils tzdata msttcorefonts-installer fontconfig
RUN update-ms-fonts && \
    fc-cache -f && \ 
mkdir -p /opt/app-root /opt/maven && rm -rf /etc/localtime && \
wget -q http://www-eu.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
tar xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt/maven && rm apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
ln -s /opt/maven/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/bin/mvn

COPY s2i/bin/ /usr/libexec/s2i
RUN mkdir /opt/config && touch /etc/localtime /etc/timezone && adduser -D -u 1001 s2i && usermod -aG 0 s2i && \
chown -R 1001 /opt /home/s2i /usr/libexec/s2i /etc/localtime /etc/timezone  && \
chgrp -R 0 /opt /home/s2i /usr/libexec/s2i /etc/localtime /etc/timezone  && \
chmod -R g=u /opt /usr/libexec/s2i /etc/localtime /etc/timezone

WORKDIR /opt/app-root

USER 1001

EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]

