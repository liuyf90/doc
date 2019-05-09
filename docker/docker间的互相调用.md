# Docker间的互相调用

今天研究了一下如何将一个Springboot项目打包为Docker镜像，并调用另一个mysql的Docker镜像。



##  准备工作
1.	mysql镜像不多说了，网上很多，我的镜像名字是my-mysql.
2. 将一个springboot项目编译为jar包->**record-the-points-0.0.1-SNAPSHOT.jar**

## 制作image文件
1.  $	mkdir mkdockerforsocre  #新建目录
2. 将 **record-the-points-0.0.1-SNAPSHOT.jar**文件拷贝到 mkdockerforsocre 目录
2.  $	vi Dockerfile       #创建Dockerfile文件

	```		
	FROM insideo/centos7-java8-build \
	COPY . /app \
	WORKDIR /app \
	EXPOSE 18530 
			
3. 将record-the-points-0.0.1-SNAPSHOT.jar 文件拷贝到mkdockerforsocre。目录下
目录下的文件如下：

		Dockerfile    record-the-points-0.0.1-SNAPSHOT.jar


4. docker image build -t score:1.0 .   #构建镜像文件



# 方法一（直接docker间调用）

##  启动并建立容器

1. 查看my-mysql容器的ip地址

			 $ docker  inspect my-mysql

2. 例如 ip为172.17.0.1，那么我们启动容器时覆盖url参数为172.17.0.1

			docker container run -d -p 18530:18530 socre:1.0  java -jar record-the-\
			points-0.0.1-SNAPSHOT.jar  spring.datasource.url=jdbc:mysql://172.17.0.1:3306/score

	**http://127.0.0.1:18530  即可访问**


# 方法二（通过docker-componse编排）
1. 新建文件 docker-compose.yml

	```
	version: '3'
		  services:
	       rabbit:
	       image: rabbitmq:3-managementß
	       ports:
	        - 8080:15672
	        - 5762:5762
	     mysql:
	       image: mysql:5.7.25
	       ports:
	        - 3307:3306
	       environment:
	        - MYSQL_ROOT_PASSWORD=123456
	        - MYSQL_DATABASE=score
	       command: --lower_case_table_names=1 #大小写不敏感
	     score:
	       image: socre:1.0
	       links:
	        - mysql    #通过内部链接上mysql
	       depends_on:
	        - mysql
	       ports:
	        - 18530:18530
	       environment:
	        - spring.datasource.url=jdbc:mysql://mysql/score?useSSL=false&useUnicode=true&characterEncoding=utf8&characterSetResults=utf8&autoReconnect=true&failOverReadOnly=false   #通过环境变量覆盖spring.datasource.url参数，通过links的名字来接连（静态路由）
	       command: "java -jar record-the-points-0.0.1-SNAPSHOT.jar"
	

2. 运行

		 	docker-compose up

3. 停止

			docker-compose down
