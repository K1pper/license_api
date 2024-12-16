use serde::Serialize;

#[derive(Serialize)]
#[allow(non_snake_case)]
pub struct UsersResponse {
    // pub User: Vec<UserResponse>
    pub Success: bool,
    pub Message: String,
}

impl Default for UsersResponse {
    fn default() -> UsersResponse {
        UsersResponse {
            Success: false,
            Message: format!(""),
        }
    }
}
