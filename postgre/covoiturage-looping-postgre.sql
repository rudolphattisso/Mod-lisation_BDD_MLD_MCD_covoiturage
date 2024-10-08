--drop table if exists "user",staff, formation ;
--DROP TYPE if exists role, work, status;

CREATE TABLE "user"(
   id SERIAL,
   last_name VARCHAR(50) ,
   first_name VARCHAR(50)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   number VARCHAR(50)  NOT NULL,
   activated_account BOOLEAN NOT NULL,
   photo BOOLEAN,
   email_choice BOOLEAN,
   sms_choice BOOLEAN,
   PRIMARY KEY(id)
);

create type role as enum('instructor','administration','external','other');
create type contract as enum('CDI','CDD','Autre');

CREATE TABLE staff(
   id SERIAL,
   "function" role NOT NULL,
   is_admin BOOLEAN,
   contract_type contract NOT NULL,
   start_date_contract DATE NOT NULL,
   end_date_contract VARCHAR(50)  NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(user_id),
   FOREIGN KEY(user_id) REFERENCES "user"(id)
);

CREATE TABLE formation(
   id SERIAL,
   formation_name VARCHAR(50)  NOT NULL,
   infos_formation VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE instructor(
   id SERIAL,
   staff_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(staff_id),
   FOREIGN KEY(staff_id) REFERENCES staff(id)
);

CREATE TABLE session(
   id SERIAL,
   start_date DATE NOT NULL,
   end_date DATE NOT NULL,
   id_1 INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(id_1) REFERENCES formation(id)
);

CREATE TABLE notification_model(
   id SERIAL,
   message VARCHAR(50) ,
   PRIMARY KEY(id)
);

CREATE TABLE fuel(
   id SERIAL,
   type VARCHAR(50) ,
   price MONEY,
   PRIMARY KEY(id)
);

CREATE TABLE general_conditions(
  id SERIAL,
   text VARCHAR(50) ,
   PRIMARY KEY(id)
);

CREATE TABLE car_type(
   id SERIAL,
   type VARCHAR(50) ,
   consumption_fuel NUMERIC(15,2)  ,
   PRIMARY KEY(id)
);

CREATE TABLE stagiaire(
   id SERIAL,
   session_id INTEGER NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(user_id),
   FOREIGN KEY(session_id) REFERENCES session(id),
   FOREIGN KEY(user_id) REFERENCES "user"(id)
);

CREATE TABLE car(
   id SERIAL,
   matricul_id VARCHAR(50) ,
   seat_quantity INTEGER NOT NULL,
   brand_car VARCHAR(50) ,
   id_car_type_id INTEGER NOT NULL,
   id_id_fuel_price INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(id_car_type_id) REFERENCES car_type(id),
   FOREIGN KEY(id_id_fuel_price) REFERENCES fuel(id)
);

CREATE TABLE notification(
   Id_notification SERIAL,
   text VARCHAR(250) ,
   id INTEGER NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(Id_notification),
   FOREIGN KEY(id) REFERENCES notification_model(id),
   FOREIGN KEY(user_id) REFERENCES "user"(id)
);

create type frequency as enum('freqeunt','punctual');

CREATE TABLE path(
   id SERIAL,
   departure_date TIMESTAMP,
   start_adresse VARCHAR(50)  NOT NULL,
   end_adress VARCHAR(50)  NOT NULL,
   price MONEY NOT NULL,
   path_frequency frequency,
   description VARCHAR(50) ,
   car_id INTEGER NOT NULL,
   user_id INTEGER NOT NULL,
   user_id_1 INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(car_id) REFERENCES car(id),
   FOREIGN KEY(user_id) REFERENCES "user"(id),
   FOREIGN KEY(user_id_1) REFERENCES "user"(id)
);

CREATE TABLE comment(
   id SERIAL,
   comments VARCHAR(250) ,
   user_id INTEGER NOT NULL,
   user_id_1 INTEGER NOT NULL,
   path_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(user_id) REFERENCES "user"(id),
   FOREIGN KEY(user_id_1) REFERENCES "user"(id),
   FOREIGN KEY(path_id) REFERENCES path(id)
);

CREATE TABLE instructor_session(
   instructor_id INTEGER,
   session_id INTEGER,
   is_referent boolean,
   PRIMARY KEY(instructor_id, session_id),
   FOREIGN KEY(instructor_id) REFERENCES instructor(id),
   FOREIGN KEY(session_id) REFERENCES session(id)
);

CREATE TABLE user_car(
   user_id INTEGER,
   car_id INTEGER,
   PRIMARY KEY(user_id, car_id),
   FOREIGN KEY(user_id) REFERENCES "user"(id),
   FOREIGN KEY(car_id) REFERENCES car(id)
);
