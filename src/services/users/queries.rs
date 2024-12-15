use actix_web::web;

use crate::entities::UserRequest;

pub async fn get_user_query(request: web::Json<UserRequest>) -> String {
    format!(
        "SELECT emailaddress, password 
         FROM users where emailaddress = '{}'",
        request.EmailAddress)
}