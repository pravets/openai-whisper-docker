ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN whisper --model base dummy.wav; exit 0

ENTRYPOINT ["whisper", "--model", "base"]
