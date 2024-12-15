#[derive(serde::Deserialize)]
#[allow(non_snake_case)]
pub struct UserRequest {
    pub EmailAddress: String,
}