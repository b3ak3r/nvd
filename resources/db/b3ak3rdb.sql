\connect b3ak3r-nvd

DROP SEQUENCE IF EXISTS vendor_seq CASCADE;
DROP SEQUENCE IF EXISTS cve_seq CASCADE;
DROP SEQUENCE IF EXISTS product_seq CASCADE;

DROP TABLE IF EXISTS vendor CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS cve CASCADE;
DROP TABLE IF EXISTS product_to_cve CASCADE;

CREATE SEQUENCE vendor_seq START 101;
CREATE SEQUENCE cve_seq START 101;
CREATE SEQUENCE product_seq START 101;

CREATE TABLE IF NOT EXISTS vendor (
  id      integer PRIMARY KEY DEFAULT nextval('vendor_seq'),
  name    text not null,
  ticker  varchar(3)
);

CREATE TABLE IF NOT EXISTS product (
  id      integer PRIMARY KEY DEFAULT nextval('cve_seq'),
  name    text not null,
  vendor  integer NOT NULL references vendor(id)
);

CREATE TABLE IF NOT EXISTS cve (
  id      integer PRIMARY KEY DEFAULT nextval('product_seq'),
  cve     text NOT NULL
);

CREATE TABLE IF NOT EXISTS product_to_cve(
  product_id    integer NOT NULL references product(id),
  cve_id        integer NOT NULL references cve(id)
);
