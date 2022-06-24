# Docker Implementation Document


## Docker Implementation Guidelines using Dockerfile (option-1)

### 1. Create a sample springboot rest API

* Description: First we'll be creating a sample rest API (in springboot, code is available in this repo ```without-maven-plugin```) which will reurn a simple text while invoking a simple GET API.


### 2. Install docker in Windows

* Description: It's simple, go ahead and install docker desktop in Windows.
* URL: https://docs.docker.com/desktop/windows/install/

<img width="959" alt="docker-desktop" src="https://user-images.githubusercontent.com/103875790/175329201-0654608f-0dd9-40d5-9095-b7fc0948a6c0.PNG">


### 3. Generate jar file of springboot application

* Description: We should have the ability to generate a jar file of our spring boot application. Go to pom.xml and modify the ```<build>``` tag as below
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
  the jar will be generated based on the ```<finalName>``` tag mentioned above. Go to the target folder and we'll see our jar file (docker-sample-api.jar), we can also mention the name dynamically by mnetioning ```<>``` tag.
* Screenshot:
<img width="235" alt="maven-jar-name" src="https://user-images.githubusercontent.com/103875790/175330684-eb4b45fa-6f0b-43e1-b229-52383ec400f3.PNG">


### 4. Create Dockerfile

* Description: To generate docker image from the springboot application, we need to configure ```Dockerfile```. in the root create a file named ```Dockerfile```  and use below on Dockerfile (it'll pick by docker automatically if we follow the naming convention as mentioned here):
```
FROM openjdk:8
EXPOSE 8090
ADD target/docker-sample-api.jar docker-sample-api.jar
ENTRYPOINT [ "java", "-jar", "/docker-sample-api.jar" ]
```
Here it's saying we need to add openjdk version 8, expose the port as ```8090``` and mention the jar in ADD and ENTRYPOINT


### 5. Make sure the docker is available and running

* Description: Use the below command in cmd to know whether the docker is installed in your windows machine or not. we can also see in docker desktop as below screenshot.
* Command: ```docker -v``` it'll return something like ```Docker version 20.10.16, build aa7e414``` as a command response
<img width="477" alt="engine-running" src="https://user-images.githubusercontent.com/103875790/175453368-fea5cfaa-99ac-4395-a2bf-4f16b884cddd.PNG">


### 6. Create docker image from springboot application

* Description: Go to the root folder of springboot application, Open cmd and use the below command to generate a docker image. It'll help us to generate a docker image based on the instruction written in Dockerfile that we created earlier.
* Command: ```docker build . -t docker-sample-api```


### 7. View the docker image

* Description: Use the below command to view all the docker images in your local system (be careful these are not available in docker hub till now, only present on the local machine).
* Command: ```docker images```
```
REPOSITORY          TAG       IMAGE ID       CREATED          SIZE
docker-sample-api   latest    4cefdb8ee5f0   13 minutes ago   544MB
rest-demo           latest    9e6afad6f392   22 hours ago     544MB
```

### 8. Run/execute docker image

* Description: Use the below command to run the docker image. So it'll run the springboot application as a docker container and will be available in port 8090. We can use image name or image id.
* Command (image name): ```docker run -p 8090:8090 docker-sample-api```
* Command (image id): ```docker run -p 8090:8090 4cefdb8ee5f0```


### 9. View docker containers

* Description: Use the below command to view all available docker containers.
* Command: ```docker ps```
It'll return all the available containers on that system.
```
CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS                  PORTS                    NAMES
494700fb3243   docker-sample-api   "java -jar /docker-s…"   2 minutes ago   Up 2 minutes	   0.0.0.0:8090->8090/tcp   nostalgic_chebyshev
```

### 10. Pause any docker container

* Description: Use the below command to pause the docker container. Remember ```494700fb3243``` is our container id.
* Command: ```docker pause 494700fb3243```


### 11. Resume/unpause any docker container

* Description: Use the below command to resume/unpause the docker container.
* Command: ```docker unpause 494700fb3243```


### 12. Stop any docker container

* Description: Use below command to stop docker container.
* Command: ```docker stop 494700fb3243```


### 12. Remove any docker container

* Description: Use below command to remove docker image (please stop the container if it's already running). Add ```rm``` for removal.
* Command: ```docker image rm 494700fb3243```


### 13. Push an image to docker hub (https://hub.docker.com/)

**Steps/notes to push any docker image to the docker hub**
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
After pushing the return should be like this:
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

### 14. Steps/notes to pull any docker image from docker hub

* Pull (by default): ```docker pull aritradb/docker-sample-api:latest```
* Pull (by tag name): ```docker pull aritradb/docker-sample-api:0.0.1-SNAPSHOT```

* Run: ```docker run -p 8090:8090 aritradb/docker-sample-api```




## Docker Implementation Guidelines using maven plugin (option-2)

### 1. Create a sample springboot rest API

* Description: First we'll be creating a sample rest API (in springboot, code is available in this repo) which will reurn a simple text while invoking a simple GET API.



## Version History

* v1.0.0
    * Initial Release
