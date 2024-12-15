use sqlx::{postgres::PgRow, Connection, PgConnection};

use crate::configuration::get_configuration;

pub async fn connection() -> PgConnection {
    let configuration = get_configuration().expect("Failed to read configuration");
    let connection_string = configuration.database.connection_string();

    PgConnection::connect(&connection_string)
        .await
        .expect("Failed to connect to Postgres.")
}

pub async fn query(sql: &str, connection: &mut PgConnection) -> Option<PgRow> {
    sqlx::query(&sql)
        .fetch_optional(connection)
        .await
        .expect("Failed to fetch saved user.")
}