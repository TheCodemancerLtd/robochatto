FROM python:3.13-slim

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    ROBOCHATTO_DB=/data/robochatto.db

RUN apt-get update \
 && apt-get install -y --no-install-recommends git \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ARG CHATTOLIB_REF=main
RUN pip install "chattolib @ git+https://github.com/TheCodemancerLtd/chattolib.git@${CHATTOLIB_REF}"

COPY pyproject.toml bot.py ./
RUN pip install .

RUN apt-get purge -y --auto-remove git \
 && rm -rf /var/lib/apt/lists/*

VOLUME ["/data"]

CMD ["python", "bot.py"]
