use crate::db::*;
use crate::{entities::users::*, services::get_user_service};
use actix_web::{web, HttpResponse, Responder, Result};
use sqlx::PgConnection;

pub async fn get_user(request: web::Json<UserRequest>) -> Result<impl Responder> {
    let mut connection: PgConnection = connection().await;
    Ok(web::Json(get_user_service(request, &mut connection).await))
}

pub async fn get_users() -> HttpResponse {
    HttpResponse::Ok().finish()
}

pub async fn post_user() -> HttpResponse {
    HttpResponse::Ok().finish()
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
