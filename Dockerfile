FROM python:3.10-slim

# Install build tools and Python stuff
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl wget libomp-dev \
    && pip install setuptools wheel

WORKDIR /app

# Clone and build KoboldCpp
RUN git clone https://github.com/LostRuins/koboldcpp.git && \
    cd koboldcpp && \
    chmod +x build-linux.sh && \
    ./build-linux.sh

# Download model
RUN mkdir -p /app/models && \
    curl -L -o /app/models/mythomax.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

EXPOSE 5000

# Run it
CMD ["./koboldcpp/koboldcpp", "--model", "models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
