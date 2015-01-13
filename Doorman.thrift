namespace java io.golgi.example.doorman.gen

struct AccessRequest {
    1:required string uname,
    2:required string key,
    3:required string lat,
    4:required string lon,
    5:required string auth,
    6:optional i32 tsh,
    7:optional i32 tsl
}

struct AccessResponse {
    1:required string code
}

struct KeyRequest {
    1:required string requestId,
    2:required string senderId,
    3:required string auth,
    4:optional i32 day,
    5:optional i32 month,
    6:optional i32 year,
    7:optional string msgid
}

struct KeyResponse {
    1:required string code,
    2:required string uname,
    3:required string key,
    4:optional i32 day,
    5:optional i32 month,
    6:optional i32 year,
    7:optional string msgid
}


service Doorman{
    AccessResponse sendAccessRequest(1:AccessRequest req),
    KeyResponse sendKeyRequest(1:KeyRequest req),
}

