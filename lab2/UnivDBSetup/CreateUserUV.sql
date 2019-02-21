prompt>Dropping user uv
DROP USER uv CASCADE;

prompt>Creating users
CREATE USER uv IDENTIFIED BY uv DEFAULT TABLESPACE users;

prompt>Granting privileges
GRANT ALL PRIVILEGES TO uv;