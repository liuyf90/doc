# Docker间的互相调用

今天研究了一下如何将一个Springboot项目打包为Docker镜像，并调用另一个mysql的Docker镜像。

## 准备工作
1.	mysql镜像不多说了，网上很多，我的镜像名字是my-mysql.
2. 将一个springboot项目编译为jar包->**record-the-points-0.0.1-SNAPSHOT.jar**

## 制作image文件
>	1. $	mkdir mkdockerforsocre  #新建目录
>	2. $	vi Dockerfile       #创建Dockerfile文件
>			
>			FROM insideo/centos7-java8-build
			COPY . /app
			WORKDIR /app
			EXPOSE 18530
			
>	3. 将record-the-points-0.0.1-SNAPSHOT.jar 文件拷贝到mkdockerforsocre。目录下
目录下的文件如下：

>     		Dockerfile				record-the-points-0.0.1-SNAPSHOT.jar


> 4. docker image build -t score:1.0 .   #构建镜像文件
>5. 查看my-mysql容器的ip地址
>
>			 sdocker  inspect my-mysql
>

## 启动并建立容器
>		
>		docker container run -d -p 18530:18530 socre:1.0  java -jar record-the-
>		points-0.0.1-SNAPSHOT.jar  spring.datasource.url=jdbc:mysql://172.17.0.1
>		:3306/score	

>**http://127.0.0.1:18530  即可访问**