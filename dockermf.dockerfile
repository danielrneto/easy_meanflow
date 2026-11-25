# Use NVIDIA CUDA 12.1 development image on Ubuntu 22.04 (required for custom CUDA extensions/compiling)
FROM nvidia/cuda:12.1.1-base-ubuntu22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bzip2 \
    wget \
    curl \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget -q https://repo.anaconda.com/archive/Anaconda3-2026.07-1-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    /opt/conda/bin/conda clean -afy

ENV PATH="/opt/conda/bin:$PATH"

# Set working directory and clone the repository
WORKDIR /easy_meanflow
COPY environment.yml /easy_meanflow/environment.yml

# Create the Conda environment from environment.yml
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r && \
    conda env create -f environment.yml && \
    conda clean -afy

RUN conda init bash && \
    echo "conda activate easy_meanflow" >> ~/.bashrc

CMD ["/bin/bash"]