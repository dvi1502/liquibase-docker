--liquibase formatted sql
--changeset DVI1502:2-1051

CREATE VIEW bookstore.catalog_v AS
SELECT b.book_id,
       b.title AS display_name
FROM   bookstore.books b;