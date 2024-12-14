use actix_web::HttpResponse;

pub async fn get_users() -> HttpResponse {
    HttpResponse::Ok().finish()
}
