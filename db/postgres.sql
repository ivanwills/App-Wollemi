BEGIN;

CREATE TABLE bem_type (
    bem_type_id     SERIAL PRIMARY KEY,
    bem_type        VARCHAR UNIQUE NOT NULL,
    bem_type_description    TEXT,
    current_bem_id  INTEGER
);

CREATE TABLE bem (
    bem_id          SERIAL PRIMARY KEY,
    bem_type_id     INTEGER NOT NULL REFERENCES bem_type(bem_type_id),
    bem_path        VARCHAR,
    bem_created     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    bem_modified    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    bem_current     BOOLEAN NOT NULL DEFAULT FALSE,
    bem_published   BOOLEAN NOT NULL DEFAULT FALSE
);

ALTER TABLE bem_type ADD CONSTRAINT current_bem_id_bem_bem_id_fkey FOREIGN KEY (current_bem_id) REFERENCES bem(bem_id);

CREATE TABLE tag_group (
    tag_group_id SERIAL PRIMARY KEY,
    tag_group    VARCHAR NOT NULL UNIQUE,
    tag_group_description    TEXT,
    tab          VARCHAR UNIQUE NOT NULL
);

CREATE TABLE tag (
    tag_id       SERIAL PRIMARY KEY,
    tag_group_id INTEGER REFERENCES tag_group(tag_group_id),
    tag          VARCHAR UNIQUE NOT NULL,
    tag_order    INTEGER DEFAULT 1
);

CREATE TABLE bem_tag (
    bem_tag_id      SERIAL PRIMARY KEY,
    bem_id          INTEGER REFERENCES bem(bem_id),
    tag_id          INTEGER REFERENCES tag(tag_id)
);

COMMIT;
