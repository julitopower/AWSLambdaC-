# AWSLambdaC++
A collections of AWS Lambda functions written in C++.

# Build

This project uses Make and CMake for the build system. The following command will build the Docker image used for building the project, and will compile and produce the AWS Lambda package (zip file) under ```./build```

```shell
make
```

# Development

If you are familiar with Emacs you can develop inside the provided container by executing:

```shell
make dev
```

The container provides a fully working Emacs-2.5 with irony-mode for C++ code completion, CMake, GCC-5, ...
