-- creating tables
create table if not exists book(book_id int not null generated always as identity, title varchar(128) not null, pid int not null, primary key (book_id));
create table if not exists course(course_id int not null generated always as identity, title varchar(128) not null, primary key (course_id));
create table if not exists loan(loan_id int not null generated always as identity, bid int not null, dateL date not null, tlcid int not null, primary key (loan_id));
create table if not exists grade(grade_id int not null generated always as identity, name varchar(128) not null, primary key (grade_id));
create table if not exists publisher(publisher_id int not null generated always as identity, name varchar(128) not null, primary key (publisher_id));
create table if not exists school(school_id int not null generated always as identity, name varchar(128) not null, primary key (school_id));
create table if not exists room(room_id int not null generated always as identity, name varchar(128) not null, primary key (room_id));
create table if not exists teacher(teacher_id int not null generated always as identity, name varchar(128) not null, sid int not null, primary key (teacher_id));
create table if not exists teachers_room(tid int not null, rid int not null, primary key (tid, rid));
create table if not exists teacher_level_course(teacher_level_course_id int not null generated always as identity, tid int not null, gid int not null, cid int not null, primary key (teacher_level_course_id));

--adding foreign keys
alter table book add constraint FK_From_publisher_to_book foreign key (pid) references publisher (publisher_id);
alter table loan add constraint FK_From_book_TO_loan foreign key (bid) references book (book_id);
alter table loan add constraint FK_From_teacher_level_course_TO_loan foreign key (tlcid) references teacher_level_course (teacher_level_course_id);
alter table teacher add constraint FK_From_school_TO_teacher foreign key (sid) references school (school_id);
alter table teachers_room add constraint FK_From_teacher_TO_teachers_room foreign key (tid) references teacher (teacher_id);
alter table teachers_room add constraint FK_From_room_TO_teachers_room foreign key (rid) references room (room_id);
alter table teacher_level_course add constraint FK_From_teacher_TO_teacher_level_course foreign key (tid) references teacher (teacher_id);
alter table teacher_level_course add constraint FK_from_grade_TO_teacher_level_course foreign key (gid) references grade (grade_id);
alter table teacher_level_course add constraint FK_From_course_TO_teacher_level_course foreign key (cid) references course (course_id);
    
      
-- initializing tables 
insert into publisher(name) values ('BOA Editions'), ('Taylor & Francis Publishing'), ('Prentice Hall'), ('McGraw Hill');
insert into book(title, pid) values ('Learning and teaching in early childhood', 1), ('Preschool,N56', 2), ('Early Childhood Education N9', 3), ('Know how to educate: guide for Parents and ...', 4);
insert into grade(name) values ('1st grade'), ('2nd grade');
insert into course(title) values ('Logical thinking'), ('Wrtting'), ('Numerical Thinking'), ('Spatial, Temporal and Causal Thinking'), ('English');
insert into room(name) values ('1.A01'), ('1.B01'), ('2.B01');
insert into school(name) values ('Horizon Education Institute'), ('Bright Institution');
insert into teacher(name, sid) values ('Chad Russell', 1), ('E.F.Codd', 1), ('Jones Smith', 1), ('Adam Baker', 2);   
insert into teachers_room(tid,rid) values (1,1), (2,2), (3,1), (4,3);
insert into teacher_level_course(tid,gid,cid) values (1,1,1), (1,1,2), (1,1,3), (2,1,4), (2,1,3), (3,2,2), (3,2,5), (4,1,1), (4,1,3); 
insert into loan(tlcid, bid, dateL) values (1, 1,'09/09/2010'), (2, 2,'05/05/2010'), (3, 1,'05/05/2010'), (4, 3,'06/05/2010'), (5, 1,'06/05/2010'), (6, 1,'09/09/2010'), (7, 4,'05/05/2010'), (8, 4,'18/12/2010'),    (9, 1,'06/05/2010');



