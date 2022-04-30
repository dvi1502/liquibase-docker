--liquibase formatted sql
--changeset DVI1502:2-1051

CREATE VIEW bookstore.operations_v AS
SELECT book_id,
       CASE
           WHEN qty_change > 0 THEN 'Поступление'
           ELSE 'Покупка'
       END op_type, 
       abs(qty_change) qty_change, 
       to_char(date_created, 'DD.MM.YYYY') date_created
FROM   bookstore.operations
ORDER BY operation_id;