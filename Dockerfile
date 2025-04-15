FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl wget libomp-dev \
    && pip install --upgrade pip setuptools wheel

# Set working directory
WORKDIR /app

# Clone and prepare KoboldCpp
RUN git clone https://github.com/LostRuins/koboldcpp.git && \
    cd koboldcpp && \
    make -j && \
    cp koboldcpp koboldcpp_default.so /app/ && \
    chmod +x /app/koboldcpp

# Download GGUF model
RUN mkdir -p /app/models && \
    curl -L -o /app/models/mythomax.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

# Run KoboldCpp in Python mode (no .so used here)
CMD ["/app/koboldcpp", "--model", "/app/models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
