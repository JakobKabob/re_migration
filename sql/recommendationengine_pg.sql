--ALTER TABLE price DROP CONSTRAINT FKprice519920;
DROP TABLE IF EXISTS visitors CASCADE;
DROP TABLE IF EXISTS sessssions CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS price CASCADE;
CREATE TABLE visitors (
  "Column" int4);
CREATE TABLE sessssions (
  );
CREATE TABLE products (
  _id                       SERIAL NOT NULL, 
  brand                     char(255), 
  category                  char(255), 
  color                     char(255), 
  deepling                  char(255), 
  description               char(255), 
  fast_mover                bool, 
  flavor                    char(255), 
  gender                    char(255), 
  herhaalaankopen           bool, 
  image                     char(255), 
  name                      char(255), 
  predict_out_of_stock_date char(255), 
  PRIMARY KEY (_id));
CREATE TABLE price (
  products_id   int4 NOT NULL, 
  discount      int4, 
  mrsp          int4 NOT NULL, 
  selling_price int4);
ALTER TABLE price ADD CONSTRAINT FKprice519920 FOREIGN KEY (products_id) REFERENCES products (_id);
