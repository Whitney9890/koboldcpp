FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/LostRuins/koboldcpp.git && \
    cd koboldcpp && \
    make -j

# Copy model into proper place (this assumes your model is mounted at /app/models)
COPY ./koboldcpp /app/koboldcpp_exec

EXPOSE 5000

CMD ["./koboldcpp/koboldcpp", "--model", "/app/models/mythomax.gguf", "--host", "0.0.0.0", "--port", "5000"]
