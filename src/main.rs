#![warn(clippy::all, clippy::pedantic)]

use std::net::TcpListener;
use license_api::startup::run;
use license_api::configuration::get_configuration;

#[tokio::main]
async fn main() -> Result<(), std::io::Error> {
    // Panic if we can't read configuration
    let configuration = get_configuration().expect("Failed to read configuration.");

    let address = format!("127.0.0.1:{}", configuration.application_port);
    let listener = TcpListener::bind(address).expect("Failed to bind to port");

    run(listener)?.await
}