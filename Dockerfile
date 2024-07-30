# Use the official Python image from the Docker Hub
#FROM python:3.9
# Use the official Python image from the Docker Hub, specifying the ARM architecture
FROM --platform=linux/arm64 python:3.9

#
FROM --platform=linux/arm64 python:3.9
# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libglib2.0-0 \
    libgl1-mesa-glx \
    libboost-python-dev \
    libboost-system-dev \
    libopenblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    libx11-dev \
    libgtk-3-dev \
    libjpeg-dev \
    libtiff-dev \
    libpng-dev \
    python3-dev

# Install dlib
RUN pip install dlib

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run main.py when the container launches
CMD ["python", "Main.py"]
