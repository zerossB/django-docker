FROM python:3.8-alpine
ENV PYTHONUNBUFFERED 1

ENV ZONEINFO=America/Sao_Paulo \
    DJANGO_VERSION=3.0

RUN apk update && apk add --no-cache postgresql-dev gcc python3-dev musl-dev bash tzdata;
RUN cp /usr/share/zoneinfo/${ZONEINFO} /etc/localtime; \
    echo "${ZONEINFO}" > /etc/timezone

RUN pip install django==${DJANGO_VERSION}

RUN mkdir /scripts
COPY ./scripts /scripts

RUN mkdir /code
WORKDIR /code

EXPOSE 8000

ENTRYPOINT [ "/scripts/entrypoint.sh" ]