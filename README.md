# Oh My Docker

参考自 [FrankFang/oh-my-docker](https://github.com/FrankFang/oh-my-docker)

## 功能介绍

基于 `archlinux:base-devel`

1. 国内源
2. 内置工具
   - oh-my-zsh
   - vim: `vimrc 默认配置` + `plugin: vim-airline / vim-snazzy`
   - git
3. 内置命令
   - nvm: `node latest --lts` / `npm` / `pnpm` / `yarn` / `yrm` / `typescript` / `http-server`
   - go

## 常见问题

#### 前端项目开发过程中无法热更新？

1. 项目放到 `~/repos` 目录下，在 Linux 环境中进行开发。

#### git merge 时报错 `error: unable to start editor 'vi'`

1. 设置 git 默认编辑器 `git config --global core.editor vim`， 原因是因为没有安装`vi`编辑器

#### 如何连接数据库？

1. 新建一个 Docker network
2. 新建另一个 Docker 的数据库实例，让其连接第一步中的 network
3. 在 my-projects/.devcontainer/devcontainer.json 中改写 runArgs 为 `"runArgs": ["--network=oh-my-docker", "--dns=114.114.114.114"],`
4. 在 VSCode 中运行 rebuild Container

## 如何让容器与宿主机共享 ssh 认证信息

参考微软官方的教程：https://code.visualstudio.com/docs/remote/containers#_using-ssh-keys
