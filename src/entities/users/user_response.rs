use serde::Serialize;

#[derive(Serialize)]
#[allow(non_snake_case)]
pub struct UserResponse {
    pub EmailAddress: String,
    pub Password: String,
    // UserId: Uuid,
    // Suspended: bool,
    // CreateDate:DateTime<Utc>
    pub Success: bool,
    pub Message: String,
}

impl Default for UserResponse {
    fn default() -> UserResponse {
        UserResponse {
            EmailAddress: format!(""),
            Password: format!(""),
            Success: false,
            Message: format!(""),
        }
    }
}