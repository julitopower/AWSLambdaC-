cmake_minimum_required(VERSION 3.5)
set(CMAKE_CXX_STANDARD 11)
project(juliod_cpp_aws_lambda LANGUAGES CXX)
find_package(aws-lambda-runtime)
find_package(AWSSDK REQUIRED COMPONENTS comprehend s3)

# Entry point for the lambda package
add_executable(${PROJECT_NAME} "src/main.cpp")
target_link_libraries(${PROJECT_NAME} PRIVATE AWS::aws-lambda-runtime ${AWSSDK_LINK_LIBRARIES})
target_compile_options(${PROJECT_NAME} PRIVATE "-Wall" "-Wextra")

# this line creates a target that packages your binary and zips it up
aws_lambda_package_target(${PROJECT_NAME})
