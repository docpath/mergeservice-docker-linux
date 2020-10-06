# Docker Configuration Files for DocPath ® MergeService 2

This is a complete example about how to deploy DocPath ® DocPath ® MergeService 2 in Linux using Docker. The example must be completed with the following files in the same directory as the repositorized files:

- mergeservicepack-2.x.y.z: DocPath ® MergeService 2 Installer.
- DocPath License File.lic: License file.
 
## Steps 
To successfully perform the example follow the steps as indicated below:
- Use the mbe1224/debian-oracle-java:stretch-slim-jre8 image. This is a Linux Debian image with Oracle JRE 8 pre-installed.
- Install DocPath ® MergeService 2.
- Copy the license file into the image.
- Use port 8086 to receive generation requests.
- Run the run.sh file on the container entrypoint. run.sh is performed as follows :
  - Starts the license server to allow DocPath ® MergeService 2 execution.
  - Deploys DocPath ® MergeService 2.

## Necessary changes
- Change the mergeservicepack-2.x.y.z.jar with the corresponding version of DocPath ® MergeService 2.
- Change the DocPath_License_File.lic file with the corresponding license filename.

## How to build and deploy
Now we are going to build the container by executing the following sequence in the same directory where the dockerfile file is located:

`docker build -t docpath/mergeservice . `

**IMPORTANT!** the full stop at the end indicates the directory where the container is located, this is mandatory.

Run the container once it has been built, use the following sequence:

`docker run --name mergeservice --hostname <hostname_container> --detach -p 8086:8086 -v $RESOURCESDIR:/usr/local/docpath/mergeservicepack/mergeservice/Resources docpath/mergeservice`

The used parameters are:
- --name: this parameter indicates the name of the container, in this case dge.
- --hostname: this parameter indicates the hostname of the machine with license.
- --detach: this parameter indicates that no messages are displayed in the execution console, silent mode.
- -p 8086:8086: this parameter indicates the port of both host machine and dge.
- docpath/mergeservice: this is the name assigned previously while building the container.

Replace:
- $RESOURCESDIR: Resources folder in the host what will be linked with the specified folder in the container.

Example:

`docker run --name mergeservice --hostname mergeservice --detach -p 8086:8086 -v /home/mainuser/mergeservicesresources:/usr/local/docpath/mergeservicepack/mergeservice/Resources docpath/mergeservice` 
