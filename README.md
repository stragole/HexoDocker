# HexoDocker

基于[yakumioto/docker-hexo](https://github.com/yakumioto/docker-hexo/tree/master/3.2/alpine)做的修改，部署改为使用`rsync`。

- 修改`apk`源到国内镜像
- 安装`rsync`和`hexo-deployer-rsync`
- 设置淘宝`npm`镜像源
- 删除不必要的匿名卷
 
## 获取镜像 (Hexo v3.3.8)
`docker pull stragod/hexo:3.3.8` 

## 创建容器

### 1. 创建本地Server容器

	# 本地端口`4000`映射容器端口`80`
	$ docker run -p 4000:80 --name hexo-server -d \
	
	# 挂载启动`Server`需要用到的三个文件夹
	-v {博客文件夹路径}/source:/Hexo/source \
	-v {博客文件夹路径}/themes:/Hexo/themes \
	-v {博客文件夹路径}/_config.yml:/Hexo/_config.yml \
	
	# s: `hexo server`
	stragod/hexo:3.3.8 s
	
### 2. 创建Deploy容器
	
	$ docker run --name hexo-deploy -d \

	# 部署需要用到`ssh`，将`.ssh`文件夹挂载到容器中
	-v ~/.ssh:/root/.ssh \
	
	# 挂载部署需要用到的三个文件夹
	-v {博客文件夹路径}/source:/Hexo/source \
	-v {博客文件夹路径}/themes:/Hexo/themes \
	-v {博客文件夹路径}/_config.yml:/Hexo/_config.yml \
	
	# d: `hexo cl && hexo d -g`
	stragod/hexo:3.3.8 d

### 3. 创建Shell执行容器
	
	# 本地端口`5000`映射容器端口`80`
	$ docker run -it -p 5000:80 --name hexo-shell \
	
	# 将.ssh挂载到容器中
	-v ~/.ssh:/root/.ssh \
	
	# 挂载Hexo需要用到的三个文件夹
	-v {博客文件夹路径}/source:/Hexo/source \
	-v {博客文件夹路径}/themes:/Hexo/themes \
	-v {博客文件夹路径}/_config.yml:/Hexo/_config.yml \
	
	# 有自定义`hexo new`模板的把对应文件夹挂载上
	-v {博客文件夹路径}/scaffolds:/Hexo/scaffolds \
	
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
- 方法2： 运行对应容器
	- Server: `docker start hexo-server`
	- Deploy: `docker start -a hexo-deploy`(`-a`: 实时输出部署日志)
