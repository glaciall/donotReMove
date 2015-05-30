#!/bin/sh

# 根据当前时间生成一个MD5值，只取四位，用于验证码
randcode=`date|md5sum|cut -c 1-4`;

fn_quit()
{
	echo -ne "\033[1;31m"
        echo -ne "ERROR: The file(s) $1 was unable to deleted.";
        echo -e "\033[0m"
        exit;
}

arg="";
for((i=1;i<=$#;i++));do
	ag=$(eval echo \${${i}});

    # 如果目标文件不是/开始，那就拼上当前目录，防止rm -fr ../../../../../
	if [ "`echo $ag|cut -c 1`"x != "/x" ]; then
		if [ ${ag:0:1} != "-" ]; then
			ag="`pwd`/$ag";
		fi
	fi

	arg="$arg $ag";
	apath=`echo $ag|awk -F "/" '{ print $2 }'`;

    # 禁止删除bin、usr、sys、dev等等目录下的文件
	if [ "$apath"x = "bin"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "usr"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "boot"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "etc"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "sys"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "var"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "mnt"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "dev"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "lib"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "sbin"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "proc"x ]; then
		fn_quit $ag;
	elif [ "$apath"x = "tmp"x ]; then
		fn_quit $ag;
	fi
done

echo -ne "\033[1;31m"
echo "WARNNING: Before enter the auth code, check if your command will be delete system/wrong files ?";
echo -ne "WARNNING: Input \"$randcode\" to continue: ";
echo -ne "\033[0m"

# 读取四个字符，10秒超时
read -n 4 -t 10 inputcode;

echo "";

if [ "$inputcode"x != "$randcode"x ]; then
	echo -ne "\033[1;31m"
	echo -ne "ERROR: wrong code, permission denied.";
	echo -e "\033[0m"
	exit;
fi

echo "delete files:  $arg";

# 转交给真正的rm命令去执行删除操作
/bin/shrm $arg;

