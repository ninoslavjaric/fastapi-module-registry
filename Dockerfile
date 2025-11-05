FROM python:3.12-alpine

ARG PORT

WORKDIR /root

COPY . /root

RUN pip install --no-cache-dir -r requirements.txt
RUN apk add --no-cache bash curl jq

ENV PORT=${PORT}
ENV PATH="/root/app/bin:${PATH}"

EXPOSE ${PORT}

HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD curl -fsS http://localhost:${PORT}/ping > /dev/null

CMD ["startup.sh"]