FROM centos:7

MAINTAINER Martin Vilche <mfvilche@gmail.com>

ENV MAVEN_VERSION=3.6.0

# Docker Image Metadata
LABEL io.k8s.description="Platform for building (Maven) and running plain Java applications" \
      io.k8s.display-name="Java Applications" \
      io.openshift.tags="builder,java,maven" \
      io.openshift.expose-services="8080" \
      org.jboss.deployments-dir="/deployments" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i

# Install Java
RUN INSTALL_PKGS="which wget java-1.8.0-openjdk java-1.8.0-openjdk-devel" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    mkdir -p /opt/s2i/destination /opt/app-root

# Install Maven
RUN wget -q http://www-eu.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mkdir /opt/maven && \
    tar xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt/maven && \
    rm apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    ln -s /opt/maven/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/local/bin/mvn

COPY ./s2i/bin/ /usr/libexec/s2i
RUN chown -R 1001:1001 /opt /usr/libexec/s2i
WORKDIR /opt
USER 1001

EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]

