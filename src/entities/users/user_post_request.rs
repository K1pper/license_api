#[derive(serde::Deserialize)]
#[allow(non_snake_case)]
pub struct UserPostRequest {
    pub EmailAddress: String,
    pub Password: String,
    pub Suspended: bool,
}

