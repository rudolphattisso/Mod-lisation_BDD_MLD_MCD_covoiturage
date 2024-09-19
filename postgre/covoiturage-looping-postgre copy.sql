CREATE TABLE "user"_(
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

CREATE type role as enum( )
CREATE TABLE staff(
   id SERIAL,
   "function" role NOT NULL,
   is_admin boolean not null default false,
   contract_type type NOT NULL,
   start_date_contract DATE NOT NULL,
   end_date_contract VARCHAR(50)  NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(user_id),
   FOREIGN KEY(user_id) REFERENCES "user"_(id)
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

CREATE TABLE path(
   id SERIAL,
   departure_date TIMESTAMPZ,
   start_adresse VARCHAR(50)  NOT NULL,
   end_adress VARCHAR(50)  NOT NULL,
   price MONEY NOT NULL,
   path_frequency frequency,
   "description" VARCHAR(50) ,
   id"user"_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(id"user"_id) REFERENCES "user"_(id)
);

CREATE TABLE car(
   id SERIAL,
   matricul_id VARCHAR(50) ,
   car_category category,
   seat_quantity INTEGER NOT NULL,
   brand_car VARCHAR(50) ,
   fuel_type enum,
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
   comments VARCHAR(250) ,
   user_id INTEGER NOT NULL,
   user_id_1 INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(user_id) REFERENCES "user"_(id),
   FOREIGN KEY(user_id_1) REFERENCES "user"_(id)
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
   Id_general_conditions SERIAL,
   PRIMARY KEY(Id_general_conditions)
);

CREATE TABLE stagiaire(
   id SERIAL,
   session_id INTEGER NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(user_id),
   FOREIGN KEY(session_id) REFERENCES session(id),
   FOREIGN KEY(user_id) REFERENCES "user"_(id)
);

CREATE TABLE notification(
   Id_notification SERIAL,
   id INTEGER NOT NULL,
   user_id INTEGER NOT NULL,
   PRIMARY KEY(Id_notification),
   FOREIGN KEY(id) REFERENCES notification_model(id),
   FOREIGN KEY(user_id) REFERENCES "user"_(id)
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
   id"user"_id INTEGER,
   id_path_id INTEGER,
   PRIMARY KEY(id"user"_id, id_path_id),
   FOREIGN KEY(id"user"_id) REFERENCES "user"_(id),
   FOREIGN KEY(id_path_id) REFERENCES path(id)
);

CREATE TABLE user_car(
   id"user"_id INTEGER,
   car_id INTEGER,
   PRIMARY KEY(id"user"_id, car_id),
   FOREIGN KEY(id"user"_id) REFERENCES "user"_(id),
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
