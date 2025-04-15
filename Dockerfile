# Use an official Python runtime as the base image
FROM python:3.12-slim

# Install system dependencies and ensure setuptools is installed
RUN apt-get update && apt-get install -y python3-distutils python3-setuptools build-essential libffi-dev && pip install setuptools==58.0.0

# Install wheel
RUN pip install wheel

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages
RUN pip install -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run the application
CMD ["./install_requirements.sh"]
