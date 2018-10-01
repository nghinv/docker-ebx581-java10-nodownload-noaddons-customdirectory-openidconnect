###
# Use docker run to start a new container with a given image: docker run -it <image name> <command>
# docker run -it <image name> <command>

# -d              : To start a container in detached mode, you use -d=true or just -d option
# -i              : Keep STDIN open even if not attached
# -t              : Allocate a pseudo-tty
###

# docker build -t ebx5.8.1-azure-openidconnect .
# put your ebxLicense in ~/.profile
# export EBXLICENSE=XXXXX-XXXXX-XXXXX-XXXXX
# source ~/.profile
# docker run -p 9090:8080 -e "CATALINA_OPTS=-DebxLicense=$EBXLICENSE" ebx5.8.1-azure-openidconnect
# docker run -it ebx5.8.1-azure-openidconnect bash
# docker ps # find your container name
# docker exec -it dazzling_roentgen /bin/bash

#########
#########
#########
# Red Hat Enterprise Linux (RHEL)
FROM amazonlinux:2018.03

RUN yum -y update \
   && yum clean all

RUN yum -y install tar unzip wget findutils shadow-utils.x86_64 \
   && yum clean all

WORKDIR /data

####
#### SETUP JDK JAVA.11
####

RUN curl -L -b "oraclelicense=a" http://download.oracle.com/otn-pub/java/jdk/11+28/55eed80b163941c8885ad9298e6d786a/jdk-11_linux-x64_bin.rpm -O
RUN echo "049425c2dbca9bab2298bb2ab08958ce5d2ba311e632ebb45d1c2231961ee7aa  jdk-11_linux-x64_bin.rpm" > SHA256SUMS
RUN sha256sum -c SHA256SUMS
RUN rpm -ivh jdk-11_linux-x64_bin.rpm
RUN rm -fr jdk-11_linux-x64_bin.rpm

####
#### SETUP TOMCAT 9
####

ENV CATALINA_HOME /data/app/tomcat
WORKDIR $CATALINA_HOME

RUN wget http://apache.claz.org/tomcat/tomcat-9/v9.0.12/bin/apache-tomcat-9.0.12.tar.gz \
  && echo "f03bdfcc85a5fc0cd4f5cbb4c7d1e7b8b48014383e47d9a92c6e974adcb0cbf8ce0f3620fee2cd267b0c46f7238c3431847cb86076283ae252ab91260e8bf569 *apache-tomcat-9.0.12.tar.gz" > SHA512SUMS \
  && sha512sum -c SHA512SUMS \
  && tar -C "${CATALINA_HOME}/" -xvf apache-tomcat-9.0.12.tar.gz --strip-components=1 \
  && rm apache-tomcat-9.0.12.tar.gz \
  && rm SHA512SUMS

####
#### SETUP JDBC drivers
####

ENV PSQL_LIBS_VERSION 42.2.2

RUN curl -k -SL -o lib/postgresql-${PSQL_LIBS_VERSION}.jar https://jdbc.postgresql.org/download/postgresql-${PSQL_LIBS_VERSION}.jar

COPY addOracleLibs.sh addOracleLibs.sh
RUN chmod +x addOracleLibs.sh \
&& ./addOracleLibs.sh http://download.oracle.com/otn-pub/java/javamail/1.4.5/javamail1_4_5.zip http://download.oracle.com/otn-pub/java/jaf/1.1.1/jaf-1_1_1.zip \
&& rm -rf addOracleLibs.sh

COPY addJarLib.sh addJarLib.sh
RUN chmod +x addJarLib.sh \
&& ./addJarLib.sh http://central.maven.org/maven2/com/h2database/h2/1.4.197/h2-1.4.197.jar http://central.maven.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar http://central.maven.org/maven2/org/slf4j/slf4j-simple/1.7.25/slf4j-simple-1.7.25.jar http://central.maven.org/maven2/javax/xml/ws/jaxws-api/2.3.0/jaxws-api-2.3.0.jar http://central.maven.org/maven2/javax/xml/soap/javax.xml.soap-api/1.4.0/javax.xml.soap-api-1.4.0.jar \
&& ./addJarLib.sh http://central.maven.org/maven2/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.jar http://central.maven.org/maven2/org/json/json/20180813/json-20180813.jar \
&& rm -rf addJarLib.sh

####
#### SETUP EBX 5.8.1
####

ENV EBX_HOME /data/app/ebx

RUN mkdir -p ${EBX_HOME} \
    && mkdir /tmp/ebx

  COPY ebx_CD_5.8.1.1067-0027 /tmp/ebx
  RUN cp -v /tmp/ebx/ebx.software/webapps/wars-packaging/*.war webapps/ \
      && cp -v /tmp/ebx/ebx.software/lib/ebx.jar lib/ \
      && rm -fr /tmp/ebx/ \
      && mkdir -p conf/Catalina/localhost

COPY context/ebx.xml ${CATALINA_HOME}/conf/Catalina/localhost/ebx.xml
COPY context.xml conf/context.xml
# COPY server.xml conf/server.xml
# COPY logging.properties conf/logging.properties
COPY ebx.properties ${EBX_HOME}/ebx.properties

ENV PATH $CATALINA_HOME/bin:$PATH
ENV EBX_OPTS="-Debx.home=${EBX_HOME} -Debx.properties=${EBX_HOME}/ebx.properties"
ENV JAVA_OPTS="${EBX_OPTS} ${JAVA_OPTS} -Dorg.ops4j.pax.logging.DefaultServiceLog.level=WARN -Dorg.apache.cxf.Logger=org.apache.cxf.common.logging.Slf4jLogger"
ENV CATALINA_OPTS ""

###
# setup project
###

RUN cd /tmp
COPY setupMaven.sh setupMaven.sh
RUN chmod +x setupMaven.sh \
  && ./setupMaven.sh \
  && rm -rf setupMaven.sh

RUN yum install -y git

RUN git clone https://github.com/mickaelgermemont/ebx-customdirectory-openidconnect.git \
  && cd ebx-customdirectory-openidconnect \
  && mvn install \
  && cp /data/app/tomcat/ebx-customdirectory-openidconnect/target/CustomDirectoryRestToken-0.1.jar $CATALINA_HOME/lib/ \
  && rm -rf /tmp/ebx-customdirectory-openidconnect

###
# last
###

RUN groupadd -g 1000 user \
   && useradd -u 1000 -g 1000 -m -s /bin/bash user \
   && chown -R 1000 /data
USER user

EXPOSE 8080
WORKDIR /data/app
CMD ["catalina.sh", "run"]
