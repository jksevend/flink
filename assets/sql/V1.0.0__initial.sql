CREATE TABLE if not exists tab_collection
(
    id          text primary key,
    name        text unique not null,
    description text,
    created_at  text        not null,
    updated_at  text        not null
);

CREATE TABLE if not exists tab_todo
(
    id            text primary key,
    collection_id text,
    title         text unique not null,
    content       text,
    deadline      text,
    remind_at     text,
    done          integer     not null,
    favourite     integer     not null,
    created_at    text        not null,
    updated_at    text        not null,

    foreign key (collection_id) references tab_collection (id)
);
