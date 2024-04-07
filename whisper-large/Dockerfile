ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN whisper --model large dummy.wav; exit 0

ENTRYPOINT ["whisper", "--model", "large"]
