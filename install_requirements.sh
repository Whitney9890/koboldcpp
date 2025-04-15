#!/bin/bash
# Update package list and install distutils
apt-get update && apt-get install -y python3-distutils

# Install Python requirements
pip install -r requirements.txt
