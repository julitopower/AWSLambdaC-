FROM julitopower/dockercppdevemacsclang

# Depedencies needed by aws-lambda
RUN apt-get update -y && apt-get install python3 git libcurl4-openssl-dev zip -y

# Dependencies needed by aws c++ sdk
RUN apt-get install libcurl4-openssl-dev libssl-dev uuid-dev zlib1g-dev libpulse-dev -y

# Setup the folder to download the source code
RUN mkdir -p /opt/third_party
WORKDIR /opt/third_party

# Download and install aws-lambda-cpp
RUN git clone https://github.com/awslabs/aws-lambda-cpp
WORKDIR /opt/third_party/aws-lambda-cpp
RUN mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release
RUN cd build && make && make install

# Download and install aws c++ sdk
WORKDIR /opt/third_party
RUN pwd && git clone https://github.com/aws/aws-sdk-cpp.git
WORKDIR /opt/third_party/aws-sdk-cpp
RUN mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release
RUN cd build && make -j 8 && make install

WORKDIR /opt/src/