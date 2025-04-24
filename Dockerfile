FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

# 1. Dependencias del sistema
RUN apt-get update && apt-get install -y \
    git curl wget unzip nano sudo software-properties-common \
    python3.11 python3.11-venv python3.11-dev python3-pip \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# 2. Establecer Python 3.11 como predeterminado
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# 3. Crear carpeta y clonar el proyecto
WORKDIR /app
RUN git clone https://github.com/oobabooga/text-generation-webui.git webui
WORKDIR /app/webui

# 4. Crear venv e instalar dependencias
RUN python3 -m venv venv
ENV PATH="/app/webui/venv/bin:$PATH"
RUN pip install --upgrade pip && pip install -r requirements/full/requirements.txt

# 5. Descargar modelo
RUN python download-model.py deepseek-ai/deepseek-coder-6.7b-instruct

# 6. Eliminar flash-attn
RUN pip uninstall flash-attn flash-attn2 -y || true

EXPOSE 7860

# 7. Soporte para argumentos externos como CLI_ARGS
CMD ["bash", "-c", "python server.py $CLI_ARGS --model models/deepseek-ai_deepseek-coder-6.7b-instruct --load-in-8bit --trust-remote-code"]

