use actix_web::web;
use sqlx::PgConnection;

use crate::{
    db::{post, query},
    entities::users::*,
};

use super::{get_user_query, map_user_response, post_user_query};

pub async fn get_user_service(
    request: web::Json<UserRequest>,
    connection: &mut PgConnection,
) -> UserResponse {
    let sql = get_user_query(request.0);
    map_user_response(query(&sql, connection).await).await
}

pub async fn get_users_service(
    _request: web::Json<UsersRequest>,
    _connection: &mut PgConnection,
) -> UsersResponse {
    UsersResponse {
        Message: "Not yet implemented".to_string(),
        ..Default::default()
    }
}

pub async fn post_user_service(
    request: web::Json<UserPostRequest>,
    connection: &mut PgConnection,
) -> UserResponse {
    let sql = post_user_query(&request);
    print!("{}", sql);
    map_user_response(post(&sql, connection).await).await

    // let get_request = UserRequest {
        // EmailAddress: request.EmailAddress.to_string()
    // };

    // let sql = get_user_query(get_request);
    // map_user_response(query(&sql, connection).await).await
}
