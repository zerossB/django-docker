#!/bin/bash

set -o errexit
set -o pipefail

## Functions

########################
# Verify installed packages have compatible dependencies.
# Arguments:
#   None
# Returns:
#   Boolean
#########################
pip_check() {
    pip check 1>/dev/null
}

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

    log "Connecting to MariaDB at $db_address"

    while ! nc -z "$db_host" 3306; do
        counter = $((counter + 1))
        if [ $counter == 30 ]; then
            log "Error: Couldn't connect to MariaDB."
            exit 1
        fi
        log "Trying to connect to mariadb at $db_address. Attempt $counter."
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
    if [[ -z manage.py ]]; then
        log "Django project found. Skipping creation..."
    else
        log "Creating new Django project..."
        django-admin startproject ${PROJECT_NAME} .

        log "Add django/django-rest/psycopg2"
        echo "django:${DJANGO_VERSION}" >>requirements.txt
        echo "djangorestframework:3.10.3" >>requirements.txt
        echo "psycopg2:2.8.4" >>requirements.txt
    fi

    if ! pip_check; then
        log "Installing requirements.txt"
        pip install -r requirements.txt
        log "Installed !!"
    fi

    if [[ -z $SKIP_DB_WAIT ]]; then
        wait_for_db
    fi
}

verify_project
