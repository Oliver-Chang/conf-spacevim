# Spacevim config
该项目用于保存我自己的 Spacevim 配置文件。

## Dockerfile
分别基于 ubuntu alpine 的 Dokcerfile

### build

构建进系镜像

```shell
$ make 
```

或者

```shell
$ make build
```

### release

发布到 Docker Hub
oliverchangnt/dnvim

```shell
$ make release
```

## docker-compose

用于运行镜像
约定
需要挂载用户目录的 Worksapce 到容器内 /home/spacevim/Workspace

## dnvim
shell 脚本通过容器名字启动容器内的nvim，并打开容器内的 /home/spacevim/Workspace 的文件或目录。
