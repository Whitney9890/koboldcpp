FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl wget libomp-dev \
    && pip install setuptools wheel

# Set working directory
WORKDIR /app

# Clone and build KoboldCpp
RUN git clone https://github.com/LostRuins/koboldcpp.git && \
    cd koboldcpp && make -j && \
    cp koboldcpp_default.so /app/koboldcpp && chmod +x /app/koboldcpp

# Download the GGUF model
RUN mkdir -p /app/models && \
    curl -L -o /app/models/mythomax.gguf https://huggingface.co/Zearal/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

# Run KoboldCpp with the model
CMD ["./koboldcpp", "--model", "/app/models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
