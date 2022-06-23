# Docker Implementation Document


## Docker Implementation Document

### Create a sample springboot rest api

* Description: First we'll be creating a sample rest api which will reurn simple text as return while invoking simple GET api.


### Install docker in Windows

* Description: It's simple, go ahead and install docker desktop in Windows.
* Repository: [https://github.com/aritraibm/service-registry.git](https://github.com/aritraibm/service-registry.git)
* Repository: ```NA```
<img width="959" alt="docker-desktop" src="https://user-images.githubusercontent.com/103875790/175329201-0654608f-0dd9-40d5-9095-b7fc0948a6c0.PNG">



### Generate jar file of springboot application

* Description: We should have the ability to generate jar file of our spring boot application.
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
  Jar will be generated based on the ```<finalName>``` tag mentioned above. Go to target folder and we'll see our jar file (docker-sample-api.jar).
* Screenshot:
<img width="235" alt="maven-jar-name" src="https://user-images.githubusercontent.com/103875790/175330684-eb4b45fa-6f0b-43e1-b229-52383ec400f3.PNG">


### Create Dockerfile

* Description: To generate dockerimage from the springboot application, we need to configure ```Dockerfile```, in the root create a file named ```Dockerfile``` and use below on Dockerfile:
```
FROM openjdk:8
EXPOSE 8090
ADD target/docker-sample-api.jar docker-sample-api.jar
ENTRYPOINT [ "java", "-jar", "/docker-sample-api.jar" ]
```
It's saying we need to add openjdk version 8, expose the port as ```8090``` and mention the jar in ADD and entrypoint


### Make sure the docker is availble and running

* Description: use below command in cmd to know whether the docker is installed in your windows machine or not.
* Command: ```docker -v``` it'll return something like ```Docker version 20.10.16, build aa7e414``` as a command response


### Create docker image from springboot application

* Description: Use below command to generate docker image.
* Command: ```docker build . -t docker-sample-api```


### View the docker image

* Description: Use below command to view all the docker images in your local system (be carefull those are not available in docker hub till now, only present in local machine).
* Command: ```docker images```
```
REPOSITORY          TAG       IMAGE ID       CREATED          SIZE
docker-sample-api   latest    4cefdb8ee5f0   13 minutes ago   544MB
rest-demo           latest    9e6afad6f392   22 hours ago     544MB
```

### Create docker image from springboot application

* Description: Use below command to generate docker image.
* Command: ```docker build . -t docker-sample-api```


### Create docker image from springboot application

* Description: Use below command to generate docker image.
* Command: ```docker build . -t docker-sample-api```


### Create docker image from springboot application

* Description: Use below command to generate docker image.
* Command: ```docker build . -t docker-sample-api```


### Create docker image from springboot application

* Description: Use below command to generate docker image.
* Command: ```docker build . -t docker-sample-api```


## Distributed Logging Implementation

### ELK Stack (with Sleuth)

* Description: To implement distributed logging, we can use Logstash, Elastic Search, and Kibana. Sleuth will help us to generate and maintain a global trace or correlation id for all the required applications. Logstash will collect the logs from the application and provide them into elastic search and Kibana helps us to visualize (as it provides us an interactive UI to view) the logs.
Here, we used ELK with the 7.6.2 version as it’s compatible with jdk8, however, we can use any of the updated versions with updated JDK. Sleuth dependency is available in user service pom.xml and below are the download link for all of the ELK applications.

* ElasticSearch: https://www.elastic.co/downloads/elasticsearch

* Logstash: https://www.elastic.co/downloads/logstash

* Kibana: https://www.elastic.co/downloads/kibana


### Zipkin & Rabbit (with Sleuth)

* Description: Zipkin is also a very good way to maintain/ view the distributed logs. Here also, Sleuth will help us to generate and maintain a global trace or correlation id for all the required applications. It’s recommended to integrate Zipkin with rabbit (MQ) to avoid single failure scenarios.


## Functionalities & Endpoints

### Save Department Details

* Description: This API will save new department details.
* URL: ```http://localhost:9191/pru-dept/save-dept```
* HTTP method: ```POST```
* Body: 
```
{
    "deptName": "IT",
    "deptAddress": "India",
    "deptCode": "D-001"
}
```


### Get Department Details by Department Id

* Description: This API will get existing department details by department Id.
* URL: ```http://localhost:9191/pru-dept/get-dept/4```
* HTTP method: ```GET```
* Body: 
```
NA
```



### Save User Details

* Description: This API will save new user details.
* URL: ```http://localhost:9191/pru-user/save-user```
* HTTP method: ```POST```
* Body: 
```
{
    "firstName": "Alex",
    "lastName": "Nichols",
    "email": "alex@test.com",
    "deptId": 4
}
```



### Get User Details by User Id (JPA method)

* Description: This API will get existing user details by user Id.
* URL: ```http://localhost:9191/pru-user/get-user/5```
* HTTP method: ```GET```
* Body: 
```
NA
```



### Get User Details by User Id (Named Native - SQL)

* Description: This API will get existing user details by user Id.
* URL: ```http://localhost:9191/pru-user/get-user-by-named-native/5```
* HTTP method: ```GET```
* Body: 
```
NA
```



### Get User Details by User Id (Named - JPQL)

* Description: This API will get existing user details by user Id.
* URL: ```http://localhost:9191/pru-user/get-user-by-named/5```
* HTTP method: ```GET```
* Body: 
```
NA
```


## Version History

* v1.0.0
    * Initial Release
