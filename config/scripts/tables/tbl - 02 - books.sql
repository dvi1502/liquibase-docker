--liquibase formatted sql
--changeset DVI1502:1


CREATE TABLE bookstore.books(
    book_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title text NOT NULL
);

INSERT INTO bookstore.books(title)
VALUES
    ('Сказка о царе Салтане'),
    ('Муму'),
    ('Трудно быть богом'),
    ('Война и мир'),
    ('Путешествия в некоторые удаленные страны мира в четырех частях: сочинение Лемюэля Гулливера, сначала хирурга, а затем капитана нескольких кораблей'),
    ('Хрестоматия');

    