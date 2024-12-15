use crate::helpers::spawn_app;

#[tokio::test]
async fn check_get_user_works() {
    println!("\ntest check get user works");
    // Arrange
    let address = spawn_app();

    let client = reqwest::Client::new();

    // Act
    let body = serde_json::json!({
        "emailaddress": "pjroden@gmail.com"
    });
    

    println!("{}", format!("{}/AuthenticationSvc/User", address));

    let response = client
        .get(&format!("{}/AuthenticationSvc/User", address))
        .form(&body)
        .send()
        .await
        .expect("Failed to execute request.");

    // Assert
    println!("  Spawned address is: {}", address);
    println!("  Returned status is: {}", response.status().as_str());
    assert!(response.status().is_success());
    assert_eq!(Some(0), response.content_length());
}
