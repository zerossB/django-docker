#!/bin/bash
if [[ -z "${ENVIRONMENT}" ]]; then
    echo "Environment Type: DEV"
    python manage.py makemigrations
    python manage.py migrate
    python manage.py runserver 0.0.0.0:8000
else
    echo "Environment Type: ${ENVIRONMENT}"
fi
