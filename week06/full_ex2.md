### Table creation

```sql
CREATE TABLE IF NOT EXISTS Author ( authorID INTEGER PRIMARY KEY, first_name VARCHAR, last_name VARCHAR );

CREATE TABLE IF NOT EXISTS Book ( bookID INTEGER PRIMARY KEY, book_title VARCHAR, month_ VARCHAR, year_ INTEGER, editor INTEGER, FOREIGN KEY ( editor ) REFERENCES Author ( authorID ) );

CREATE TABLE IF NOT EXISTS Pub ( pubID INTEGER PRIMARY KEY, title VARCHAR, bookID INTEGER, FOREIGN KEY ( bookID ) REFERENCES Book ( bookID ) );

CREATE TABLE IF NOT EXISTS AuthorPub ( authorID INTEGER, pubID INTEGER, author_position INTEGER ), PRIMARY KEY ( authorID, pubID ), FOREIGN KEY ( authorID ) REFERENCES Author( authorID ), FOREIGN KEY ( pubID ) REFERENCES Pub( pubID ) );
	
```

### Data insertion into tables 

```sql
INSERT INTO Author VALUES  ( 1, 'John', 'McCarthy' ),  ( 2, 'Dennis', 'Ritchie' ), ( 3, 'Ken', 'Thompson' ), ( 4, 'Claude', 'Shannon' ),  ( 5, 'Alan', 'Turing' ),  ( 6, 'Alonzo', 'Church' ),  ( 7, 'Perry', 'White' ),  ( 8, 'Moshe', 'Vardi' ), ( 9, 'Roy', 'Batty' );

INSERT INTO Book VALUES ( 1, 'CACM', 'April', 1960, 8 ),  ( 2, 'CACM', 'July', 1974, 8 ),  ( 3, 'BTS', 'July', 1948, 2 ), ( 4, 'MLS', 'November', 1936, 7 ), ( 5, 'Mind', 'October', 1950, NULL ), ( 6, 'AMS', 'Month', 1941, NULL ), ( 7, 'AAAI', 'July', 2012, 9 ), ( 8, 'NIPS', 'July', 2012, 9 );

INSERT INTO Pub VALUES ( 1, 'LISP', 1 ), ( 2, 'Unix', 2 ), ( 3, 'Info Theory', 3 ), ( 4, 'Turing Machines', 4 ), ( 5, 'Turing Test', 5 ), ( 6, 'Lambda Calculus', 6 );

INSERT INTO AuthorPub VALUES ( 1,1,1 ), ( 2,2,1 ), ( 3,2,2 ), ( 4,3,1 ), ( 5,4,1 ), ( 5,5,1 ), ( 6,6,1 );
```

### EXERCISE 2

##### 1 QUERY 

```sql
SELECT * FROM Author JOIN Book ON Author.authorID=Book.editor;
```



##### 2 QUERY 

```sql
SELECT Q1.first_name, Q1.last_name FROM (SELECT W1.authorID, W1.first_name, W1.last_name FROM Author AS W1 EXCEPT SELECT E1.editor, Author.first_name, Author.last_name FROM Book AS E1 JOIN Author ON E1.editor=Author.authorID ) AS Q1;
```



##### 3 QUERY

```sql
SELECT authorID FROM Author EXCEPT SELECT editor FROM Book;
```

