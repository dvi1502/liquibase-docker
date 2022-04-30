# poc.liquibase
Proof of concept for liquibase migrations

1- Run docker compose for the database
```bash
Docker-compose -f docker-compose.database.yml up
```

2- Run docker compose for the Liquibase migration
```bash
Docker-compose -f docker-compose.liquibase.yml up
```

All scripts inside /scripts folder will be executed on target database


*****
*****

# Полезные команды для терминала, точнее для трех.

1. Запустить контейнер с БД
```bash
docker-compose -f "docker-compose.database.yml" up -d --build --force-recreate
```

2. Запустить в отдельном терминале psql 
```bash
psql -U postgres -p 5432 -d postgres -h 170.17.0.151
```
3. Много раз запускать контейнер с liquibase. Будут внесены изменения в БД
```bash
docker-compose -f "docker-compose.liquibase.yml" up --build --force-recreate 
```
4. Погасить контейнер с БД
```bash
docker-compose -f "docker-compose.database.yml" down
```


********
********
# Liquibase и changeset’ы на чистом SQL
https://habr.com/ru/post/251617/


Для определения метаданных в файлах SQL используются комментарии, каждый файл changeset’ов начинается с комментария:
```sql
--liquibase formatted sql
```

Каждый changeset в файле начинается с комментария, в котором указываются все необходимые параметры в следующем виде:
```sql
--changeset author:id attribute1:value1 attribute2:value2 [...]
```

Для changeset’а можно задать следующие атрибуты:
|Атрибут|Описание
| -----|------|
|stripComments	|   Если установлено значение true, то перед выполнением SQL операторов удаляются все комментарии. Значение по умолчанию true.|
| splitStatements	|        Если установлено значение false, то Liquibase не будет разделять SQL выражения на символе «;», используется для описания подпрограмм.|
|endDelimiter	|        Задает разделитель SQL операторов, по умолчанию «;».|
|runAlways	|        Если установлено значение true, то список изменений будет выполнятся во время каждой сборки проекта.|
|runOnChange	|        Если установлено значение true, то при внесении правок changeset, он будет выполнен при следующей сборке проекта.|
|context	|        Создание метки для changeset’а, которые в последствии можно выполнить по запросу.|
runInTransaction	|        Если установлено значение true, то все операторы SQL будут выполняться в рамках одной транзакции, если это возможно. По умолчанию значение true.|
|failOnError	|        True – весь changeset будет отменен при возникновении ошибок во время выполнения.|
|dbms	|        Указание типа СУБД, для которой написан changeset.|



После задания параметров указываются предусловия (опционально). Далее идет набор SQL операторов, разделенных точкой с запятой или символом, указанным в атрибуте «endDelimiter».

В настоящий момент в changeset’ах на чистом SQL поддерживается лишь один вид предусловия: SQL Check. Пример предусловия:
```sql
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM my_table
```

В параметр expectedResult передается значение, которое возвращает SQL запрос. Запрос обязательно должен возвращать единственное значение.

Для задания поведения обработки проверки предусловия используется синтаксис аналогичный заданию параметров changeset’а:
```sql
--preconditions attribute1:value1 attribute2:value2 [...]
```

Атрибуты могут быть следующие:
Атрибут	|                    Описание
|--|--|
onFail	            |        Действия в случае, когда changeset не может быть выполнен.
onError	         |           Действия в случае, когда changeset возвращают ошибку.
onUpdateSQL	      |          Действия, которые будут выполнены над changeset’ом, в случае выполнения его в режиме updateSQL.
onFailMessage	       |     Сообщение, которое будет возвращено если changeset не может быть выполнен.
onErrorMessage	        |    Сообщение, которое будет возвращено если changeset выполняется с ошибкой.


В атрибуты onFail и onError могут быть переданы следующие значения:

Значение	  |              Описание
|--|--|
HALT	       |             Немедленно прекратить выполнение changeset’а.
CONTINUE	    |            Содержимое changeset’а будет пропущено и будет предпринята попытка по повторному его выполнению в следующий раз.
MARK_RAN	     |           Changeset будет помечен как выполненный.
WARN	          |          Будет сгенерировано предупреждение и changeset продолжит выполнятся в нормальном режиме.



Changeset’ы могут включать SQL выражения для отката. Выражения отката описываются в форме комментария:

```sql
--rollback SQL STATEMENT
```

Ну и в завершение небольшой примерчик файла changeset’ов:

****
```sql
--liquibase formatted sql
--changeset User1:1 
create table test1 (
    id int primary key,
    name varchar(255)
);
--rollback drop table test1;

--changeset User2:1 
--preconditions onFail:CONTINUE onError:CONTINUE
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM test1
insert into test1 (id, name) values (1, 'User1');
--rollback delete from test1 where id = 1;
```
*******


Подытожив все вышесказанное, хочется добавить, что такие файлы читаются и пишутся гораздо проще, чем xml'ки, но не все плюшки еще поддерживаются (пример по предусловиям, поддерживается сейчас только SQL Check).

***************


## Управление миграциями БД с Liquibase
https://habr.com/ru/post/178665/

## Использование Liquibase без головной боли. 10 советов из опыта реальной разработки
https://habr.com/ru/post/179425/

## Liquibase и Maven
https://habr.com/ru/post/436994/