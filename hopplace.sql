SHOW DATABASES;

USE hopplace;


SHOW TABLES;

CREATE TABLE users(
	id int primary key auto_increment,
    username varchar(50) not null
);

ALTER TABLE users CHANGE username email varchar(50);
ALTER TABLE users ADD COLUMN customerID VARCHAR(50) AFTER email;
ALTER TABLE users ADD CONSTRAINT UNIQUE (customerID);
DESC users;
SELECT * FROM users;


UPDATE users SET socialMediaToken=121 WHERE ID=2;
SHOW TABLES;
INSERT INTO users(username) values 
("ali"),
("test"),
("new");

SELECT * FROM users;
CREATE TABLE listings(
	id int primary key auto_increment,
    user_id int,
    category varchar(50) not null,
    subCategory varchar(50) not null,
    typeOfResidency varchar(50) not null,
    
    address varchar(100) not null,
    latitude float not null,
    longitude float not null,
    
    guestAllowed int not null,
    noBedroom int not null,
    noBed int not null,
    noBath int not null,
    -- amenity
    pool bool not null,
    hotTub bool not null,
    patio bool not null,
    bbqGrill bool not null,
    firePit bool not null,
    poolTable bool not null,
    indoorFireplace bool not null,
    outDoorDiningArea bool not null,
    excerciseEquipment bool not null,
    -- guest favourites
    wifi bool not null,
    tv bool not null,
    kitchen bool not null,
    washingMacine bool not null,
    freeParking bool not null,
    paidParking bool not null,
    acUnit bool not null,
    workspace bool not null,
    outdoorShower bool not null,
    -- saftey items
    smokeAlarm bool not null,
    firstAid bool not null,
    carbonMonoxideAlarm bool not null,
    fireExtinguisher bool not null,
    -- highlights
    highlight1 varchar(50),
    highlight2 varchar(50),
    -- security question
    securityCamera bool not null,
    weapons bool not null,
    dangerousAnimal bool not null,
    
    description text not null,
    pricing int not null,
    active bool not null,
    
    foreign key(user_id) references users(id) on delete cascade
);
DESC users;
CREATE TABLE bookedlistings(
	id int primary key auto_increment,
    listing_id int,
    bookerID int,
    multiple_days bool not null,
    start_day date not null unique,
    end_day date,
    foreign key(listing_id) REFERENCES listings(id),
    foreign key(bookerID) REFERENCES users(id)
);

SELECT * FROM bookedlistings;
SELECT CURDATE();
insert into bookedlistings (listing_id,bookerID,multiple_days,start_day,end_day) values(2,2,false,"2021-11-22","2021-11-24");
drop table booked_listings;
CREATE TABLE images(
	user_id int not null,
    img_url varchar(255),
    foreign key(user_id) references users(id) on delete cascade
);
DROP TABLE images;
SELECT * FROM images;
INSERT into images(user_id,img_url) values(2,"ausdkjasndaksdnasjkdnjkasdakjsdsa");
-- drop table listings;
INSERT INTO listings 
(user_id,category,subCategory,typeOfResidency,address,latitude,longitude,noBedroom,noBed,noBath,guestAllowed,
pool,hotTub,patio,bbqGrill,firePit,poolTable,indoorFireplace,outDoorDiningArea,excerciseEquipment,
wifi,tv,kitchen,washingMacine,freeParking,paidParking,acUnit,workspace,outdoorShower,
smokeAlarm,firstAid,carbonMonoxideAlarm,fireExtinguisher,
highlight1,highlight2,
securityCamera,weapons,dangerousAnimal,
description,pricing,active)
values
(2,"pool","villa","shared","test address",31.57,74.31,2,4,5,6,
true,false,true,true,false,false,false,false,true,
false,false,false,false,true,true,true,false,false,
true,true,true,true,
"test highight 1","test highlight 2",
true,true,true,
"very good house",25,true
);

describe listings;

SELECT * FROM listings;
SELECT * FROM listings WHERE user_id = 2;
DELETE FROM listings where id>12 AND id<17;



SELECT
  *, (
    3959 * acos (
      cos ( radians(31.54972) )
      * cos( radians( latitude ) )
      * cos( radians( longitude ) - radians(74.34361) )
      + sin ( radians(31.54972) )
      * sin( radians( latitude ) )
    )
  ) AS distance
FROM listings
HAVING distance < 100 AND active=true AND category="house" AND subCategory="villa"
ORDER BY distance;


-- price, amanites can be edited only;