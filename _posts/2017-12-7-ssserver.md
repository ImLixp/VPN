---
layout: post
title: 安装ss-server
tags: server
---

> 搬瓦工支持一键搭建shadowsocks server，但其默认安装的是python程序，理论上解释执行效率要低一些。如果希望运行编译好的程序，或者服务器不支持一键搭建，可以参考本文。也可以查看官方[README][ss-libev]。

#### Ubuntu 和 Debian
Shadowsocks-libev已经在官方软件库中:
- Debian 8或更高版本
- Ubuntu 16.10或更高版本

##### Ubuntu 16.10:
- sudo apt update
- sudo apt install shadowsocks-libev

##### Ubuntu 14.04/16.04:
- sudo apt-get install software-properties-common -y
- sudo add-apt-repository ppa:max-c-lv/shadowsocks-libev -y
- sudo apt-get update
- sudo apt install shadowsocks-libev

##### Debian 8(Jessie):
- sudo sh -c 'printf "deb http://deb.debian.org/debian jessie-backports main\n" > /etc/apt/sources.list.d/jessie-backports.list'
- sudo sh -c 'printf "deb http://deb.debian.org/debian jessie-backports-sloppy main" >> /etc/apt/sources.list.d/jessie-backports.list'
- sudo apt update
- sudo apt -t jessie-backports-sloppy install shadowsocks-libev

##### Debian 9(Stretch):
- sudo sh -c 'printf "deb http://deb.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/stretch-backports.list'
- sudo apt update
- sudo apt -t stretch-backports install shadowsocks-libev

#### OS X
- ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
- brew install shadowsocks-libev

#### 运行
- ss-server -c ss.json


[ss-libev]: https://github.com/shadowsocks/shadowsocks-libev
