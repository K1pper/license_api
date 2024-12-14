use actix_web::dev::Server;
use actix_web::{web, App, HttpServer};
use std::net::TcpListener;
use crate::routes::*;

pub fn run(listener: TcpListener) -> Result<Server, std::io::Error> {
    let server = HttpServer::new(|| {
        App::new()
            .route("/healthcheck", web::get().to(health_check))
            .route("/users", web::get().to(get_users))
            .route("/AuthenticationSvc/User", web::get().to(get_user))
            .route("/AuthenticationSvc/Users", web::get().to(health_check))
            .route("/AuthenticationSvc/User", web::post().to(health_check))
            .route("/AuthenticationSvc/User", web::delete().to(health_check))
            .route("/AuthenticationSvc/User", web::patch().to(health_check))
            .route("/AuthenticationSvc/Login", web::post().to(health_check))
            .route("/AuthenticationSvc/Logout", web::post().to(health_check))
    })
    .listen(listener)?
    .run();
    Ok(server)
}