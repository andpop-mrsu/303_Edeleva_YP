.open vehicle_inspection.db

DROP TABLE IF EXISTS service_name;
DROP TABLE IF EXISTS service;
DROP TABLE IF EXISTS service_master;
DROP TABLE IF EXISTS master;
DROP TABLE IF EXISTS work_reports;
DROP TABLE IF EXISTS person_schedules;

PRAGMA foreign_keys=ON;
	
CREATE TABLE service_name (
  id INTEGER PRIMARY KEY,
  name CHAR
);

CREATE TABLE service (
  id INTEGER PRIMARY KEY,
  id_service_name INTEGER,
  lasting INTEGER,
  price INTEGER,
  work_type CHAR,
  FOREIGN KEY (id_service_name) REFERENCES service_name (id),
  CHECK (work_type = 'М' OR work_type = 'Ж' OR work_type = 'М/Ж')

);
		
CREATE TABLE service_master (
  id INTEGER PRIMARY KEY,
  id_service INTEGER,
  id_master INTEGER,
  FOREIGN KEY (id_master) REFERENCES master (id),
  FOREIGN KEY(id_service)  REFERENCES service(id)
);
		
CREATE TABLE master (
  id INTEGER PRIMARY KEY,
  name CHAR,
  last_name CHAR,
  patronymic CHAR,
  percent FLOAT,
  id_person_schedules INTEGER,
  is_working_now CHAR DEFAULT 'True',
  gender CHAR,

  FOREIGN KEY (id_person_schedules) REFERENCES person_schedules (id)

  CHECK (is_working_now = 'True' OR is_working_now = 'False'),
  CHECK (gender = 'М' OR gender = 'Ж'),
  CHECK (percent >= 0 AND percent <= 100)
);
		
CREATE TABLE work_reports (
  id INTEGER PRIMARY KEY,
  date DATE,
  time TIME,
  id_service_master INTEGER,
  FOREIGN KEY (id_service_master) REFERENCES service_master (id)
);
		
		
CREATE TABLE person_schedules (
  id INTEGER PRIMARY KEY,
  mon_start TIME NULL DEFAULT '9:00',
  mon_end TIME NULL DEFAULT '17:00',
  tue_start TIME NULL DEFAULT '9:00',
  tue_end TIME NULL DEFAULT '17:00',
  wed_start TIME NULL DEFAULT '9:00',
  wed_end TIME NULL DEFAULT '17:00',
  thu_start TIME NULL DEFAULT '9:00',
  thu_end TIME NULL DEFAULT '17:00',
  fri_start TIME NULL DEFAULT '9:00',
  fri_end TIME NULL DEFAULT '17:00',
  sat_start TIME NULL DEFAULT '9:00',
  sat_end TIME NULL DEFAULT '17:00',
  sun_start TIME NULL DEFAULT '9:00',
  sun_end TIME NULL DEFAULT '17:00'
);







INSERT INTO service_name (id, name) VALUES
(0, 'Окрашиание средняя длина'),
(1, 'Мелирование средняя длина'),
(2, 'Омбре средняя длина'),
(3, 'Стрижка каре'),
(4, 'Стрижка каскад'),
(5, 'Стрижка боб'),
(6, 'Стрижка пикси'),
(7, 'Стрижка полубокс'),
(8, 'Стрижка бокс'),
(9, 'Андекарт'),
(10, 'Оформление бороды и усов');


 INSERT INTO person_schedules (id,mon_start,mon_end,tue_start,tue_end,wed_start,wed_end,thu_start,thu_end,fri_start,fri_end,sat_start,sat_end,sun_start,sun_end) VALUES
 (0,'9:00','17:00','9:00','17:00','9:00','17:00','9:00','17:00','9:00','17:00','10:00','14:00','NULL','NULL'),
(1,'NULL','NULL','9:00','16:00','11:00','16:00','9:00','16:00','10:00','17:00','14:00','16:00','NULL','NULL'),
(2,'15:00','22:00','15:00','22:00','15:00','22:00','15:00','22:00','15:00','22:00','NULL','NULL','NULL','NULL'),
(3,'16:00','22:00','9:00','16:00','16:00','22:00','9:00','16:00','16:00','22:00','NULL','NULL','NULL','NULL'),
(4,'12:00','21:00','NULL','NULL','12:00','21:00','NULL','NULL','12:00','21:00','NULL','NULL','NULL','NULL'),
(5,'NULL','NULL','13:00','21:00','NULL','NULL','NULL','NULL','13:00','21:00','NULL','NULL','12:00','14:00'),
(6,'8:00','12:00','8:00','12:00','8:00','12:00','8:00','12:00','8:00','12:00','NULL','NULL','NULL','NULL'),
(7,'8:00','17:00','8:00','17:00','8:00','17:00','8:00','17:00','8:00','17:00','NULL','NULL','NULL','NULL'),
(8,'9:00','12:00','10:00','13:30','9:30','12:00','11:00','15:00','10:00','12:50','NULL','NULL','NULL','NULL'),
(9,'10:00','16:00','11:00','16:00','14:00','16:30','14:00','17:00','14:00','17:00','10:00','14:00','NULL','NULL'),
(10,'12:00','15:00','9:00','11:30','9:30','13:00','12:00','17:00','11:00','17:00','NULL','NULL','NULL','NULL');








 INSERT INTO master (id,name,last_name,patronymic, gender, percent, id_person_schedules, is_working_now) VALUES
(0, 'Барсуков', 'Лев', 'Филиппович', 'М', 1, 0,'True'),
(1,'Виноградова', 'София', 'Владимировна','Ж',  3, 3, 'True'),
(2,'Беляев','Николай',  'Никитич','М', 4, 5, 'False'),
(3,'Белова', 'Анастасия', 'Демидовна', 'Ж', 11,10,'True'),
(4,'Макеев', 'Егор', 'Русланович','М', 11,7,'True'),
(5,'Давыдова', 'Виктория', 'Михайловна', 'Ж', 19,5,'True'),
(6,'Кузин', 'Алексадр', 'Михайлович', 'М', 30,6,'True'),
(7,'Софронова', 'Алена', 'Андреевна','Ж', 1,2,'False'),
(8,'Яковлев', 'Максим', 'Матвеевич', 'М', 14,4,'False'),
(9,'Пахомов', 'Вячеслав', 'Матвеевич', 'М', 21,9,'True'),
(10,'Ульянов', 'Алексей', 'Андреевич','М', 15, 8,'True'),
(11,'Софронова', 'Мария', 'Матвеевна','Ж', 10,4,'False');





 INSERT INTO service(id,id_service_name,lasting,price,work_type) VALUES
(0, 1, 120 , 2000, 'М/Ж' ),
(1, 2, 180 , 2500, 'М/Ж' ),
(2, 5, 60 , 2700, 'Ж' ),
(3, 3, 30 , 800, 'Ж' ),
(4, 6, 40 , 900, 'Ж' ),
(5, 10, 35 , 400, 'М' ),
(6, 9, 40 , 1000, 'М' ),
(7, 4, 30 , 1000, 'Ж' ),
(8, 5, 30 , 600, 'М/Ж' ),
(9, 7, 35 , 500, 'М' ),
(10, 8, 25 , 700, 'М' );





 INSERT INTO service_master (id, id_service,id_master) VALUES
(0, 2, 3),
(1, 4, 4),
(2, 6, 3),
(3, 1, 4),
(4, 3, 5),
(5, 10, 6),
(6, 3, 7),
(7, 9, 8),
(8, 8, 9),
(9, 7, 10),
(10, 5, 1);





 INSERT INTO work_reports (id,date,time,id_service_master) VALUES
 (0,'2021-03-21','9:00', 0),
(1,'2021-03-25','10:30', 1),
(2,'2021-04-03','11:00', 2),
(3,'2021-04-15','11:30', 3),
(4,'2021-04-27','9:00', 4),
(5,'2021-04-30','11:00', 5),
(6,'2021-05-04','10:00', 6),
(7,'2021-05-05','14:40', 7),
(8,'2021-05-14','15:00', 8),
(9,'2021-04-08','12:00', 9),
(10,'2021-05-14','11:00', 10);




