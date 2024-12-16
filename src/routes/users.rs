use crate::db::*;
use crate::{entities::users::*, services::users::*};
use actix_web::{web, HttpResponse, Responder, Result};
use sqlx::PgConnection;

pub async fn get_user(request: web::Json<UserRequest>) -> Result<impl Responder> {
    let mut connection: PgConnection = connection().await;
    Ok(web::Json(get_user_service(request, &mut connection).await))
}

pub async fn get_users(request: web::Json<UsersRequest>) -> Result<impl Responder> {
    let mut connection: PgConnection = connection().await;
    Ok(web::Json(get_users_service(request, &mut connection).await))
}

pub async fn post_user(request: web::Json<UserPostRequest>) -> Result<impl Responder> {
    let mut connection: PgConnection = connection().await;
    Ok(web::Json(post_user_service(request, &mut connection).await))
}

pub async fn patch_user() -> HttpResponse {
    HttpResponse::Ok().finish()
}

pub async fn delete_user() -> HttpResponse {
    HttpResponse::Ok().finish()
}

pub async fn login() -> HttpResponse {
    HttpResponse::Ok().finish()
}

pub async fn logout() -> HttpResponse {
    HttpResponse::Ok().finish()
}
