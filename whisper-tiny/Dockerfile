ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN whisper --model tiny dummy.wav; exit 0

ENTRYPOINT ["whisper", "--model", "tiny"]
