FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl wget libomp-dev \
    && pip install setuptools wheel

# Set working directory
WORKDIR /app

# Clone & build KoboldCpp
RUN git clone https://github.com/LostRuins/koboldcpp.git && \
    cd koboldcpp && \
    make -j

# Download model
RUN mkdir -p /app/models && \
    curl -L -o /app/models/mythomax.gguf https://huggingface.co/Zearal/Mee/resolve/main/mythomax-12-13b_Q5_K_M.gguf

# Run KoboldCpp with model + debug log
CMD ["./koboldcpp/koboldcpp", "--model", "models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000", "--logdir", "logs"]
