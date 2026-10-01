# OmniVoice (https://github.com/k2-fsa/OmniVoice) Gradio web UI
FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    HF_HOME=/root/.cache/huggingface

# ffmpeg: decode mp3/m4a reference audio; libsndfile1: soundfile backend
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Same torch version as the upstream uv constraints. On Linux x86_64 the PyPI
# wheel of torch 2.8.0 is the CUDA 12.8 build; it falls back to CPU when no GPU
# is passed into the container.
RUN pip install torch==2.8.0 torchaudio==2.8.0

ARG OMNIVOICE_VERSION=0.2.1
RUN pip install "omnivoice==${OMNIVOICE_VERSION}"

WORKDIR /app
EXPOSE 7860

# Models (k2-fsa/OmniVoice + Whisper ASR) download on first start into HF_HOME.
ENTRYPOINT ["omnivoice-demo", "--ip", "0.0.0.0", "--port", "7860"]
