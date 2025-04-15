FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl wget libomp-dev \
    && pip install setuptools wheel

# Set working directory
WORKDIR /app

RUN git clone --branch master https://github.com/LostRuins/koboldcpp.git && \
    cd koboldcpp && \
    make -j && \
    mv koboldcpp /app/koboldcpp

# Download the GGUF model
RUN mkdir -p /app/models && \
    curl -L -o /app/models/mythomax.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

EXPOSE 5000

# Run KoboldCpp on the model
CMD ["/app/koboldcpp", "--model", "models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
