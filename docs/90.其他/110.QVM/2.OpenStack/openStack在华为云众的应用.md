

云计算和虚拟化的区别

虚拟化：将物理机通过一定的技术进行虚拟化，分割成逻辑上互相隔离的服务器。主要是提升物理机的资源利用率。环境隔离，降低隔离损耗，提升运行效率。对特定的硬件做一些虚拟化

聚焦于硬件



云计算：聚焦的是服务。按需使用。多租户隔离。



两者关系：云计算的基础是虚拟化





openStack是一个**云操作系统**

类比windows、linux操作系统。



操作系统的功能

抽象资源：资源隔离。例如将网络、cpu等进行抽象，然后对供给上层的软件进行使用。

OpenStack可以将物理机中网络资源、cpu资源、存储资源等进行封装，以统一接口api的方式提供给上层





资源分配与负载调度

云上会跑很多应用软件，而OpenStack会负责这些软件之间如何进行调度。





应用生命周期管理

安装软件、卸载软件



系统运维

监控系统的资源使用了多少



人机交互

通过界面进行操作。



![image-20230824154041941](https://2290653824-github-io.oss-cn-hangzhou.aliyuncs.com/image-20230824154041941.png)

将各个物理机的计算资源、网络资源、存储资源进行抽象，形成一个操作系统，提供上层服务。

云操作系统。



### OpenStack的一个定位

OpenStack是一个云计算系统的控制面

是什么事控制面？

一个复杂的系统，可以抽象为两个层次---控制面：执行面



例如计算机系统中：

cpu就是控制面，而网卡磁盘就是执行面



人的大脑是控制面，人的四肢就是执行面。

![image-20230824154832021](https://2290653824-github-io.oss-cn-hangzhou.aliyuncs.com/image-20230824154832021.png)

最底层为硬件设施。需要向上进行抽象虚拟，变为Resource Pool即资源池，也就是一个个虚拟出来的虚拟机。OpenStack就相当于一个控制面来操控这些资源，并进一步进行抽象向上层提供统一的api。



OpenStack；

开源：

灵活：可插拔，提供插件。

![image-20230824155449143](https://2290653824-github-io.oss-cn-hangzhou.aliyuncs.com/image-20230824155449143.png)



可扩展

![image-20230824155502631](https://2290653824-github-io.oss-cn-hangzhou.aliyuncs.com/image-20230824155502631.png)

从一台机器可逐渐扩展到1000台机器

因为由很多相互独立的组件构成，是一个**无中心化**、无状态的架构





### 项目分层

![image-20230824160009199](https://2290653824-github-io.oss-cn-hangzhou.aliyuncs.com/image-20230824160009199.png)

### 各个组件之间的关系

![image-20230824160303911](https://2290653824-github-io.oss-cn-hangzhou.aliyuncs.com/image-20230824160303911.png)

network提供网络服务，提供存储服务，虚拟机需要操作系统，image提供镜像服务，镜像本身存储在对象存储里面，另外，各个组角之间需要通过identity进行鉴权，dashboard通过rest api与各个组件进行交互



![image-20230824161703579](/Users/zhengjian/Library/Application Support/typora-user-images/image-20230824161703579.png)





### Nova

![image-20230824162230649](https://2290653824-github-io.oss-cn-hangzhou.aliyuncs.com/image-20230824162230649.png)

![image-20230824162603133](https://2290653824-github-io.oss-cn-hangzhou.aliyuncs.com/image-20230824162603133.png)



如果调用API执行一个打开虚拟机的指令。api接收到指令后，会直接调用通过message下发指令到compute，然后通过Hypervisor去执行打开虚拟机的任务。

什么是Hypervisor？

> Hypervisor（虚拟机监控器），也被称为虚拟化管理程序，是一种软件、固件或硬件，它允许在单个物理计算机上运行多个虚拟操作系统实例。它的主要功能是管理和分配计算机资源，以便虚拟机可以在同一台物理机上同时运行，而彼此之间相互隔离。
>
> Hypervisor 有两种主要类型：
>
> 1. **Type 1 Hypervisor（裸金属Hypervisor）**：这种1类型的Hypervisor直接在物理硬件上运行，无需操作系统。它们被认为是更接近硬件的虚拟化解决方案。Type 1 Hypervisor通常用于服务器虚拟化场景，允许在单个物理服务器上运行多个虚拟机。一些著名的Type 1 Hypervisor包括VMware vSphere/ESXi、Microsoft Hyper-V、Xen等。
> 2. **Type 2 Hypervisor（主机Hypervisor）**：这种类型的Hypervisor运行在一个操作系统之上，也被称为主机操作系统。它通过在宿主操作系统内部创建虚拟机，允许用户在宿主操作系统中运行多个虚拟机。这种虚拟化方法通常用于开发和测试环境，以及个人计算机上的虚拟化。一些著名的Type 2 Hypervisor包括Oracle VirtualBox、VMware Workstation、Parallels Desktop等。
>
> Hypervisor 的主要目标之一是在物理资源之间实现隔离，使虚拟机之间不会相互干扰。它们能够分配和管理处理器、内存、存储和网络等资源，使多个虚拟机能够共享同一台物理机的资源，同时保持相对的隔离性和性能。虚拟化技术和Hypervisor对于数据中心的资源优化、快速部署以及灾难恢复等方面具有重要意义。



如果调用API属于一个创建虚拟机的指令，这个时候肯可能就比较麻烦了。

这时候指令会先下发到conductor，调用Schedule服务选择对应的机器（例如比较空闲，资源较多）。然后将选择的机器给到compute，conpute调用外界的服务，如Glance和Cinder提供相应的镜像，调用neutron获得网络服务，这些调用外部组件都是通过http来进行调用的。





引入整个服务也是需要将数据存入到一个统一的DB的，openStack默认的Db是mysql数据库。所以各个组件调用数据库是通过sql进行调用的。













对象存储、块存储、文件存储有什么区别

















# 参考：

[OpenStack原理及在华为云中的应用](https://www.bilibili.com/video/BV1aQ4y117hd/?spm_id_from=333.337.search-card.all.click&vd_source=a05a4698720267eb93bab07197b4276c)