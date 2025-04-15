FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    build-essential cmake git curl libomp-dev libfftw3-dev libopenblas-dev \
    python3-setuptools && \
    pip install setuptools wheel

WORKDIR /koboldcpp

RUN git clone https://github.com/LostRuins/koboldcpp.git . && \
    make -j && \
    chmod +x koboldcpp

RUN mkdir -p /koboldcpp/models && \
    curl -L -o models/mythomax.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

EXPOSE 5000

CMD ["./koboldcpp", "--model", "models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
