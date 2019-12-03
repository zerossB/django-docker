# Django Development Container

Image made to be able to create and run Django projects in a simple and 100% modifiable way.

## How to use?

Simply build the image using `docker build -t docker-django`.

and run it with all needed parameter:

```bash
docker run --rm \
    -v ./:/code \
    -e ZONEINFO=America/Sao_Paulo \
    -e DJANGO_VERSION=2.2.7\
    -e PROJECT_NAME=myproject
     django-docker
```

With Docker-Compose

```yaml
version: "3"
services:
  db:
    image: postgres
    ports:
      - "5432:5432"
  web:
    image: zerossb/django-docker:2-alpine
    restart: always
    environment:
      ZONEINFO: "America/Sao_Paulo"
      DJANGO_VERSION: 2.2.7
      PROJECT_NAME: myapp
    ports:
      - 8000:8000
    volumes:
      - .:/code
```

That's it.

## Environment variables

This image uses environment variables for configuration.


Available variables | Default value| Description
--- | --- | ---
ZONEINFO | America/Sao_Paulo | [Django Time Zone](https://docs.djangoproject.com/en/2.2/topics/i18n/timezones/)
DJANGO_VERSION | 2.2.7 | Django Version
PROJECT_NAME | myapp | Project Name

## Functionalities

- Creates the project automatically.
- Install all requirements.txt dependencies
- 100% customizable

## License
This git repo is under the GNU V3 license. Find it here.