# Use the official Python image from the Docker Hub, specifying the ARM architecture
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
    python3-dev \
    && apt-get clean

# Install pipenv
RUN pip install pipenv

# Copy the Pipfile and Pipfile.lock
COPY Pipfile Pipfile.lock /app/

# Install dependencies
RUN pipenv install --deploy --system

# Copy the rest of the application code
COPY . /app

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME=World

# Run main.py when the container launches
CMD ["pipenv", "run", "python", "Main.py"]
