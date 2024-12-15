use actix_web::web;
use sqlx::PgConnection;

use crate::{
    db::query,
    entities::{UserRequest, UserResponse},
};

use super::{get_user_query, map_user_response};

pub async fn get_user_service(
    request: web::Json<UserRequest>,
    connection: &mut PgConnection,
) -> UserResponse {
    let sql = get_user_query(request).await;
    map_user_response(query(&sql, connection).await).await
}
