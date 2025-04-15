FROM python:3.10-slim

# Install system dependencies, setup tools, wheel, and build essentials
RUN apt-get update && apt-get install -y \
    git build-essential cmake curl wget \
    libomp-dev libfftw3-dev libopenblas-dev \
    python3-setuptools && \
    pip install setuptools wheel

# Set working directory
WORKDIR /app

# Install KoboldCpp (builds from source)
RUN git clone https://github.com/LostRuins/koboldcpp.git . && \
    make -j

# Make the models directory and download your model
RUN mkdir -p /app/models
RUN curl -L -o /app/models/mythomax-12-13b.Q5_K_M.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

# Expose port
EXPOSE 5000

# Launch KoboldCpp with your model
CMD ["./koboldcpp", "--model", "/app/models/mythomax-12-13b.Q5_K_M.gguf", "--host", "0.0.0.0", "--port", "5000"]
