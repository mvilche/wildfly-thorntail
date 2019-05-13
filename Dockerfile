FROM centos:7

ENV MAVEN_VERSION=3.6.0 \
JRE_VERSION=java-11-openjdk \
JDK_VERSION=java-11-openjdk-devel

LABEL autor="Martin Vilche <mfvilche@gmail.com>" \
      io.k8s.description="Compilador de aplicaciones java con maven s2i" \
      io.k8s.display-name="Java Applications" \
      io.openshift.tags="builder,java,maven" \
      io.openshift.expose-services="8080" \
      org.jboss.deployments-dir="/opt/app-root" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

RUN yum install $JDK_VERSION $JRE_VERSION wget git telnet which openssh-clients -y && mkdir -p /opt/app-root /opt/maven && \
wget -q http://www-eu.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
tar xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt/maven && rm apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
ln -s /opt/maven/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/bin/mvn && yum clean all -y && rm -rf /var/cache/yum/*

COPY s2i/bin/ /usr/libexec/s2i
RUN adduser -u 1001 s2i && chown -R 1001:1001 /opt /usr/libexec/s2i
COPY --chown=1001:1001 config/settings.xml /home/s2i/.m2/settings.xml

WORKDIR /opt/app-root

USER 1001

EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]

