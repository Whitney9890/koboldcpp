FROM python:3.10-slim

# Install required build dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl wget \
    libomp-dev libfftw3-dev libopenblas-dev \
    python3-setuptools && \
    pip install setuptools wheel

# Set working directory
WORKDIR /koboldcpp

# Clone KoboldCpp and build it
RUN git clone https://github.com/LostRuins/koboldcpp.git . && \
    make -j

# Create model folder & download model
RUN mkdir -p /koboldcpp/models
RUN curl -L -o /koboldcpp/models/mythomax.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

# Expose port
EXPOSE 5000

# Launch KoboldCpp server
CMD ["./koboldcpp", "--model", "models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
