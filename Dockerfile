# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# 替换 APT 源
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware" > /etc/apt/sources.list && \
	echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
	echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
	echo "deb https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list

# Install curl or wget, if not already available
RUN apt-get update && apt-get install -y curl


# # Copy the current directory contents into the container at /usr/src/app
COPY . /app

# Use Tsinghua University's PyPI mirror for faster pip installation
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Download and extract the Linux kernel source using a mirror
RUN curl -L https://mirrors.tuna.tsinghua.edu.cn/kernel/v4.x/linux-4.14.tar.xz | tar -xJ

# Run bash when the container launches
CMD ["/bin/bash"]
