ALTER TABLE images DROP CONSTRAINT FKimages333331;
ALTER TABLE stock DROP CONSTRAINT FKstock355840;
ALTER TABLE price DROP CONSTRAINT FKprice519920;
ALTER TABLE properties DROP CONSTRAINT FKproperties531217;
ALTER TABLE sm DROP CONSTRAINT FKsm588886;
DROP TABLE IF EXISTS visitors CASCADE;
DROP TABLE IF EXISTS sessions CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS price CASCADE;
DROP TABLE IF EXISTS images CASCADE;
DROP TABLE IF EXISTS properties CASCADE;
DROP TABLE IF EXISTS sm CASCADE;
DROP TABLE IF EXISTS stock CASCADE;