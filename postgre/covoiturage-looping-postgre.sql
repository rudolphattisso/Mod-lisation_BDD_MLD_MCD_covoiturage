drop table if exists "user",staff, formation ;
DROP TYPE if exists role, work, status;

CREATE TABLE "user"(
   id serial,
   last_name VARCHAR(50) not NULL,
   first_name VARCHAR(50) NOT NULL,
   email VARCHAR(50) NOT NULL,
   number VARCHAR(50) NOT NULL,
   activated_account BOOLEAN not NULL default false ,
   photo VARCHAR(250) ,
   PRIMARY KEY(id)
);

CREATE TYPE role AS ENUM ('instructor','administration','external','other');
CREATE TYPE work AS ENUM ('cdi','cdd','other');

CREATE TABLE staff(
   id INT,
   "function" role NOT NULL,
   is_admin boolean NOT NULL DEFAULT false,
   contract_type work NOT NULL,
   start_date_contract DATE NOT NULL,
   end_date_contract VARCHAR(50) NOT NULL,
   user_id INT NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(user_id),
   FOREIGN KEY(user_id) REFERENCES "user"(id)
);

CREATE TYPE status AS ENUM ('distancel','presentiel','hybrid');
CREATE TABLE formation(
   id serial,
   formation_name VARCHAR(50) NOT NULL,
   infos_formation VARCHAR(50) NOT NULL,
   is_cdi boolean NOT null default false,
   contract_type status NOT NULL,
   PRIMARY KEY(id)
);

---
CREATE TYPE frequency AS ENUM ('punctual','regular');
CREATE TABLE path(
   id SERIAL,
   departure_date TIMESTAMP,
   start_adresse VARCHAR(50)  NOT NULL,
   end_adress VARCHAR(50)  NOT NULL,
   price MONEY NOT NULL,
   path_frequency frequency,
   description VARCHAR(50) ,
   id_user_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(id_user_id) REFERENCES "user"(id)
);
CREATE TYPE category AS ENUM ('compact','suv','4X4','MonoSpace','utilitary_car');
create type fuel as enum('essence','gazole','GPL','electric','hybrid');

CREATE TABLE car(
   id SERIAL,
   matricul_id VARCHAR(50) ,
   car_category category,
   seat_quantity INTEGER NOT NULL,
   brand_car VARCHAR(50) ,
   fuel_type fuel NOT NULL,
   fuel_consumption INTEGER NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE session(
   id SERIAL,
   start_date DATE NOT NULL,
   end_date DATE NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE notification(
   id serial,
   comments varchar(250) not null,
   PRIMARY KEY(id)
);

CREATE TABLE stagiaire(
   id SERIAL,
   session_id INTEGER NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(user_id),
   FOREIGN KEY(session_id) REFERENCES session(id),
   FOREIGN KEY(user_id) REFERENCES _user_(id)
);

CREATE TABLE dispens(
   instructor_id INTEGER,
   session_id INTEGER,
   PRIMARY KEY(instructor_id, session_id),
   FOREIGN KEY(instructor_id) REFERENCES instructor(id),
   FOREIGN KEY(session_id) REFERENCES session(id)
);

CREATE TABLE booking(
   id_user_id INTEGER,
   id_path_id INTEGER,
   PRIMARY KEY(id_user_id, id_path_id),
   FOREIGN KEY(id_user_id) REFERENCES _user_(id),
   FOREIGN KEY(id_path_id) REFERENCES path(id)
);

CREATE TABLE has(
   id_user_id INTEGER,
   car_id INTEGER,
   PRIMARY KEY(id_user_id, car_id),
   FOREIGN KEY(id_user_id) REFERENCES _user_(id),
   FOREIGN KEY(car_id) REFERENCES car(id)
);

CREATE TABLE makes(
   path_id INTEGER,
   car_id INTEGER,
   PRIMARY KEY(path_id, car_id),
   FOREIGN KEY(path_id) REFERENCES path(id),
   FOREIGN KEY(car_id) REFERENCES car(id)
);

CREATE TABLE belongs_to(
   id INTEGER,
   id_1 INTEGER,
   PRIMARY KEY(id, id_1),
   FOREIGN KEY(id) REFERENCES formation(id),
   FOREIGN KEY(id_1) REFERENCES session(id)
);

CREATE TABLE is_send(
   path_id INTEGER,
   notification_id INTEGER,
   PRIMARY KEY(path_id, notification_id),
   FOREIGN KEY(path_id) REFERENCES path(id),
   FOREIGN KEY(notification_id) REFERENCES notification(id)
);

CREATE TABLE receives(
   user_id INTEGER,
   id_notification_id INTEGER,
   PRIMARY KEY(user_id, id_notification_id),
   FOREIGN KEY(user_id) REFERENCES _user_(id),
   FOREIGN KEY(id_notification_id) REFERENCES notification(id)
);

CREATE TABLE send(
   user_id INTEGER,
   notification_id INTEGER,
   PRIMARY KEY(user_id, notification_id),
   FOREIGN KEY(user_id) REFERENCES _user_(id),
   FOREIGN KEY(notification_id) REFERENCES notification(id)
);

