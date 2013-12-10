CREATE TABLE bem_type (
    bem_tpye_id     SERIAL PRIMARY KEY,
    bem_type        VARCHAR UNIQUE NOT NULL,
    bem_type_description    TEXT,
    current_bem_id  INTEGER REFERENCES bem(bem_id)
);

CREATE TABLE bem (
    bem_id          SERIAL PRIMARY KEY,
    bem_type_id     INTEGER REFERENCES bem_type(bem_type_id) NOT NULL,
    bem_path        VARCHAR,
    bem_created     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    bem_modified    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    bem_current     BOOLEAN NOT NULL DEFAULT FALSE,
    bem_published   BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE tag_group (
    tag_group_id SERIAL PRIMARY KEY,
    tag_group    VARCHAR NOT NULL UNIQUE,
    tab          VARCHAR UNIQUE NOT NULL
)

CREATE TABLE tag (
    tag_id       SERIAL PRIMARY KEY,
    tag_group_id INTEGER REFERENCES tag_group(tag_group_id),
    tag_order    INTEGER DEFAULT 1,
    tab          VARCHAR UNIQUE NOT NULL
)

CREATE TABLE bem_tag (
    bem_tag_id      SERIAL PRIMARY KEY,
    bem_id          INTEGER REFERENCES bem(bem_id),
    tag_id          INTEGER REFERENCES tag(tag_id)
);
