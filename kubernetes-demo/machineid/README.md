# 环境搭建

## docker私有仓库

1. hosts

        $ sudo vim /etc/hosts
        127.0.0.1 dr.repo.net

2. 下载镜像

        $ docker pull registry

3. 修改配置文件

        $ sudo vim /etc/sysconfig/docker
        DOCKER_OPTS="--insecure-registry dr.repo.net:5000 -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375"

4. 运行容器

        $ sudo docker run -d -p 5000:5000 -v /opt/data/registry:/tmp/registry --name registry registry

    有时候镜像放置的位置不一定是`/tmp/registry`,这时候进入registry容器查看下:

        $ docker exec -ti registry sh
        / # find / -name registry
        /etc/docker/registry
        /var/lib/registry
        /var/lib/registry/docker/registry
        /bin/registry

    可知镜像放置在`/var/lib/registry`, 那么上述命令挂载卷应该改为`-v /opt/data/registry:/var/lib/registry`

    但是这时候`docker push`镜像可能会失败，查看`docker logs registry | tail -20`，如果出现以下错误:

        mkdir /var/lib/registry/docker: permission denied" err.message="unknown error"

    那应该是SELinux问题:

        $ /usr/sbin/sestatus -v
        SELinux status:                 enabled
        ...

        $ getenforce         ##也可以用这个命令检查

    那么关闭SELinux:

    * 临时关闭:

            $ sudo setenforce 0 ##设置SELinux 成为permissive模式, setenforce 1 设置SELinux 成为enforcing模式

    * 修改配置文件(需要重启)

            $ sudo vim /etc/selinux/config
            SELINUX=enforcing ===> SELINUX=disabled             
            $ sudo reboot

   解决后，删除registry容器，重新运行上述`docker run`命令创建一个新的registry容器，然后`docker push`本地镜像即可。

## kubernetes安装

    $ sudo dnf install kubernetes etcd flannel

    $ sudo systemctl mask firewalld.service
    $ sudo systemctl stop firewalld.service
    $ sudo systemctl disable iptables.service
    $ sudo systemctl stop iptables.service

    $ sudo systemctl start docker
    $ sudo systemctl enable docker
    $ sudo groupadd docker
    $ sudo usermod -aG docker chenjs
    $ sudo reboot

启动master节点:

    $ sudo vim start_master.sh
    #!/bin/sh

    # flanneld启动有问题，可以不启动...
    for SERVICES in etcd kube-apiserver kube-controller-manager kube-scheduler kube-proxy kubelet flanneld; do
        systemctl restart $SERVICES
        #systemctl enable $SERVICES
        systemctl status $SERVICES
    done

启动node节点:

    $ sudo vim start_node.sh
    #!/bin/sh

    # flanneld启动有问题，可以不启动...
    for SERVICES in kube-proxy kubelet flanneld; do
        systemctl restart $SERVICES
        #systemctl enable $SERVICES
        systemctl status $SERVICES
    done
    
验证:

    $ kubectl get all

**问题**:

1.

        $ kubectl get pods
        no resources found

找一下错误信息:

        $ kubectl get rs
        $ kubectl describe rs xxx ## xxx是上一条命令下返回的rc NAME
        Warning  FailedCreate  13m (x19 over 37m)  replicaset-controller  Error creating: No API token found for service account "default", retry after the token is automatically created and added to the service account

解决方案:

        $ sudo vim /etc/kubernetes/apiserver
        delete ServiceAccount in var KUBE_ADMISSION_CONTROL
        $ sudo systemctl restart kube-apiserver.service

2.
    
        $ kubectl get pods
        STATUS is pending

找一下错误信息:

        $ kubectl describe pods pod-name-xxxx
        Warning  FailedScheduling  29s (x8 over 1m)  default-scheduler  no nodes available to schedule pods
        $ kubectl get cs
        etcd-1               Unhealthy   Get http://127.0.0.1:4001/health: dial tcp 127.0.0.1:4001: connect: connection refused

解决方案:

        $ sudo vim /etc/etcd/etcd.conf
        ETCD_LISTEN_CLIENT_URLS="http://localhost:2379,http://localhost:4001"
        $ sudo systemctl restart etcd.service
        $ kubectl get cs

如果状态还是pending或者不是running，请看问题3。

3.

        $ kubectl get nodes
        no resources found
 
[参考文档](https://kubernetes.io/docs/getting-started-guides/fedora/fedora_manual_config/)，解决方案:

        $ sudo vim /etc/kubernetes/kubelet
        KUBELET_ARGS="--cgroup-driver=systemd --kubeconfig=/etc/kubernetes/master-kubeconfig.yaml"
        $ sudo vim /etc/kubernetes/master-kubeconfig.yaml
        kind: Config
        clusters:
        - name: local
          cluster:
            server: http://127.0.0.1:8080
        users:
        - name: kubelet
        contexts:
        - context:
            cluster: local
            user: kubelet
          name: kubelet-context
        current-context: kubelet-context

        
        $ sudo systemctl restart kubelet.service
        $ systemctl status kubelet.service 

## minikube安装

此项可选，可不安装

    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
    whereis minikube

## helm安装

[downloadURL](https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz)

    tar -xf ~/Downloads/helm-v2.9.1-linux-amd64.tar.gz 
    sudo mv linux-amd64/helm /usr/local/bin/

## machineid

参考[Generating Unique 64 bit IDs with Go on Kubernetes](https://outcrawl.com/generating-unique-ids-kubernetes/)
