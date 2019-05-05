FROM julitopower/dockercppdevemacsclang

RUN mkdir -p /opt/third_party
WORKDIR /opt/third_party

RUN apt-get update -y && apt-get install python3 git libcurl4-openssl-dev zip -y
RUN git clone https://github.com/awslabs/aws-lambda-cpp
WORKDIR /opt/third_party/aws-lambda-cpp
RUN mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release
RUN cd build && make && make install

WORKDIR /opt/src/