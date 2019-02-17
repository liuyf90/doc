#nginx docker 使用说明
摘自<http://www.ruanyifeng.com/blog/2018/02/nginx-docker.html>

> 看了阮一峰的nginx容器教程后，按照自己的macos系统进行了操作，仅有小部分适应自己系统的修改，绝大部分内容摘自**阮一峰的blog**。

##一. HTTP服务
Nginx的最大作用，就是搭建一个Web Server.有了容器，只要一行命令，服务器就假设好了，完全不用配置。
>
>		$ docker container run\
>			-d \
>			-p 9090:80 \
>			--rm \
>			--name mynginx \
>			nginx

上面的命令下载并运行官方的Nginx image,默认版本是最新版（latest）。

上面命令的各个参数含义如下。

> 		* -d: 在后台运行
> 		* -p：容器的80端口映射到本机的8080端口
> 		* --rm： 容器停止运行后，自动删除容器文件
> 		* --name：容器的名字为mynginx

  ----------
 ***(我在这里报错，原因是端口冲突，先停止容器，修改端口后成功)***
>		 $ docker container stop 3ec7b1188027
 -------------
 如果没有报错，就可以打开浏览器访问 localhost:9090了，正常情况下，应该显示欢迎页。
![MacDown Screenshot](http://www.ruanyifeng.com/blogimg/asset/2018/bg2018022703.png)

