--liquibase formatted sql
--changeset DVI1502:3


CREATE TABLE bookstore.authorship(
    book_id integer REFERENCES bookstore.books,
    author_id integer REFERENCES bookstore.authors,
    seq_num integer NOT NULL,
    PRIMARY KEY (book_id,author_id)
);


INSERT INTO bookstore.authorship(book_id, author_id, seq_num) 
VALUES
    (1, 1, 1),
    (2, 2, 1),
    (3, 3, 2),
    (3, 4, 1),
    (4, 5, 1),
    (5, 6, 1),
    (6, 1, 1),
    (6, 5, 2),
    (6, 2, 3);