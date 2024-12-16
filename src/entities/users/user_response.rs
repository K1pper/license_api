use chrono::{DateTime, Utc};
use serde::Serialize;
use sqlx::types::Uuid;

use crate::types::UuidExt;

#[derive(Serialize)]
#[allow(non_snake_case)]
pub struct UserResponse {
    pub EmailAddress: String,
    pub Password: String,
    pub UserId: Uuid,
    pub Suspended: bool,
    pub CreateDate: DateTime<Utc>,
    pub Success: bool,
    pub Message: String,
}

impl Default for UserResponse {
    fn default() -> UserResponse {
        UserResponse {
            UserId: <Uuid as UuidExt>::empty(),
            EmailAddress: format!(""),
            Password: format!(""),
            Suspended: true,
            CreateDate: Utc::now(),
            Success: false,
            Message: format!(""),
        }
    }
}
