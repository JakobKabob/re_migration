CREATE TABLE visitor (
  _id             char(255) NOT NULL, 
  latest_activity timestamp, 
  origin          char(255), 
  order_count     int4, 
  PRIMARY KEY (_id));
CREATE TABLE "session" (
  _id           char(255) NOT NULL, 
  session_start timestamp, 
  session_end   timestamp, 
  has_sale      bool, 
  buid          char(255), 
  PRIMARY KEY (_id));
CREATE TABLE product (
  _id                  char(255) NOT NULL, 
  brand                char(255), 
  category             char(255), 
  deeplink             char(255) NOT NULL, 
  description          char(255), 
  gender               char(255), 
  herhaalaankopen      bool, 
  name                 char(255) NOT NULL, 
  recommendable        bool, 
  sub_category         char(255), 
  sub_sub_category     char(255), 
  sub_sub_sub_category char(255), 
  image_url            char(255), 
  PRIMARY KEY (_id));
CREATE TABLE price (
  product_id    char(255) NOT NULL, 
  discount      int4, 
  mrsp          int4 NOT NULL, 
  selling_price int4 NOT NULL, 
  PRIMARY KEY (product_id));
CREATE TABLE properties (
  products_id         char(255) NOT NULL, 
  availability        int4, 
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
  mid                 int8, 
  serie               char(32), 
  soort               char(32), 
  soorthaarverzorging char(32), 
  soortmondverzorging char(32), 
  sterkte             char(32), 
  stock               int8, 
  type                char(32), 
  typehaarkleuring    char(32), 
  typetandenborstel   char(32), 
  variant             char(32), 
  waterproof          bool, 
  weekdeal            bool, 
  PRIMARY KEY (products_id));
CREATE TABLE bought_product (
  session_id char(255) NOT NULL, 
  product_id char(255) NOT NULL, 
  _id        int4 NOT NULL, 
  PRIMARY KEY (session_id, 
  product_id, 
  _id));
CREATE TABLE buid (
  visitor_id char(255) NOT NULL, 
  buid       char(255) NOT NULL, 
  PRIMARY KEY (buid));
CREATE TABLE previously_recommended (
  product_id char(255), 
  visitor_id char(255) NOT NULL);
ALTER TABLE price ADD CONSTRAINT FKprice565483 FOREIGN KEY (product_id) REFERENCES product (_id);
ALTER TABLE properties ADD CONSTRAINT FKproperties819154 FOREIGN KEY (products_id) REFERENCES product (_id);
ALTER TABLE bought_product ADD CONSTRAINT FKbought_pro143486 FOREIGN KEY (session_id) REFERENCES "session" (_id);
ALTER TABLE buid ADD CONSTRAINT FKbuid710512 FOREIGN KEY (visitor_id) REFERENCES visitor (_id);
ALTER TABLE "session" ADD CONSTRAINT FKsession95722 FOREIGN KEY (buid) REFERENCES buid (buid);
ALTER TABLE bought_product ADD CONSTRAINT FKbought_pro165373 FOREIGN KEY (product_id) REFERENCES product (_id);
ALTER TABLE previously_recommended ADD CONSTRAINT FKpreviously550564 FOREIGN KEY (visitor_id) REFERENCES visitor (_id);
