FROM python:3.10-slim

# Install tools
RUN apt-get update && apt-get install -y curl wget libomp-dev && apt-get clean

WORKDIR /app

# Download precompiled KoboldCpp binary (Linux)
RUN curl -L -o koboldcpp https://huggingface.co/lostruins/koboldcpp-binaries/resolve/main/koboldcpp-linux && \
    chmod +x koboldcpp

# Download the model
RUN mkdir -p /app/models && \
    curl -L -o /app/models/mythomax.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

CMD ["./koboldcpp", "--model", "/app/models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
