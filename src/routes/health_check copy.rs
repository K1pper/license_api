use crate::helpers::spawn_app;

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
