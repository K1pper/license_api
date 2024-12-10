#!/usr/bin/env bash
set -x
set -eo pipefail

if ! [ -x "$(command -v psql)" ]; then
echo >&2 "Error: psql is not installed."
exit 1
fi

if ! [ -x "$(command -v sqlx)" ]; then
echo >&2 "Error: sqlx is not installed."
echo >&2 "Use:"
echo >&2 "
cargo install --version='~0.7' sqlx-cli \
--no-default-features --features rustls,postgres"
echo >&2 "to install it."
exit 1
fi

# Check if a custom user has been set, otherwise default to 'postgres'
DB_USER="${POSTGRES_USER:=license}"
# Check if a custom password has been set, otherwise default to 'password'
DB_PASSWORD="${POSTGRES_PASSWORD:=password}"
# Check if a custom database name has been set, otherwise default to 'newsletter'
DB_NAME="${POSTGRES_DB:=master}"
# Check if a custom port has been set, otherwise default to '5432'
DB_PORT="${POSTGRES_PORT:=5433}"
# Check if a custom host has been set, otherwise default to 'localhost'
DB_HOST="${POSTGRES_HOST:=localhost}"
# Launch postgres using Docker
docker run \
-e POSTGRES_USER=${DB_USER} \
-e POSTGRES_PASSWORD=${DB_PASSWORD} \
-e POSTGRES_DB=${DB_NAME} \
-p "${DB_PORT}":5433 \
-d postgres \
postgres -N 1000
# ^ Increased maximum number of connections for testing purposes