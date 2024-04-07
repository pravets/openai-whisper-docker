ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN whisper --model small dummy.wav; exit 0

ENTRYPOINT ["whisper", "--model", "small"]
