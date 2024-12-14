use actix_web::{web, HttpResponse, Responder, Result};
//use uuid::Uuid;
use serde::Serialize;
//use sqlx::types::{chrono::{DateTime, Utc}, uuid::{self}};

pub async fn get_user() -> Result<impl Responder> {
    let response = UserResponse {
            success: true,
            message: "".to_string(),
            EmailAddress: "pjroden@gmail.com".to_string(),
            password: "password".to_string(),
    };
    Ok(web::Json(response))
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

#[derive(Serialize)]
#[warn(non_snake_case)]
struct UserResponse {
    EmailAddress: String,
    password: String,
    // UserId: Uuid,
    // Suspended: bool,
    // CreateDate:DateTime<Utc>
    success: bool,
    message: String,
}
