# Use an official Python runtime as the base image
FROM python:3.12-slim

# Install system dependencies, setuptools, and wheel
RUN apt-get update && apt-get install -y python3-distutils python3-setuptools build-essential libffi-dev && \
    pip install --upgrade pip setuptools wheel

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install each package separately
RUN pip install setuptools
RUN pip install numpy==1.24.4
RUN pip install sentencepiece==0.1.98
RUN pip install transformers>=4.34.0
RUN pip install gguf>=0.1.0
RUN pip install customtkinter>=5.1.0
RUN pip install protobuf>=4.21.0

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run the application
CMD ["./install_requirements.sh"]
