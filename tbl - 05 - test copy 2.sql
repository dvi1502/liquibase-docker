--liquibase formatted sql
--changeset DVI1502:5

CREATE TABLE bookstore.mytest3 (
    id integer,
    title text 
);

INSERT INTO bookstore.mytest3 (id, title)
VALUES 
    (1, 'Александр'),
    (2, 'Иван'),
    (3, 'Борис');