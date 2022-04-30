--liquibase formatted sql
--changeset DVI1502:5

CREATE TABLE bookstore.mytest (
    id integer,
    title text 
);

INSERT INTO bookstore.mytest (id, title)
VALUES 
    (1, 'Александр'),
    (2, 'Иван'),
    (3, 'Борис');