FROM mbe1224/debian-oracle-java:stretch-slim-jdk8

RUN apt-get update && apt-get install -y apt-utils && apt-get install -y lib32stdc++6 gcc-multilib procps
RUN mkdir /required_files
COPY mergeservicepack-2.x.y.z-java.jar /required_files/
WORKDIR /required_files
RUN java -jar mergeservicepack-2.x.y.z-java.jar -solname"DocPath Merge Service" -install -solution"/usr/local/docpath/mergeservicepack/mergeservice/Bin" -silentmode -console -licserverpath"/usr/local/docpath/licenseserver" -licserverport1765
COPY DocPath_License_File.lic /usr/local/docpath/Licenses/
COPY run.sh /usr/local/bin/
WORKDIR /
RUN rm -rf /required_files
EXPOSE 1790

ENTRYPOINT ["/usr/local/bin/run.sh"]

