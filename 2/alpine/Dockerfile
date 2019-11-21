FROM python:3.7-alpine
ENV PYTHONUNBUFFERED 1

ENV ZONEINFO=America/Sao_Paulo \
    DJANGO_VERSION=2.2.7

RUN apk update && apk add --no-cache postgresql-dev gcc python3-dev musl-dev bash
RUN apk add --no-cache tzadata; \
    cp /usr/share/zoneinfo/${ZONEINFO} /etc/localtime; \
    echo "${ZONEINFO}" > /etc/timezone

RUN pip install django:${DJANGO_VERSION}

RUN mkdir /code
WORKDIR /code

EXPOSE 8000

ENTRYPOINT [ "/entrypoint.sh" ]