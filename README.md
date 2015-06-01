# donotReMove
专治各种手贱rm -fr /

看了硅谷S2E8，就知道这么做的重要性了。。。

# Install
下载rm.sh到任意目录下，比如/opt/rm.sh，以root身份执行

mv /bin/rm /bin/shrm

ln -s /opt/rm.sh /bin/rm

完事

# Usage
rm -fr /

大胆的去犯迷糊吧。。。

# Attention
因为make install时，会执行大量的rm删除命令，所以会导致install时疯狂提示输入验证码，嘿嘿。。。
