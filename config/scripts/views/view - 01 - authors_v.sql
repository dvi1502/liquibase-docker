--liquibase formatted sql
--changeset DVI1502:2-1050

CREATE VIEW bookstore.authors_v AS
SELECT a.author_id,
       a.last_name || ' ' ||
       a.first_name ||
       coalesce(' ' || nullif(a.middle_name, ''), '') AS display_name
FROM   bookstore.authors a;