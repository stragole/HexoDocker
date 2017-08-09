#!/bin/sh
# Author: strago, <strago.xin@gmail.com>
if [ "$1" = 's' ] || [ "$1" = 'server' ]; then
    set -- /usr/bin/hexo server -p 80
fi
if [ "$1" = 'd' ] || [ "$1" = 'deploy' ]; then
    set -- /usr/bin/hexo cl && /usr/bin/hexo d -g
fi
exec "$@"