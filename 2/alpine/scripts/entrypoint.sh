#!/bin/bash
set -o errexit
set -o pipefail

## Functions

########################
# Verify and Create Project
# Globals:
#   PROJECT_NAME
#   DJANGO_VERSION
#   SKIP_DB_WAIT
# Arguments:
#   None
# Returns:
#   None
#########################
verify_project() {
    if [[ -f /code/manage.py ]]; then
        echo "Django project found. Skipping creation..."
    else
        echo "Creating new Django project..."
        django-admin startproject ${PROJECT_NAME:-myapp} .

        echo "Add django/django-rest/psycopg2"
        echo "django==${DJANGO_VERSION}" >>requirements.txt
        echo "djangorestframework==3.10.3" >>requirements.txt
        echo "psycopg2==2.8.4" >>requirements.txt

        echo "Installing requirements.txt"
        pip install -r requirements.txt
        echo "Installed !!"
    fi

    echo "Creating Migrations"
    python manage.py makemigrations
    echo "Applying Migrations"
    python manage.py migrate
    echo "Executing Server"
    python manage.py runserver 0.0.0.0:8000
}

verify_project
