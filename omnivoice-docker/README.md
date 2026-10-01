# OmniVoice Docker（Windows 一键运行）

把 [k2-fsa/OmniVoice](https://github.com/k2-fsa/OmniVoice) 的 Gradio 网页界面（`omnivoice-demo`）打包成 Docker 镜像。

## 前置条件

- Windows 10/11 + [Docker Desktop](https://www.docker.com/products/docker-desktop/)（WSL2 后端）
- 有 NVIDIA 显卡：装好最新的 NVIDIA Windows 驱动即可，Docker Desktop 会通过 WSL2 把 GPU 传进容器
- 磁盘空间：镜像约 12 GB（含 CUDA 运行库），模型缓存另需数 GB

## 一键启动

在本目录中双击 `start.bat`，或在终端里运行：

```bat
start.bat
```

它会检测 `nvidia-smi`，有 NVIDIA 显卡就用 GPU 模式，没有就用 CPU 模式，然后执行构建并在后台启动。
启动完成后打开 http://localhost:7860 。

首次启动会下载 OmniVoice 模型和 Whisper ASR 模型，耗时较长。下载的文件存在 Docker volume `hf-cache` 里，以后启动不会再下载。

也可以直接用 compose 命令：

```bat
:: GPU 模式
docker compose up -d --build
:: CPU 模式
docker compose -f docker-compose.yml -f docker-compose.cpu.yml up -d --build
```

## 常用操作

```bat
docker compose logs -f     :: 查看日志 / 模型下载进度
docker compose down        :: 停止
```

国内网络连接 HuggingFace 困难时，先设置镜像再启动：

```bat
set HF_ENDPOINT=https://hf-mirror.com
start.bat
```

## 说明

- 版本：`omnivoice==0.2.1`，`torch==2.8.0`（CUDA 12.8），与上游 `pyproject.toml` 的约束一致。修改版本可用 `--build-arg OMNIVOICE_VERSION=...`。
- CPU 模式能运行，但上游 demo 固定使用 float16 加载模型，在 CPU 上速度会明显慢于 GPU。
