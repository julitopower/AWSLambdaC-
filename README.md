# AWSLambdaC++

A collection of AWS Lambda functions written in C++. There is currently a single function that makes use of AWS Comprehend sentiment analysis. 

Example request:

```json
{
"lang": "en",
"text": "I love it"
}
```

Example response:

```
"POSITIVE"
```

# Build

This project uses Make and CMake for the build system. The following command will build the Docker image used for building the project, and will compile and produce the AWS Lambda package (zip file) under ```./build```

```shell
make
```

The generated [AWS Lambda package](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html) can be directly deployed on AWS. 

# Development

If you are familiar with Emacs you can develop inside the provided container by executing:

```shell
make dev
```

The container provides a fully working Emacs-2.5 with irony-mode for C++ code completion, CMake, GCC-5, ...
