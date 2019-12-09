FROM python:3.8-alpine
ENV PYTHONUNBUFFERED 1

ENV ZONEINFO=America/Sao_Paulo \
    DJANGO_VERSION=2.2.8

RUN apk update && apk add --no-cache postgresql-dev gcc python3-dev musl-dev bash tzdata;\
    cp /usr/share/zoneinfo/${ZONEINFO} /etc/localtime; \
    echo "${ZONEINFO}" > /etc/timezone; \
    pip install django==${DJANGO_VERSION}; \
    mkdir /scripts; \
    mkdir /code;

COPY ./scripts /scripts
WORKDIR /code
EXPOSE 8000
RUN chmod +x /scripts/entrypoint.sh
ENTRYPOINT [ "/scripts/entrypoint.sh" ]