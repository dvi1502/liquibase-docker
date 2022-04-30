--liquibase formatted sql

--changeset DVI1502:"2020-03-08-create-table-bookstore-authors"
--comment: example comment

CREATE TABLE bookstore.authors(
    author_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    last_name text NOT NULL,
    first_name text NOT NULL,
    middle_name text
);

--rollback DROP TABLE bookstore.authors;

--changeset DVI1502:"2020-03-08-insert-table-bookstore-authors"
--comment: example comment
INSERT INTO bookstore.authors(last_name, first_name, middle_name)
VALUES 
    ('Пушкин', 'Александр', 'Сергеевич'),
    ('Тургенев', 'Иван', 'Сергеевич'),
    ('Стругацкий', 'Борис', 'Натанович'),
    ('Стругацкий', 'Аркадий', 'Натанович'),
    ('Толстой', 'Лев', 'Николаевич'),
    ('Свифт', 'Джонатан', NULL);

--rollback TRUNCATE TABLE bookstore.authors;    