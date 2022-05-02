# Docker Configuration Files for DocPath ® MergeService 2

This is a complete example about how to deploy DocPath ® DocPath ® MergeService 2 in Linux using Docker. The example must be completed with the following files in the same directory as the repositorized files:

- mergeservicepack-2.xx.y.z: DocPath ® MergeService 2 Installer.
- DocPath License File.olc: License file.
 
## Steps 
To successfully perform the example follow the steps indicated below:
- Use the openjdk:8 image. This is a Linux Debian image with OpenJDK 8 pre-installed.
- Install DocPath ® MergeService 2.
- Copy the license file into the image.
- Use port 8086 to receive generation requests.
- Run the run.sh file on the container entrypoint. run.sh is performed as follows :
  - Starts the license server to allow DocPath ® MergeService 2 execution.
  - Deploys DocPath ® MergeService 2.

## Necessary Changes
- Change the `mergeservicepack-2.x.y.z.jar` with the corresponding version of DocPath ® MergeService 2.
- Change the `DocPath_License_File.olc` file with the corresponding license filename.

## How to Build and Deploy
Now we are going to build the container by executing the following sequence in the same directory where the dockerfile file is located:

`docker build -t docpath/mergeservice . `

**IMPORTANT!** the full stop at the end indicates the directory where the container is located, this is mandatory.

In the installation, the following values has been taken by default:

- -licserverpath **/usr/local/docpath/licenseserver**
- -licserverport**1765**

Once the container has been built, run it by using the following sequence:

`docker run --name mergeservice --hostname <hostname_container> --detach -p 8086:8086 -v $RESOURCESDIR:/usr/local/docpath/mergeservicepack/mergeservice/Resources docpath/mergeservice`

The parameters used are:
- --name: this parameter indicates the name of the container, in this case mergeservice.
- --hostname: this parameter indicates the hostname of the machine with license.
- --detach: this parameter indicates that no messages are displayed in the execution console, silent mode.
- -p 8086:8086: this parameter indicates the port of both host machine and mergeservice.
- docpath/mergeservice: this is the name assigned previously while building the container.

Replace:
- $RESOURCESDIR: Resources folder in the host what will be linked with the specified folder in the container.

Example:

`docker run --name mergeservice --hostname mergeservice --detach -p 8086:8086 -v /home/mainuser/mergeservicesresources:/usr/local/docpath/mergeservicepack/mergeservice/Resources docpath/mergeservice`

To use a session license, please follow the steps below:

`docker run --name mergeservice --hostname mergeservice --detach -p 8086:8086 -e TRANSACTION_ID=<session_transaction_id> -e SHUTDOWN_SESSION=<shutdown_session> -e LICENSE_ADDRESS=<license_server_address> -e LICENSE_PORT=<license_server_port> -v $RESOURCESDIR:/usr/local/docpath/mergeservicepack/mergeservice/Resources docpath/mergeservice`

- TRANSACTION_ID: indicates the license identifier. Mandatory field if you want to start the service with the license in session mode.
- SHUTDOWN_SESSION: indicates to close the license session once the service is stopped. Mandatory field if you want to start the service with the license in session mode.
- LICENSE_PORT: indicates the port of the license server. Mandatory field if you want to start the service with the license in session mode.
- LICENSE_ADDRESS: indicates the address of the license server. Mandatory field if you want to start the service with the license in session mode.

Example:

`docker run --name mergeservice --hostname mergeservice --detach -p 8086:8086 -e TRANSACTION_ID=d1234ec5-fe67-8f90-a123-45f67890123b -e SHUTDOWN_SESSION=TRUE -e LICENSE_ADDRESS=localhost -e LICENSE_PORT=1765 -v /home/mainuser/mergeservicesresources:/usr/local/docpath/mergeservicepack/mergeservice/Resources docpath/mergeservice`

**IMPORTANT!** The command `sleep 5` is added from `run.sh`. This is a delay necessary for the license server to be launched before DocPath® MergeService 2 is deployed. If it is removed or if an insufficient time (in seconds) is indicated, an error may result in the license product.

