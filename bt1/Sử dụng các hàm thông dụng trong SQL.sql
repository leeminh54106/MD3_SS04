create database class_student;
use class_student;

create table class(
id int primary key auto_increment,
name varchar(255),
startdate varchar(255),
status bit);

create table student(
id int primary key auto_increment,
name varchar(100),
address varchar(255),
phone varchar (11),
class_id int,
foreign key (class_id) references class(id),
status bit);

create table subjects(
id int primary key auto_increment,
name varchar(255),
credit int,
status bit);

create table mark(
id int primary key auto_increment,
student_id int,
foreign key (student_id) references student(id),
subject_id int,
foreign key (subject_id) references subjects(id),
mark double,
examtime datetime);

select id,name,startdate, case when status = 0 then 'true' else 'false' end as status from class;
insert into class (name,startdate,status) values('HN-JV231103','03-11-2023',0),
('HN-JV231229','29-12-2023',0),
('HN-JV230615','15-06-2023',0);

select id,name,address,phone,class_id, case when status = 0 then 'true' else 'false' end as status from student;
insert into student values(1,'hồ da hùng','hà nội','0987654321',1,0),
(2,'phan văn giang','đà nẵng','0967811255',1,0),
(3,'dương mỹ huyền','hà nội','0385546611',2,0);

insert into student values(4,'hoàng minh hiếu','nghệ an','0987654333',2,0),
(5,'nguyễn vịnh','hà nội','0967811656',3,0),
(6,'nam cao','hà tĩnh','0985547911',1,0),
(7,'nguyễn du','nghệ an','0385546597',3,0);

select *,case when status = 0 then 'true' else 'false' end as trang_thai from subjects;
insert into subjects values(1,'toán',3,0),(2,'văn',3,0),(3,'anh',2,0);

select * from mark;
insert into mark values(1,1,1,7,'2024-5-12'),(2,1,1,7,'2024-3-15');
insert into mark values(3,2,2,8,'2024-5-15'),(4,2,3,9,'2024-03-08'),(5,3,3,10,'2024-02-11');

select * from class order by class.name desc;

select * from student where address = 'hà nội' ;

select s.*,c.name from class c
join student s on s.class_id = c.id
where c.name = 'HN-JV231103';

select * from subjects where credit >2;

select * from student where phone like '09%';

-- Hiển thị số lượng sinh viên theo từng địa chỉ nơi ở.
select address, count(*) as student_count from student group by address;


-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select sub.name,max(m.mark) as diemcao from subjects sub
join mark m on m.subject_id = sub.id
group by sub.name;

-- Tính điểm trung bình các môn học của từng học sinh.
select s.name,avg(m.mark) as diem_tb from student s 
join mark m on m.student_id = s.id
group by m.student_id;

-- Hiển thị những bạn học viên có điểm trung bình các môn học nhỏ hơn hoặc bằng 7.
select s.name,avg(m.mark) as diem_tb from student s
join mark m on m.student_id = s.id
group by m.student_id
having avg(m.mark) <= 7;

-- Hiển thị thông tin học viên có điểm trung bình các môn lớn nhất.

SELECT s.id, s.name,
       AVG(m.mark) AS 'Điểm trung bình'
FROM student s
JOIN mark m ON s.id = m.student_id
JOIN subjects sub ON m.subject_id = sub.id
GROUP BY s.id, s.name
HAVING AVG(m.mark) = (
    SELECT MAX(avg_mark)
    FROM (
        SELECT AVG(mark) AS avg_mark
        FROM mark
        GROUP BY student_id
    ) AS max_marks
);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select s.*, avg(mark) as diem_tb from student s
join mark m on m.student_id = s.id
group by m.student_id
order by avg(mark) desc;


