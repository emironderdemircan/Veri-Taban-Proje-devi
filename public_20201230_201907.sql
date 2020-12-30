--
-- PostgreSQL database dump
--

-- Dumped from database version 11.10
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: bisiklet; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE bisiklet WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Turkish_Turkey.1252';


ALTER DATABASE bisiklet OWNER TO postgres;

\connect bisiklet

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: bisiklet_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bisiklet_delete(k_urunid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Bisiklet"
    where "urunId"=k_urunId;
    if found then
        return 1;
    else
        return 0;
    end if;
end
$$;


ALTER FUNCTION public.bisiklet_delete(k_urunid integer) OWNER TO postgres;

--
-- Name: bisikletlog_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.bisikletlog_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.bisikletlog_func() OWNER TO postgres;

--
-- Name: insert_bisiklet(character varying, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_bisiklet(_urunadi character varying, _firmaid integer, _satisfiyati integer, "_bisiklettürü" character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	insert into "Bisiklet"("urunId", "urunAdi","firmaId","satisFiyati","bisikletTürü")
	values(nextval('bisiklet_seq'),_urunAdi,_firmaId,_satisFiyati,_bisikletTürü);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$;


ALTER FUNCTION public.insert_bisiklet(_urunadi character varying, _firmaid integer, _satisfiyati integer, "_bisiklettürü" character varying) OWNER TO postgres;

--
-- Name: insert_bisiklet(integer, character varying, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_bisiklet(_urunid integer, _urunadi character varying, _firmaid integer, _satisfiyati integer, "_bisiklettürü" character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	insert into "Bisiklet"("urunId", "urunAdi","firmaId","satisFiyati","bisikletTürü")
	values(nextval('bisiklet_seq'),_urunAdi,_firmaId,_satisFiyati,_bisikletTürü);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$;


ALTER FUNCTION public.insert_bisiklet(_urunid integer, _urunadi character varying, _firmaid integer, _satisfiyati integer, "_bisiklettürü" character varying) OWNER TO postgres;

--
-- Name: insert_kiralik(integer, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_kiralik(_urunid integer, _urunadi character varying, _kategori character varying, _kirafiyati integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	insert into "Kiralik"("kiralikId", "urunId","urunAdi","kategori","kiraFiyati")
	values(nextval('kiralik_seq'),_urunId,_urunAdi,_kategori,_kiraFiyati);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$;


ALTER FUNCTION public.insert_kiralik(_urunid integer, _urunadi character varying, _kategori character varying, _kirafiyati integer) OWNER TO postgres;

--
-- Name: insert_kiralik(integer, integer, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_kiralik(_kiralikid integer, _urunid integer, _urunadi character varying, _kategori character varying, _kirafiyati integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	insert into "Kiralik"("kiralikId", "urunId","urunAdi","kategori","kiraFiyati")
	values(nextval('kiralik_seq'),_urunId,_urunAdi,_kategori,_kiraFiyati);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$;


ALTER FUNCTION public.insert_kiralik(_kiralikid integer, _urunid integer, _urunadi character varying, _kategori character varying, _kirafiyati integer) OWNER TO postgres;

--
-- Name: insert_kullanici(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_kullanici(_ad character varying, _soyad character varying, _email character varying, _yetki character varying, _cinsiyet character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	insert into "Kullanici"("kullaniciId", "ad","soyad","email","yetki","cinsiyet")
	values(nextval('kullanici_seq'),_ad,_soyad,_email,_yetki,_cinsiyet);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$;


ALTER FUNCTION public.insert_kullanici(_ad character varying, _soyad character varying, _email character varying, _yetki character varying, _cinsiyet character varying) OWNER TO postgres;

--
-- Name: insert_kullanici(integer, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_kullanici(_kullaniciid integer, _ad character varying, _soyad character varying, _email character varying, _yetki character varying, _cinsiyet character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	insert into "Kullanici"("kullaniciId", "ad","soyad","email","yetki","cinsiyet")
	values(nextval('kullanici_seq'),_ad,_soyad,_email,_yetki,_cinsiyet);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$;


ALTER FUNCTION public.insert_kullanici(_kullaniciid integer, _ad character varying, _soyad character varying, _email character varying, _yetki character varying, _cinsiyet character varying) OWNER TO postgres;

--
-- Name: insert_kullanici(bigint, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_kullanici(_kullaniciid bigint, _ad character varying, _soyad character varying, _email character varying, _yetki character varying, _cinsiyet character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	insert into "Kullanici"("kullaniciId", "ad","soyad","email","yetki","cinsiyet")
	values(_kullaniciId,_ad,_soyad,_email,_yetki,_cinsiyet);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$;


ALTER FUNCTION public.insert_kullanici(_kullaniciid bigint, _ad character varying, _soyad character varying, _email character varying, _yetki character varying, _cinsiyet character varying) OWNER TO postgres;

--
-- Name: insert_yetkili(integer, character varying, character varying, integer, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_yetkili(_kullaniciid integer, _kullaniciadi character varying, _kullanicisifre character varying, _evtel integer, _istel integer, _ceptel integer, _kullaniciadres character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	insert into "Yetkili"("yetkiliId", "kullaniciId","kullaniciAdi","kullaniciSifre","evTel","isTel","cepTel","kullaniciAdres")
	values(nextval('yetkili_seq'),_kullaniciId,_kullaniciAdi,_kullaniciSifre,_evTel,_isTel,_cepTel,_kullaniciAdres);
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$;


ALTER FUNCTION public.insert_yetkili(_kullaniciid integer, _kullaniciadi character varying, _kullanicisifre character varying, _evtel integer, _istel integer, _ceptel integer, _kullaniciadres character varying) OWNER TO postgres;

--
-- Name: kiralik_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kiralik_delete(k_kiralikid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Kiralik"
    where "kiralikId"=k_kiralikId;
    if found then
        return 1;
    else
        return 0;
    end if;
end
$$;


ALTER FUNCTION public.kiralik_delete(k_kiralikid integer) OWNER TO postgres;

--
-- Name: kiraliklog_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kiraliklog_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.kiraliklog_func() OWNER TO postgres;

--
-- Name: kullanici_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullanici_delete(k_kullaniciid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM "Kullanici"
    where "kullaniciId"=k_kullaniciId;
    if found then
        return 1;
    else
        return 0;
    end if;
end
$$;


ALTER FUNCTION public.kullanici_delete(k_kullaniciid integer) OWNER TO postgres;

--
-- Name: kullanicilog_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullanicilog_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.kullanicilog_func() OWNER TO postgres;

--
-- Name: st_select(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.st_select() RETURNS TABLE(k_kullaniciid integer, k_ad character varying, k_soyad character varying, k_email character varying, k_yetki character varying, k_cinsiyet character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN query
    SELECT "kullaniciId", ad, soyad, email, yetki, cinsiyet FROM "Kullanici" order by "kullaniciId";
END
$$;


ALTER FUNCTION public.st_select() OWNER TO postgres;

--
-- Name: st_selectkiralik(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.st_selectkiralik() RETURNS TABLE(k_kiralikid integer, k_urunid integer, k_urunadi character varying, k_kategori character varying, k_kirafiyati integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN query
    SELECT "kiralikId", "urunId", "urunAdi", "kategori", "kiraFiyati" FROM "Kiralik" order by "kiralikId";
END
$$;


ALTER FUNCTION public.st_selectkiralik() OWNER TO postgres;

--
-- Name: st_selectsiparis(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.st_selectsiparis() RETURNS TABLE(k_urunid integer, k_urunadi character varying, k_firmaid integer, k_satisfiyati integer, "k_bisiklettürü" character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN query
    SELECT "urunId", "urunAdi", "firmaId", "satisFiyati", "bisikletTürü" FROM "Bisiklet" order by "urunId";
END
$$;


ALTER FUNCTION public.st_selectsiparis() OWNER TO postgres;

--
-- Name: st_selectyetkili(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.st_selectyetkili(_kadi character varying, _ksifre character varying) RETURNS TABLE(yetkiliid integer, kullaniciid integer, kullaniciadi character varying, kullanicisifre character varying, evtel integer, istel integer, ceptel integer, kullaniciadres character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN query
    SELECT "yetkiliId", "kullaniciId", "kullaniciAdi", "kullaniciSifre", "evTel", "isTel", "cepTel", "kullaniciAdres" FROM "Yetkili" where "kullaniciAdi" = _kadi and "kullaniciSifre" = _ksifre order by "yetkiliId";
END
$$;


ALTER FUNCTION public.st_selectyetkili(_kadi character varying, _ksifre character varying) OWNER TO postgres;

--
-- Name: topluluklog_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.topluluklog_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   if (TG_OP = 'INSERT') then
       INSERT INTO "ToplulukLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('topluluk_log_seq'),
           null,
           to_jsonb(NEW),
           'INSERT',
           CURRENT_TIMESTAMP,
           'USER'
       );
             
       RETURN NEW;
   elsif (TG_OP = 'UPDATE') then
       INSERT INTO "ToplulukLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('topluluk_log_seq'),
           to_jsonb(OLD),
           to_jsonb(NEW),
           'UPDATE',
           CURRENT_TIMESTAMP,
           'USER'
       );
             
       RETURN NEW;
   elsif (TG_OP = 'DELETE') then
       INSERT INTO "ToplulukLog" (
           "logID",
           "old_row_data",
           "new_row_data",
           "dml_type",
           "dml_timestamp",
           "dml_created_by"
       )
       VALUES(
           nextval('topluluk_log_seq'),
           to_jsonb(OLD),
           null,
           'DELETE',
           CURRENT_TIMESTAMP,
           'USER'
       );
        
       RETURN OLD;
   end if;
     
END;
$$;


ALTER FUNCTION public.topluluklog_func() OWNER TO postgres;

--
-- Name: update_bisiklet(integer, character varying, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_bisiklet(k_urunid integer, k_urunadi character varying, k_firmaid integer, k_satisfiyati integer, "k_bisiklettürü" character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.update_bisiklet(k_urunid integer, k_urunadi character varying, k_firmaid integer, k_satisfiyati integer, "k_bisiklettürü" character varying) OWNER TO postgres;

--
-- Name: update_kiralik(integer, integer, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_kiralik(k_kiralikid integer, k_urunid integer, k_urunadi character varying, k_kategori character varying, k_kirafiyati integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.update_kiralik(k_kiralikid integer, k_urunid integer, k_urunadi character varying, k_kategori character varying, k_kirafiyati integer) OWNER TO postgres;

--
-- Name: update_kullanici(integer, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_kullanici(k_kullaniciid integer, k_ad character varying, k_soyad character varying, k_email character varying, k_yetki character varying, k_cinsiyet character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.update_kullanici(k_kullaniciid integer, k_ad character varying, k_soyad character varying, k_email character varying, k_yetki character varying, k_cinsiyet character varying) OWNER TO postgres;

--
-- Name: uzman_kullanici(integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.uzman_kullanici(_kullaniciid integer, _kullaniciadi character varying, _sifre character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	insert into "Uzman"("kullaniciId","kullaniciAdi","sifre")
	values(nextval('kullanici_seq'),"kullaniciAdi","sifre");
	if found then -- insert succes
		return 1;
	else return 0;
	end if;
end;
$$;


ALTER FUNCTION public.uzman_kullanici(_kullaniciid integer, _kullaniciadi character varying, _sifre character varying) OWNER TO postgres;

--
-- Name: yetkilist_select(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yetkilist_select() RETURNS TABLE(_kullaniciid integer, _kullaniciadi character varying, _sifre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN query
    SELECT "kullaniciId", _kullaniciAdi, _sifre FROM "Uzman" order by "kullaniciId";
END
$$;


ALTER FUNCTION public.yetkilist_select() OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: Adres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Adres" (
    "adresId" integer NOT NULL,
    il character varying(80),
    "ilçe" character varying(80),
    mahalle character varying(80),
    "apartmanNo" integer
);


ALTER TABLE public."Adres" OWNER TO postgres;

--
-- Name: Adres_adresId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Adres_adresId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Adres_adresId_seq" OWNER TO postgres;

--
-- Name: Adres_adresId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Adres_adresId_seq" OWNED BY public."Adres"."adresId";


--
-- Name: Bisiklet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bisiklet" (
    "urunId" integer NOT NULL,
    "urunAdi" character varying(80),
    "firmaId" integer,
    "satisFiyati" integer,
    "bisikletTürü" character varying(40)
);


ALTER TABLE public."Bisiklet" OWNER TO postgres;

--
-- Name: BisikletLog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BisikletLog" (
    "logID" bigint NOT NULL,
    old_row_data jsonb,
    new_row_data jsonb,
    dml_type character varying(255) NOT NULL,
    dml_timestamp timestamp without time zone NOT NULL,
    dml_created_by character varying(255) NOT NULL
);


ALTER TABLE public."BisikletLog" OWNER TO postgres;

--
-- Name: Bisiklet_urunId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bisiklet_urunId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bisiklet_urunId_seq" OWNER TO postgres;

--
-- Name: Bisiklet_urunId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bisiklet_urunId_seq" OWNED BY public."Bisiklet"."urunId";


--
-- Name: Firma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Firma" (
    "firmaId" integer NOT NULL,
    "urunId" integer,
    "firmaAdi" character varying(80),
    adres character varying(80),
    tel integer,
    "satisFiyati" integer,
    fax character varying(40),
    email character varying(40)
);


ALTER TABLE public."Firma" OWNER TO postgres;

--
-- Name: Firma_firmaId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Firma_firmaId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Firma_firmaId_seq" OWNER TO postgres;

--
-- Name: Firma_firmaId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Firma_firmaId_seq" OWNED BY public."Firma"."firmaId";


--
-- Name: Katagori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Katagori" (
    "KatagoriId" integer NOT NULL,
    "urunId" integer,
    "dagBisikleti" character varying(80),
    "sehitBisikleti" character varying(80),
    "yarisBisikleti" character varying(80),
    "cocukBisikleti" character varying(80)
);


ALTER TABLE public."Katagori" OWNER TO postgres;

--
-- Name: Katagori_KatagoriId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Katagori_KatagoriId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Katagori_KatagoriId_seq" OWNER TO postgres;

--
-- Name: Katagori_KatagoriId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Katagori_KatagoriId_seq" OWNED BY public."Katagori"."KatagoriId";


--
-- Name: Kiralik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kiralik" (
    "kiralikId" integer NOT NULL,
    "urunId" integer,
    "urunAdi" character varying(80),
    kategori character varying(80),
    "kiraFiyati" integer
);


ALTER TABLE public."Kiralik" OWNER TO postgres;

--
-- Name: KiralikLog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KiralikLog" (
    "logID" bigint NOT NULL,
    old_row_data jsonb,
    new_row_data jsonb,
    dml_type character varying(255) NOT NULL,
    dml_timestamp timestamp without time zone NOT NULL,
    dml_created_by character varying(255) NOT NULL
);


ALTER TABLE public."KiralikLog" OWNER TO postgres;

--
-- Name: Kiralik_kiralikId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kiralik_kiralikId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kiralik_kiralikId_seq" OWNER TO postgres;

--
-- Name: Kiralik_kiralikId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kiralik_kiralikId_seq" OWNED BY public."Kiralik"."kiralikId";


--
-- Name: Kullanici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kullanici" (
    "kullaniciId" integer NOT NULL,
    ad character varying(80),
    soyad character varying(80),
    email character varying(80),
    yetki character varying(80),
    cinsiyet character varying(40)
);


ALTER TABLE public."Kullanici" OWNER TO postgres;

--
-- Name: KullaniciLog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KullaniciLog" (
    "logID" bigint NOT NULL,
    old_row_data jsonb,
    new_row_data jsonb,
    dml_type character varying(255) NOT NULL,
    dml_timestamp timestamp without time zone NOT NULL,
    dml_created_by character varying(255) NOT NULL
);


ALTER TABLE public."KullaniciLog" OWNER TO postgres;

--
-- Name: Kullanici_kullaniciId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kullanici_kullaniciId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kullanici_kullaniciId_seq" OWNER TO postgres;

--
-- Name: Kullanici_kullaniciId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kullanici_kullaniciId_seq" OWNED BY public."Kullanici"."kullaniciId";


--
-- Name: Musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Musteri" (
    "musteriId" integer NOT NULL,
    "kullaniciId" integer,
    "adresId" integer,
    "telefonId" integer
);


ALTER TABLE public."Musteri" OWNER TO postgres;

--
-- Name: Musteri_musteriId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Musteri_musteriId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Musteri_musteriId_seq" OWNER TO postgres;

--
-- Name: Musteri_musteriId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Musteri_musteriId_seq" OWNED BY public."Musteri"."musteriId";


--
-- Name: SiparişDetay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SiparişDetay" (
    "siparisDetayId" integer NOT NULL,
    "urunId" integer,
    "urunAdedi" integer
);


ALTER TABLE public."SiparişDetay" OWNER TO postgres;

--
-- Name: SiparişDetay_siparisDetayId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."SiparişDetay_siparisDetayId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SiparişDetay_siparisDetayId_seq" OWNER TO postgres;

--
-- Name: SiparişDetay_siparisDetayId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."SiparişDetay_siparisDetayId_seq" OWNED BY public."SiparişDetay"."siparisDetayId";


--
-- Name: Siparişler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Siparişler" (
    "siparisId" integer NOT NULL,
    "siparisDetayId" integer,
    "kullaniciId" integer,
    "urunAdi" character varying(80),
    kategori character varying(80),
    "firmaId" integer,
    fiyati integer,
    tarih integer,
    "bisikletTuru" character varying(80)
);


ALTER TABLE public."Siparişler" OWNER TO postgres;

--
-- Name: Siparişler_siparisId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Siparişler_siparisId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Siparişler_siparisId_seq" OWNER TO postgres;

--
-- Name: Siparişler_siparisId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Siparişler_siparisId_seq" OWNED BY public."Siparişler"."siparisId";


--
-- Name: Telefon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Telefon" (
    "telefonId" integer NOT NULL,
    "isTel" integer,
    "cepTel" integer,
    "evTel" integer
);


ALTER TABLE public."Telefon" OWNER TO postgres;

--
-- Name: Telefon_telefonId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Telefon_telefonId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Telefon_telefonId_seq" OWNER TO postgres;

--
-- Name: Telefon_telefonId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Telefon_telefonId_seq" OWNED BY public."Telefon"."telefonId";


--
-- Name: Topluluk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Topluluk" (
    "toplulukId" integer NOT NULL,
    "kullaniciId" integer,
    "kisiSayisi" integer,
    "bisikletTürü" character varying(80)
);


ALTER TABLE public."Topluluk" OWNER TO postgres;

--
-- Name: Topluluk_toplulukId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Topluluk_toplulukId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Topluluk_toplulukId_seq" OWNER TO postgres;

--
-- Name: Topluluk_toplulukId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Topluluk_toplulukId_seq" OWNED BY public."Topluluk"."toplulukId";


--
-- Name: Yetkili; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yetkili" (
    "yetkiliId" integer NOT NULL,
    "kullaniciId" integer,
    "kullaniciAdi" character varying(80),
    "kullaniciSifre" character varying(80),
    "evTel" integer,
    "isTel" integer,
    "cepTel" integer,
    "kullaniciAdres" character varying(80)
);


ALTER TABLE public."Yetkili" OWNER TO postgres;

--
-- Name: Yetkili_yetkiliId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Yetkili_yetkiliId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Yetkili_yetkiliId_seq" OWNER TO postgres;

--
-- Name: Yetkili_yetkiliId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Yetkili_yetkiliId_seq" OWNED BY public."Yetkili"."yetkiliId";


--
-- Name: bisiklet_log_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bisiklet_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bisiklet_log_seq OWNER TO postgres;

--
-- Name: bisiklet_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bisiklet_seq
    START WITH 15
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bisiklet_seq OWNER TO postgres;

--
-- Name: erkekBisiklet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."erkekBisiklet" (
    "erkekBisikletId" integer NOT NULL,
    "urunId" integer,
    fiyat integer,
    "garantiSüresi" integer
);


ALTER TABLE public."erkekBisiklet" OWNER TO postgres;

--
-- Name: erkekBisiklet_erkekBisikletId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."erkekBisiklet_erkekBisikletId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."erkekBisiklet_erkekBisikletId_seq" OWNER TO postgres;

--
-- Name: erkekBisiklet_erkekBisikletId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."erkekBisiklet_erkekBisikletId_seq" OWNED BY public."erkekBisiklet"."erkekBisikletId";


--
-- Name: kadınBisiklet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."kadınBisiklet" (
    "kadınBisikletId" integer NOT NULL,
    "urunId" integer,
    fiyat integer,
    "garantiSüresi" integer
);


ALTER TABLE public."kadınBisiklet" OWNER TO postgres;

--
-- Name: kadınBisiklet_kadınBisikletId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."kadınBisiklet_kadınBisikletId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."kadınBisiklet_kadınBisikletId_seq" OWNER TO postgres;

--
-- Name: kadınBisiklet_kadınBisikletId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."kadınBisiklet_kadınBisikletId_seq" OWNED BY public."kadınBisiklet"."kadınBisikletId";


--
-- Name: kiralik_log_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kiralik_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kiralik_log_seq OWNER TO postgres;

--
-- Name: kiralik_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kiralik_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kiralik_seq OWNER TO postgres;

--
-- Name: kullanici_log_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kullanici_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kullanici_log_seq OWNER TO postgres;

--
-- Name: kullanici_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kullanici_seq
    START WITH 15
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kullanici_seq OWNER TO postgres;

--
-- Name: topluluk_log_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topluluk_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topluluk_log_seq OWNER TO postgres;

--
-- Name: uzman_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uzman_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uzman_seq OWNER TO postgres;

--
-- Name: yetkili_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.yetkili_seq
    START WITH 15
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.yetkili_seq OWNER TO postgres;

--
-- Name: Adres adresId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Adres" ALTER COLUMN "adresId" SET DEFAULT nextval('public."Adres_adresId_seq"'::regclass);


--
-- Name: Bisiklet urunId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bisiklet" ALTER COLUMN "urunId" SET DEFAULT nextval('public."Bisiklet_urunId_seq"'::regclass);


--
-- Name: Firma firmaId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Firma" ALTER COLUMN "firmaId" SET DEFAULT nextval('public."Firma_firmaId_seq"'::regclass);


--
-- Name: Katagori KatagoriId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Katagori" ALTER COLUMN "KatagoriId" SET DEFAULT nextval('public."Katagori_KatagoriId_seq"'::regclass);


--
-- Name: Kiralik kiralikId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kiralik" ALTER COLUMN "kiralikId" SET DEFAULT nextval('public."Kiralik_kiralikId_seq"'::regclass);


--
-- Name: Kullanici kullaniciId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kullanici" ALTER COLUMN "kullaniciId" SET DEFAULT nextval('public."Kullanici_kullaniciId_seq"'::regclass);


--
-- Name: Musteri musteriId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri" ALTER COLUMN "musteriId" SET DEFAULT nextval('public."Musteri_musteriId_seq"'::regclass);


--
-- Name: SiparişDetay siparisDetayId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SiparişDetay" ALTER COLUMN "siparisDetayId" SET DEFAULT nextval('public."SiparişDetay_siparisDetayId_seq"'::regclass);


--
-- Name: Siparişler siparisId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Siparişler" ALTER COLUMN "siparisId" SET DEFAULT nextval('public."Siparişler_siparisId_seq"'::regclass);


--
-- Name: Telefon telefonId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Telefon" ALTER COLUMN "telefonId" SET DEFAULT nextval('public."Telefon_telefonId_seq"'::regclass);


--
-- Name: Topluluk toplulukId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Topluluk" ALTER COLUMN "toplulukId" SET DEFAULT nextval('public."Topluluk_toplulukId_seq"'::regclass);


--
-- Name: Yetkili yetkiliId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yetkili" ALTER COLUMN "yetkiliId" SET DEFAULT nextval('public."Yetkili_yetkiliId_seq"'::regclass);


--
-- Name: erkekBisiklet erkekBisikletId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."erkekBisiklet" ALTER COLUMN "erkekBisikletId" SET DEFAULT nextval('public."erkekBisiklet_erkekBisikletId_seq"'::regclass);


--
-- Name: kadınBisiklet kadınBisikletId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kadınBisiklet" ALTER COLUMN "kadınBisikletId" SET DEFAULT nextval('public."kadınBisiklet_kadınBisikletId_seq"'::regclass);


--
-- Data for Name: Adres; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Bisiklet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Bisiklet" ("urunId", "urunAdi", "firmaId", "satisFiyati", "bisikletTürü") VALUES
	(1, 'Bisiklet', 1, 1500, 'Dag bisikleti'),
	(2, 'Bisiklet', 3, 5000, 'Çocuk bisikleti'),
	(3, 'Bisiklet', 2, 500, 'Yarış bisikleti'),
	(4, 'Bisiklet', 4, 1200, 'Şehir bisikleti');


--
-- Data for Name: BisikletLog; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Firma; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Katagori; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Kiralik; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kiralik" ("kiralikId", "urunId", "urunAdi", kategori, "kiraFiyati") VALUES
	(31, 3, 'kron', 'Çocuk Bisikleti', 80),
	(32, 1, 'asd', 'asd', 123);


--
-- Data for Name: KiralikLog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KiralikLog" ("logID", old_row_data, new_row_data, dml_type, dml_timestamp, dml_created_by) VALUES
	(1, NULL, '{"urunId": 3, "urunAdi": "kron", "kategori": "Çocuk Bisikleti", "kiralikId": 30, "kiraFiyati": 80}', 'INSERT', '2020-12-30 20:09:37.332986', 'USER'),
	(2, '{"urunId": 3, "urunAdi": "kron", "kategori": "Çocuk Bisikleti", "kiralikId": 30, "kiraFiyati": 80}', '{"urunId": 3, "urunAdi": "kronz", "kategori": "Çocuk Bisikleti", "kiralikId": 30, "kiraFiyati": 80}', 'UPDATE', '2020-12-30 20:10:09.76989', 'USER'),
	(3, '{"urunId": 3, "urunAdi": "kronz", "kategori": "Çocuk Bisikleti", "kiralikId": 30, "kiraFiyati": 80}', '{"urunId": 3, "urunAdi": "kron", "kategori": "Çocuk Bisikleti", "kiralikId": 30, "kiraFiyati": 80}', 'UPDATE', '2020-12-30 20:10:17.30718', 'USER'),
	(4, '{"urunId": 3, "urunAdi": "kron", "kategori": "Çocuk Bisikleti", "kiralikId": 30, "kiraFiyati": 80}', NULL, 'DELETE', '2020-12-30 20:10:23.114994', 'USER'),
	(5, NULL, '{"urunId": 3, "urunAdi": "kron", "kategori": "Çocuk Bisikleti", "kiralikId": 31, "kiraFiyati": 80}', 'INSERT', '2020-12-30 20:10:30.421892', 'USER'),
	(6, NULL, '{"urunId": 1, "urunAdi": "asd", "kategori": "asd", "kiralikId": 32, "kiraFiyati": 123}', 'INSERT', '2020-12-30 20:17:46.316716', 'USER');


--
-- Data for Name: Kullanici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kullanici" ("kullaniciId", ad, soyad, email, yetki, cinsiyet) VALUES
	(1, 'Mert', 'Akarsu', 'makarsu@gmail.com', 'Kullanici', 'Erkek'),
	(2, 'Önder', 'Demircan', 'odemircan@gmail.com', 'Yönetici', 'Erkek'),
	(3, 'Aynur', 'Gülsu', 'agulsu@gmail.com', 'Kullanici', 'Kadın'),
	(4, 'Denizhan', 'Turan', 'dturan@gmail.com', 'Yönetici', 'Erkek'),
	(33, 'Emir', 'Demircan', 'edemircan@gmail.com', 'Yönetici', 'Erkek');


--
-- Data for Name: KullaniciLog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KullaniciLog" ("logID", old_row_data, new_row_data, dml_type, dml_timestamp, dml_created_by) VALUES
	(24, NULL, '{"ad": "Emir", "email": "cerkezler78@gmail.com", "soyad": "Demircan", "yetki": "Yönetici", "cinsiyet": "Erkek", "kullaniciId": 33}', 'INSERT', '2020-12-30 19:59:52.346132', 'USER'),
	(25, '{"ad": "Emir", "email": "cerkezler78@gmail.com", "soyad": "Demircan", "yetki": "Yönetici", "cinsiyet": "Erkek", "kullaniciId": 33}', '{"ad": "Emir", "email": "edemircan@gmail.com", "soyad": "Demircan", "yetki": "Yönetici", "cinsiyet": "Erkek", "kullaniciId": 33}', 'UPDATE', '2020-12-30 20:00:05.793987', 'USER');


--
-- Data for Name: Musteri; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: SiparişDetay; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Siparişler; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Telefon; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Topluluk; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Topluluk" ("toplulukId", "kullaniciId", "kisiSayisi", "bisikletTürü") VALUES
	(1, 1, 1, 'Dag bisikleti'),
	(2, 2, 1, 'Yarış bisikleti'),
	(3, 3, 1, 'Çocuk bisikleti'),
	(4, 4, 1, 'Dag bisikleti');


--
-- Data for Name: Yetkili; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Yetkili" ("yetkiliId", "kullaniciId", "kullaniciAdi", "kullaniciSifre", "evTel", "isTel", "cepTel", "kullaniciAdres") VALUES
	(1, 1, 'onder', '159', 4123, 120023, 412312, 'harman mahallesi');


--
-- Data for Name: erkekBisiklet; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: kadınBisiklet; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: Adres_adresId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Adres_adresId_seq"', 1, false);


--
-- Name: Bisiklet_urunId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bisiklet_urunId_seq"', 1, false);


--
-- Name: Firma_firmaId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Firma_firmaId_seq"', 1, false);


--
-- Name: Katagori_KatagoriId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Katagori_KatagoriId_seq"', 1, false);


--
-- Name: Kiralik_kiralikId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kiralik_kiralikId_seq"', 1, false);


--
-- Name: Kullanici_kullaniciId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kullanici_kullaniciId_seq"', 1, false);


--
-- Name: Musteri_musteriId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Musteri_musteriId_seq"', 1, false);


--
-- Name: SiparişDetay_siparisDetayId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."SiparişDetay_siparisDetayId_seq"', 1, false);


--
-- Name: Siparişler_siparisId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Siparişler_siparisId_seq"', 1, false);


--
-- Name: Telefon_telefonId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Telefon_telefonId_seq"', 1, false);


--
-- Name: Topluluk_toplulukId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Topluluk_toplulukId_seq"', 1, false);


--
-- Name: Yetkili_yetkiliId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Yetkili_yetkiliId_seq"', 1, true);


--
-- Name: bisiklet_log_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bisiklet_log_seq', 13, true);


--
-- Name: bisiklet_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bisiklet_seq', 27, true);


--
-- Name: erkekBisiklet_erkekBisikletId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."erkekBisiklet_erkekBisikletId_seq"', 1, false);


--
-- Name: kadınBisiklet_kadınBisikletId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."kadınBisiklet_kadınBisikletId_seq"', 1, false);


--
-- Name: kiralik_log_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kiralik_log_seq', 6, true);


--
-- Name: kiralik_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kiralik_seq', 32, true);


--
-- Name: kullanici_log_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kullanici_log_seq', 25, true);


--
-- Name: kullanici_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kullanici_seq', 33, true);


--
-- Name: topluluk_log_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topluluk_log_seq', 1, false);


--
-- Name: uzman_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uzman_seq', 1, false);


--
-- Name: yetkili_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yetkili_seq', 47, true);


--
-- Name: Adres AdresPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Adres"
    ADD CONSTRAINT "AdresPK" PRIMARY KEY ("adresId");


--
-- Name: BisikletLog BisikletLogPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BisikletLog"
    ADD CONSTRAINT "BisikletLogPK" PRIMARY KEY ("logID");


--
-- Name: Bisiklet BisikletPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bisiklet"
    ADD CONSTRAINT "BisikletPK" PRIMARY KEY ("urunId");


--
-- Name: Firma FirmaPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Firma"
    ADD CONSTRAINT "FirmaPK" PRIMARY KEY ("firmaId");


--
-- Name: Katagori KatagoriPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Katagori"
    ADD CONSTRAINT "KatagoriPK" PRIMARY KEY ("KatagoriId");


--
-- Name: KiralikLog KiralikLogPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KiralikLog"
    ADD CONSTRAINT "KiralikLogPK" PRIMARY KEY ("logID");


--
-- Name: Kiralik KiralikPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kiralik"
    ADD CONSTRAINT "KiralikPK" PRIMARY KEY ("kiralikId");


--
-- Name: KullaniciLog KullaniciLogPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KullaniciLog"
    ADD CONSTRAINT "KullaniciLogPK" PRIMARY KEY ("logID");


--
-- Name: Kullanici KullaniciPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kullanici"
    ADD CONSTRAINT "KullaniciPK" PRIMARY KEY ("kullaniciId");


--
-- Name: Musteri MusteriPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri"
    ADD CONSTRAINT "MusteriPK" PRIMARY KEY ("musteriId");


--
-- Name: SiparişDetay SiparişDetayPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SiparişDetay"
    ADD CONSTRAINT "SiparişDetayPK" PRIMARY KEY ("siparisDetayId");


--
-- Name: Siparişler SiparişlerPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Siparişler"
    ADD CONSTRAINT "SiparişlerPK" PRIMARY KEY ("siparisId");


--
-- Name: Telefon TelefonPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Telefon"
    ADD CONSTRAINT "TelefonPK" PRIMARY KEY ("telefonId");


--
-- Name: Topluluk ToplulukPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Topluluk"
    ADD CONSTRAINT "ToplulukPK" PRIMARY KEY ("toplulukId");


--
-- Name: Yetkili YetkiliPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yetkili"
    ADD CONSTRAINT "YetkiliPK" PRIMARY KEY ("yetkiliId");


--
-- Name: erkekBisiklet erkekBisikletPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."erkekBisiklet"
    ADD CONSTRAINT "erkekBisikletPK" PRIMARY KEY ("erkekBisikletId");


--
-- Name: kadınBisiklet kadınBisikletPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kadınBisiklet"
    ADD CONSTRAINT "kadınBisikletPK" PRIMARY KEY ("kadınBisikletId");


--
-- Name: Bisiklet bisikletlog_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER bisikletlog_trigger AFTER INSERT OR DELETE OR UPDATE ON public."Bisiklet" FOR EACH ROW EXECUTE PROCEDURE public.bisikletlog_func();


--
-- Name: Kiralik kiralik_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER kiralik_trigger AFTER INSERT OR DELETE OR UPDATE ON public."Kiralik" FOR EACH ROW EXECUTE PROCEDURE public.kiraliklog_func();


--
-- Name: Kullanici kullanicilog_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER kullanicilog_trigger AFTER INSERT OR DELETE OR UPDATE ON public."Kullanici" FOR EACH ROW EXECUTE PROCEDURE public.kullanicilog_func();


--
-- Name: Firma FirmaFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Firma"
    ADD CONSTRAINT "FirmaFK" FOREIGN KEY ("urunId") REFERENCES public."Bisiklet"("urunId");


--
-- Name: Katagori KatagoriFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Katagori"
    ADD CONSTRAINT "KatagoriFK" FOREIGN KEY ("urunId") REFERENCES public."Bisiklet"("urunId");


--
-- Name: Kiralik KiralikFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kiralik"
    ADD CONSTRAINT "KiralikFK" FOREIGN KEY ("urunId") REFERENCES public."Bisiklet"("urunId");


--
-- Name: Musteri Musteri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri"
    ADD CONSTRAINT "Musteri" FOREIGN KEY ("musteriId") REFERENCES public."Kullanici"("kullaniciId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Musteri MusteriFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri"
    ADD CONSTRAINT "MusteriFK" FOREIGN KEY ("kullaniciId") REFERENCES public."Kullanici"("kullaniciId");


--
-- Name: Musteri MusteriFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri"
    ADD CONSTRAINT "MusteriFK2" FOREIGN KEY ("telefonId") REFERENCES public."Telefon"("telefonId");


--
-- Name: Musteri MusteriFK3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Musteri"
    ADD CONSTRAINT "MusteriFK3" FOREIGN KEY ("adresId") REFERENCES public."Adres"("adresId");


--
-- Name: SiparişDetay SiparişDetayFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SiparişDetay"
    ADD CONSTRAINT "SiparişDetayFK" FOREIGN KEY ("urunId") REFERENCES public."Bisiklet"("urunId");


--
-- Name: Siparişler SiparişlerFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Siparişler"
    ADD CONSTRAINT "SiparişlerFK" FOREIGN KEY ("siparisDetayId") REFERENCES public."SiparişDetay"("siparisDetayId");


--
-- Name: Topluluk ToplulukFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Topluluk"
    ADD CONSTRAINT "ToplulukFK" FOREIGN KEY ("kullaniciId") REFERENCES public."Kullanici"("kullaniciId");


--
-- Name: Yetkili Yetkili; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yetkili"
    ADD CONSTRAINT "Yetkili" FOREIGN KEY ("yetkiliId") REFERENCES public."Kullanici"("kullaniciId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Yetkili YetkiliFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yetkili"
    ADD CONSTRAINT "YetkiliFK" FOREIGN KEY ("kullaniciId") REFERENCES public."Kullanici"("kullaniciId");


--
-- Name: erkekBisiklet erkekBisiklet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."erkekBisiklet"
    ADD CONSTRAINT "erkekBisiklet" FOREIGN KEY ("erkekBisikletId") REFERENCES public."Bisiklet"("urunId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: erkekBisiklet erkekBisikletFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."erkekBisiklet"
    ADD CONSTRAINT "erkekBisikletFK" FOREIGN KEY ("urunId") REFERENCES public."Bisiklet"("urunId");


--
-- Name: kadınBisiklet kadınBisiklet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kadınBisiklet"
    ADD CONSTRAINT "kadınBisiklet" FOREIGN KEY ("kadınBisikletId") REFERENCES public."Bisiklet"("urunId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kadınBisiklet kadınBisikletFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kadınBisiklet"
    ADD CONSTRAINT "kadınBisikletFK" FOREIGN KEY ("urunId") REFERENCES public."Bisiklet"("urunId");


--
-- PostgreSQL database dump complete
--

