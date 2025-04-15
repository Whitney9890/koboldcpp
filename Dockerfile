# Use an official Python runtime as the base image
FROM python:3.12-slim

# Install distutils and setuptools
RUN apt-get update && apt-get install -y python3-distutils && pip install --upgrade setuptools

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
