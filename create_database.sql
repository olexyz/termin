--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.3
-- Dumped by pg_dump version 9.3.5
-- Started on 2017-10-17 10:10:45

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2033 (class 1262 OID 57812)
-- Name: termin; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE termin WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8';


ALTER DATABASE termin OWNER TO postgres;

\connect termin

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 188 (class 3079 OID 11775)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2036 (class 0 OID 0)
-- Dependencies: 188
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 201 (class 1255 OID 58692)
-- Name: updslova(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updslova() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE bUpdate boolean;
BEGIN 
bUpdate=false;
IF (TG_OP = 'INSERT') THEN 
bUpdate:=true;
ELSEIF (TG_OP = 'UPDATE') THEN
IF
NEW.name!=OLD.name THEN
bUpdate:=true;
END IF;
END IF;
IF (bUpdate=TRUE) THEN
RAISE NOTICE 'UPDATE';
new.fts_v=setweight(coalesce(to_tsvector(NEW.name),''),'A');
END IF;
RETURN NEW;
END;
$$;


ALTER FUNCTION public.updslova() OWNER TO postgres;

--
-- TOC entry 202 (class 1255 OID 59690)
-- Name: updznvector(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updznvector() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE bUpdate boolean;
BEGIN 
bUpdate=false;
IF (TG_OP = 'INSERT') THEN 
bUpdate:=true;
ELSEIF (TG_OP = 'UPDATE') THEN
IF NEW.znach!=OLD.znach THEN
bUpdate:=true;
END IF;
END IF;
IF (bUpdate=TRUE) THEN
RAISE NOTICE 'UPDATE';
new.fts_v=setweight(coalesce(to_tsvector(NEW.znach),''),'A');
END IF;
RETURN NEW;
END;
$$;


ALTER FUNCTION public.updznvector() OWNER TO postgres;

--
-- TOC entry 1544 (class 3600 OID 58689)
-- Name: mydict_russian_ispell; Type: TEXT SEARCH DICTIONARY; Schema: public; Owner: postgres
--

CREATE TEXT SEARCH DICTIONARY mydict_russian_ispell (
    TEMPLATE = pg_catalog.ispell,
    dictfile = 'ru_ru', afffile = 'ru_ru', stopwords = 'russian' );


ALTER TEXT SEARCH DICTIONARY public.mydict_russian_ispell OWNER TO postgres;

--
-- TOC entry 1561 (class 3602 OID 58690)
-- Name: mydict_ru; Type: TEXT SEARCH CONFIGURATION; Schema: public; Owner: postgres
--

CREATE TEXT SEARCH CONFIGURATION mydict_ru (
    PARSER = pg_catalog."default" );

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR word WITH mydict_russian_ispell;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR email WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR url WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR host WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR sfloat WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR version WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR hword_numpart WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR hword_part WITH mydict_russian_ispell;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR numhword WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR hword WITH mydict_russian_ispell;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR url_path WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR file WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR "float" WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR "int" WITH simple;

ALTER TEXT SEARCH CONFIGURATION mydict_ru
    ADD MAPPING FOR uint WITH simple;


ALTER TEXT SEARCH CONFIGURATION public.mydict_ru OWNER TO postgres;

--
-- TOC entry 2037 (class 0 OID 0)
-- Dependencies: 1561
-- Name: TEXT SEARCH CONFIGURATION mydict_ru; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON TEXT SEARCH CONFIGURATION mydict_ru IS 'conf. for mydict ru';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 185 (class 1259 OID 60107)
-- Name: inslovo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE inslovo (
    id integer NOT NULL,
    id_slovo integer,
    id_lang integer,
    name text,
    sokr text
);


ALTER TABLE public.inslovo OWNER TO postgres;

--
-- TOC entry 2038 (class 0 OID 0)
-- Dependencies: 185
-- Name: TABLE inslovo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE inslovo IS 'Наименование термина на иностранном языке';


--
-- TOC entry 2039 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN inslovo.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN inslovo.id IS 'Идентификатор иностранного названия термина';


--
-- TOC entry 2040 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN inslovo.id_slovo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN inslovo.id_slovo IS 'Ссылка на идентификатор термина';


--
-- TOC entry 2041 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN inslovo.id_lang; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN inslovo.id_lang IS 'Ссылка на идентификатор языка термина';


--
-- TOC entry 2042 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN inslovo.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN inslovo.name IS 'Наименование термина на иностранном языке';


--
-- TOC entry 2043 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN inslovo.sokr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN inslovo.sokr IS 'Сокращение термина на иностранном языке';


--
-- TOC entry 184 (class 1259 OID 60105)
-- Name: inslovo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE inslovo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inslovo_id_seq OWNER TO postgres;

--
-- TOC entry 2044 (class 0 OID 0)
-- Dependencies: 184
-- Name: inslovo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE inslovo_id_seq OWNED BY inslovo.id;


--
-- TOC entry 177 (class 1259 OID 57915)
-- Name: istochnik; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE istochnik (
    id integer NOT NULL,
    name text,
    opisanie text,
    ssilka text
);


ALTER TABLE public.istochnik OWNER TO postgres;

--
-- TOC entry 2045 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE istochnik; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE istochnik IS 'Источники терминов';


--
-- TOC entry 2046 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN istochnik.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN istochnik.id IS 'Идентификатор источника термина';


--
-- TOC entry 2047 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN istochnik.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN istochnik.name IS 'Наименование источника термина';


--
-- TOC entry 2048 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN istochnik.opisanie; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN istochnik.opisanie IS 'Описание источника термина';


--
-- TOC entry 2049 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN istochnik.ssilka; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN istochnik.ssilka IS 'Ссылка на электрнный вид источника термина';


--
-- TOC entry 176 (class 1259 OID 57913)
-- Name: istochnik_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE istochnik_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.istochnik_id_seq OWNER TO postgres;

--
-- TOC entry 2050 (class 0 OID 0)
-- Dependencies: 176
-- Name: istochnik_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE istochnik_id_seq OWNED BY istochnik.id;


--
-- TOC entry 179 (class 1259 OID 57924)
-- Name: k_ist; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE k_ist (
    id integer NOT NULL,
    id_znach integer,
    id_ist integer
);


ALTER TABLE public.k_ist OWNER TO postgres;

--
-- TOC entry 2051 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE k_ist; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE k_ist IS 'Таблица связки термина и источников';


--
-- TOC entry 2052 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN k_ist.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN k_ist.id IS 'Идентификатор записи';


--
-- TOC entry 2053 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN k_ist.id_znach; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN k_ist.id_znach IS 'Ссылка на идентификатор значения термина';


--
-- TOC entry 2054 (class 0 OID 0)
-- Dependencies: 179
-- Name: COLUMN k_ist.id_ist; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN k_ist.id_ist IS 'Ссылка на идентификатор источника значения термина';


--
-- TOC entry 178 (class 1259 OID 57922)
-- Name: k_ist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE k_ist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.k_ist_id_seq OWNER TO postgres;

--
-- TOC entry 2055 (class 0 OID 0)
-- Dependencies: 178
-- Name: k_ist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE k_ist_id_seq OWNED BY k_ist.id;


--
-- TOC entry 181 (class 1259 OID 58739)
-- Name: k_rub; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE k_rub (
    id integer NOT NULL,
    id_rub integer,
    id_znach integer
);


ALTER TABLE public.k_rub OWNER TO postgres;

--
-- TOC entry 2056 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE k_rub; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE k_rub IS 'Таблица привязки значений термина к рубрикам';


--
-- TOC entry 2057 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN k_rub.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN k_rub.id IS 'Идентификатор записи';


--
-- TOC entry 2058 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN k_rub.id_rub; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN k_rub.id_rub IS 'Ссылка на идентификатор рубрики';


--
-- TOC entry 2059 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN k_rub.id_znach; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN k_rub.id_znach IS 'Ссылка на идентификатор значения термина';


--
-- TOC entry 180 (class 1259 OID 58737)
-- Name: k_rub_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE k_rub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.k_rub_id_seq OWNER TO postgres;

--
-- TOC entry 2060 (class 0 OID 0)
-- Dependencies: 180
-- Name: k_rub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE k_rub_id_seq OWNED BY k_rub.id;


--
-- TOC entry 183 (class 1259 OID 58893)
-- Name: lang; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lang (
    id integer NOT NULL,
    name text,
    abr text
);


ALTER TABLE public.lang OWNER TO postgres;

--
-- TOC entry 2061 (class 0 OID 0)
-- Dependencies: 183
-- Name: TABLE lang; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lang IS 'Справочник иностранных языков';


--
-- TOC entry 2062 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN lang.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lang.id IS 'Идентификатор записи';


--
-- TOC entry 2063 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN lang.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lang.name IS 'Название иностранного языка';


--
-- TOC entry 2064 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN lang.abr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lang.abr IS 'Аббревиатура (обозначение) иностранного языка';


--
-- TOC entry 182 (class 1259 OID 58891)
-- Name: lang_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lang_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lang_id_seq OWNER TO postgres;

--
-- TOC entry 2065 (class 0 OID 0)
-- Dependencies: 182
-- Name: lang_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lang_id_seq OWNED BY lang.id;


--
-- TOC entry 170 (class 1259 OID 57814)
-- Name: rubrikator; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rubrikator (
    id integer NOT NULL,
    rubrika text,
    par_id integer,
    num text
);


ALTER TABLE public.rubrikator OWNER TO postgres;

--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 170
-- Name: TABLE rubrikator; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE rubrikator IS 'Рубрики';


--
-- TOC entry 2067 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN rubrikator.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rubrikator.id IS 'Идентификатор рубрики';


--
-- TOC entry 2068 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN rubrikator.rubrika; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rubrikator.rubrika IS 'Название рубрики';


--
-- TOC entry 2069 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN rubrikator.par_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rubrikator.par_id IS 'Идентификатор родительской рубрики';


--
-- TOC entry 2070 (class 0 OID 0)
-- Dependencies: 170
-- Name: COLUMN rubrikator.num; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rubrikator.num IS 'Порядковый номер рубрики';


--
-- TOC entry 171 (class 1259 OID 57820)
-- Name: rubrikator_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rubrikator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rubrikator_id_seq OWNER TO postgres;

--
-- TOC entry 2071 (class 0 OID 0)
-- Dependencies: 171
-- Name: rubrikator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rubrikator_id_seq OWNED BY rubrikator.id;


--
-- TOC entry 172 (class 1259 OID 57822)
-- Name: slova; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE slova (
    id integer NOT NULL,
    name text,
    sokr text,
    fts_v tsvector
);


ALTER TABLE public.slova OWNER TO postgres;

--
-- TOC entry 2072 (class 0 OID 0)
-- Dependencies: 172
-- Name: COLUMN slova.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN slova.id IS 'Идентификатор термина';


--
-- TOC entry 2073 (class 0 OID 0)
-- Dependencies: 172
-- Name: COLUMN slova.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN slova.name IS 'Наименование термина';


--
-- TOC entry 2074 (class 0 OID 0)
-- Dependencies: 172
-- Name: COLUMN slova.sokr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN slova.sokr IS 'Сокращение термина на русском языке';


--
-- TOC entry 2075 (class 0 OID 0)
-- Dependencies: 172
-- Name: COLUMN slova.fts_v; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN slova.fts_v IS 'Поле оптимизированное для текстового поиска';


--
-- TOC entry 186 (class 1259 OID 60675)
-- Name: slovari; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE slovari (
    id integer NOT NULL,
    name text,
    comment text,
    ip text,
    accept boolean
);


ALTER TABLE public.slovari OWNER TO postgres;

--
-- TOC entry 2076 (class 0 OID 0)
-- Dependencies: 186
-- Name: TABLE slovari; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE slovari IS 'Словари';


--
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN slovari.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN slovari.id IS 'Идентификатор словаря';


--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN slovari.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN slovari.name IS 'Наименование словаря';


--
-- TOC entry 2079 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN slovari.comment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN slovari.comment IS 'Примечание';


--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN slovari.ip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN slovari.ip IS 'Ссылка на словарь';


--
-- TOC entry 187 (class 1259 OID 60678)
-- Name: slovari_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE slovari_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.slovari_id_seq OWNER TO postgres;

--
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 187
-- Name: slovari_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE slovari_id_seq OWNED BY slovari.id;


--
-- TOC entry 173 (class 1259 OID 57828)
-- Name: termin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE termin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.termin_id_seq OWNER TO postgres;

--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 173
-- Name: termin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE termin_id_seq OWNED BY slova.id;


--
-- TOC entry 174 (class 1259 OID 57830)
-- Name: znach; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE znach (
    id integer NOT NULL,
    id_slova integer,
    znach text,
    fts_v tsvector,
    comment text,
    date_upd timestamp without time zone
);


ALTER TABLE public.znach OWNER TO postgres;

--
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN znach.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN znach.id IS 'Идентификатор значения термина';


--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN znach.id_slova; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN znach.id_slova IS 'Ссылка на идентификатор термина';


--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN znach.znach; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN znach.znach IS 'Определние термина';


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN znach.fts_v; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN znach.fts_v IS 'Поле оптимизированное для текстового поиска';


--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN znach.comment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN znach.comment IS 'Комментарий';


--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN znach.date_upd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN znach.date_upd IS 'Дата обновления';


--
-- TOC entry 175 (class 1259 OID 57836)
-- Name: znach_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE znach_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.znach_id_seq OWNER TO postgres;

--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 175
-- Name: znach_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE znach_id_seq OWNED BY znach.id;


--
-- TOC entry 1906 (class 2604 OID 60110)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inslovo ALTER COLUMN id SET DEFAULT nextval('inslovo_id_seq'::regclass);


--
-- TOC entry 1902 (class 2604 OID 57918)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY istochnik ALTER COLUMN id SET DEFAULT nextval('istochnik_id_seq'::regclass);


--
-- TOC entry 1903 (class 2604 OID 57927)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY k_ist ALTER COLUMN id SET DEFAULT nextval('k_ist_id_seq'::regclass);


--
-- TOC entry 1904 (class 2604 OID 58742)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY k_rub ALTER COLUMN id SET DEFAULT nextval('k_rub_id_seq'::regclass);


--
-- TOC entry 1905 (class 2604 OID 58896)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lang ALTER COLUMN id SET DEFAULT nextval('lang_id_seq'::regclass);


--
-- TOC entry 1899 (class 2604 OID 57846)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rubrikator ALTER COLUMN id SET DEFAULT nextval('rubrikator_id_seq'::regclass);


--
-- TOC entry 1900 (class 2604 OID 57847)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY slova ALTER COLUMN id SET DEFAULT nextval('termin_id_seq'::regclass);


--
-- TOC entry 1907 (class 2604 OID 60680)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY slovari ALTER COLUMN id SET DEFAULT nextval('slovari_id_seq'::regclass);


--
-- TOC entry 1901 (class 2604 OID 57848)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY znach ALTER COLUMN id SET DEFAULT nextval('znach_id_seq'::regclass);


--
-- TOC entry 1909 (class 1259 OID 58691)
-- Name: i_fts_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX i_fts_idx ON slova USING gist (fts_v);


--
-- TOC entry 1913 (class 1259 OID 60782)
-- Name: istochnik_id_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX istochnik_id_key ON istochnik USING btree (id);


--
-- TOC entry 1908 (class 1259 OID 60766)
-- Name: rubrikator_id_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX rubrikator_id_key ON rubrikator USING btree (id);


--
-- TOC entry 1910 (class 1259 OID 60742)
-- Name: slova_id_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX slova_id_key ON slova USING btree (id);


--
-- TOC entry 1911 (class 1259 OID 59689)
-- Name: z_fts_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX z_fts_idx ON znach USING gist (fts_v);


--
-- TOC entry 1912 (class 1259 OID 60760)
-- Name: znach_id_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX znach_id_key ON znach USING btree (id);


--
-- TOC entry 1920 (class 2620 OID 58693)
-- Name: slovaFTStrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "slovaFTStrigger" BEFORE INSERT OR UPDATE ON slova FOR EACH ROW EXECUTE PROCEDURE updslova();


--
-- TOC entry 1921 (class 2620 OID 59691)
-- Name: znFTStrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "znFTStrigger" BEFORE INSERT OR UPDATE ON znach FOR EACH ROW EXECUTE PROCEDURE updznvector();


--
-- TOC entry 1919 (class 2606 OID 60788)
-- Name: inslovo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inslovo
    ADD CONSTRAINT inslovo_fk FOREIGN KEY (id_slovo) REFERENCES slova(id) ON DELETE CASCADE;


--
-- TOC entry 1915 (class 2606 OID 60777)
-- Name: k_ist_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY k_ist
    ADD CONSTRAINT k_ist_fk FOREIGN KEY (id_znach) REFERENCES znach(id) ON DELETE CASCADE;


--
-- TOC entry 1916 (class 2606 OID 60783)
-- Name: k_ist_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY k_ist
    ADD CONSTRAINT k_ist_fk1 FOREIGN KEY (id_ist) REFERENCES istochnik(id) ON DELETE CASCADE;


--
-- TOC entry 1917 (class 2606 OID 60761)
-- Name: k_rub_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY k_rub
    ADD CONSTRAINT k_rub_fk FOREIGN KEY (id_znach) REFERENCES znach(id) ON DELETE CASCADE;


--
-- TOC entry 1918 (class 2606 OID 60767)
-- Name: k_rub_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY k_rub
    ADD CONSTRAINT k_rub_fk1 FOREIGN KEY (id_rub) REFERENCES rubrikator(id) ON DELETE CASCADE;


--
-- TOC entry 1914 (class 2606 OID 60743)
-- Name: znach_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY znach
    ADD CONSTRAINT znach_fk FOREIGN KEY (id_slova) REFERENCES slova(id) ON DELETE CASCADE;


--
-- TOC entry 2035 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-10-17 10:10:46

--
-- PostgreSQL database dump complete
--

