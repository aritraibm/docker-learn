# Docker Implementation Document


## Docker Implementation Guidelines using Dockerfile

### Create a sample springboot rest API

* Description: First we'll be creating a sample rest API which will reurn a simple text while invoking a simple GET API.


### Install docker in Windows

* Description: It's simple, go ahead and install docker desktop in Windows.
* Url: https://docs.docker.com/desktop/windows/install/

<img width="959" alt="docker-desktop" src="https://user-images.githubusercontent.com/103875790/175329201-0654608f-0dd9-40d5-9095-b7fc0948a6c0.PNG">


### Generate jar file of springboot application

* Description: We should have the ability to generate a jar file of our spring boot application.
* pom.xml: 
  ```
  	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
		</plugins>
		<finalName>docker-sample-api</finalName>
	</build>
  ```
* Steps to generate: 
  1. maven clean
  2. maven install
  the jar will be generated based on the ```<finalName>``` tag mentioned above. Go to the target folder and we'll see our jar file (docker-sample-api.jar).
* Screenshot:
<img width="235" alt="maven-jar-name" src="https://user-images.githubusercontent.com/103875790/175330684-eb4b45fa-6f0b-43e1-b229-52383ec400f3.PNG">


### Create Dockerfile

* Description: To generate docker image from the springboot application, we need to configure ```Dockerfile```, in the root create a file named ```Dockerfile``` and use below on Dockerfile:
```
FROM openjdk:8
EXPOSE 8090
ADD target/docker-sample-api.jar docker-sample-api.jar
ENTRYPOINT [ "java", "-jar", "/docker-sample-api.jar" ]
```
It's saying we need to add openjdk version 8, expose the port as ```8090``` and mention the jar in ADD and entrypoint


### Make sure the docker is available and running

* Description: use the below command in cmd to know whether the docker is installed in your windows machine or not.
* Command: ```docker -v``` it'll return something like ```Docker version 20.10.16, build aa7e414``` as a command response


### Create docker image from springboot application

* Description: Use the below command to generate a docker image.
* Command: ```docker build . -t docker-sample-api```


### View the docker image

* Description: Use the below command to view all the docker images in your local system (be careful those are not available in docker hub till now, only present on the local machine).
* Command: ```docker images```
```
REPOSITORY          TAG       IMAGE ID       CREATED          SIZE
docker-sample-api   latest    4cefdb8ee5f0   13 minutes ago   544MB
rest-demo           latest    9e6afad6f392   22 hours ago     544MB
```

### Run/execute docker image

* Description: Use the below command to run the docker image.
* Command: ```docker run -p 8090:8090 docker-sample-api```


### View docker containers

* Description: Use the below command to view all available docker containers.
* Command: ```docker ps```
It'll return all the available containers on that system.
```
CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS                  PORTS                    NAMES
494700fb3243   docker-sample-api   "java -jar /docker-s…"   2 minutes ago   Up 2 minutes	   0.0.0.0:8090->8090/tcp   nostalgic_chebyshev
```

### Pause any docker container

* Description: Use the below command to pause the docker container.
* Command: ```docker pause 494700fb3243```


### Resume/unpause any docker container

* Description: Use the below command to resume/unpause the docker container.
* Command: ```docker unpause 494700fb3243```

### Stop any docker container

* Description: Use below command to stop docker container.
* Command: ```docker stop 494700fb3243```


## Push an image to docker hub (https://hub.docker.com/)

### Steps/notes to push any docker image to the docker hub
```
docker logout                                   # to make sure you're logged out and not cause any clashes
docker tag <imageId> myusername/docker-whale    # use :1.0.0 for specific version, default is 'latest'
docker login --username=myusername              # use the username/pwd to login to docker hub
docker push myusername/docker-whale             # use :1.0.0 for pushing specific version, default is 'latest'
```
based on our example, the commands should be:
```
docker logout                                   
docker tag docker-sample-api aritradb/docker-sample-api 
docker login --username=aritradb       
docker push aritradb/docker-sample-api
```
after pushing the return should be like this:
```
Using default tag: latest
The push refers to repository [docker.io/aritradb/docker-sample-api]
0ea37e415702: Pushed
89f3c2569d89: Pushed
cc63c81d3b06: Pushed
369123a7ed65: Pushed
5afd661c6106: Pushed
66183893ba24: Pushed
6840c8ff46bd: Pushed
97d5fec864d8: Pushed
latest: digest: sha256:9848e35f1185c9bfa1dad06e1f8852fcb82b50077823aa1665960d3f8063c75d size: 2007
```

### Steps/notes to pull any docker image from docker hub

* Pull: ```docker pull aritradb/docker-sample-api:latest```

* Run: ```docker run -p 8090:8090 aritradb/docker-sample-api```







## Version History

* v1.0.0
    * Initial Release
