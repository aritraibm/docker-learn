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


### 12. Remove any docker image

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

### Follow Step 1 and 2 from above.

### 1. Generate jar file, generate docker image and push it to docker hub from springboot application

* Description: We should have the ability to generate a jar file, generate docker image and pudh it to docker hub from our spring boot application. Go to pom.xml and modify the ```<build>``` tag as below (here we'll be using diferent springboot project, hence name will be diferent).
* pom.xml: 
  ```
  	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
			<plugin>
				<groupId>io.openliberty.boost</groupId>
				<artifactId>boost-maven-plugin</artifactId>
				<version>0.1</version>
				<executions>
					<execution>
						<id>default</id>
						<phase>install</phase>
						<goals>
							<goal>docker-build</goal>
							<goal>docker-push</goal>
						</goals>
					</execution>
				</executions>
				<configuration>
					<repository>aritradb/${project.artifactId}</repository>
					<tag>${project.version}</tag>
					<useMavenSettingsForAuth>true</useMavenSettingsForAuth>
					<buildArgs>
						<JAR_FILE>target/${project.build.finalName}.jar</JAR_FILE>
					</buildArgs>
				</configuration>
			</plugin>
		</plugins>
		<finalName>rest-demo</finalName>
	</build>
  ```

* Explanation: Here, instead of using manual steps (like above), we are using the maven plugin to do the same job. Create jar, image, and push into docker hub.
 
```
	<executions>
		<execution>
			<id>default</id>
			<phase>install</phase>
			<goals>
				<goal>docker-build</goal>
				<goal>docker-push</goal>
			</goals>
		</execution>
	</executions>
```
The above section is responsible to set the goal to build the docker image and push. 
```
	<configuration>
		<repository>aritradb/${project.artifactId}</repository>
		<tag>${project.version}</tag>
		<useMavenSettingsForAuth>true</useMavenSettingsForAuth>
		<buildArgs>
			<JAR_FILE>target/${project.build.finalName}.jar</JAR_FILE>
		</buildArgs>
	</configuration>
```
Above configuration describes our repository details along with tag name and uses the jar file name as build args.

* Steps to generate: 
  1. maven clean
  2. maven install
  
* Screenshot:
<img width="598" alt="execution runing" src="https://user-images.githubusercontent.com/103875790/175480008-db745f9e-762e-49a7-a8e1-4d938efd709a.PNG">

Go to docker hub to view the newly uploaded image. From there we can pull the image and run it as a container.

<img width="789" alt="docker-hub-1" src="https://user-images.githubusercontent.com/103875790/175483091-3b70bc30-9710-407c-bd95-e46041ab78f3.PNG">


<img width="784" alt="docker-hub-2" src="https://user-images.githubusercontent.com/103875790/175482375-2b73708e-336e-443b-9d91-65e257ca1e31.PNG">


### 2. Follow the same steps (from step 4) in the above section




## Version History

* v1.0.0
    * Initial Release
