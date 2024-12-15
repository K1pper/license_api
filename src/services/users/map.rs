use sqlx::{Row, postgres::PgRow};

use crate::entities::UserResponse;


pub async fn map_user_response(result: Option<PgRow>) -> UserResponse {
    if let Some(result) = result {
        UserResponse {
            EmailAddress: result.get("emailaddress"),
            Password: result.get("password"),
            Success: true,
            ..Default::default()
        }
    } else {
        UserResponse {
            Message: "User not found".to_string(),
            ..Default::default()
        }
    }
}