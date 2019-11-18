FROM python:3.7-alpine
ENV PYTHONUNBUFFERED 1

ENV ZONEINFO=America/Sao_Paulo

RUN apk update && apk add --no-cache postgresql-dev gcc python3-dev musl-dev bash
RUN apk add --no-cache tzadata; \
    cp /usr/share/zoneinfo/${ZONEINFO} /etc/localtime; \
    echo "${ZONEINFO}" > /etc/timezone

RUN mkdir /code
WORKDIR /code

EXPOSE 8000

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "executable" ]