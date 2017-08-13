# HexoDocker

基于[yakumioto/docker-hexo](https://github.com/yakumioto/docker-hexo/tree/master/3.2/alpine)做的修改
## 获取镜像
`docker pull stragod/hexo:3.3.8` (Hexo v3.3.8)

## 创建容器

### 1. 创建本地Server容器

	# 本地端口`4000`映射容器端口`80`
	$ docker run -p 4000:80 --name hexo-server -d \
	
	# 将.ssh挂载到容器中
	-v ~/.ssh:/root/.ssh \
	
	# 挂载Hexo需要用到的三个路径
	-v {博客文件夹路径}/source:/Hexo/source \
	-v {博客文件夹路径}/themes:/Hexo/themes \
	-v {博客文件夹路径}/_config.yml:/Hexo/_config.yml \
	
	# 使用的镜像; s -> `hexo server`
	stragod/hexo:3.3.8 s
	
### 2. 创建Deploy容器
	
	$ docker run --name hexo-deploy -d \

	# 将.ssh挂载到容器中
	-v ~/.ssh:/root/.ssh \
	
	# 挂载Hexo需要用到的三个路径
	-v {博客文件夹路径}/source:/Hexo/source \
	-v {博客文件夹路径}/themes:/Hexo/themes \
	-v {博客文件夹路径}/_config.yml:/Hexo/_config.yml \
	
	# 使用的镜像; d -> `hexo cl && hexo d -g`
	stragod/hexo:3.3.8 d

### 3. 创建Shell执行容器
	
	# 本地端口`5000`映射容器端口`80`
	$ docker run -it -p 5000:80 --name hexo-shell \
	
	# 将.ssh挂载到容器中
	-v ~/.ssh:/root/.ssh \
	
	# 挂载Hexo需要用到的三个路径
	-v {博客文件夹路径}/source:/Hexo/source \
	-v {博客文件夹路径}/themes:/Hexo/themes \
	-v {博客文件夹路径}/_config.yml:/Hexo/_config.yml \
	
	# /bin/sh作为参数，进入终端
	stragod/hexo:3.3.8 /bin/sh
	
## 使用容器

### 1. 新建草稿、文章等

	# 1. 进入`hexo-shell`
	$ docker start -i hexo-shell
	
	# 2. 执行对应hexo命令
	/hexo $ hexo new draft HEXO+DOCKER+VPS
	/hexo $ hexo publish HEXO+DOCKER+VPS
	/hexo $ hexo s -p 80
	/hexo $ hexo cl && hexo d -g
	...
	/hexo $ exit

### 2. 本地预览/部署
- 方法1： 进入`hexo-shell`中执行对应命令
- 方法2：
	- Server: `docker start hexo-server`
	- Deploy: `docker start hexo-deploy`
	- 查看执行日志: `docker logs hexo-deploy`