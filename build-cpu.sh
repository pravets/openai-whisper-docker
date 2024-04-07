#!/bin/bash

DOCKER_USERNAME=sleemp
BASE_NAME=whisper-cpu-empty
BASE_IMAGE_NAME="${DOCKER_USERNAME}/${BASE_NAME}:latest"

# Build base image
echo "Building base image: ${BASE_IMAGE_NAME}"
docker build -t ${BASE_IMAGE_NAME} -f ./whisper-cpu-empty/Dockerfile .
# Push base image
echo "Pushing ${BASE_IMAGE_NAME}"
docker push ${BASE_IMAGE_NAME}

# Build tiny model image
MODEL_NAME=tiny
MODEL_IMAGE_NAME="${DOCKER_USERNAME}/whisper-cpu-${MODEL_NAME}:latest"
echo "Building model-specific image: ${MODEL_IMAGE_NAME}"
docker build -t ${MODEL_IMAGE_NAME} --build-arg BASE_IMAGE=${BASE_IMAGE_NAME} -f ./whisper-${MODEL_NAME}/Dockerfile .
echo "Pushing ${MODEL_IMAGE_NAME}"
docker push ${MODEL_IMAGE_NAME}

# Build base model image
MODEL_NAME=base
MODEL_IMAGE_NAME="${DOCKER_USERNAME}/whisper-cpu-${MODEL_NAME}:latest"
echo "Building model-specific image: ${MODEL_IMAGE_NAME}"
docker build -t ${MODEL_IMAGE_NAME} --build-arg BASE_IMAGE=${BASE_IMAGE_NAME} -f ./whisper-${MODEL_NAME}/Dockerfile .
echo "Pushing ${MODEL_IMAGE_NAME}"
docker push ${MODEL_IMAGE_NAME}

# Build small model image
MODEL_NAME=small
MODEL_IMAGE_NAME="${DOCKER_USERNAME}/whisper-cpu-${MODEL_NAME}:latest"
echo "Building model-specific image: ${MODEL_IMAGE_NAME}"
docker build -t ${MODEL_IMAGE_NAME} --build-arg BASE_IMAGE=${BASE_IMAGE_NAME} -f ./whisper-${MODEL_NAME}/Dockerfile .
echo "Pushing ${MODEL_IMAGE_NAME}"
docker push ${MODEL_IMAGE_NAME}

# Build medium model image
MODEL_NAME=medium
MODEL_IMAGE_NAME="${DOCKER_USERNAME}/whisper-cpu-${MODEL_NAME}:latest"
echo "Building model-specific image: ${MODEL_IMAGE_NAME}"
docker build -t ${MODEL_IMAGE_NAME} --build-arg BASE_IMAGE=${BASE_IMAGE_NAME} -f ./whisper-${MODEL_NAME}/Dockerfile .
echo "Pushing ${MODEL_IMAGE_NAME}"
docker push ${MODEL_IMAGE_NAME}

# Build large model image
MODEL_NAME=large
MODEL_IMAGE_NAME="${DOCKER_USERNAME}/whisper-cpu-${MODEL_NAME}:latest"
echo "Building model-specific image: ${MODEL_IMAGE_NAME}"
docker build -t ${MODEL_IMAGE_NAME} --build-arg BASE_IMAGE=${BASE_IMAGE_NAME} -f ./whisper-${MODEL_NAME}/Dockerfile .
echo "Pushing ${MODEL_IMAGE_NAME}"
docker push ${MODEL_IMAGE_NAME}
