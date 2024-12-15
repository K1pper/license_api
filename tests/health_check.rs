use std::net::TcpListener;

// Launch our application in the background ~somehow~
fn spawn_app() -> String {
    let listener = TcpListener::bind("127.0.0.1:0").expect("Failed to bind to random port");
    let port = listener.local_addr().unwrap().port();
    let server = license_api::startup::run(listener).expect("Failed to bind address");
    // Launch the server as a background task
    // tokio::spawn returns a handle to the spawned future,
    // but we have no use for it here, hence the non-binding let
    let _ = tokio::spawn(server);
    format!("http://127.0.0.1:{}", port)
}

#[test]
fn dummy_test() {
    println!("");
    assert_eq!(1, 1);
}

// `tokio::test` is the testing equivalent of `tokio::main`.
// It also spares you from having to specify the `#[test]` attribute.
//
// You can inspect what code gets generated using
// `cargo expand --test health_check` (<- name of the test file)

#[tokio::test]
/*
- the health check is exposed at /health_check;
- the health check is behind a GET method;
- the health check always returns a 200;
- the health check’s response has no body.
*/
async fn health_check_works() {
    println!("\ntest health_check_works");
    // Arrange
    let address = spawn_app();

    let client = reqwest::Client::new();

    // Act
    let response = client
        .get(&format!("{}/healthcheck", address))
        .send()
        .await
        .expect("Failed to execute request.");

    // Assert
    println!("  Spawned address is: {}", address);
    assert!(response.status().is_success());
    assert_eq!(Some(0), response.content_length());
}
