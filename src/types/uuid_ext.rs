use uuid::Uuid;

pub trait UuidExt {
    fn empty() -> Uuid;
}

impl UuidExt for Uuid {
    fn empty() -> Uuid {
        match Uuid::parse_str("00000000-0000-0000-0000-000000000000") {
            Ok(uuid) => uuid,
            Err(_e) => Uuid::nil(),
        }
    }
}
