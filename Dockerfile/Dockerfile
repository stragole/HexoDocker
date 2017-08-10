FROM mhart/alpine-node:6

MAINTAINER strago , <strago.xin@gmail.com>

RUN \
    echo "http://mirrors.ustc.edu.cn/alpine/v3.4/main" > /etc/apk/repositories && \
    echo "http://mirrors.ustc.edu.cn/alpine/v3.4/community" >> /etc/apk/repositories && \
    apk --update --no-progress add git openssh && \
    apk add rsync && \
    apk add ca-certificates && \
    apk add tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

WORKDIR /Hexo

RUN \
    npm config set registry https://registry.npm.taobao.org \
    && npm install hexo-cli -g \
    && hexo init . \
    && npm install \
    && npm install hexo-generator-sitemap --save \
    && npm install hexo-generator-feed --save \
    && npm install hexo-deployer-git --save \
    && npm install hexo-renderer-markdown-it --save \
    && npm install hexo-deployer-rsync --save

VOLUME ["/Hexo/source", "/root/.ssh"]

EXPOSE 80

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ['/bin/bash']