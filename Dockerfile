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
    pip install -r requirements.txt && \
    pip install .

# Copy the main script
RUN cp koboldcpp/koboldcpp.py /app/koboldcpp_exec && \
    chmod +x /app/koboldcpp_exec

# Download model from HuggingFace
RUN mkdir -p /app/models && \
    curl -L -o /app/models/mythomax.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

# Run KoboldCpp with the model
CMD ["python", "/app/koboldcpp_exec", "--model", "/app/models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
