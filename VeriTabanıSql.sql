CREATE TABLE "Kullanici" (
	"kullaniciId" SERIAL,
	"ad" VARCHAR(80),
	"soyad" VARCHAR(80),
	"email" VARCHAR(80),
	"yetki" VARCHAR(80),
	"cinsiyet" VARCHAR(40),
	CONSTRAINT "KullaniciPK" PRIMARY key ("kullaniciId")
);


CREATE TABLE "Topluluk" (
	"toplulukId" SERIAL,
	"kullaniciId" INTEGER,
	"kisiSayisi" INTEGER,
	"bisikletTürü" VARCHAR(80),
	CONSTRAINT "ToplulukPK" PRIMARY key ("toplulukId"),
	CONSTRAINT "ToplulukFK" FOREIGN key ("kullaniciId") REFERENCES "Kullanici" ("kullaniciId")
);

CREATE TABLE "Yetkili" (
	"yetkiliId" SERIAL,
	"kullaniciId" INTEGER,
	"kullaniciAdi" VARCHAR(80),
	"kullaniciSifre" VARCHAR(80),
	"evTel" INTEGER,
	"isTel" INTEGER,
	"cepTel" INTEGER,
	"kullaniciAdres" VARCHAR(80),
	CONSTRAINT "YetkiliPK" PRIMARY key ("yetkiliId"),
	CONSTRAINT "YetkiliFK" FOREIGN key ("kullaniciId") REFERENCES "Kullanici" ("kullaniciId")
);

CREATE TABLE "Telefon" (
	"telefonId" SERIAL,
	"isTel" INTEGER,
	"cepTel" INTEGER,
	"evTel" INTEGER,
	CONSTRAINT "TelefonPK" PRIMARY key ("telefonId")
);

CREATE TABLE "Adres" (
	"adresId" SERIAL,
	"il" VARCHAR(80),
	"ilçe" VARCHAR(80),
	"mahalle" VARCHAR(80),
	"apartmanNo" INTEGER,
	CONSTRAINT "AdresPK" PRIMARY key ("adresId")
);

CREATE TABLE "Musteri" (
	"musteriId" SERIAL,
	"kullaniciId" INTEGER,
	"adresId" INTEGER,
	"telefonId" INTEGER,
	CONSTRAINT "MusteriPK" PRIMARY key ("musteriId"),
	CONSTRAINT "MusteriFK" FOREIGN key ("kullaniciId") REFERENCES "Kullanici" ("kullaniciId"),
	CONSTRAINT "MusteriFK2" FOREIGN key ("telefonId") REFERENCES "Telefon" ("telefonId"),
	CONSTRAINT "MusteriFK3" FOREIGN key ("adresId") REFERENCES "Adres" ("adresId")
);

ALTER TABLE "Yetkili"
	ADD CONSTRAINT "Yetkili" FOREIGN KEY ("yetkiliId")
	REFERENCES "Kullanici" ("kullaniciId")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
ALTER TABLE "Musteri"
	ADD CONSTRAINT "Musteri" FOREIGN KEY ("musteriId")
	REFERENCES "Kullanici" ("kullaniciId")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
CREATE TABLE "Bisiklet" (
	"urunId" SERIAL,
	"urunAdi" VARCHAR(80),
	"firmaId" INTEGER,
	"satisFiyati" INTEGER,
	"bisikletTürü" VARCHAR(40),
	CONSTRAINT "BisikletPK" PRIMARY key ("urunId")
);

CREATE TABLE "Firma" (
	"firmaId" SERIAL,
	"urunId" INTEGER,
	"firmaAdi" VARCHAR(80),
	"adres" VARCHAR(80),
	"tel" INTEGER,
	"satisFiyati" INTEGER,
	"fax" VARCHAR(40),
	"email" VARCHAR(40),
	CONSTRAINT "FirmaPK" PRIMARY key ("firmaId"),
	CONSTRAINT "FirmaFK" FOREIGN key ("urunId") REFERENCES "Bisiklet" ("urunId")
);

CREATE TABLE "Katagori" (
	"KatagoriId" SERIAL,
	"urunId" INTEGER,
	"dagBisikleti" VARCHAR(80),
	"sehitBisikleti" VARCHAR(80),
	"yarisBisikleti" VARCHAR(80),
	"cocukBisikleti" VARCHAR(80),
	CONSTRAINT "KatagoriPK" PRIMARY key ("KatagoriId"),
	CONSTRAINT "KatagoriFK" FOREIGN key ("urunId") REFERENCES "Bisiklet" ("urunId")
);

CREATE TABLE "Kiralik" (
	"kiralikId" SERIAL,
	"urunId" INTEGER,
	"urunAdi" VARCHAR(80),
	"kategori" VARCHAR(80),
	"kiraFiyati" INTEGER,
	CONSTRAINT "KiralikPK" PRIMARY key ("kiralikId"),
	CONSTRAINT "KiralikFK" FOREIGN key ("urunId") REFERENCES "Bisiklet" ("urunId")
);

CREATE TABLE "erkekBisiklet" (
	"erkekBisikletId" SERIAL,
	"urunId" INTEGER,
	"fiyat" INTEGER,
	"garantiSüresi" INTEGER,
	CONSTRAINT "erkekBisikletPK" PRIMARY key ("erkekBisikletId"),
	CONSTRAINT "erkekBisikletFK" FOREIGN key ("urunId") REFERENCES "Bisiklet" ("urunId")
);

CREATE TABLE "kadınBisiklet" (
	"kadınBisikletId" SERIAL,
	"urunId" INTEGER,
	"fiyat" INTEGER,
	"garantiSüresi" INTEGER,
	CONSTRAINT "kadınBisikletPK" PRIMARY key ("kadınBisikletId"),
	CONSTRAINT "kadınBisikletFK" FOREIGN key ("urunId") REFERENCES "Bisiklet" ("urunId")
);

ALTER TABLE "erkekBisiklet"
	ADD CONSTRAINT "erkekBisiklet" FOREIGN KEY ("erkekBisikletId")
	REFERENCES "Bisiklet" ("urunId")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
ALTER TABLE "kadınBisiklet"
	ADD CONSTRAINT "kadınBisiklet" FOREIGN KEY ("kadınBisikletId")
	REFERENCES "Bisiklet" ("urunId")
	ON DELETE CASCADE
	ON UPDATE CASCADE;
	
CREATE TABLE "SiparişDetay" (
	"siparisDetayId" SERIAL,
	"urunId" INTEGER,
	"urunAdedi" INTEGER,
	CONSTRAINT "SiparişDetayPK" PRIMARY key ("siparisDetayId"),
	CONSTRAINT "SiparişDetayFK" FOREIGN key ("urunId") REFERENCES "Bisiklet" ("urunId")
);

CREATE TABLE "Siparişler" (
	"siparisId" SERIAL,
	"siparisDetayId" INTEGER,
	"kullaniciId" INTEGER,
	"urunAdi" VARCHAR(80),
	"kategori" VARCHAR(80),
	"firmaId" INTEGER,
	"fiyati" INTEGER,
	"tarih" INTEGER,
	"bisikletTuru" VARCHAR(80),
	CONSTRAINT "SiparişlerPK" PRIMARY key ("siparisId"),
	CONSTRAINT "SiparişlerFK" FOREIGN key ("siparisDetayId") REFERENCES "SiparişDetay" ("siparisDetayId")
);

INSERT INTO "Kullanici" 
( "kullaniciId", "ad", "soyad", "email", "yetki","cinsiyet" )
VALUES
('0001','Mert', 'Akarsu', 'makarsu@gmail.com', 'Kullanici', 'Erkek');

INSERT INTO "Kullanici" 
( "kullaniciId", "ad", "soyad", "email", "yetki","cinsiyet" )
VALUES
('0002','Önder', 'Demircan', 'odemircan@gmail.com', 'Yönetici', 'Erkek');

INSERT INTO "Kullanici" 
( "kullaniciId", "ad", "soyad", "email", "yetki","cinsiyet" )
VALUES
('0003','Aynur', 'Gülsu', 'agulsu@gmail.com', 'Kullanici', 'Kadın');

INSERT INTO "Kullanici" 
( "kullaniciId", "ad", "soyad", "email", "yetki","cinsiyet" )
VALUES
('0004','Denizhan', 'Turan', 'dturan@gmail.com', 'Yönetici', 'Erkek');

INSERT INTO "Topluluk" 
( "toplulukId", "kullaniciId", "kisiSayisi", "bisikletTürü" )
VALUES
('001', '0001', '1', 'Dag bisikleti');

INSERT INTO "Topluluk" 
( "toplulukId", "kullaniciId", "kisiSayisi", "bisikletTürü" )
VALUES
('002', '0002', '1', 'Yarış bisikleti');

INSERT INTO "Topluluk" 
( "toplulukId", "kullaniciId", "kisiSayisi", "bisikletTürü" )
VALUES
('003', '0003', '1', 'Çocuk bisikleti');

INSERT INTO "Topluluk" 
( "toplulukId", "kullaniciId", "kisiSayisi", "bisikletTürü" )
VALUES
('004', '0004', '1', 'Dag bisikleti');

INSERT INTO "Bisiklet" 
( "urunId", "urunAdi", "firmaId", "satisFiyati", "bisikletTürü" )
VALUES
(001, 'Bisiklet', 1, 1500, 'Dag bisikleti');

INSERT INTO "Bisiklet" 
( "urunId", "urunAdi", "firmaId", "satisFiyati", "bisikletTürü" )
VALUES
(002, 'Bisiklet', 3, 5000, 'Çocuk bisikleti');

INSERT INTO "Bisiklet" 
( "urunId", "urunAdi", "firmaId", "satisFiyati", "bisikletTürü" )
VALUES
(003, 'Bisiklet', 2, 500, 'Yarış bisikleti');

INSERT INTO "Bisiklet" 
( "urunId", "urunAdi", "firmaId", "satisFiyati", "bisikletTürü" )
VALUES
(004, 'Bisiklet', 4, 1200, 'Şehir bisikleti');

INSERT INTO "Yetkili" 
("kullaniciId", "kullaniciAdi", "kullaniciSifre", "evTel", "isTel", "cepTel", "kullaniciAdres" )
VALUES
(1, 'onder', '159', 4123, 120023, 412312, 'harman mahallesi');


CREATE SEQUENCE yetkili_seq
  start 10
  increment 1;

create or replace function insert_yetkili(_kullaniciId Int, _kullaniciAdi character varying, _kullaniciSifre character varying, _evTel Int, _isTel Int, _cepTel Int, _kullaniciAdres character varying)
returns int as 
$$
begin
	insert into "Yetkili"("yetkiliId", "kullaniciId","kullaniciAdi","kullaniciSifre","evTel","isTel","cepTel","kullaniciAdres")
	values(nextval('yetkili_seq'),_kullaniciId,_kullaniciAdi,_kullaniciSifre,_evTel,_isTel,_cepTel,_kullaniciAdres);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$
language plpgsql;


create or replace function st_selectyetkili(_kadi character varying, _ksifre character varying)
returns table
(
    yetkiliId INT,
    kullaniciId INT,
    kullaniciAdi character varying,
    kullaniciSifre character varying,
    evTel INT,
    isTel INT,
    cepTel INT,
    kullaniciAdres character varying
)AS
$$
BEGIN
    RETURN query
    SELECT "yetkiliId", "kullaniciId", "kullaniciAdi", "kullaniciSifre", "evTel", "isTel", "cepTel", "kullaniciAdres" FROM "Yetkili" where "kullaniciAdi" = _kadi and "kullaniciSifre" = _ksifre order by "yetkiliId";
END
$$
language plpgsql


CREATE SEQUENCE kiralik_seq
  start 10
  increment 1;


create or replace function insert_kiralik(_urunId Int, _urunAdi character varying, _kategori character varying, _kiraFiyati Int) 
returns int as 
$$
begin
	insert into "Kiralik"("kiralikId", "urunId","urunAdi","kategori","kiraFiyati")
	values(nextval('kiralik_seq'),_urunId,_urunAdi,_kategori,_kiraFiyati);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$
language plpgsql;
select * from "Kiralik";
select * from insert_kiralik(1, 3, 'kron', 'Çocuk Bisikleti', 80);


create or replace function update_kiralik(k_kiralikId int, k_urunId int, k_urunAdi character varying, k_kategori character varying, k_kiraFiyati int) 
returns int as 
$$
begin
    UPDATE "Kiralik"
    set
        "urunId"=k_urunId,
        "urunAdi"=k_urunAdi,
        "kategori"=k_kategori,
        "kiraFiyati"=k_kiraFiyati
    where "kiralikId"=k_kiralikId;
	if found then
		return 1;
	else 
        return 0;
	end if;
end
$$
language plpgsql
select * from "Kiralik";



create or replace function st_selectKiralik()
returns table
(
    k_kiralikId INT,
    k_urunId INT,
    k_urunAdi character varying,
    k_kategori character varying,
    k_kiraFiyati INT
)AS
$$
BEGIN
    RETURN query
    SELECT "kiralikId", "urunId", "urunAdi", "kategori", "kiraFiyati" FROM "Kiralik" order by "kiralikId";
END
$$
language plpgsql
SELECT * FROM st_selectKiralik();


CREATE OR replace FUNCTION Kiralik_delete(k_kiralikId INT)
RETURNs int as
$$
BEGIN
    DELETE FROM "Kiralik"
    where "kiralikId"=k_kiralikId;
    if found then
        return 1;
    else
        return 0;
    end if;
end
$$
LANGUAGE plpgsql;
select * from "Kiralik";


CREATE SEQUENCE kullanici_seq
  start 15
  increment 1;
  
create or replace function insert_kullanici(_kullaniciId Int, _ad character varying, _soyad character varying, _email character varying, _yetki character varying, _cinsiyet character varying) 
returns int as 
$$
begin
	insert into "Kullanici"("kullaniciId", "ad","soyad","email","yetki","cinsiyet")
	values(nextval('kullanici_seq'),_ad,_soyad,_email,_yetki,_cinsiyet);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$
language plpgsql;
SELECT * FROM insert_kullanici('emir','demircan','edemircan@gmail.com','yönetici','erkek')
SELECT * FROM insert_kullanici;


create or replace function update_kullanici(k_kullaniciId int, k_ad character varying, k_soyad character varying, k_email character varying, k_yetki character varying, k_cinsiyet character varying) 
returns int as 
$$
begin
    UPDATE "Kullanici"
    set
        ad=k_ad,
        soyad=k_soyad,
        email=k_email,
        yetki=k_yetki,
        cinsiyet=k_cinsiyet
    where "kullaniciId"=k_kullaniciId;
	if found then
		return 1;
	else 
        return 0;
	end if;
end
$$
language plpgsql
select * from "Kullanici";


create or replace function st_select()
returns table
(
    k_kullaniciId INT,
    k_ad character varying,
    k_soyad character varying,
    k_email character varying,
    k_yetki character varying,
    k_cinsiyet character varying
)AS
$$
BEGIN
    RETURN query
    SELECT "kullaniciId", ad, soyad, email, yetki, cinsiyet FROM "Kullanici" order by "kullaniciId";
END
$$
language plpgsql
SELECT * FROM st_select();


CREATE OR replace FUNCTION Kullanici_delete(k_kullaniciId INT)
RETURNs int as
$$
BEGIN
    DELETE FROM "Kullanici"
    where "kullaniciId"=k_kullaniciId;
    if found then
        return 1;
    else
        return 0;
    end if;
end
$$
LANGUAGE plpgsql;
select * from "Kullanici";
select * from Kullanici_delete(10);


CREATE SEQUENCE bisiklet_seq
  start 15
  increment 1;

create or replace function insert_bisiklet(_urunAdi character varying, _firmaId INT, _satisFiyati INT, _bisikletTürü character varying) 
returns int as 
$$
begin
	insert into "Bisiklet"("urunId", "urunAdi","firmaId","satisFiyati","bisikletTürü")
	values(nextval('bisiklet_seq'),_urunAdi,_firmaId,_satisFiyati,_bisikletTürü);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$
language plpgsql;
select * from "Bisiklet";
select * from insert_bisiklet('MotorBisiklet', 6, 2000, 'Yaris Bisikleti');

create or replace function update_bisiklet(k_urunId int, k_urunAdi character varying, k_firmaId int, k_satisFiyati int, k_bisikletTürü character varying) 
returns int as 
$$
begin
    UPDATE "Bisiklet"
    set
        "urunAdi"=k_urunAdi,
        "firmaId"=k_firmaId,
        "satisFiyati"=k_satisFiyati,
        "bisikletTürü"=k_bisikletTürü
    where "urunId"=k_urunId;
	if found then
		return 1;
	else 
        return 0;
	end if;
end
$$
language plpgsql;
select * from update_bisiklet(15, 'Bisiklet', 21,4200, 'Dag Bisikleti');


create or replace function st_selectsiparis()
returns table
(
    k_urunId int,
    k_urunAdi character varying,
    k_firmaId int,
    k_satisFiyati int,
    k_bisikletTürü character varying
)AS
$$
BEGIN
    RETURN query
    SELECT "urunId", "urunAdi", "firmaId", "satisFiyati", "bisikletTürü" FROM "Bisiklet" order by "urunId";
END
$$
language plpgsql
SELECT * FROM st_selectsiparis();

CREATE OR replace FUNCTION Bisiklet_delete(k_urunId INT)
RETURNs int as
$$
BEGIN
    DELETE FROM "Bisiklet"
    where "urunId"=k_urunId;
    if found then
        return 1;
    else
        return 0;
    end if;
end
$$
LANGUAGE plpgsql;
select * from "Bisiklet";
select * from Bisiklet_delete(23);


CREATE SEQUENCE kullanici_log_seq
  start 1
  increment 1;

 
  CREATE TABLE "KullaniciLog" (
	"logID" bigint NOT NULL,
    "old_row_data" jsonb,
    "new_row_data" jsonb,
    "dml_type" varchar(255) NOT NULL,
    "dml_timestamp" timestamp NOT NULL,
    "dml_created_by" varchar(255) NOT NULL,
	CONSTRAINT "KullaniciLogPK" PRIMARY key ("logID")
);


CREATE OR REPLACE FUNCTION KullaniciLog_FUNC()
RETURNS trigger AS $body$
BEGIN
   if (TG_OP = 'INSERT') then
       INSERT INTO "KullaniciLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('kullanici_log_seq'),
           null,
           to_jsonb(NEW),
           'INSERT',
           CURRENT_TIMESTAMP,
           'USER'
       );
             
       RETURN NEW;
   elsif (TG_OP = 'UPDATE') then
       INSERT INTO "KullaniciLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('kullanici_log_seq'),
           to_jsonb(OLD),
           to_jsonb(NEW),
           'UPDATE',
           CURRENT_TIMESTAMP,
           'USER'
       );
             
       RETURN NEW;
   elsif (TG_OP = 'DELETE') then
       INSERT INTO "KullaniciLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('kullanici_log_seq'),
           to_jsonb(OLD),
           null,
           'DELETE',
           CURRENT_TIMESTAMP,
           'USER'
       );
        
       RETURN OLD;
   end if;
     
END;
$body$
LANGUAGE plpgsql


CREATE TRIGGER KullaniciLog_trigger
AFTER INSERT OR UPDATE OR DELETE ON "Kullanici"
FOR EACH ROW EXECUTE FUNCTION KullaniciLog_FUNC() 

select * from "KullaniciLog";


CREATE SEQUENCE bisiklet_log_seq
  start 1
  increment 1;

CREATE TABLE "BisikletLog" (
    "logID" bigint NOT NULL,
    "old_row_data" jsonb,
    "new_row_data" jsonb,
    "dml_type" varchar(255) NOT NULL,
    "dml_timestamp" timestamp NOT NULL,
    "dml_created_by" varchar(255) NOT NULL,
	CONSTRAINT "BisikletLogPK" PRIMARY key ("logID")
);


CREATE OR REPLACE FUNCTION BisikletLog_FUNC()
RETURNS trigger AS $body$
BEGIN
   if (TG_OP = 'INSERT') then
       INSERT INTO "BisikletLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('bisiklet_log_seq'),
           null,
           to_jsonb(NEW),
           'INSERT',
           CURRENT_TIMESTAMP,
           'USER'
       );
             
       RETURN NEW;
   elsif (TG_OP = 'UPDATE') then
       INSERT INTO "BisikletLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('bisiklet_log_seq'),
           to_jsonb(OLD),
           to_jsonb(NEW),
           'UPDATE',
           CURRENT_TIMESTAMP,
           'USER'
       );
             
       RETURN NEW;
   elsif (TG_OP = 'DELETE') then
       INSERT INTO "BisikletLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('bisiklet_log_seq'),
           to_jsonb(OLD),
           null,
           'DELETE',
           CURRENT_TIMESTAMP,
           'USER'
       );
        
       RETURN OLD;
   end if;
     
END;
$body$
LANGUAGE plpgsql


ON "Bisiklet";

CREATE TRIGGER BisikletLog_trigger
AFTER INSERT OR UPDATE OR DELETE ON "Bisiklet"
FOR EACH ROW EXECUTE FUNCTION BisikletLog_FUNC() 

select * from "BisikletLog";


CREATE SEQUENCE kiralik_log_seq
  start 1
  increment 1;

 
  CREATE TABLE "KiralikLog" (
	"logID" bigint NOT NULL,
    "old_row_data" jsonb,
    "new_row_data" jsonb,
    "dml_type" varchar(255) NOT NULL,
    "dml_timestamp" timestamp NOT NULL,
    "dml_created_by" varchar(255) NOT NULL,
	CONSTRAINT "KiralikLogPK" PRIMARY key ("logID")
);


CREATE OR REPLACE FUNCTION KiralikLog_FUNC()
RETURNS trigger AS $body$
BEGIN
   if (TG_OP = 'INSERT') then
       INSERT INTO "KiralikLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('kiralik_log_seq'),
           null,
           to_jsonb(NEW),
           'INSERT',
           CURRENT_TIMESTAMP,
           'USER'
       );
             
       RETURN NEW;
   elsif (TG_OP = 'UPDATE') then
       INSERT INTO "KiralikLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('kiralik_log_seq'),
           to_jsonb(OLD),
           to_jsonb(NEW),
           'UPDATE',
           CURRENT_TIMESTAMP,
           'USER'
       );
             
       RETURN NEW;
   elsif (TG_OP = 'DELETE') then
       INSERT INTO "KiralikLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('kiralik_log_seq'),
           to_jsonb(OLD),
           null,
           'DELETE',
           CURRENT_TIMESTAMP,
           'USER'
       );
        
       RETURN OLD;
   end if;
     
END;
$body$
LANGUAGE plpgsql


ON "Kiralik";

CREATE TRIGGER Kiralik_trigger
AFTER INSERT OR UPDATE OR DELETE ON "Kiralik"
FOR EACH ROW EXECUTE FUNCTION KiralikLog_FUNC() 

select * from "KiralikLog";