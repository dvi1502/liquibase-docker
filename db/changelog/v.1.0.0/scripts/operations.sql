--liquibase formatted sql
--changeset DVI1502:4


CREATE TABLE bookstore.operations(
    operation_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    book_id integer NOT NULL REFERENCES bookstore.books,
    qty_change integer NOT NULL,
    date_created date NOT NULL DEFAULT current_date
);


-- COPY operations (operation_id, book_id, qty_change) FROM stdin;
-- 1	1	10
-- 2	1	10
-- 3	1	-1
-- \.

-- SELECT pg_catalog.setval('operations_operation_id_seq', 3, true);