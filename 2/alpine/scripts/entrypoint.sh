#!/bin/bash
set -o errexit
set -o pipefail

## Functions

########################
# Wait for database to be ready
# Globals:
#   DATABASE_HOST
# Arguments:
#   None
# Returns:
#   None
#########################
wait_for_db() {
    local db_host="${DATABASE_HOST:-mariadb}"
    local db_address
    db_address="$(getent hosts "$db_host" | awk '{ print $1 }')"
    counter=0

    echo "Connecting to MariaDB at $db_address"

    while ! nc -z "$db_host" 3306; do
        counter = $((counter + 1))
        if [ $counter == 30 ]; then
            echo "Error: Couldn't connect to MariaDB."
            exit 1
        fi
        echo "Trying to connect to mariadb at $db_address. Attempt $counter."
        sleep 5
    done
}

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

    # if [[ -z $SKIP_DB_WAIT ]]; then
    #     wait_for_db
    # fi

    echo "Creating Migrations"
    python manage.py makemigrations
    echo "Applying Migrations"
    python manage.py migrate
    echo "Executing Server"
    python manage.py runserver 0.0.0.0:8000
}

verify_project
