# 通过docker-compose的volumes 数据卷来存储mysql docker中的数据

学习了一下如何使用数据卷 [Docker 持久化存储和数据共享_Volume](https://my.oschina.net/665544/blog/1933032),自己动手练习了一下，总结如下：

1.  在本机新建目录如下
	
		mkdir 	/usr/mydocker/mysql-volume/mysql
	

2.  编写docker-compose.yml

		version: '3'
		services:
		  mysql:
		    image: mysql:5.7.25
		    ports:
		     - 3307:3306
		    volumes:
		     - /usr/mydocker/mysql-volume/mysql  #新建本机卷
		    environment:
		     - MYSQL_ROOT_PASSWORD=123456
		     - MYSQL_DATABASE=score
		  score:
		    image: socre:1.0
		    links:
		     - mysql
		    depends_on:
		     - mysql
		    ports:
		     - 18530:18530
		    environment:
		     - spring.datasource.url=jdbc:mysql://mysql/score?useSSL=false&useUnicode=true&characterEncoding=utf8&characterSetResults=utf8&autoReconnect=true&failOverReadOnly=false
		    command: "java -jar record-the-points-0.0.1-SNAPSHOT.jar"
		  nginx:
		    image: nginx
		    ports:
		     - 9090:80
		     
		     
3. 首先运行编排器

		docker-compose up -d
		
4. 查看/usr/mydocker/mysql-volume/mysql 目录下，果然有数据

		[root@localhost mysql]# ls
		auto.cnf    ca.pem           client-key.pem  ibdata1      ib_logfile1  mysql               private_key.pem  score            server-key.pem
		ca-key.pem  client-cert.pem  ib_buffer_pool  ib_logfile0  ibtmp1       performance_schema  public_key.pem   server-cert.pem  sys
		
5. 通过navicat将score库导入数据，确认数据导入
6. 终止容器
	
		docker-compose down
		
7. 再次运行编排器
		
		docker-compose up
		
8. 通过navicat查看score表数据都在，确认数据卷在本地部署成功！
		
		