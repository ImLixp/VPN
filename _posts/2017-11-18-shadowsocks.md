---
layout: post
title: VPN服务器搭建教程[简易]
tags: server serverBuild easy
---

#### Shadowsocks简介
> VPN是一个统称，其具体的实现有很多种，比如*PPTP*、*L2TP*、*OpenVPN*、*Shadowsocks*等，本文仅介绍*Shadowsocks*。

*Shadowsocks*是一个开源的VPN实现，简称*ss*，也称影梭，原作者是clowwindy。  
搬瓦工支持*Shadowsocks Server*一键搭建，这里介绍一下。


#### Shadowsocks一键安装

##### 1.打开服务器管理页面
点击 *`Services`* -> *`My Services`*，然后点击 *`KiwiVM Control Panel`* 进入管理面板。  
![Service][1]

##### 2.打开服务器管理页面
点击左边的 *`Main controls`*，在右边的服务器信息中查看*IP*、*状态*、*操作系统*。
  
- 状态（*Status*）：***Running***
- 服务器*IP*（*IP address*）：***104.224.154.239***
- 操作系统（*Operating system*）：***Centos 6 x86_64***

![Main][2]

##### 3.一键安装*Shadowsocks Server*
点击左边的 *`Shadowsocks Server`*，在右边的面板中点击 *`Install Shadowsocks Server`*。  
![Install][3]

##### 4.等待安装完成
等待安装完成后，点击 *`Go back`* 返回。  
![Complete][4]

##### 5.安装完成
在右边的面板中查看 *Shadowsocks Server* 信息。  
在PC、手机上使用VPN需要用到下面信息：

- 服务器 *IP* 地址：***104.224.154.239***
- *Shadowsocks Server* 端口：***443***
- *Shadowsocks Server* 密码：***ZjYxOGFlN2***
- *Shadowsocks Server* 加密方式：***aes-256-cfb***

![SScfg][5]

[1]: {{ site.baseurl }}/images/2/1.png
[2]: {{ site.baseurl }}/images/2/2.png
[3]: {{ site.baseurl }}/images/2/3.png
[4]: {{ site.baseurl }}/images/2/4.png
[5]: {{ site.baseurl }}/images/2/5.png
