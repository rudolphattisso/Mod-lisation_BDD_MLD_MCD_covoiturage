--drop table if exists "user",staff, formation ;
--DROP TYPE if exists role, work, status;

CREATE TABLE "user"(
   id SERIAL,
   last_name VARCHAR(50) ,
   first_name VARCHAR(50)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   "number" VARCHAR(50)  NOT NULL,
   activated_account boolean not null default false NOT NULL,
   photo boolean not null default false,
   "message" boolean not null default false ,
   email_1 boolean not null default false,
   sms boolean not null default false,
   PRIMARY KEY(id)
);

create type role as enum('instructor','administration','external','other');
create type contract as enum('cdi','cdd','other');

CREATE TABLE staff(
   id SERIAL,
   "function" role NOT NULL,
   is_admin boolean not null default false,
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
   is_cdi boolean not null default false NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE instructor(
   id SERIAL,
   staff_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(staff_id),
   FOREIGN KEY(staff_id) REFERENCES staff(id)
);

create type frequency as enum('freqeunt','punctual');

CREATE TABLE path(
   id SERIAL,
   departure_date TIMESTAMP not null,
   start_adresse VARCHAR(50)  NOT NULL,
   end_adress VARCHAR(50)  NOT NULL,
   price MONEY NOT NULL,
   path_frequency frequency not null,
   "description" VARCHAR(50),
   user_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(user_id) REFERENCES "user"(id)
);

create type category as enum('compact','suv','4X4','MonoSpace','utilitary_car');
create type fuel as enum('essence','gazole','GPL','electric');

CREATE TABLE car(
   id SERIAL,
   matricul_id VARCHAR(50) not null ,
   car_category category not null ,
   seat_quantity INTEGER NOT NULL,
   brand_car VARCHAR(50) not Null,
   fuel_type fuel not null ,
   fuel_consumption INTEGER NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE session(
   id SERIAL,
   start_date DATE NOT NULL,
   end_date DATE NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE comment(
   id SERIAL,
   comments VARCHAR(250) not null ,
   user_id INTEGER NOT NULL,
   user_id_1 INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(user_id) REFERENCES "user"(id),
   FOREIGN KEY(user_id_1) REFERENCES "user"(id)
);

CREATE TABLE notification_model(
   id SERIAL,
   "message" VARCHAR(50) ,
   PRIMARY KEY(id)
);

CREATE TABLE fuel_price(
   id SERIAL,
   essence__price MONEY,
   gazole_price MONEY,
   GPL_price MONEY,
   electric_price VARCHAR(50) ,
   PRIMARY KEY(id)
);

CREATE TABLE general_conditions(
   id SERIAL,
   "text" text not null,
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

CREATE TABLE notification(
   Id_notification SERIAL,
   id INTEGER NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(Id_notification),
   FOREIGN KEY(id) REFERENCES notification_model(id),
   FOREIGN KEY(user_id) REFERENCES "user"(id)
);

CREATE TABLE instructor_session(
   instructor_id INTEGER,
   session_id INTEGER,
   is_referent boolean NOT NULL default false,
   PRIMARY KEY(instructor_id, session_id),
   FOREIGN KEY(instructor_id) REFERENCES instructor(id),
   FOREIGN KEY(session_id) REFERENCES session(id)
);

CREATE TABLE user_path(
   user_id INTEGER,
   path_id INTEGER,
   PRIMARY KEY(user_id, path_id),
   FOREIGN KEY(user_id) REFERENCES "user"(id),
   FOREIGN KEY(path_id) REFERENCES path(id)
);

CREATE TABLE user_car(
   user_id INTEGER,
   car_id INTEGER,
   PRIMARY KEY(user_id, car_id),
   FOREIGN KEY(user_id) REFERENCES "user"(id),
   FOREIGN KEY(car_id) REFERENCES car(id)
);

CREATE TABLE car_path(
   path_id INTEGER,
   car_id INTEGER,
   PRIMARY KEY(path_id, car_id),
   FOREIGN KEY(path_id) REFERENCES path(id),
   FOREIGN KEY(car_id) REFERENCES car(id)
 );
 
CREATE TABLE session_formation(
   id INTEGER,
   id_1 INTEGER,
   PRIMARY KEY(id, id_1),
   FOREIGN KEY(id) REFERENCES formation(id),
   FOREIGN KEY(id_1) REFERENCES session(id)
);

CREATE TABLE notification_path(
   path_id INTEGER,
   notification_id INTEGER,
   PRIMARY KEY(path_id, notification_id),
   FOREIGN KEY(path_id) REFERENCES path(id),
   FOREIGN KEY(notification_id) REFERENCES comment(id)
);

CREATE TABLE car_fuel_type(
   id_1_1 INTEGER,
   id_id_fuel_price INTEGER,
   PRIMARY KEY(id_1_1, id_id_fuel_price),
   FOREIGN KEY(id_1_1) REFERENCES car(id),
   FOREIGN KEY(id_id_fuel_price) REFERENCES fuel_price(id)
);


