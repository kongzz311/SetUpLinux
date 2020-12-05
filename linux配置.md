# Ubuntu

## 配置ssh

```bash
sudo apt-get remove openssh-server
sudo apt-get install openssh-server
sudo vi /etc/ssh/sshd_config
```

```config
PasswordAuthentication yes
```

```bash
sudo service ssh restart
```

## 静态地址

/etc/netplan

```bash
# Let NetworkManager manage all devices on this system
network:
  version: 2
  renderer: NetworkManager
  ethernets:
     ens33: #配置的网卡名称,使用ifconfig -a查看得到,且必须是空格缩进，netplan只认空格
       dhcp4: no #no-dhcp4开启 true-dhcp4开启
       
       addresses: [192.168.3.59/24, ] #设置本机IP及掩码,这个逗号和空格好像不能少，少了就不生效，后面的空格之后可以写入IPv6的地址，从而变成这样[192.168.2.110/24, "2001:1::1/64"]
       gateway4: 192.168.3.1 #设置ipv4的默认网关
       
       
       nameservers:  #设置DNS服务器
         addresses: [114.114.114.114,114.114.115.115]  #多个DNS服务器之间用逗号隔开
```

```bash
sudo netplan apply
```



## 配置镜像源

清华镜像源

```
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
```

备份默认

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources_back.list
```

```bash
sudo apt update
sudo apt install curl git net-tools
```

create user

```bash
adduser --disabled-password <your_username>
usermod -aG sudo <your_username>
su - <your_username>
```





## 配置代理

程序员不喜欢 repeat (him/her/it)self，所以。。。

首先，创建两个文件，`openproxy.sh` 和 `closeproxy.sh`，

openproxy.sh

```
export http_proxy="http://192.168.3.3:7890"
export https_proxy="http://192.168.3.3:7890"
export ALL_PROXY="socks5://192.168.3.3:7890"
echo "already open proxy with 192.168.3.3:7890"
```

假如是虚拟机 填入主机的局域网地址

closeproxy.sh

```
unset http_proxy
unset https_proxy
unset ALL_PROXY

echo "already close proxy"
```

接着，在你的用户根目录新建一个 `.command` 文件夹，然后存放这两个文件，

然后，修改你的 `.bzshrc` 或者 `.zshrc`，在合适的地方添加如下别名（alias）命令，

```
alias openproxy="source ~/.command/openproxy.sh"
alias closeproxy="source ~/.command/closeproxy.sh"
```

最后，打开一个新的终端，在你需要开启的时候敲下 `openproxy` ，需要关闭的时候敲下 `closeproxy` 就可以喽～

## zsh

```bash
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```


```bash
git clone https://github.com/MarsWang42/My-Vim-Conf.git
```

```
chmod +x ./setup.sh ./tmux.sh
./setup.sh
```

```bash
source ~/.zshrc
```

# centos

change download sources

```bash
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo

yum makecache
```

## 网络

## 配置网络

设置成桥接模式

```bash
su root
dhclient
ifconfig
# 192.168.3.19
vim /etc/sysconfig/network-scripts/ifcfg-ens33
#edit
#bootproto = static
#onboot = yes
#add
#IPADDR=192.168.3.19
#NETMASK=255.255.255.0
#GATEWAY=192.168.3.1
#DNS1=8.8.8.8

#restart network
#centos 8
nmcli networking off
nmcli networking on
```

Windows 虚拟机ping不通宿主机，前往Windows10的防火墙打开ICMPv4-in这个规则。

#

# 开发环境搭建

