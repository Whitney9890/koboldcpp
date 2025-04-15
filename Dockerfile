FROM python:3.10-slim

# Install system dependencies and tools
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl libomp-dev libfftw3-dev libopenblas-dev \
    python3-setuptools && \
    pip install setuptools wheel

# Set the working directory
WORKDIR /app

# Clone the KoboldCpp repo and build it
RUN git clone https://github.com/LostRuins/koboldcpp.git && \
    cd koboldcpp && \
    make -j && \
    chmod +x koboldcpp

# Download the GGUF model into the correct path
RUN mkdir -p /app/models && \
    curl -L -o /app/models/mythomax.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

EXPOSE 5000

# Run the built binary from inside the cloned directory
CMD ["./koboldcpp/koboldcpp", "--model", "models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
