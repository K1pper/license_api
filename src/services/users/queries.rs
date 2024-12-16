use sqlx::types::chrono;
use uuid::Uuid;

use crate::entities::{UserPostRequest, UserRequest, UsersRequest};

pub fn get_user_query(request: UserRequest) -> String {
    format!(
        "SELECT emailaddress, password, userid, createdate, suspended 
         FROM users where emailaddress = '{}'",
        request.EmailAddress
    )
}

pub fn get_users_query(_request: UsersRequest) -> String {
    format!(
        "SELECT emailaddress, password, userid, createdate, suspended 
         FROM users"
    )
}

pub fn post_user_query(request: &UserPostRequest) -> String {
    format!(
        "INSERT INTO users (
           userid, emailaddress, password, suspended, createdate
         ) VALUES (
           '{}', '{}', '{}', {}, '{}'
         )",
        Uuid::new_v4(), request.EmailAddress,
        request.Password, request.Suspended, chrono::Utc::now()
    )
}

pub fn patch_user_query(request: UserPostRequest) -> String {
    format!(
        "UPDATE users
         set password = '{}', suspended = '{}'
         where emailaddress = '{}'",
         request.Password, request.Suspended, request.EmailAddress
    )
}
