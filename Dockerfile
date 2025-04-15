FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl libomp-dev libfftw3-dev libopenblas-dev \
    python3-setuptools && \
    pip install setuptools wheel

# Set working dir
WORKDIR /koboldcpp

# Clone repo & build
RUN git clone https://github.com/LostRuins/koboldcpp.git . && \
    make -j4 && \
    cp ./build/koboldcpp ./koboldcpp

# Download your GGUF model
RUN mkdir -p /koboldcpp/models && \
    curl -L -o models/mythomax.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

# Expose port
EXPOSE 5000

# Launch server
CMD ["./koboldcpp", "--model", "models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
