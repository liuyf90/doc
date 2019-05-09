# nginx docker 使用说明
------------------
摘自<http://www.ruanyifeng.com/blog/2018/02/nginx-docker.html>

> 看了阮一峰的nginx容器教程后，按照自己的macos系统进行了操作，仅有小部分适应自己系统的修改，绝大部分内容摘自**阮一峰的blog**。

## 一. HTTP服务
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
![MacDown Screenshot](https://github.com/liuyf90/doc/blob/master/pic/ngnix%E4%B8%BB%E9%A1%B5.png?raw=true)

然后把这个容器终止，由于-rm参数的作用，容器文件会自动删除。
> 		$ docker container stop mynginx

# 二. 映射网页目录
网页文件都在容器里，没法直接修改，显然很不方便。下一步就是让网页文件所在的目录/usr/share/nginx/html**(容器内)**映射到本地。

首先，新建一个目录，并进入该目录
>		$ mkdir nginx-docker-demo
>		$ cd nginx-docker-demo
然后新建一个html子目录。

>		$ mkdir html

在这个目录中，放置一个index.html文件，内容如下。

>		<h1>Hello World</h1>
接着，就可以把这个目录html，映射到容器的网页文件目录 /usr/share/nginx/html。

>		$ docker container run \
>			-d \
>			-p 9090:80 \
>			--rm \
>			--name mynginx \
>			--volume "$PWD/html":/usr/share/nginx/html \
>			nginx

打开浏览器，访问 localhost:9090,应该就能看到Hello World 了。


# 三. 拷贝配置
修改网页文件还不够，还要修改Nginx的配置文件，否则后面没法家ssl支持。
首先，把容器里面的Nginx配置文件拷贝到本地。

>   	$ docker container cp mynginx:/etc/nginx .

上面的命令的含义是，把mynginx容器的 /etc/nginx	拷贝到当前目录。**不要漏掉最后那个点**。

`执行完成后，当前目录应该多出一个nginx子目录。然后，把这个子目录改名为conf`

>		$ mv nginx conf

现在可以把容器停止了。

>		$ docker container stop mynginx

# 四. 映射配置目录

重新启动一个容器，这次不仅映射网页目录，还要映射配置目录.`（注意：运行在nginx-docker-demo目录下）`。

>		$ docker container run \
>			-d \
>			-p 9090:80 \
>			--rm \
>			--name mynginx \
>			--volume "$PWD/html":/usr/share/nginx/html \
>			--volume "$PWD/conf":/etc/nginx \
>			nginx

上面代码中， --volume "$PWD/conf":/etc/nginx 表示把容器的配置目录/etc/nginx,映射到本地的conf子目录。

浏览器访问localhost:9090，如果能看到网页，就说明本地的配置生效了。这时，可以把这个容器终止了。

>		$ docker container stop mynginx

# 五. 自签名证书

现在要为容器加入HTTP支持，第一件事就是生成私钥和证书。正式的证书需要证书当局（CA）的签名，这里是为了测试，搞一张自签名（self-signed）证书就可以了。

下面，我参考的是[DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04).的教程。首先，确定你的机器安装了[OpenSSL](https://www.openssl.org/source/),然后执行下面的命令。
**(macos 默认带有openssl)**

>		$ sudo openssl req \
>  	     -x509 \
>  		 -nodes \
>  		 -days 365 \
> 		 -newkey rsa:2048 \
> 		 -keyout example.key \
>		 -out example.crt

上面的命令的各个参数如下。
>
> *		req：处理证书签署请求。
> *		-x509：生成自签名证书。
> *		-nodes：跳过为证书设置密码的阶段，这样 Nginx 才可以直接打开证书。
> *		-days 365：证书有效期为一年。
> * 	-newkey rsa:2048：生成一个新的私钥，采用的算法是2048位的 RSA。
> *		-keyout：新生成的私钥文件为当前目录下的example.key。
> *		-out：新生成的证书文件为当前目录下的example.crt。

执行后，命令行会跳出一堆问题要你回答，比如你在哪个国家、你的email等等。


![MacDown Screenshot](https://github.com/liuyf90/doc/blob/master/pic/nginx_openssl.png?raw=true)

其中最重要的一个问题是Common Name,正常情况下应该填入一个域名，这里可以填127.0.0.1.

回答完问题，当前目录下应该会多出两个文件：example.crt和example.key。conf目录下新建一个子目录certs,把这两个文件放入这个目录。

> 		$ mkdir conf/certs
> 		$ mv example.crt example.key conf/certs

# 六. HTTP配置

有了私钥和证书，就可以打开nginx的HTTP了。

首先，打开conf/conf.d/default.conf文件，在结尾添加下面的配置。

		server {
		    listen 443 ssl http2;
		    server_name  localhost;
		
		    ssl                      on;
		    ssl_certificate          /etc/nginx/certs/example.crt;
		    ssl_certificate_key      /etc/nginx/certs/example.key;
		
		    ssl_session_timeout  5m;
		
		    ssl_ciphers HIGH:!aNULL:!MD5;
		    ssl_protocols SSLv3 TLSv1 TLSv1.1 TLSv1.2;
		    ssl_prefer_server_ciphers   on;
		
		    location / {
		        root   /usr/share/nginx/html;
		        index  index.html index.htm;
		    }
	}

然后，启动一个新的 Nginx 容器。

		$ docker container run \
		  --rm \
		  --name mynginx \
		  --volume "$PWD/html":/usr/share/nginx/html \
		  --volume "$PWD/conf":/etc/nginx \
		  -p 9090:80 \
		  -p 9091:443 \
		  -d \
		  nginx
		 
上面命令中，不仅映射了容器的80端口，还映射了443端口，这是 HTTPS 的专用端口。

打开浏览器，访问 https://127.0.0.2:8081/ 。因为使用了自签名证书，浏览器会提示不安全。不要去管它，选择继续访问，应该就可以看到 Hello World 了。

至此，Nginx 容器的 HTTPS 支持就做好了。有了这个容器，下一篇文章，我就来试验 HTTP/2 的 server push 功能。


