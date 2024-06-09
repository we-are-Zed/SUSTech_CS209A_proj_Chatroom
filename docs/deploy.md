### 部署视图

### Docker 部署方式

要部署和运行 `ln-chat-server` 软件，可以使用以下 Docker 命令：

```sh
docker run -d -p ${YOUR_EXPOSE_PORT}:11451 lambillda/ln-chat-server
```

在这个命令中，将 `${YOUR_EXPOSE_PORT}` 替换为你希望映射到宿主机上的端口号。容器内部的 `11451` 端口将映射到宿主机的 `${YOUR_EXPOSE_PORT}` 端口，允许你从宿主机访问运行在容器中的服务。

部署步骤如下：

首先，确保你的物理节点上已经安装并运行 Docker。可以参考 Docker 官方文档获取安装指南。然后，使用 `docker pull lambillda/ln-chat-server` 命令从 Docker Hub 拉取镜像。最后，使用 `docker run -d -p ${YOUR_EXPOSE_PORT}:11451 lambillda/ln-chat-server` 命令启动容器，并将容器内部的端口映射到宿主机的指定端口上。这样，`ln-chat-server` 应用程序将运行在宿主机的 `${YOUR_EXPOSE_PORT}` 端口，你可以通过访问 `http://localhost:${YOUR_EXPOSE_PORT}` 来使用该服务。

### Kubernetes 部署方式

在 Kubernetes 中部署 `ln-chat-server` 可以更好地管理和扩展应用。下面是一个示例 YAML 文件，用于在 Kubernetes 集群中部署 `ln-chat-server`：

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ln-chat-server-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: ln-chat-server
  template:
    metadata:
      labels:
        app: ln-chat-server
    spec:
      containers:
      - name: ln-chat-server
        image: lambillda/ln-chat-server
        ports:
        - containerPort: 11451
---
apiVersion: v1
kind: Service
metadata:
  name: ln-chat-server-service
spec:
  selector:
    app: ln-chat-server
  ports:
  - protocol: TCP
    port: 80
    targetPort: 11451
  type: LoadBalancer
```

这个 YAML 文件定义了一个 Deployment 和一个 Service。Deployment 部署了 `ln-chat-server` 应用，并创建了三个副本来确保高可用性。每个副本将监听 `11451` 端口。Service 定义了一个负载均衡器，将外部请求路由到这些副本。

部署步骤如下：

首先，确保你的 Kubernetes 集群已经设置并运行。然后，使用 `kubectl apply -f <your-yaml-file>.yaml` 命令应用上述 YAML 文件。这将创建 `ln-chat-server` 的 Deployment 和 Service。Service 将自动分配一个外部 IP 地址，你可以通过该 IP 地址访问 `ln-chat-server` 服务。

通过这种方式，你可以将 `ln-chat-server` 部署到任何支持 Kubernetes 的集群，并根据需要进行扩展和管理。确保物理节点的网络配置和资源能够支持容器的运行，从而保证应用程序的性能和稳定性。
