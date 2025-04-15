FROM python:3.10-slim

# Install system dependencies, setuptools, and wheel
RUN apt-get update && apt-get install -y curl python3-distutils python3-setuptools build-essential libffi-dev cmake git && pip install setuptools wheel

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Create the models directory and download the GGUF model
RUN mkdir -p /app/models
RUN curl -L -o /app/models/mythomax-12-13b.Q5_K_M.gguf https://huggingface.co/Zeara1/Mee/resolve/main/mythomax-12-13b.Q5_K_M.gguf

# Install each package separately
RUN pip install setuptools
RUN pip install numpy
RUN pip install sentencepiece==0.1.98
RUN pip install transformers>=4.34.0
RUN pip install gguf>=0.1.0
RUN pip install customtkinter>=5.1.0
RUN pip install protobuf>=4.21.0

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Give execute permissions to the install script
RUN chmod +x ./install_requirements.sh

# Run the application
CMD ["./install_requirements.sh"]
