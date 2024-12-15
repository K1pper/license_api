use sqlx::{postgres::PgRow, Row};

use crate::entities::UserResponse;

pub async fn map_user_response(result: Option<PgRow>) -> UserResponse {
    if let Some(result) = result {
        UserResponse {
            EmailAddress: result.get("emailaddress"),
            Password: result.get("password"),
            UserId: result.get("userid"),
            CreateDate: result.get("createdate"),
            Suspended: result.get("suspended"),
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
