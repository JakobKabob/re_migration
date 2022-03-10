CREATE TABLE visitors (
  );
CREATE TABLE sessions (
  );
CREATE TABLE products (
  _id                       char(255) NOT NULL, 
  brand                     char(255), 
  category                  char(255), 
  color                     char(255), 
  deeplink                  char(255) NOT NULL, 
  description               char(255), 
  fast_mover                bool, 
  flavor                    char(255), 
  gender                    char(255), 
  herhaalaankopen           bool, 
  name                      char(255) NOT NULL, 
  predict_out_of_stock_date char(255), 
  recommendable             bool NOT NULL, 
  "size"                    char(32), 
  sub_category              char(32), 
  sub_sub_category          char(32), 
  sub_sub_sub_category      char(32), 
  PRIMARY KEY (_id));
CREATE TABLE price (
  products_id   char(255) NOT NULL, 
  discount      int4, 
  mrsp          int4 NOT NULL, 
  selling_price int4 NOT NULL);
CREATE TABLE images (
  products_id char(255) NOT NULL, 
  "Index"     SERIAL NOT NULL, 
  url         char(255), 
  PRIMARY KEY ("Index"));
CREATE TABLE properties (
  products_id         char(255) NOT NULL, 
  availability        int4 NOT NULL, 
  bundel_sku          int8, 
  discount            char(32), 
  doelgroep           char(32), 
  eenheid             int4, 
  factor              int8, 
  folder_actief       char(32), 
  gebruik             char(32), 
  geschiktvoor        char(32), 
  geursoort           char(32), 
  huidconditie        char(32), 
  huidtype            char(32), 
  huidtypegezicht     char(32), 
  inhoud              char(32), 
  klacht              char(64), 
  kleur               char(32), 
  leeftijd            int4, 
  mid                 int8 NOT NULL, 
  online_only         bool, 
  serie               char(32), 
  soort               char(32), 
  soorthaarverzorging char(32), 
  soortmondverzorging char(32), 
  sterkte             char(32), 
  stock               int8 NOT NULL, 
  tax                 char(32) NOT NULL, 
  type                char(32), 
  typehaarkleuring    char(32), 
  typetandenborstel   char(32), 
  variant             char(32), 
  waterproof          bool, 
  weekdeal            bool, 
  weekdeal_from       timestamp, 
  weekdeal_to         timestamp);
CREATE TABLE sm (
  products_id  char(255) NOT NULL, 
  is_active    bool NOT NULL, 
  last_updated timestamp NOT NULL, 
  type         char(32));
CREATE TABLE stock (
  products_id char(255) NOT NULL, 
  "date"      timestamp NOT NULL, 
  stock_level int8 NOT NULL, 
  PRIMARY KEY (products_id));
ALTER TABLE images ADD CONSTRAINT FKimages333331 FOREIGN KEY (products_id) REFERENCES products (_id);
ALTER TABLE stock ADD CONSTRAINT FKstock355840 FOREIGN KEY (products_id) REFERENCES products (_id);
ALTER TABLE price ADD CONSTRAINT FKprice519920 FOREIGN KEY (products_id) REFERENCES products (_id);
ALTER TABLE properties ADD CONSTRAINT FKproperties531217 FOREIGN KEY (products_id) REFERENCES products (_id);
ALTER TABLE sm ADD CONSTRAINT FKsm588886 FOREIGN KEY (products_id) REFERENCES products (_id);
