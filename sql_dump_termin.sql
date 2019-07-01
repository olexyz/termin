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

--ПЕРВИЧНОЕ ЗАПОЛНЕНИЕ ТАБЛИЦ


INSERT INTO slova (id, name, sokr, fts_v) VALUES (15188, 'Абстрагированная информация', '', '''абстрагирова'':1A ''информац'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15189, 'Абстрактная модель', '', '''абстрактн'':1A ''модел'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15190, 'Абстракция данных', '', '''абстракц'':1A ''дан'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15191, 'Аварийный режим АС', '', '''аварийн'':1A ''ас'':3A ''реж'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15193, 'Авария АС', '', '''авар'':1A ''ас'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15194, 'Автоматизация обработки неструктурированной информации', '', '''автоматизац'':1A ''информац'':4A ''неструктурирова'':3A ''обработк'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15195, 'Автоматизированная организация', '', '''автоматизирова'':1A ''организац'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15197, 'Автоматизированная система', '', '''автоматизирова'':1A ''систем'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15198, 'Автоматизированная система военного назначения', '', '''автоматизирова'':1A ''воен'':3A ''назначен'':4A ''систем'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15199, 'Автоматизированная система обработки текста', '', '''автоматизирова'':1A ''обработк'':3A ''систем'':2A ''текст'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15200, 'Автоматизированная система высокой доступности ', 'АСВД', '''автоматизирова'':1A ''высок'':3A ''доступн'':4A ''систем'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15201, 'Автоматизированная система управления', 'АСУ', '''автоматизирова'':1A ''систем'':2A ''управлен'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15202, 'Автоматизированная система управления войсками (силами)', 'АСУ войсками (силами)', '''автоматизирова'':1A ''войск'':4A ''сил'':5A ''систем'':2A ''управлен'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15203, 'Автоматизированная система управления Вооруженными Силами Российской Федерации', 'АСУ ВС РФ', '''автоматизирова'':1A ''вооружен'':4A ''российск'':6A ''сил'':5A ''систем'':2A ''управлен'':3A ''федерац'':7A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15204, 'Автоматизированная система управления знаниями', '', '''автоматизирова'':1A ''знан'':4A ''систем'':2A ''управлен'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15205, 'Автоматизированная система управления производственными и технологическими процессами критически важного объекта инфраструктуры Российской Федерации', '', '''автоматизирова'':1A ''важн'':9A ''инфраструктур'':11A ''критическ'':8A ''объект'':10A ''производствен'':4A ''процесс'':7A ''российск'':12A ''систем'':2A ''технологическ'':6A ''управлен'':3A ''федерац'':13A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15206, 'Автоматизированное ведение досье на информационный объект', '', '''автоматизирова'':1A ''веден'':2A ''дос'':3A ''информацион'':5A ''объект'':6A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15207, 'Автоматизированное рабочее место', 'АРМ', '''автоматизирова'':1A ''мест'':3A ''рабоч'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15208, 'Автоматизированное рабочее место должностного лица органа военного управления', 'АРМ ДЛ ОВУ', '''автоматизирова'':1A ''воен'':7A ''должностн'':4A ''лиц'':5A ''мест'':3A ''орга'':6A ''рабоч'':2A ''управлен'':8A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15209, 'Автоматизированные системы управления четвертого поколения', '', '''автоматизирова'':1A ''поколен'':5A ''систем'':2A ''управлен'':3A ''четверт'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15210, 'Автоматизированный', '', '''автоматизирова'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15212, 'Автоматизированный информационно-поисковый тезаурус', '', '''автоматизирова'':1A ''информацион'':3A ''информационно-поисков'':2A ''поисков'':4A ''тезаурус'':5A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15213, 'Автоматизированный перевод текста', '', '''автоматизирова'':1A ''перевод'':2A ''текст'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15214, 'Автоматизированный процесс', '', '''автоматизирова'':1A ''процесс'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15215, 'Автоматический анализ текста', '', '''автоматическ'':1A ''анализ'':2A ''текст'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15216, 'Автоматический синтез текста', '', '''автоматическ'':1A ''синтез'':2A ''текст'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15217, 'Автоматический', '', '''автоматическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15218, 'Автоматическое извлечение ключевых терминов', '', '''автоматическ'':1A ''извлечен'':2A ''ключев'':3A ''термин'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15219, 'Автоматная модель', '', '''автоматн'':1A ''модел'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15220, 'Автономная система управления', '', '''автономн'':1A ''систем'':2A ''управлен'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15225, 'Авторизация', '', '''авторизац'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15226, 'Авторизация данных', '', '''авторизац'':1A ''дан'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15227, 'Авторизация программы', '', '''авторизац'':1A ''программ'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15228, 'Авторский надзор за состоянием АС', '', '''авторск'':1A ''ас'':5A ''надзор'':2A ''состоян'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15229, 'Авторский надзор за состоянием автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':5A ''авторск'':1A ''войск'':8A ''надзор'':2A ''сил'':9A ''систем'':6A ''состоян'':4A ''управлен'':7A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15230, 'Агрегация контента различных источников информации', '', '''агрегац'':1A ''информац'':5A ''источник'':4A ''контент'':2A ''различн'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15231, 'Агрегирование данных', '', '''агрегирован'':1A ''дан'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15232, 'Адаптация программных средств', '', '''адаптац'':1A ''программн'':2A ''средств'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15233, 'Адаптация программы для ЭВМ или базы данных', '', '''адаптац'':1A ''баз'':6A ''дан'':7A ''программ'':2A ''эвм'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15234, 'Адаптивность автоматизированной системы', '', '''автоматизирова'':2A ''адаптивн'':1A ''систем'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15235, 'Адекватность информации', '', '''адекватн'':1A ''информац'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15236, 'Адекватность программного средства', '', '''адекватн'':1A ''программн'':2A ''средств'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15237, 'Административные меры защиты АСУ ВС', '', '''административн'':1A ''ас'':4A ''вс'':5A ''защит'':3A ''мер'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15240, 'Администратор базы данных', '', '''администратор'':1A ''баз'':2A ''дан'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15241, 'Администратор защиты', '', '''администратор'':1A ''защит'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15242, 'Администратор защиты автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':3A ''администратор'':1A ''войск'':6A ''защит'':2A ''сил'':7A ''систем'':4A ''управлен'':5A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15243, 'Администратор службы безопасности', '', '''администратор'':1A ''безопасн'':3A ''служб'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15244, 'Администрирование базы данных', '', '''администрирован'':1A ''баз'':2A ''дан'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15245, 'Адрес', '', '''адрес'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15246, 'Аккредитация в области защиты информации', '', '''аккредитац'':1A ''защит'':4A ''информац'':5A ''област'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15247, 'Активный мониторинг', '', '''активн'':1A ''мониторинг'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15248, 'Актор', '', '''актор'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15249, 'Актуализация', '', '''актуализац'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15250, 'Актуализация данных', '', '''актуализац'':1A ''дан'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15251, 'Актуальность безошибочной информации', '', '''актуальн'':1A ''безошибочн'':2A ''информац'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15255, 'Алгоритм', '', '''алгоритм'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15256, 'Алгоритм SPF', '', '''spf'':2A ''алгоритм'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15257, 'Алгоритм маршрутизации', '', '''алгоритм'':1A ''маршрутизац'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15258, 'Алгоритм функционирования автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':3A ''алгоритм'':1A ''войск'':6A ''сил'':7A ''систем'':4A ''управлен'':5A ''функционирован'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15259, 'Алгоритм шифрования', '', '''алгоритм'':1A ''шифрован'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15260, 'Алгоритмизированное изложение информации', '', '''алгоритмизирова'':1A ''изложен'':2A ''информац'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15261, 'Анализ информационного риска', '', '''анализ'':1A ''информацион'':2A ''риск'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15265, 'База данных', 'БД', '''баз'':1A ''дан'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15266, 'База данных лексикографическая', '', '''баз'':1A ''дан'':2A ''лексикографическ'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15267, 'База данных лексическая', '', '''баз'':1A ''дан'':2A ''лексическ'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15268, 'База данных рисков', '', '''баз'':1A ''дан'':2A ''риск'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15269, 'База данных управления конфигурацией', '', '''баз'':1A ''дан'':2A ''конфигурац'':4A ''управлен'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15271, 'База знаний', 'БЗ', '''баз'':1A ''знан'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15272, 'База знаний замкнутая', '', '''баз'':1A ''замкнут'':3A ''знан'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15273, 'База знаний интенсиональная', '', '''баз'':1A ''знан'':2A ''интенсиональн'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15274, 'База знаний открытая', '', '''баз'':1A ''знан'':2A ''открыт'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15275, 'База известных ошибок', '', '''баз'':1A ''известн'':2A ''ошибок'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15276, 'База накопленных знаний', '', '''баз'':1A ''знан'':3A ''накоплен'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15277, 'База управляющей информации', '', '''баз'':1A ''информац'':3A ''управля'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15278, 'Вакцинирование', '', '''вакцинирован'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15281, 'Валидация', '', '''валидац'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15282, 'Веб-адрес', '', '''адрес'':3A ''веб'':2A ''веб-адрес'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15283, 'Веб-интерфейс', '', '''веб'':2A ''веб-интерфейс'':1A ''интерфейс'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15284, 'Веб-майнинг', '', '''веб'':2A ''веб-майнинг'':1A ''майнинг'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15285, 'Веб-сервис', '', '''веб'':2A ''веб-сервис'':1A ''сервис'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15286, 'Веб-страница', '', '''веб'':2A ''веб-страниц'':1A ''страниц'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15287, 'Вейвлет-преобразование', '', '''вейвлет'':2A ''вейвлет-преобразован'':1A ''преобразован'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15288, 'Вербально-образное представление знаний', '', '''вербальн'':2A ''вербально-образн'':1A ''знан'':5A ''образн'':3A ''представлен'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15294, 'Верификация', '', '''верификац'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15295, 'Гаджет', '', '''гаджет'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15296, 'Гарантийный надзор за состоянием АС', '', '''ас'':5A ''гарантийн'':1A ''надзор'':2A ''состоян'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15297, 'Гарантия ИТ-услуги', '', '''гарант'':1A ''ит'':3A ''ит-услуг'':2A ''услуг'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15299, 'Гарантия защиты', '', '''гарант'':1A ''защит'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15300, 'Генетические алгоритмы', '', '''алгоритм'':2A ''генетическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15301, 'Географические данные (геоданные)', '', '''географическ'':1A ''геода'':3A ''дан'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15302, 'Геоинформатика', '', '''геоинформатик'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15305, 'Геоинформационная система', 'ГИС', '''геоинформацион'':1A ''систем'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15307, 'Геоинформационная технология', '', '''геоинформацион'':1A ''технолог'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15308, 'Геокодирование (пространственного объекта)', '', '''геокодирован'':1A ''объект'':3A ''пространствен'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15309, 'Геоматика ', '', '''геоматик'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15310, 'Геоматика', '', '''геоматик'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15311, 'Геопозиционирование', '', '''геопозиционирован'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15312, 'Геореференция', '', '''геореференц'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15315, 'Данные', '', '''дан'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15316, 'Данные входные', '', '''входн'':2A ''дан'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15317, 'Данные выходные', '', '''выходн'':2A ''дан'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15318, 'Даталогическая модель базы данных', '', '''баз'':3A ''дан'':4A ''даталогическ'':1A ''модел'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15319, 'Датчик случайных чисел', '', '''датчик'':1A ''случайн'':2A ''чисел'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15320, 'Двухуровневая архитектура', '', '''архитектур'':2A ''двухуровнев'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15322, 'Дезинформация', '', '''дезинформац'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15323, 'Декодер', '', '''декодер'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15326, 'Декодирование', '', '''декодирован'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15327, 'Декомпилирование программы для ЭВМ', '', '''декомпилирован'':1A ''программ'':2A ''эвм'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15329, 'Дескриптор', '', '''дескриптор'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15330, 'Дескриптор-смысл', '', '''дескриптор'':2A ''дескриптор-смысл'':1A ''смысл'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15331, 'Единая точка отказа', '', '''един'':1A ''отказ'':3A ''точк'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15332, 'Единица данных протоколов', '', '''дан'':2A ''единиц'':1A ''протокол'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15333, 'Единица затрат', '', '''единиц'':1A ''затрат'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15334, 'Единица релиза', '', '''единиц'':1A ''релиз'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15337, 'Единое информационное пространство', 'ЕИП', '''един'':1A ''информацион'':2A ''пространств'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15338, 'Единое информационное пространство Вооруженных Сил Российской Федерации', '', '''вооружен'':4A ''един'':1A ''информацион'':2A ''пространств'':3A ''российск'':6A ''сил'':5A ''федерац'':7A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15383, 'Извлечение знаний', '', '''знан'':2A ''извлечен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15385, 'Кадр (фрейм)', '', '''кадр'':1A ''фрейм'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15339, 'Единая государственная система обнаружения и предупреждения компьютерных атак на критическую информационную инфраструктуру и оценки уровня реальной защищенности ее элементов', '', '''атак'':8A ''государствен'':2A ''един'':1A ''защищен'':17A ''информацион'':11A ''инфраструктур'':12A ''компьютерн'':7A ''критическ'':10A ''обнаружен'':4A ''оценк'':14A ''предупрежден'':6A ''реальн'':16A ''систем'':3A ''уровн'':15A ''элемент'':19A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15340, 'Е-инфраструктура', '', '''е'':2A ''е-инфраструктур'':1A ''инфраструктур'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15341, 'Естественно-языковый интерфейс', '', '''естествен'':2A ''естественно-языков'':1A ''интерфейс'':4A ''языков'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15342, 'Жадный алгоритм', '', '''алгоритм'':2A ''жадн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15343, 'Живучесть автоматизированной организации', '', '''автоматизирова'':2A ''живучест'':1A ''организац'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15344, 'Живучесть автоматизированной системы', '', '''автоматизирова'':2A ''живучест'':1A ''систем'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15345, 'Живучесть автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':2A ''войск'':5A ''живучест'':1A ''сил'':6A ''систем'':3A ''управлен'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15346, 'Жизненный цикл', '', '''жизнен'':1A ''цикл'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15347, 'Жизненный цикл автоматизированной системы', '', '''автоматизирова'':3A ''жизнен'':1A ''систем'':4A ''цикл'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15348, 'Жизненный цикл автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':3A ''войск'':6A ''жизнен'':1A ''сил'':7A ''систем'':4A ''управлен'':5A ''цикл'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15349, 'Жизненный цикл доверенной среды', '', '''доверен'':3A ''жизнен'':1A ''сред'':4A ''цикл'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15350, 'Жизненный цикл изделий ВТ', '', '''вт'':4A ''жизнен'':1A ''издел'':3A ''цикл'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15351, 'Жизненный цикл программ', '', '''жизнен'':1A ''программ'':3A ''цикл'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15353, 'Жизненный цикл системы', '', '''жизнен'':1A ''систем'':3A ''цикл'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15354, 'Журнал (лог)', '', '''журна'':1A ''лог'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15355, 'Журнал сервера', '', '''журна'':1A ''сервер'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15356, 'Журнализация файловой системы', '', '''журнализац'':1A ''систем'':3A ''файлов'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15357, 'Завершающие процессы', '', '''заверша'':1A ''процесс'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15358, 'Задача автоматизированной системы', '', '''автоматизирова'':2A ''задач'':1A ''систем'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15359, 'Задача автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':2A ''войск'':5A ''задач'':1A ''сил'':6A ''систем'':3A ''управлен'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15360, 'Закон ассоциации информации в информационной динамике', '', '''ассоциац'':2A ''динамик'':6A ''закон'':1A ''информац'':3A ''информацион'':5A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15361, 'Закон преемственности информации в информационной динамике', '', '''динамик'':6A ''закон'':1A ''информац'':3A ''информацион'':5A ''преемствен'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15362, 'Закон принадлежности и интерпретация в информационной динамике', '', '''динамик'':7A ''закон'':1A ''интерпретац'':4A ''информацион'':6A ''принадлежн'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15363, 'Закон различия в информационной динамике', '', '''динамик'':5A ''закон'':1A ''информацион'':4A ''различ'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15364, 'Закон тождества и идентификация в информационной динамике', '', '''динамик'':7A ''закон'':1A ''идентификац'':4A ''информацион'':6A ''тождеств'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15365, 'Закрытые (защищенные) данные', '', '''дан'':3A ''закрыт'':1A ''защищен'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15366, 'Замысел защиты информации', '', '''замысел'':1A ''защит'':2A ''информац'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15367, 'Идентификатор', '', '''идентификатор'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15368, 'Идентификатор виртуального пути', '', '''виртуальн'':2A ''идентификатор'':1A ''пут'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15369, 'Идентификационная метка', '', '''идентификацион'':1A ''метк'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15372, 'Идентификация', '', '''идентификац'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15373, 'Идентификация знаний', '', '''знан'':2A ''идентификац'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15374, 'Идентификация конфигурации', '', '''идентификац'':1A ''конфигурац'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15375, 'Идентификация необходимых ресурсов', '', '''идентификац'':1A ''необходим'':2A ''ресурс'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15376, 'Идентификация посредством облачных сервисов', '', '''идентификац'':1A ''облачн'':3A ''посредств'':2A ''сервис'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15377, 'Идентификация релиза', '', '''идентификац'':1A ''релиз'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15378, 'Идентификация рисков в проекте', '', '''идентификац'':1A ''проект'':4A ''риск'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15379, 'Иерархическая модель данных', '', '''дан'':3A ''иерархическ'':1A ''модел'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15380, 'Иерархическая эскалация', '', '''иерархическ'':1A ''эскалац'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15381, 'Иерархический протокол маршрутизации', '', '''иерархическ'':1A ''маршрутизац'':3A ''протокол'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15386, 'Кадровая безопасность', '', '''безопасн'':2A ''кадров'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15388, 'Канальный уровень', '', '''канальн'':1A ''уровен'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15389, 'Капитал знания', '', '''знан'':2A ''капита'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15390, 'Карта знаний', '', '''знан'':2A ''карт'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15391, 'Картинное восприятие', '', '''восприят'':2A ''картин'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15392, 'Картографическая база данных', '', '''баз'':2A ''дан'':3A ''картографическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15393, 'Каталог', '', '''каталог'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15394, 'Каталог ИТ-услуг', '', '''ит'':3A ''ит-услуг'':2A ''каталог'':1A ''услуг'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15395, 'Каталогизация продукции (для федеральных государственных нужд)', '', '''государствен'':5A ''каталогизац'':1A ''нужд'':6A ''продукц'':2A ''федеральн'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15396, 'Катастрофоустойчивость АС', '', '''ас'':2A ''катастрофоустойчив'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15397, 'Категория безопасности информации', '', '''безопасн'':2A ''информац'':3A ''категор'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15399, 'Категория защиты информации', '', '''защит'':2A ''информац'':3A ''категор'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15400, 'Категория защищенности автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':3A ''войск'':6A ''защищен'':2A ''категор'':1A ''сил'':7A ''систем'':4A ''управлен'':5A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15401, 'Лаг', '', '''лаг'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15402, 'Легендирование', '', '''легендирован'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15403, 'Лексико-морфоло-гический анализ', '', '''анализ'':5A ''гическ'':4A ''лексик'':2A ''лексико-морфоло-гическ'':1A ''морфол'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15404, 'Лексическая единица', 'ЛЕ', '''единиц'':2A ''лексическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15405, 'Лингвистическая переменная', '', '''лингвистическ'':1A ''перемен'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15406, 'Лингвистическая совместимость автоматизированных систем', '', '''автоматизирова'':3A ''лингвистическ'':1A ''сист'':4A ''совместим'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15407, 'Лингвистическая эвристика', '', '''лингвистическ'':1A ''эвристик'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15410, 'Лингвистический анализ', '', '''анализ'':2A ''лингвистическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15411, 'Лингвистический поиск', '', '''лингвистическ'':1A ''поиск'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15412, 'Лингвистический процессор', '', '''лингвистическ'':1A ''процессор'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15414, 'Лингвистическое обеспечение автоматизированной системы', '', '''автоматизирова'':3A ''лингвистическ'':1A ''обеспечен'':2A ''систем'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15415, 'Лингвистическое обеспечение автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':3A ''войск'':6A ''лингвистическ'':1A ''обеспечен'':2A ''сил'':7A ''систем'':4A ''управлен'':5A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15416, 'Лингвистическая совместимость автоматизированных систем управления войсками (силами)', '', '''автоматизирова'':3A ''войск'':6A ''лингвистическ'':1A ''сил'':7A ''сист'':4A ''совместим'':2A ''управлен'':5A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15417, 'Линейка ИТ-услуг', '', '''ит'':3A ''ит-услуг'':2A ''линейк'':1A ''услуг'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15418, 'Лицензирование в области защиты информации', '', '''защит'':4A ''информац'':5A ''лицензирован'':1A ''област'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15419, 'Логико-семантический анализ ресурсно-сервисных возможностей АС', '', '''анализ'':4A ''ас'':9A ''возможн'':8A ''логик'':2A ''логико-семантическ'':1A ''ресурсн'':6A ''ресурсно-сервисн'':5A ''семантическ'':3A ''сервисн'':7A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15420, 'Логико-семантический подход к анализу ресурсно-сервисных возможностей АС', '', '''анализ'':6A ''ас'':11A ''возможн'':10A ''логик'':2A ''логико-семантическ'':1A ''подход'':4A ''ресурсн'':8A ''ресурсно-сервисн'':7A ''семантическ'':3A ''сервисн'':9A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15421, 'Логическая модель данных', '', '''дан'':3A ''логическ'':1A ''модел'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15422, 'Логический диск', '', '''диск'':2A ''логическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15423, 'Логическое блокирование', '', '''блокирован'':2A ''логическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15424, 'Локальная непрерывная репликация', '', '''локальн'':1A ''непрерывн'':2A ''репликац'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15425, 'Локальный диск', '', '''диск'':2A ''локальн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15426, 'Люк', '', '''люк'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15427, 'Магистральная сеть связи', '', '''магистральн'':1A ''связ'':3A ''сет'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15428, 'Макет', '', '''макет'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15429, 'Макровирусы', '', '''макровирус'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15430, 'Максимально приемлемый период нарушения', '', '''максимальн'':1A ''нарушен'':4A ''период'':3A ''приемлем'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15432, 'Мандатное управление доступом', '', '''доступ'':3A ''мандатн'':1A ''управлен'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15433, 'Мандатный принцип контроля доступа', '', '''доступ'':4A ''контрол'':3A ''мандатн'':1A ''принцип'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15434, 'Манипулирование знаниями', '', '''знан'':2A ''манипулирован'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15436, 'Маршрутизатор (роутер)', '', '''маршрутизатор'':1A ''роутер'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15437, 'Маршрутизатор с коммутацией меток', '', '''коммутац'':3A ''маршрутизатор'':1A ''меток'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15438, 'Маршрутизация', '', '''маршрутизац'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15439, 'Маскиратор', '', '''маскиратор'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15440, 'Маскирование цифровых данных', '', '''дан'':3A ''маскирован'':1A ''цифров'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15441, 'Массив данных', '', '''дан'':2A ''масс'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15442, 'Массовая параллельная обработка', '', '''массов'':1A ''обработк'':3A ''параллельн'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15443, 'Масштабирование анализа данных', '', '''анализ'':2A ''дан'':3A ''масштабирован'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15444, 'Масштабируемость', '', '''масштабируем'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15445, 'Математическая модель боевых действий', '', '''боев'':3A ''действ'':4A ''математическ'':1A ''модел'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15446, 'Математическое обеспечение автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':3A ''войск'':6A ''математическ'':1A ''обеспечен'':2A ''сил'':7A ''систем'':4A ''управлен'':5A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15447, 'Математическое обеспечение средств защиты информации', '', '''защит'':4A ''информац'':5A ''математическ'':1A ''обеспечен'':2A ''средств'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15448, 'Машина баз данных', '', '''баз'':2A ''дан'':3A ''машин'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15449, 'Машина баз знаний', '', '''баз'':2A ''знан'':3A ''машин'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15450, 'Машина вывода', '', '''вывод'':2A ''машин'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15451, 'Машина логического вывода', '', '''вывод'':3A ''логическ'':2A ''машин'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15452, 'Машина параллельного вывода', '', '''вывод'':3A ''машин'':1A ''параллельн'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15453, 'Машинная информационная база автоматизированных систем управления войсками (силами)', '', '''автоматизирова'':4A ''баз'':3A ''войск'':7A ''информацион'':2A ''машин'':1A ''сил'':8A ''сист'':5A ''управлен'':6A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15454, 'Машинный перевод', '', '''машин'':1A ''перевод'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15455, 'Медиаконтейнер (мультимедиаконтейнер)', '', '''медиаконтейнер'':1A ''мультимедиаконтейнер'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15456, 'Межмашинное взаимодействие', '', '''взаимодейств'':2A ''межмашин'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15457, 'Межсетевое взаимодействие', '', '''взаимодейств'':2A ''межсетев'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15458, 'Межсетевой шлюз', '', '''межсетев'':1A ''шлюз'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15459, 'Межсетевой экран (сетевой экран, файервол, брандмауэр)', '', '''брандмауэр'':6A ''межсетев'':1A ''сетев'':3A ''файервол'':5A ''экра'':2A,4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15461, 'Мейнфрейм (мэйн-фрейм)', '', '''мейнфрейм'':1A ''мэйн'':3A ''мэйн-фрейм'':2A ''фрейм'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15462, 'Навигационная информация', '', '''информац'':2A ''навигацион'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15463, 'Надежность автоматизированной системы', '', '''автоматизирова'':2A ''надежн'':1A ''систем'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15464, 'Надежность автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':2A ''войск'':5A ''надежн'':1A ''сил'':6A ''систем'':3A ''управлен'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15465, 'Надежность ИТ-услуги', '', '''ит'':3A ''ит-услуг'':2A ''надежн'':1A ''услуг'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15466, 'Надежность предоставления информации', '', '''информац'':3A ''надежн'':1A ''предоставлен'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15468, 'Надежность программного обеспечения (изделия)', '', '''издел'':4A ''надежн'':1A ''обеспечен'':3A ''программн'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15469, 'Надежность программных средств', '', '''надежн'':1A ''программн'':2A ''средств'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15470, 'Надстройка', '', '''надстройк'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15471, 'Нарушение автоматизированной деятельности', '', '''автоматизирова'':2A ''деятельн'':3A ''нарушен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15473, 'Нарушение безопасности информационной системы', '', '''безопасн'':2A ''информацион'':3A ''нарушен'':1A ''систем'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15476, 'Нарушитель информационной безопасности', '', '''безопасн'':3A ''информацион'':2A ''нарушител'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15526, 'Показатель качества документооборота', '', '''документооборот'':3A ''качеств'':2A ''показател'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15477, 'Нарушитель правил разграничения доступа', '', '''доступ'':4A ''нарушител'':1A ''прав'':2A ''разграничен'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15479, 'Наследование', '', '''наследован'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15480, 'Натурный метод информационного обследования органов военного управления', '', '''воен'':6A ''информацион'':3A ''метод'':2A ''натурн'':1A ''обследован'':4A ''орган'':5A ''управлен'':7A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15481, 'Научно-исследовательская работа по созданию изделия ВТ', '', '''вт'':8A ''издел'':7A ''исследовательск'':3A ''научн'':2A ''научно-исследовательск'':1A ''работ'':4A ''создан'':6A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15482, 'Научно-технический уровень автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':5A ''войск'':8A ''научн'':2A ''научно-техническ'':1A ''сил'':9A ''систем'':6A ''техническ'':3A ''управлен'':7A ''уровен'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15483, 'Национальная облачная платформа', '', '''национальн'':1A ''облачн'':2A ''платформ'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15484, 'Начальная поддержка', '', '''начальн'':1A ''поддержк'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15486, 'Недекларированные возможности', '', '''возможн'':2A ''недекларирова'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15487, 'Недекларированные возможности программного обеспечения автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':5A ''возможн'':2A ''войск'':8A ''недекларирова'':1A ''обеспечен'':4A ''программн'':3A ''сил'':9A ''систем'':6A ''управлен'':7A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15488, 'Нейроинформатика', '', '''нейроинформатик'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15489, 'Нейрокомпьютер', '', '''нейрокомпьютер'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15490, 'Нейрокомпьютерный интерфейс', '', '''интерфейс'':2A ''нейрокомпьютерн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15491, 'Немедленное восстановление', '', '''восстановлен'':2A ''немедлен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15492, 'Неогеография', '', '''неогеограф'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15493, 'Неоднородные информационные ресурсы', '', '''информацион'':2A ''неоднородн'':1A ''ресурс'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15494, 'Непредвиденная ситуация', '', '''непредвиден'':1A ''ситуац'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15495, 'Неработоспособное состояние системы (комплекса, образца) военной техники', '', '''воен'':6A ''комплекс'':4A ''неработоспособн'':1A ''образц'':5A ''систем'':3A ''состоян'':2A ''техник'':7A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15497, 'Неструктурированные данные', '', '''дан'':2A ''неструктурирова'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15498, 'Нечеткая информация', '', '''информац'':2A ''нечетк'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15499, 'Норма безопасности', '', '''безопасн'':2A ''норм'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15500, 'Нормативно-справочная информация автоматизированной системы', '', '''автоматизирова'':5A ''информац'':4A ''нормативн'':2A ''нормативно-справочн'':1A ''систем'':6A ''справочн'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15501, 'Обеспечение информационной безопасности', '', '''безопасн'':3A ''информацион'':2A ''обеспечен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15502, 'Обладатель информации', '', '''информац'':2A ''обладател'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15503, 'Облачная аналитика', '', '''аналитик'':2A ''облачн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15504, 'Облачные базы данных', '', '''баз'':2A ''дан'':3A ''облачн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15505, 'Облачные технологии', '', '''облачн'':1A ''технолог'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15507, 'Обмен данными', '', '''дан'':2A ''обм'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15508, 'Обобщение знаний', '', '''знан'':2A ''обобщен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15511, 'Обработка информации', '', '''информац'':2A ''обработк'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15512, 'Обработка персональных данных', '', '''дан'':3A ''обработк'':1A ''персональн'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15513, 'Обработка текстовой информации', '', '''информац'':3A ''обработк'':1A ''текстов'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15514, 'Общая база данных об изделиях', 'ОБДИ', '''баз'':2A ''дан'':3A ''издел'':5A ''общ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15515, 'Общая база данных эксплуатационной документации', '', '''баз'':2A ''дан'':3A ''документац'':5A ''общ'':1A ''эксплуатацион'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15516, 'Пакет', '', '''пакет'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15517, 'Пакетная технология', '', '''пакетн'':1A ''технолог'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15518, 'Парадигматические отношения', '', '''отношен'':2A ''парадигматическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15519, 'Параметр качества услуги', '', '''качеств'':2A ''параметр'':1A ''услуг'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15520, 'Параметры информации', '', '''информац'':2A ''параметр'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15521, 'Парсинг', '', '''парсинг'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15522, 'Пассивная оптическая сеть', '', '''оптическ'':2A ''пассивн'':1A ''сет'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15523, 'Патч', '', '''патч'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15524, 'Пертинентность', '', '''пертинентн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15525, 'Пиринговая (одноранговая, децентрализованная) сеть', '', '''децентрализова'':3A ''однорангов'':2A ''пирингов'':1A ''сет'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15527, 'Получатель документов', '', '''документ'':2A ''получател'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15528, 'Разработка АС', '', '''ас'':2A ''разработк'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15530, 'Распределенная база данных', '', '''баз'':2A ''дан'':3A ''распределен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15531, 'Распределенная интеллектуальная сеть', '', '''интеллектуальн'':2A ''распределен'':1A ''сет'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15533, 'Распределенная обработка данных', '', '''дан'':3A ''обработк'':2A ''распределен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15534, 'Режим инцидента', '', '''инцидент'':2A ''реж'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15536, 'Реинжиниринг онтологий', '', '''онтолог'':2A ''реинжиниринг'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15537, 'Реляционная база данных', '', '''баз'':2A ''дан'':3A ''реляцион'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15540, 'Реляционная модель данных', '', '''дан'':3A ''модел'':2A ''реляцион'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15541, 'Ресурс', '', '''ресурс'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15542, 'Ресурсы АС', '', '''ас'':2A ''ресурс'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15543, 'Риски АС', '', '''ас'':2A ''риск'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15544, 'Сбор данных', '', '''дан'':2A ''сбор'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15545, 'Свойство крупномасштабности АС', '', '''ас'':3A ''крупномасштабн'':2A ''свойств'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15546, 'Свойство многоуровневости АС', '', '''ас'':3A ''многоуровнев'':2A ''свойств'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15547, 'Свойство открытости', '', '''открыт'':2A ''свойств'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15548, 'Свойство самоорганизуемости', '', '''самоорганизуем'':2A ''свойств'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15549, 'Свойство слабой предсказуемости', '', '''предсказуем'':3A ''свойств'':1A ''слаб'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15550, 'Свойство сложности', '', '''свойств'':1A ''сложност'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15551, 'Связывание информационных объектов', '', '''информацион'':2A ''объект'':3A ''связыван'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15552, 'Сегмент сети', '', '''сегмент'':1A ''сет'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15553, 'Семантент', '', '''семантент'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15554, 'Семантическая мера информации', '', '''информац'':3A ''мер'':2A ''семантическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15555, 'Семантические технологии', '', '''семантическ'':1A ''технолог'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15558, 'Сервер', '', '''сервер'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15559, 'Сервер приложений', '', '''приложен'':2A ''сервер'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15560, 'Тактико-технические характеристики автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':5A ''войск'':8A ''сил'':9A ''систем'':6A ''тактик'':2A ''тактико-техническ'':1A ''техническ'':3A ''управлен'':7A ''характеристик'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15561, 'Твердотельный накопитель', '', '''накопител'':2A ''твердотельн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15562, 'Телекоммуникационная инфраструктура', '', '''инфраструктур'':2A ''телекоммуникацион'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15563, 'Телекоммуникационное оборудование', '', '''оборудован'':2A ''телекоммуникацион'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15564, 'Тематический поиск', '', '''поиск'':2A ''тематическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15565, 'Термин', '', '''термин'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15566, 'Техническая живучесть АС', '', '''ас'':3A ''живучест'':2A ''техническ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15567, 'Техническая совместимость автоматизированных систем', '', '''автоматизирова'':3A ''сист'':4A ''совместим'':2A ''техническ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15568, 'Техническая совместимость автоматизированной системы управления войсками (силами)', '', '''автоматизирова'':3A ''войск'':6A ''сил'':7A ''систем'':4A ''совместим'':2A ''техническ'':1A ''управлен'':5A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15569, 'Технические характеристики восстановления непрерывности функционирования АС', '', '''ас'':6A ''восстановлен'':3A ''непрерывн'':4A ''техническ'':1A ''функционирован'':5A ''характеристик'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15570, 'Технологии Business Intelligence (BI)', '', '''bi'':4A ''busi'':2A ''intellig'':3A ''технолог'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15571, 'Технологии БД', '', '''бд'':2A ''технолог'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15572, 'Технологии представления знаний', '', '''знан'':3A ''представлен'':2A ''технолог'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15573, 'Технологии распознавания и синтеза речи', '', '''распознаван'':2A ''реч'':5A ''синтез'':4A ''технолог'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15574, 'Технологии формализации знаний', '', '''знан'':3A ''технолог'':1A ''формализац'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15575, 'Угроза', '', '''угроз'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15576, 'Угроза активная', '', '''активн'':2A ''угроз'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15580, 'Угроза (безопасности информации)', '', '''безопасн'':2A ''информац'':3A ''угроз'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15581, 'Угроза пассивная', '', '''пассивн'':2A ''угроз'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15582, 'Узел сети', '', '''сет'':2A ''узел'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15583, 'Умозрительное восприятие информации', '', '''восприят'':2A ''информац'':3A ''умозрительн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15584, 'Унифицированная форма военного документа', 'УФВД', '''воен'':3A ''документ'':4A ''унифицирова'':1A ''форм'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15585, 'Унифицированная форма документа', 'УФД', '''документ'':3A ''унифицирова'':1A ''форм'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15586, 'Унифицированная форма документа по учету сведений военного назначения', '', '''воен'':7A ''документ'':3A ''назначен'':8A ''сведен'':6A ''унифицирова'':1A ''учет'':5A ''форм'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15587, 'Управление базами данных', '', '''баз'':2A ''дан'':3A ''управлен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15588, 'Управление войсками (силами)', '', '''войск'':2A ''сил'':3A ''управлен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15591, 'Управление знаниями', '', '''знан'':2A ''управлен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15592, 'Файловый загрузочный вирус «overwriting»', '', '''overwrit'':4A ''вирус'':3A ''загрузочн'':2A ''файлов'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15593, 'Файлообменная сеть', '', '''сет'':2A ''файлообмен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15594, 'Фактографическая информация', '', '''информац'':2A ''фактографическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15595, 'Фактор, воздействующий на защищаемую информацию', '', '''воздейств'':2A ''защища'':4A ''информац'':5A ''фактор'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15596, 'Физическая защита информации', '', '''защит'':2A ''информац'':3A ''физическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15597, 'Фишинг', '', '''фишинг'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15598, 'Формализация данных', '', '''дан'':2A ''формализац'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15599, 'Формализация информации', '', '''информац'':2A ''формализац'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15600, 'Функциональная живучесть АС', '', '''ас'':3A ''живучест'':2A ''функциональн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15601, 'Функциональная устойчивость', '', '''устойчив'':2A ''функциональн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15602, 'Функция автоматизированной системы', '', '''автоматизирова'':2A ''систем'':3A ''функц'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15605, 'Хакер', '', '''хакер'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15607, 'Хеширование (хэширование)', '', '''хеширован'':1A ''хэширован'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15608, 'Хештег', '', '''хештег'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15610, 'Хеш-функция (хэш-функция)', '', '''функц'':3A,6A ''хеш'':2A ''хеш-функц'':1A ''хэш'':5A ''хэш-функц'':4A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15611, 'Холодное резервирование', '', '''резервирован'':2A ''холодн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15612, 'Хост, узел', '', '''узел'':2A ''хост'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15613, 'Хостинг', '', '''хостинг'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15614, 'Хранение данных как служба', '', '''дан'':2A ''служб'':4A ''хранен'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15615, 'Хранилище данных', '', '''дан'':2A ''хранилищ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15616, 'Хронологический анализ', '', '''анализ'':2A ''хронологическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15617, 'Целостность базы данных', '', '''баз'':2A ''дан'':3A ''целостн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15621, 'Целостность данных', '', '''дан'':2A ''целостн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15627, 'Целостность информации', '', '''информац'':2A ''целостн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15630, 'Целостность системы', '', '''систем'':2A ''целостн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15631, 'Цель защиты информации', '', '''защит'':2A ''информац'':3A ''цел'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15632, 'Ценность информации', '', '''информац'':2A ''ценност'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15633, 'Центр управления АС', '', '''ас'':3A ''управлен'':2A ''центр'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15634, 'Цифровая карта', '', '''карт'':2A ''цифров'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15635, 'Цифровая карта местности', '', '''карт'':2A ''местност'':3A ''цифров'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15636, 'Цифровая сеть с интеграцией служб', '', '''интеграц'':4A ''сет'':2A ''служб'':5A ''цифров'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15637, 'Цифровой сертификат', '', '''сертификат'':2A ''цифров'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15638, 'Цифровые технологии', '', '''технолог'':2A ''цифров'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15639, 'Частная верификация', '', '''верификац'':2A ''частн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15640, 'Частное облако', '', '''облак'':2A ''частн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15641, 'Чистые ИТ-технологии', '', '''ит'':3A ''ит-технолог'':2A ''технолог'':4A ''чист'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15642, 'Чрезвычайное событие', '', '''событ'':2A ''чрезвычайн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15643, 'Чрезвычайный режим работы АС', '', '''ас'':4A ''работ'':3A ''реж'':2A ''чрезвычайн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15644, 'Шелл-доступ', '', '''доступ'':3A ''шелл'':2A ''шелл-доступ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15645, 'Шестой технологический уклад', '', '''технологическ'':2A ''уклад'':3A ''шест'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15646, 'Широковещание', '', '''широковещан'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15647, 'Широковещательный адрес', '', '''адрес'':2A ''широковещательн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15648, 'Широкополосная мультисервисная сеть (All-NGN)', '', '''all-ngn'':4A ''ngn'':6A ''мультисервисн'':2A ''сет'':3A ''широкополосн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15651, 'Шифр, криптосистема', '', '''криптосистем'':2A ''шифр'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15653, 'Шифратор', '', '''шифратор'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15656, 'Шифрование', '', '''шифрован'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15657, 'Шифрование с открытым ключом', '', '''ключ'':4A ''открыт'':3A ''шифрован'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15658, 'Эвоинформатика', '', '''эвоинформатик'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15659, 'Эвристическая информация', '', '''информац'':2A ''эвристическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15660, 'Экспертиза технической документации', '', '''документац'':3A ''техническ'':2A ''экспертиз'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15662, 'Экспертная система', 'ЭС', '''систем'':2A ''экспертн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15663, 'Экспертно-аналитический метод информационного обследования органов военного управления', '', '''аналитическ'':3A ''воен'':8A ''информацион'':5A ''метод'':4A ''обследован'':6A ''орган'':7A ''управлен'':9A ''экспертн'':2A ''экспертно-аналитическ'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15665, 'Эксплойт (эксплоит, сплоит)', '', '''спло'':3A ''экспло'':2A ''эксплойт'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15666, 'Эксплуатационная документация на АС', '', '''ас'':4A ''документац'':2A ''эксплуатацион'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15667, 'Эксплуатационная живучесть АС', '', '''ас'':3A ''живучест'':2A ''эксплуатацион'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15668, 'Эластичность к отказам', '', '''отказ'':3A ''эластичн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15669, 'Электронная библиотека', '', '''библиотек'':2A ''электрон'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15670, 'Электронная карта', 'ЭК', '''карт'':2A ''электрон'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15674, 'Электронная подпись (электронная цифровая подпись)', 'ЭП', '''подп'':2A,5A ''цифров'':4A ''электрон'':1A,3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15675, 'Электронный архив', '', '''арх'':2A ''электрон'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15677, 'Электронный документ', '', '''документ'':2A ''электрон'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15678, 'Электронный документооборот', '', '''документооборот'':2A ''электрон'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15679, 'Явные знания', '', '''знан'':2A ''явн'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15680, 'Язык администрирования базы данных', '', '''администрирован'':2A ''баз'':3A ''дан'':4A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15682, 'Язык базы данных', '', '''баз'':2A ''дан'':3A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15683, 'Язык гипертекстовой разметки HTML', '', '''html'':4A ''гипертекстов'':2A ''разметк'':3A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15684, 'Язык гипертекстовой разметки WML', '', '''wml'':4A ''гипертекстов'':2A ''разметк'':3A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15685, 'Язык гипертекстовой разметки XML', '', '''xml'':4A ''гипертекстов'':2A ''разметк'':3A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15687, 'Язык запросов', '', '''запрос'':2A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15688, 'Язык искусственный', '', '''искусствен'':2A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15690, 'Язык манипулирования данными', '', '''дан'':3A ''манипулирован'':2A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15691, 'Язык описания данных', 'ЯОД', '''дан'':3A ''описан'':2A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15692, 'Язык описания онтологий', '', '''онтолог'':3A ''описан'':2A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15693, 'Язык разметки данных', '', '''дан'':3A ''разметк'':2A ''язык'':1A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15694, '3D-моделирование', '', '''3d'':2A ''3d-моделирование'':1A ''моделирован'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15695, '3D-печать', '', '''3d'':2A ''3d-печать'':1A ''печа'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15696, '3D-сканирование', '', '''3d'':2A ''3d-сканирование'':1A ''сканирован'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15697, '4D-печать', '', '''4d'':2A ''4d-печать'':1A ''печа'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15698, 'Big Table', '', '''big'':1A ''tabl'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15699, 'CALS-технологии', '', '''cal'':2A ''cals-технолог'':1A ''технолог'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15700, 'CASE-технологии', '', '''case'':2A ''case-технолог'':1A ''технолог'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15701, 'CRM системы', '', '''crm'':1A ''систем'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15702, 'ERP системы', '', '''erp'':1A ''систем'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15703, 'IP-телефония', '', '''ip'':2A ''ip-телефон'':1A ''телефон'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15704, 'NoSQL база данных', '', '''nosql'':1A ''баз'':2A ''дан'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15705, 'Open system environment', 'OSE', '''environ'':3A ''open'':1A ''system'':2A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15706, 'SIP-протокол', '', '''sip'':2A ''sip-протокол'':1A ''протокол'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15707, 'SIP-сервер', '', '''sip'':2A ''sip-сервер'':1A ''сервер'':3A');
INSERT INTO slova (id, name, sokr, fts_v) VALUES (15708, 'SQL-сервер', '', '''sql'':2A ''sql-сервер'':1A ''сервер'':3A');


INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16755, 15188, 'Информация, обеспечивающая представление абстрактных сведений, содержащихся в ней в визуально воспринимаемом виде.', '''абстрактн'':4A ''вид'':12A ''визуальн'':10A ''воспринима'':11A ''информац'':1A ''обеспечива'':2A ''представлен'':3A ''сведен'':5A ''содержа'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16756, 15189, 'Модель, отражающая лишь самые общие характеристики моделируемого явления. Чаще всего абстрактная модель дает лишь качественные характеристики моделируемого объекта или явления.', '''абстрактн'':11A ''дает'':13A ''качествен'':15A ''лиш'':3A,14A ''модел'':1A,12A ''моделируем'':7A,17A ''общ'':5A ''объект'':18A ''отража'':2A ''сам'':4A ''характеристик'':6A,16A ''чащ'':9A ''явлен'':8A,20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16757, 15190, 'Процесс, представляющий упрощенное идеализированное описание реальных сущностей предметных областей путем отвлечения от некоторых их характеристик. Этот процесс находит широкое применение в технике программирования, что позволяет представлять некоторые конкретные данные без учета их семантики и применять к ним общие методы обработки.', '''дан'':29A ''идеализирова'':4A ''конкретн'':28A ''метод'':39A ''наход'':18A ''некотор'':13A,27A ''област'':9A ''обработк'':40A ''общ'':38A ''описан'':5A ''отвлечен'':11A ''позволя'':25A ''предметн'':8A ''представля'':2A,26A ''применен'':20A ''применя'':35A ''программирован'':23A ''процесс'':1A,17A ''пут'':10A ''реальн'':6A ''семантик'':33A ''сущност'':7A ''техник'':22A ''упрощен'':3A ''учет'':31A ''характеристик'':15A ''широк'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16758, 15191, 'Режим работы АС (части АС), обусловленный аварией ресурса (ресурсов) и допускающий на время ликвидации последствий аварии выполнение в затронутой части АС только критичных сервисов с понижением их уровня до минимального, предусмотренного для данного типа аварии.', '''авар'':7A,16A,35A ''ас'':3A,5A,21A ''врем'':13A ''выполнен'':17A ''дан'':33A ''допуска'':11A ''затронут'':19A ''критичн'':23A ''ликвидац'':14A ''минимальн'':30A ''обусловлен'':6A ''понижен'':26A ''последств'':15A ''предусмотрен'':31A ''работ'':2A ''реж'':1A ''ресурс'':8A,9A ''сервис'':24A ''тип'':34A ''уровн'':28A ''част'':4A,20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16760, 15193, 'Происшествие, в результате которого повреждена или разрушена техника обработки информации или средства ее защиты, приведшая к потере информации или появлению возможности несанкционированного доступа к ней.', '''возможн'':21A ''доступ'':23A ''защит'':14A ''информац'':10A,18A ''котор'':4A ''несанкционирова'':22A ''обработк'':9A ''поврежд'':5A ''потер'':17A ''появлен'':20A ''приведш'':15A ''происшеств'':1A ''разруш'':7A ''результат'':3A ''средств'':12A ''техник'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17162, 15595, 'Явление, действие или процесс, результатом которых могут быть утечка, искажение, уничтожение защищаемой информации, блокирование доступа к ней.', '''блокирован'':14A ''действ'':2A ''доступ'':15A ''защища'':12A ''информац'':13A ''искажен'':10A ''котор'':6A ''могут'':7A ''процесс'':4A ''результат'':5A ''уничтожен'':11A ''утечк'':9A ''явлен'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16759, 15193, 'Повреждение (в т. ч. и разрушение, исчезновение) ресурса АС, сопровождающееся его отказом и необходимостью проведения работ по его восстановлению (ремонту или замене) на основании типового или уникального проекта. На время ликвидации последствий аварии в затронутой части АС допускается выполнение только критичных сервисов с понижением их уровня до минимального, предусмотренного для данного типа аварии.', '''авар'':33A,53A ''ас'':9A,37A ''восстановлен'':19A ''врем'':30A ''выполнен'':39A ''дан'':51A ''допуска'':38A ''замен'':22A ''затронут'':35A ''исчезновен'':7A ''критичн'':41A ''ликвидац'':31A ''минимальн'':48A ''необходим'':14A ''основан'':24A ''отказ'':12A ''поврежден'':1A ''понижен'':44A ''последств'':32A ''предусмотрен'':49A ''проведен'':15A ''проект'':28A ''работ'':16A ''разрушен'':6A ''ремонт'':20A ''ресурс'':8A ''сервис'':42A ''сопровожда'':10A ''т'':3A ''тип'':52A ''типов'':25A ''уникальн'':27A ''уровн'':46A ''ч'':4A ''част'':36A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16761, 15194, 'Применение программных средств и технологий для сбора, обработки и консолидации разнородной неструктурированной информации — текстовой и аудиовизуальной — из внутренних и внешних источников (базы данных, интернет, файловые системы, корпоративные информационные системы и др.) и ее автоматической аналитической обработки.', '''автоматическ'':34A ''аналитическ'':35A ''аудиовизуальн'':16A ''баз'':22A ''внешн'':20A ''внутрен'':18A ''дан'':23A ''др'':31A ''интернет'':24A ''информац'':13A ''информацион'':28A ''источник'':21A ''консолидац'':10A ''корпоративн'':27A ''неструктурирова'':12A ''обработк'':8A,36A ''применен'':1A ''программн'':2A ''разнородн'':11A ''сбор'':7A ''систем'':26A,29A ''средств'':3A ''текстов'':14A ''технолог'':5A ''файлов'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16764, 15197, 'Организационно-техническая система, обеспечивающая выработку решений на основе автоматизации информационных процессов в различных сферах деятельности (управление, проектирование, производство и т. д.) или их сочетаниях. В процессе функционирования АС представляет собой совокупность комплекса (комплексов) средств автоматизации (КСА), организационно-методических и технических документов и специалистов, использующих их в процессе своей профессиональной деятельности.', '''автоматизац'':10A,36A ''ас'':29A ''выработк'':6A ''д'':22A ''деятельн'':16A,52A ''документ'':43A ''информацион'':11A ''использ'':46A ''комплекс'':33A,34A ''кса'':37A ''методическ'':40A ''обеспечива'':5A ''организацион'':2A,39A ''организационно-методическ'':38A ''организационно-техническ'':1A ''основ'':9A ''представля'':30A ''проектирован'':18A ''производств'':19A ''профессиональн'':51A ''процесс'':12A,27A,49A ''различн'':14A ''решен'':7A ''сво'':50A ''систем'':4A ''соб'':31A ''совокупн'':32A ''сочетан'':25A ''специалист'':45A ''средств'':35A ''сфер'':15A ''т'':21A ''техническ'':3A,42A ''управлен'':17A ''функционирован'':28A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16762, 15195, 'Организация, в которой все функциональные процессы или основные базовые процессы, влияющие на деятельность организации, осуществляются с использованием автоматизированных систем.', '''автоматизирова'':18A ''базов'':9A ''влия'':11A ''деятельн'':13A ''использован'':17A ''котор'':3A ''организац'':1A,14A ''основн'':8A ''осуществля'':15A ''процесс'':6A,10A ''сист'':19A ''функциональн'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17195, 15630, 'Состояние системы, при котором обеспечивается неизменность ее инфраструктуры.', '''инфраструктур'':8A ''котор'':4A ''неизмен'':6A ''обеспечива'':5A ''систем'':2A ''состоян'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16763, 15197, 'Система, состоящая из персонала и комплекса средств автоматизации его деятельности, реализующая информационную технологию выполнения установленных функций.
Примечания:
1 В зависимости от вида деятельности выделяют, например, следующие виды АС: автоматизированные системы управления (АСУ), системы автоматизированного проектирования (САПР), автоматизированные системы научных исследований (АСНИ) и др.
2 В зависимости от вида управляемого объекта (процесса) АСУ делят, например, на АСУ технологическими процессами (АСУТП), АСУ предприятиями (АСУП) и т. д.', '''1'':18A ''2'':44A ''автоматизац'':8A ''автоматизирова'':29A,34A,37A ''ас'':28A,32A,52A,56A,60A ''асн'':41A ''асуп'':62A ''асутп'':59A ''вид'':22A,27A,48A ''выделя'':24A ''выполнен'':14A ''д'':65A ''дел'':53A ''деятельн'':10A,23A ''др'':43A ''зависим'':20A,46A ''информацион'':12A ''исследован'':40A ''комплекс'':6A ''например'':25A,54A ''научн'':39A ''объект'':50A ''персона'':4A ''предприят'':61A ''примечан'':17A ''проектирован'':35A ''процесс'':51A,58A ''реализ'':11A ''сапр'':36A ''систем'':1A,30A,33A,38A ''след'':26A ''состоя'':2A ''средств'':7A ''т'':64A ''технолог'':13A ''технологическ'':57A ''управлен'':31A ''управля'':49A ''установлен'':15A ''функц'':16A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16765, 15198, 'Система, состоящая из персонала и комплекса средств автоматизации, обеспечивающая автоматизацию функций определенных структурных элементов Вооруженных Сил, систем оружия и военной техники.', '''автоматизац'':8A,10A ''воен'':20A ''вооружен'':15A ''комплекс'':6A ''обеспечива'':9A ''определен'':12A ''оруж'':18A ''персона'':4A ''сил'':16A ''сист'':17A ''систем'':1A ''состоя'':2A ''средств'':7A ''структурн'':13A ''техник'':21A ''функц'':11A ''элемент'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16766, 15199, 'Система, которая автоматизирует некоторые операции по смысловому преобразованию текста. Современные системы обработки позволяют создавать краткие обзоры текстов (рефераты) или готовить перевод с одного естественного языка на другой, поиск, расшифровку или уточнение значений слов.', '''автоматизир'':3A ''готов'':20A ''естествен'':24A ''значен'':32A ''котор'':2A ''кратк'':15A ''некотор'':4A ''обзор'':16A ''обработк'':12A ''одн'':23A ''операц'':5A ''перевод'':21A ''позволя'':13A ''поиск'':28A ''преобразован'':8A ''расшифровк'':29A ''реферат'':18A ''систем'':1A,11A ''слов'':33A ''смыслов'':7A ''современ'':10A ''создава'':14A ''текст'':9A,17A ''уточнен'':31A ''язык'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16798, 15231, 'Процесс сбора, обработки и представления информации в окончательном виде. Агрегирование данных в основном выполняется для формирования отчетов, выработки политики, управления здравоохранением, научных исследований, статистического анализа и изучения здоровья населения.', '''агрегирован'':10A ''анализ'':25A ''вид'':9A ''выполня'':14A ''выработк'':18A ''дан'':11A ''здоров'':28A ''здравоохранен'':21A ''изучен'':27A ''информац'':6A ''исследован'':23A ''населен'':29A ''научн'':22A ''обработк'':3A ''окончательн'':8A ''основн'':13A ''отчет'':17A ''политик'':19A ''представлен'':5A ''процесс'':1A ''сбор'':2A ''статистическ'':24A ''управлен'':20A ''формирован'':16A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16807, 15240, 'Лицо, имеющее полное представление о данных, используемых в учреждении (на предприятии), и отвечающее за хранение, обновление и организацию их использования.', '''дан'':6A ''имеющ'':2A ''использован'':20A ''используем'':7A ''лиц'':1A ''обновлен'':16A ''организац'':18A ''отвеча'':13A ''полн'':3A ''предприят'':11A ''представлен'':4A ''учрежден'':9A ''хранен'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16830, 15265, 'Совокупность взаимосвязанных данных, организованных в соответствии со схемой базы данных таким образом, чтобы с ними мог работать пользователь.', '''баз'':9A ''взаимосвяза'':2A ''дан'':3A,10A ''мог'':16A ''ним'':15A ''образ'':12A ''организова'':4A ''пользовател'':18A ''работа'':17A ''совокупн'':1A ''соответств'':6A ''схем'':8A ''так'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16832, 15265, 'Совокупность данных, хранимых в соответствии со схемой данных, манипулирование которыми выполняют в соответствии с правилами средств моделирования данных.', '''выполня'':11A ''дан'':2A,8A,18A ''котор'':10A ''манипулирован'':9A ''моделирован'':17A ''правил'':15A ''совокупн'':1A ''соответств'':5A,13A ''средств'':16A ''схем'':7A ''храним'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16767, 15200, 'АС, в которой любой пользователь может обратиться к ней и получить доступ в рамках своих полномочий к нужным ему ресурсам и услугам за приемлемое для него (пользователя) время. Причем приемлемое время доступа сохраняется не только при существующих нагрузках, но и при ожидаемом их увеличении на заданную перспективу, деградации архитектуры системы, вызванной отказами, массовым уничтожением ее компонентов и (или) целых объектовых комплексов и связей между ними.', '''архитектур'':49A ''ас'':1A ''врем'':28A,31A ''вызва'':51A ''деградац'':48A ''доступ'':12A,32A ''зада'':46A ''комплекс'':61A ''компонент'':56A ''котор'':3A ''люб'':4A ''массов'':53A ''нагрузк'':38A ''ним'':65A ''нужн'':18A ''обрат'':7A ''объектов'':60A ''ожида'':42A ''отказ'':52A ''перспектив'':47A ''полномоч'':16A ''получ'':11A ''пользовател'':5A,27A ''приемлем'':24A,30A ''прич'':29A ''рамк'':14A ''ресурс'':20A ''сво'':15A ''связ'':63A ''систем'':50A ''сохраня'':33A ''существ'':37A ''увеличен'':44A ''уничтожен'':54A ''услуг'':22A ''цел'':59A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16846, 15281, 'Подтверждение посредством представления объективных свидетельств того, что требования, предназначенные для конкретного использования или применения, выполнены.
Примечания:
1 Термин «валидирован» используют для обозначения соответствующего статуса.
2 Условия применения могут быть реальными или смоделированными.', '''1'':17A ''2'':25A ''валидирова'':19A ''выполн'':15A ''использ'':20A ''использован'':12A ''конкретн'':11A ''могут'':28A ''обозначен'':22A ''объективн'':4A ''подтвержден'':1A ''посредств'':2A ''предназначен'':9A ''представлен'':3A ''применен'':14A,27A ''примечан'':16A ''реальн'':30A ''свидетельств'':5A ''смоделирова'':32A ''соответств'':23A ''статус'':24A ''термин'':18A ''требован'':8A ''услов'':26A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16768, 15201, 'Система, состоящая из персонала и комплекса средств автоматизации, в которой осуществляется сбор информации об объектах управления, вырабатываются управляющие воздействия и проводится доведение их до объектов управления с использованием средств вычислительной техники и связи.', '''автоматизац'':8A ''воздейств'':19A ''вырабатыва'':17A ''вычислительн'':30A ''доведен'':22A ''информац'':13A ''использован'':28A ''комплекс'':6A ''котор'':10A ''объект'':15A,25A ''осуществля'':11A ''персона'':4A ''провод'':21A ''сбор'':12A ''связ'':33A ''систем'':1A ''состоя'':2A ''средств'':7A,29A ''техник'':31A ''управлен'':16A,26A ''управля'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16769, 15202, 'Составная часть автоматизированной системы управления Вооруженными Силами, обеспечивающая деятельность органов военного управления по поддержанию боевой готовности и боевой способности войск (сил), подготовке операций и боевых действий и руководству ими при выполнении поставленных задач.', '''автоматизирова'':3A ''боев'':15A,18A,25A ''воен'':11A ''войск'':20A ''вооружен'':6A ''выполнен'':31A ''готовн'':16A ''действ'':26A ''деятельн'':9A ''задач'':33A ''им'':29A ''обеспечива'':8A ''операц'':23A ''орган'':10A ''подготовк'':22A ''поддержан'':14A ''поставлен'':32A ''руководств'':28A ''сил'':7A,21A ''систем'':4A ''составн'':1A ''способн'':19A ''управлен'':5A,12A ''част'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16848, 15281, 'Подтверждение путем проверки и предоставления объективных доказательств выполнения особых требований к конкретному предусмотренному применению, а также того, что все требования выполняются надлежащим образом и в полном объеме, и что обеспечивается прослеживание выполнения системных требований.', '''выполнен'':8A,32A ''выполня'':21A ''доказательств'':7A ''конкретн'':12A ''надлежа'':22A ''обеспечива'':30A ''образ'':23A ''объективн'':6A ''объем'':27A ''особ'':9A ''подтвержден'':1A ''полн'':26A ''предоставлен'':5A ''предусмотрен'':13A ''применен'':14A ''проверк'':3A ''прослеживан'':31A ''пут'':2A ''системн'':33A ''такж'':16A ''требован'':10A,20A,34A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16875, 15308, 'Косвенное описание местоположения пространственного объекта путем его соотнесения с позиционированным объектом.
Примечание — Местоположение геокодированного объекта обычно описывается через географическое название, почтовый адрес, почтовый код и другие идентификационные и адресные характеристики какого-либо позиционированного объекта.', '''адрес'':22A ''адресн'':29A ''географическ'':19A ''геокодирова'':14A ''друг'':26A ''идентификацион'':27A ''как'':32A ''какого-либ'':31A ''код'':24A ''косвен'':1A ''либ'':33A ''местоположен'':3A,13A ''назван'':20A ''объект'':5A,11A,15A,35A ''обычн'':16A ''описан'':2A ''описыва'':17A ''позиционирова'':10A,34A ''почтов'':21A,23A ''примечан'':12A ''пространствен'':4A ''пут'':6A ''соотнесен'':8A ''характеристик'':30A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16872, 15305, 'Автоматизированная информационная система, предназначенная для обработки данных о пространственно-временных характеристиках объектов системы навигационного обеспечения, для их хранения и отображения на терминалах пользователей с использованием технологий цифровых карт местности.', '''автоматизирова'':1A ''времен'':11A ''дан'':7A ''информацион'':2A ''использован'':26A ''карт'':29A ''местност'':30A ''навигацион'':15A ''обеспечен'':16A ''обработк'':6A ''объект'':13A ''отображен'':21A ''пользовател'':24A ''предназначен'':4A ''пространствен'':10A ''пространственно-времен'':9A ''систем'':3A,14A ''терминал'':23A ''технолог'':27A ''характеристик'':12A ''хранен'':19A ''цифров'':28A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16770, 15203, 'Автоматизированная система, представляющая собой совокупность автоматизированных систем высшего звена управления и автоматизированных систем управления войсками (силами), обеспечивающая управление Вооруженными Силами Российской Федерации в мирное и военное время.', '''автоматизирова'':1A,6A,12A ''воен'':26A ''войск'':15A ''вооружен'':19A ''врем'':27A ''высш'':8A ''звен'':9A ''мирн'':24A ''обеспечива'':17A ''представля'':3A ''российск'':21A ''сил'':16A,20A ''сист'':7A,13A ''систем'':2A ''соб'':4A ''совокупн'':5A ''управлен'':10A,14A,18A ''федерац'':22A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16771, 15204, 'Система, определяющая систематические процессы, благодаря которым создаются, сохраняются, распределяются и применяются основные элементы интеллектуального капитала, необходимые для успеха организации; задается стратегия, трансформирующая все виды интеллектуальных активов в более высокую производительность, эффективность и новую стоимость.', '''актив'':26A ''благодар'':5A ''вид'':24A ''высок'':29A ''зада'':20A ''интеллектуальн'':14A,25A ''капита'':15A ''котор'':6A ''необходим'':16A ''нов'':33A ''определя'':2A ''организац'':19A ''основн'':12A ''применя'':11A ''производительн'':30A ''процесс'':4A ''распределя'':9A ''систем'':1A ''систематическ'':3A ''созда'':7A ''сохраня'':8A ''стоимост'':34A ''стратег'':21A ''трансформир'':22A ''успех'':18A ''элемент'':13A ''эффективн'':31A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16895, 15329, 'Лексическая единица, выраженная информативным словом (вербально) или кодом и являющаяся именем класса синонимичных или близких по смыслу ключевых слов.
Примечание — Дескрипторы используются для координатного индексирования документов и информационных запросов с целью последующего поиска.', '''близк'':15A ''вербальн'':6A ''выражен'':3A ''дескриптор'':21A ''документ'':26A ''единиц'':2A ''запрос'':29A ''имен'':11A ''индексирован'':25A ''информативн'':4A ''информацион'':28A ''использ'':22A ''класс'':12A ''ключев'':18A ''код'':8A ''координатн'':24A ''лексическ'':1A ''поиск'':33A ''послед'':32A ''примечан'':20A ''синонимичн'':13A ''слов'':5A,19A ''смысл'':17A ''цел'':31A ''явля'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16896, 15329, 'Описатель, элемент информационной структуры объекта, указывающий, в каком виде запоминается та или иная информация (например, в массиве записи или файле). Обратившись к дескриптору, программа получает возможность интерпретировать характеризуемые им данные.', '''вид'':9A ''возможн'':26A ''дан'':30A ''дескриптор'':23A ''запис'':18A ''запомина'':10A ''ин'':13A ''интерпретирова'':27A ''информац'':14A ''информацион'':3A ''как'':8A ''массив'':17A ''например'':15A ''обрат'':21A ''объект'':5A ''описател'':1A ''получа'':25A ''программ'':24A ''структур'':4A ''та'':11A ''указыва'':6A ''файл'':20A ''характеризуем'':28A ''элемент'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16903, 15337, 'В широком смысле — специальным образом упорядоченную совокупность всей информации, имеющейся в Федеральных органах исполнительной власти (ФОИВ), в узком смысле — как совокупность информационных ресурсов ФОИВ, упорядоченную по единым принципам и правилам формирования, формализации, хранения, распространения информации.', '''власт'':15A ''все'':8A ''един'':27A ''имеющ'':10A ''информац'':9A,35A ''информацион'':22A ''исполнительн'':14A ''образ'':5A ''орган'':13A ''правил'':30A ''принцип'':28A ''распространен'':34A ''ресурс'':23A ''смысл'':3A,19A ''совокупн'':7A,21A ''специальн'':4A ''узк'':18A ''упорядочен'':6A,25A ''федеральн'':12A ''фо'':16A,24A ''формализац'':32A ''формирован'':31A ''хранен'':33A ''широк'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16772, 15205, 'Комплекс аппаратных и программных средств, информационных систем и информационно-телекоммуникационных сетей, предназначенных для решения задач оперативного управления и контроля за различными процессами и техническими объектами в рамках организации производства или технологического процесса критически важного объекта, нарушение (или прекращение) функционирования которых может нанести вред внешнеполитическим интересам Российской Федерации, стать причиной аварий и катастроф, массовых беспорядков, длительных остановок транспорта, производственных или технологических процессов, дезорганизации работы учреждений, предприятий или организаций, нанесения материального ущерба в крупном размере, смерти или нанесения тяжкого вреда здоровью хотя бы одного человека и (или) иных тяжелых последствий.', '''авар'':51A ''аппаратн'':2A ''беспорядк'':55A ''важн'':35A ''внешнеполитическ'':45A ''вред'':44A,79A ''дезорганизац'':63A ''длительн'':56A ''задач'':16A ''здоров'':80A ''ин'':87A ''интерес'':46A ''информацион'':6A,10A ''информационно-телекоммуникацион'':9A ''катастроф'':53A ''комплекс'':1A ''контрол'':20A ''котор'':41A ''критическ'':34A ''крупн'':73A ''массов'':54A ''материальн'':70A ''нанесен'':69A,77A ''нанест'':43A ''нарушен'':37A ''объект'':26A,36A ''одн'':83A ''оперативн'':17A ''организац'':29A,68A ''остановок'':57A ''последств'':89A ''предназначен'':13A ''предприят'':66A ''прекращен'':39A ''причин'':50A ''программн'':4A ''производств'':30A ''производствен'':59A ''процесс'':23A,33A,62A ''работ'':64A ''различн'':22A ''размер'':74A ''рамк'':28A ''решен'':15A ''российск'':47A ''сет'':12A ''сист'':7A ''смерт'':75A ''средств'':5A ''стат'':49A ''телекоммуникацион'':11A ''техническ'':25A ''технологическ'':32A,61A ''транспорт'':58A ''тяжел'':88A ''тяжк'':78A ''управлен'':18A ''учрежден'':65A ''ущерб'':71A ''федерац'':48A ''функционирован'':40A ''хот'':81A ''человек'':84A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16773, 15206, 'Процесс построения досье на некоторый информационный объект (как правило, лицо или организацию). Досье строится на основе имеющихся данных в базе фактографической информации на момент его построения. Для требуемых досье устанавливается режим мониторинга, при котором вся вновь поступающая фактографическая информация соотносится с существующим досье. Если выявляются связи, то новые объекты добавляются в досье автоматически.', '''автоматическ'':53A ''баз'':20A ''внов'':36A ''вся'':35A ''выявля'':45A ''дан'':18A ''добавля'':50A ''дос'':3A,13A,29A,43A,52A ''имеющ'':17A ''информац'':22A,39A ''информацион'':6A ''котор'':34A ''лиц'':10A ''момент'':24A ''мониторинг'':32A ''некотор'':5A ''нов'':48A ''объект'':7A,49A ''организац'':12A ''основ'':16A ''построен'':2A,26A ''поступа'':37A ''прав'':9A ''процесс'':1A ''реж'':31A ''связ'':46A ''соотнос'':40A ''стро'':14A ''существ'':42A ''требуем'':28A ''устанавлива'':30A ''фактографическ'':21A,38A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16904, 15337, 'Совокупность хранимых и обрабатываемых в узлах информационного пространства информационных ресурсов (о предметной области предприятии, компании, организации и др.), между которыми обеспечена необходимая интеграция данных и возможность полноценного поиска и целенаправленного обмена данными по принципу «каждый с каждым» в реальном масштабе времени на основе соответствующих информационно-телекоммуникационных технологий, реализуемых аппаратно-программными средствами с учетом применения международных, государственных, ведомственных и отраслевых стандартов, спецификаций, унифицированных организационно-нормативных документов и обеспечения взаимодействия и устойчивого доступа полномочных пользователей к ресурсам и ИТ-услугам системы.', '''аппаратн'':51A ''аппаратно-программн'':50A ''ведомствен'':59A ''взаимодейств'':71A ''возможн'':26A ''времен'':41A ''государствен'':58A ''дан'':24A,32A ''документ'':68A ''доступ'':74A ''др'':18A ''интеграц'':23A ''информацион'':7A,9A,46A ''информационно-телекоммуникацион'':45A ''ит'':81A ''ит-услуг'':80A ''кажд'':35A,37A ''компан'':15A ''котор'':20A ''масштаб'':40A ''международн'':57A ''необходим'':22A ''нормативн'':67A ''обеспеч'':21A ''обеспечен'':70A ''област'':13A ''обм'':31A ''обрабатыва'':4A ''организац'':16A ''организацион'':66A ''организационно-нормативн'':65A ''основ'':43A ''отраслев'':61A ''поиск'':28A ''полномочн'':75A ''полноцен'':27A ''пользовател'':76A ''предметн'':12A ''предприят'':14A ''применен'':56A ''принцип'':34A ''программн'':52A ''пространств'':8A ''реализуем'':49A ''реальн'':39A ''ресурс'':10A,78A ''систем'':83A ''совокупн'':1A ''соответств'':44A ''спецификац'':63A ''средств'':53A ''стандарт'':62A ''телекоммуникацион'':47A ''технолог'':48A ''узл'':6A ''унифицирова'':64A ''услуг'':82A ''устойчив'':73A ''учет'':55A ''храним'':2A ''целенаправлен'':30A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16955, 15388, 'Уровень взаимосвязи открытых систем, обеспечивающий услуги по обмену данными между логическими объектами сетевого уровня, протокол управления звеном данных, формирование и передачу кадров данных.', '''взаимосвяз'':2A ''дан'':9A,18A,23A ''звен'':17A ''кадр'':22A ''логическ'':11A ''обеспечива'':5A ''обмен'':8A ''объект'':12A ''открыт'':3A ''передач'':21A ''протокол'':15A ''сетев'':13A ''сист'':4A ''управлен'':16A ''уровен'':1A ''уровн'':14A ''услуг'':6A ''формирован'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16939, 15372, 'Процесс обработки информации об известных индивидах, а именно их отождествления с имеющимися эталонами и получения новой информации о них (закон тождества).', '''закон'':20A ''известн'':5A ''имен'':8A ''имеющ'':12A ''индивид'':6A ''информац'':3A,17A ''нов'':16A ''обработк'':2A ''отождествлен'':10A ''получен'':15A ''процесс'':1A ''тождеств'':21A ''эталон'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17196, 15630, 'Качество системы, которым она обладает, если корректно выполняет все свои функции, свободна от намеренных или случайных несанкционированных манипуляций.', '''выполня'':8A ''качеств'':1A ''корректн'':7A ''котор'':3A ''манипуляц'':18A ''намерен'':14A ''несанкционирова'':17A ''облада'':5A ''сво'':10A ''свободн'':12A ''систем'':2A ''случайн'':16A ''функц'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16774, 15207, 'Программно-технический комплекс АС, предназначенный для автоматизации деятельности должностных лиц. Видами АРМ, например, являются АРМ руководителя, АРМ оператора-исполнителя, АРМ инженера, АРМ проектировщика и т. п.', '''автоматизац'':8A ''арм'':13A,16A,18A,22A,24A ''ас'':5A ''вид'':12A ''деятельн'':9A ''должностн'':10A ''инженер'':23A ''исполнител'':21A ''комплекс'':4A ''лиц'':11A ''например'':14A ''оператор'':20A ''оператора-исполнител'':19A ''п'':28A ''предназначен'':6A ''программн'':2A ''программно-техническ'':1A ''проектировщик'':25A ''руководител'':17A ''т'':27A ''техническ'':3A ''явля'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16775, 15208, 'Совокупность программных и технических средств, обеспечивающих выполнение функциональных обязанностей должностным лицом органа военного управления в автоматизированном режиме.', '''автоматизирова'':16A ''воен'':13A ''выполнен'':7A ''должностн'':10A ''лиц'':11A ''обеспечива'':6A ''обязан'':9A ''орга'':12A ''программн'':2A ''режим'':17A ''совокупн'':1A ''средств'':5A ''техническ'':4A ''управлен'':14A ''функциональн'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16776, 15209, 'Гибкие адаптированные к знание-ориентированной обработке больших потоков неструктурированной информации с элементами искусственного интеллекта с настройкой на класс управляемых объектов с реализацией на супер-ЭВМ, объединенных в единую информационно-телекоммуникационную сеть.', '''адаптирова'':2A ''больш'':8A ''гибк'':1A ''един'':30A ''знан'':5A ''знание-ориентирова'':4A ''интеллект'':15A ''информац'':11A ''информацион'':32A ''информационно-телекоммуникацион'':31A ''искусствен'':14A ''класс'':19A ''настройк'':17A ''неструктурирова'':10A ''обработк'':7A ''объединен'':28A ''объект'':21A ''ориентирова'':6A ''поток'':9A ''реализац'':23A ''сет'':34A ''супер'':26A ''супер-эвм'':25A ''телекоммуникацион'':33A ''управля'':20A ''эвм'':27A ''элемент'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16978, 15411, 'Поиск с помощью стационарных электронных словарей или он-лайн словарей. Сюда относятся: поиск по ключевому слову/ словосочетанию без уточнения или ограничения поиска, поиск по ключевому слову/ словосочетанию в кавычках, использование уточняющих слов, использование масок.', '''использован'':31A,34A ''кавычк'':30A ''ключев'':16A,26A ''лайн'':10A ''масок'':35A ''ограничен'':22A ''он-лайн'':8A ''относ'':13A ''поиск'':1A,14A,23A,24A ''помощ'':3A ''слов'':17A,27A,33A ''словар'':6A,11A ''словосочетан'':18A,28A ''стационарн'':4A ''сюд'':12A ''уточнен'':20A ''уточня'':32A ''электрон'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16777, 15210, 'Объект или процесс, реализуемый с использованием средств вычислительной техники и связи.', '''вычислительн'':8A ''использован'':6A ''объект'':1A ''процесс'':3A ''реализуем'':4A ''связ'':11A ''средств'':7A ''техник'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16989, 15422, 'Единица разбиения физического диска. Состоит из последовательно расположенных физических секторов. Внутренняя структура логического диска определяется типом файловой структуры (FAT, NTFS или др.). На одном физическом диске могут быть «нарезаны» несколько логических дисков (например, FAT и NTFS). Логическим дискам ставятся в соответствие заглавные символы (А:, В:, С:, D: и т. д.). Логические диски могут быть «сжатыми», т. е. доступными не напрямую, а только через специальную программу типа DoubleSpace. Логический диск С: играет особую роль – он является загрузочным логическим диском, на нем же находятся в виде файлов специальной структуры «сжатые» логические диски, поэтому многие вирусы стараются разрушить именно логический диск C:.', '''c'':99A ''d'':47A ''doublespac'':67A ''fat'':19A,34A ''ntfs'':20A,36A ''вид'':84A ''вирус'':93A ''внутрен'':11A ''д'':50A ''диск'':4A,14A,26A,32A,38A,52A,69A,78A,90A,98A ''доступн'':58A ''др'':22A ''е'':57A ''единиц'':1A ''заглавн'':42A ''загрузочн'':76A ''игра'':71A ''имен'':96A ''логическ'':13A,31A,37A,51A,68A,77A,89A,97A ''мног'':92A ''могут'':27A,53A ''например'':33A ''напрям'':60A ''нареза'':29A ''наход'':82A ''нем'':80A ''нескольк'':30A ''одн'':24A ''определя'':15A ''особ'':72A ''последовательн'':7A ''поэт'':91A ''программ'':65A ''разбиен'':2A ''разруш'':95A ''расположен'':8A ''рол'':73A ''сектор'':10A ''сжат'':55A,88A ''символ'':43A ''соответств'':41A ''состо'':5A ''специальн'':64A,86A ''став'':39A ''стара'':94A ''структур'':12A,18A,87A ''т'':49A,56A ''тип'':16A,66A ''файл'':85A ''файлов'':17A ''физическ'':3A,9A,25A ''явля'':75A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16981, 15414, 'Совокупность логико-семантических средств и правил формализованного описания естественного языка в целях повышения эффективности машинной обработки информационных объектов, используемых в АС при ее функционировании. К логико-семантическим средствам относятся разного рода формализованные словари лексических терминов и их определений, онтологические тезаурусы, классификаторы, рубрикаторы и другие языковые средства, используемые для описания содержания обрабатываемой информации. К правилам относятся формализованные процедуры (метаданные, метазнания), методические рекомендации, содержащие дополнительную информацию, гарантирующую осмысленность обработки данных (знаний) и интероперабельность пользователей и различных систем между собой.', '''ас'':22A ''гарантир'':67A ''дан'':70A ''дополнительн'':65A ''друг'':46A ''естествен'':10A ''знан'':71A ''интероперабельн'':73A ''информац'':54A,66A ''информацион'':18A ''используем'':20A,49A ''классификатор'':43A ''лексическ'':36A ''логик'':3A,28A ''логико-семантическ'':2A,27A ''машин'':16A ''метада'':60A ''метазнан'':61A ''методическ'':62A ''обрабатыва'':53A ''обработк'':17A,69A ''объект'':19A ''онтологическ'':41A ''описан'':9A,51A ''определен'':40A ''осмыслен'':68A ''относ'':31A,57A ''повышен'':14A ''пользовател'':74A ''прав'':7A ''правил'':56A ''процедур'':59A ''различн'':76A ''разн'':32A ''рекомендац'':63A ''род'':33A ''рубрикатор'':44A ''семантическ'':4A,29A ''сист'':77A ''словар'':35A ''соб'':79A ''совокупн'':1A ''содержа'':64A ''содержан'':52A ''средств'':5A,30A,48A ''тезаурус'':42A ''термин'':37A ''формализова'':8A,34A,58A ''функционирован'':25A ''цел'':13A ''эффективн'':15A ''язык'':11A ''языков'':47A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17003, 15436, 'Функциональное устройство, которое устанавливает маршрут через одну или несколько вычислительных сетей.
Примечание — В вычислительных сетях, соответствующих моделям ВОС, маршрутизатор функционирует на сетевом уровне.', '''вос'':18A ''вычислительн'':10A,14A ''котор'':3A ''маршрут'':5A ''маршрутизатор'':19A ''модел'':17A ''нескольк'':9A ''одн'':7A ''примечан'':12A ''сет'':11A,15A ''сетев'':22A ''соответств'':16A ''уровн'':23A ''устанавлива'':4A ''устройств'':2A ''функциональн'':1A ''функционир'':20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16778, 15212, 'Контролируемый словарь терминов на естественном языке, явно указывающий отношения между терминами и предназначенный для информационного поиска. Используется для автоматического и/или контролируемого индексирования.', '''автоматическ'':19A ''естествен'':5A ''индексирован'':23A ''информацион'':15A ''использ'':17A ''контролируем'':1A,22A ''отношен'':9A ''поиск'':16A ''предназначен'':13A ''словар'':2A ''термин'':3A,11A ''указыва'':8A ''явн'':7A ''язык'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16779, 15212, 'Нормативный онтологический словарь, находящийся в памяти ЭВМ, с зафиксированными в нем логико-семантическими отношениями лексических единиц и предназначенный для автоматической обработки и поиска информации по запросам.', '''автоматическ'':21A ''единиц'':17A ''запрос'':27A ''зафиксирова'':9A ''информац'':25A ''лексическ'':16A ''логик'':13A ''логико-семантическ'':12A ''находя'':4A ''нем'':11A ''нормативн'':1A ''обработк'':22A ''онтологическ'':2A ''отношен'':15A ''памят'':6A ''поиск'':24A ''предназначен'':19A ''семантическ'':14A ''словар'':3A ''эвм'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17012, 15445, 'Система математических зависимостей и логических правил, позволяющая с достаточной полнотой и точностью воспроизводить во времени наиболее существенные составляющие моделируемых боевых действий и рассчитывать на основе этого численные значения показателей прогнозируемого хода и исхода боевых действий.', '''боев'':20A,34A ''воспроизвод'':13A ''времен'':15A ''действ'':21A,35A ''достаточн'':9A ''зависим'':3A ''значен'':28A ''исход'':33A ''логическ'':5A ''математическ'':2A ''моделируем'':19A ''наибол'':16A ''основ'':25A ''позволя'':7A ''показател'':29A ''полнот'':10A ''прав'':6A ''прогнозируем'':30A ''рассчитыва'':23A ''систем'':1A ''составля'':18A ''существен'':17A ''точност'':12A ''ход'':31A ''числен'':27A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16780, 15213, 'Процесс перевода текстов с одних естественных языков на другие с использованием компьютерных технологий, моделирующих деятельность человека-переводчика.', '''деятельн'':15A ''друг'':9A ''естествен'':6A ''использован'':11A ''компьютерн'':12A ''моделир'':14A ''одн'':5A ''перевод'':2A ''переводчик'':18A ''процесс'':1A ''текст'':3A ''технолог'':13A ''человек'':17A ''человека-переводчик'':16A ''язык'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16781, 15214, 'Процесс, осуществляемый при совместном участии человека и средств автоматизации.', '''автоматизац'':9A ''осуществля'':2A ''процесс'':1A ''совместн'':4A ''средств'':8A ''участ'':5A ''человек'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16782, 15215, 'Операция, которая заключается в том, что из данного текста на естественном языке извлекается содержащаяся в этом тексте лексическая, грамматическая и семантическая информация, выполняемая по определенному алгоритму в соответствии с заранее разработанным описанием данного языка.', '''алгоритм'':26A ''выполня'':23A ''грамматическ'':19A ''дан'':8A,33A ''естествен'':11A ''заключа'':3A ''заран'':30A ''извлека'':13A ''информац'':22A ''котор'':2A ''лексическ'':18A ''операц'':1A ''описан'':32A ''определен'':25A ''разработа'':31A ''семантическ'':21A ''содержа'':14A ''соответств'':28A ''текст'':9A,17A ''язык'':12A,34A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16783, 15216, 'Операция, в которой по заданной грамматической и семантической информации строится содержащий эту информацию текст на естественном языке. Операция выполняется по некоторому алгоритму в соответствии с заранее разработанным описанием данного языка.', '''алгоритм'':22A ''выполня'':19A ''грамматическ'':6A ''дан'':29A ''естествен'':16A ''зада'':5A ''заран'':26A ''информац'':9A,13A ''котор'':3A ''некотор'':21A ''операц'':1A,18A ''описан'':28A ''разработа'':27A ''семантическ'':8A ''содержа'':11A ''соответств'':24A ''стро'':10A ''текст'':14A ''язык'':17A,30A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16784, 15217, 'Объект или процесс, реализуемый с использованием средств вычислительной техники и связи без вмешательства человека.', '''вмешательств'':13A ''вычислительн'':8A ''использован'':6A ''объект'':1A ''процесс'':3A ''реализуем'':4A ''связ'':11A ''средств'':7A ''техник'':9A ''человек'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16785, 15218, 'Процесс выделения важных тематических терминов в тексте для последующего поиска и обработки документа.', '''важн'':3A ''выделен'':2A ''документ'':13A ''обработк'':12A ''поиск'':10A ''послед'':9A ''процесс'':1A ''текст'':7A ''тематическ'':4A ''термин'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17022, 15455, 'Формат файла или потоковый формат (поток необязательно должен быть сохранен в виде файла), чьи спецификации определяют только способ сохранения данных, но не алгоритм кодирования, в пределах одного файла. Медиаконтейнер определяет, сколько метаданных фактически может быть сохранено, вместе с тем он не определяет никакую кодификацию самих данных. Медиаконтейнер фактически является метаформатом, так как он хранит данные и информацию о том, как данные будут сохраняться непосредственно внутри файла.', '''алгоритм'':23A ''будут'':62A ''вид'':12A ''вмест'':37A ''внутр'':65A ''дан'':20A,46A,55A,61A ''долж'':8A ''информац'':57A ''кодирован'':24A ''кодификац'':44A ''медиаконтейнер'':29A,47A ''метада'':32A ''метаформат'':50A ''необязательн'':7A ''непосредствен'':64A ''никак'':43A ''одн'':27A ''определя'':16A,30A,42A ''поток'':6A ''потоков'':4A ''предел'':26A ''сам'':45A ''скольк'':31A ''сохран'':10A,36A ''сохранен'':19A ''сохраня'':63A ''спецификац'':15A ''способ'':18A ''файл'':2A,13A,28A,66A ''фактическ'':33A,48A ''формат'':1A,5A ''хран'':54A ''чьи'':14A ''явля'':49A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16786, 15219, 'Описание проекта в виде граф-схемы алгоритма функционирования объекта проектирования.', '''алгоритм'':8A ''вид'':4A ''граф'':6A ''граф-схем'':5A ''объект'':10A ''описан'':1A ''проект'':2A ''проектирован'':11A ''схем'':7A ''функционирован'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16787, 15220, 'Комплекс математических, программных, технических, информационных, лингвистических, организационно-технологических средств и персонала, предназначенный для управления различными объектами, функционирующий независимо от основной системы управления АС.', '''ас'':24A ''информацион'':5A ''комплекс'':1A ''лингвистическ'':6A ''математическ'':2A ''независим'':19A ''объект'':17A ''организацион'':8A ''организационно-технологическ'':7A ''основн'':21A ''персона'':12A ''предназначен'':13A ''программн'':3A ''различн'':16A ''систем'':22A ''средств'':10A ''техническ'':4A ''технологическ'':9A ''управлен'':15A,23A ''функционир'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16788, 15225, 'Предоставление прав доступа.', '''доступ'':3A ''прав'':2A ''предоставлен'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16789, 15225, 'Определение типов действий, разрешенных данному пользователю. Обычно разрешение находится в контексте установления подлинности.', '''дан'':5A ''действ'':3A ''контекст'':11A ''наход'':9A ''обычн'':7A ''определен'':1A ''подлин'':13A ''пользовател'':6A ''разрешен'':4A,8A ''тип'':2A ''установлен'':12A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17028, 15461, 'Мощная многопроцессорная высокопроизводительная ЭВМ с весьма значительным объемом оперативной и внешней памяти, которая выполняет функции сервера в развитых локальных вычислительных сетях (ЛВС) с большим числом периферийных ЭВМ и терминалов (например, ЛВС больших организаций, фирм, учебных заведений и т. д.).', '''больш'':24A,32A ''весьм'':6A ''внешн'':11A ''выполня'':14A ''высокопроизводительн'':3A ''вычислительн'':20A ''д'':39A ''заведен'':36A ''значительн'':7A ''котор'':13A ''лвс'':22A,31A ''локальн'':19A ''многопроцессорн'':2A ''мощн'':1A ''например'':30A ''объем'':8A ''оперативн'':9A ''организац'':33A ''памят'':12A ''периферийн'':26A ''развит'':18A ''сервер'':16A ''сет'':21A ''т'':38A ''терминал'':29A ''учебн'':35A ''фирм'':34A ''функц'':15A ''числ'':25A ''эвм'':4A,27A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17027, 15461, 'Большой универсальный высокопроизводительный отказоустойчивый сервер со значительными ресурсами ввода-вывода, большим объемом оперативной и внешней памяти, предназначенный для использования в критически важных системах с интенсивной пакетной и оперативной транзакционной обработкой.', '''больш'':1A,12A ''важн'':23A ''ввод'':10A ''ввода-вывод'':9A ''внешн'':16A ''вывод'':11A ''высокопроизводительн'':3A ''значительн'':7A ''интенсивн'':26A ''использован'':20A ''критическ'':22A ''обработк'':31A ''объем'':13A ''оперативн'':14A,29A ''отказоустойчив'':4A ''пакетн'':27A ''памят'':17A ''предназначен'':18A ''ресурс'':8A ''сервер'':5A ''систем'':24A ''транзакцион'':30A ''универсальн'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16790, 15225, 'Предоставление прав доступа субъекту или объекту к системе и ее ресурсам.', '''доступ'':3A ''объект'':6A ''прав'':2A ''предоставлен'':1A ''ресурс'':11A ''систем'':8A ''субъект'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16791, 15225, 'Представление субъекту некоторых прав доступа к информации.', '''доступ'':5A ''информац'':7A ''некотор'':3A ''прав'':4A ''представлен'':1A ''субъект'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16792, 15225, 'Предоставление субъекту прав на доступ, а также предоставление доступа в соответствии с установленными правами на доступ.', '''доступ'':5A,9A,16A ''прав'':3A,14A ''предоставлен'':1A,8A ''соответств'':11A ''субъект'':2A ''такж'':7A ''установлен'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16793, 15226, 'Определение и установление степени приватности данных в базе данных.', '''баз'':8A ''дан'':6A,9A ''определен'':1A ''приватн'':5A ''степен'':4A ''установлен'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16794, 15227, 'Установление ограничения на доступ к системной или пользовательской программе со стороны других программ и пользователей.', '''доступ'':4A ''друг'':12A ''ограничен'':2A ''пользовател'':15A ''пользовательск'':8A ''программ'':9A,13A ''системн'':6A ''сторон'':11A ''установлен'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16795, 15228, 'Комплекс мероприятий, проводимых разработчиком с участием изготовителя и заказчика АС, связанных с непосредственным надзором за качеством изделий, входящих в состав АС, в течение всего времени ее эксплуатации.', '''ас'':10A,21A ''времен'':25A ''входя'':18A ''заказчик'':9A ''изготовител'':7A ''издел'':17A ''качеств'':16A ''комплекс'':1A ''мероприят'':2A ''надзор'':14A ''непосредствен'':13A ''проводим'':3A ''разработчик'':4A ''связа'':11A ''соста'':20A ''течен'':23A ''участ'':6A ''эксплуатац'':27A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16796, 15229, 'Комплекс мероприятий, проводимых разработчиком с участием изготовителя и заказчика автоматизированной системы управления войсками (силами), связанных с непосредственным надзором за качеством изделий, входящих в состав автоматизированной системы, в течение всего времени ее эксплуатации.', '''автоматизирова'':10A,25A ''войск'':13A ''времен'':30A ''входя'':22A ''заказчик'':9A ''изготовител'':7A ''издел'':21A ''качеств'':20A ''комплекс'':1A ''мероприят'':2A ''надзор'':18A ''непосредствен'':17A ''проводим'':3A ''разработчик'':4A ''связа'':15A ''сил'':14A ''систем'':11A,26A ''соста'':24A ''течен'':28A ''управлен'':12A ''участ'':6A ''эксплуатац'':32A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16797, 15230, 'Способ накопления, систематизации, поиска и совместного использования контента вокруг определенного набора интересов какого-либо сегмента пользователей с целью упрощения поиска контента.', '''вокруг'':9A ''интерес'':12A ''использован'':7A ''как'':14A ''какого-либ'':13A ''контент'':8A,22A ''либ'':15A ''набор'':11A ''накоплен'':2A ''определен'':10A ''поиск'':4A,21A ''пользовател'':17A ''сегмент'':16A ''систематизац'':3A ''совместн'':6A ''способ'':1A ''упрощен'':20A ''цел'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17031, 15464, 'Комплексное свойство АСУ войсками (силами) сохранять во времени в установленных пределах значения всех параметров, характеризующих способность АСУ войсками (силами) выполнять свои функции в заданных режимах и условиях эксплуатации.
Примечание — Надежность АСУ войсками (силами) включает свойства безотказности и ремонтопригодности АСУ войсками (силами), а в некоторых случаях и долговечности технических средств.', '''ас'':3A,17A,31A,39A ''безотказн'':36A ''включа'':34A ''войск'':4A,18A,32A,40A ''времен'':8A ''выполня'':20A ''долговечн'':47A ''зада'':24A ''значен'':12A ''комплексн'':1A ''надежн'':30A ''некотор'':44A ''параметр'':14A ''предел'':11A ''примечан'':29A ''режим'':25A ''ремонтопригодн'':38A ''сво'':21A ''свойств'':2A,35A ''сил'':5A,19A,33A,41A ''случа'':45A ''сохраня'':6A ''способн'':16A ''средств'':49A ''техническ'':48A ''услов'':27A ''установлен'':10A ''функц'':22A ''характериз'':15A ''эксплуатац'':28A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17199, 15632, 'Свойство информации, определяемое ее пригодностью к практическому использованию в различных областях целенаправленной деятельности человека.', '''деятельн'':13A ''информац'':2A ''использован'':8A ''област'':11A ''определя'':3A ''практическ'':7A ''пригодн'':5A ''различн'':10A ''свойств'':1A ''целенаправлен'':12A ''человек'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16799, 15232, 'Приспособление программных средств к условиям функционирования, не предусмотренным при разработке.
Примечание — Адаптация заключается в доработке программного средства без изменения его основных функций.', '''адаптац'':12A ''доработк'':15A ''заключа'':13A ''изменен'':19A ''основн'':21A ''предусмотрен'':8A ''примечан'':11A ''приспособлен'':1A ''программн'':2A,16A ''разработк'':10A ''средств'':3A,17A ''услов'':5A ''функц'':22A ''функционирован'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16800, 15233, 'Внесение изменений, осуществляемых исключительно в целях обеспечения функционирования программы для ЭВМ или базы данных на конкретных технических средствах пользователя или под управлением конкретных программ пользователя.', '''баз'':13A ''внесен'':1A ''дан'':14A ''изменен'':2A ''исключительн'':4A ''конкретн'':16A,23A ''обеспечен'':7A ''осуществля'':3A ''пользовател'':19A,25A ''программ'':9A,24A ''средств'':18A ''техническ'':17A ''управлен'':22A ''функционирован'':8A ''цел'':6A ''эвм'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16801, 15234, 'Способность АС изменяться для сохранения своих эксплуатационных показателей в заданных пределах при изменениях внешней среды.', '''ас'':2A ''внешн'':14A ''зада'':10A ''изменен'':13A ''изменя'':3A ''показател'':8A ''предел'':11A ''сво'':6A ''сохранен'':5A ''способн'':1A ''сред'':15A ''эксплуатацион'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16802, 15235, 'Уровень соответствия образа, создаваемого с помощью информации, реальному объекту, процессу, явлению. От степени адекватности информации зависит правильность принятия решения.', '''адекватн'':14A ''завис'':16A ''информац'':7A,15A ''образ'':3A ''объект'':9A ''помощ'':6A ''правильн'':17A ''принят'':18A ''процесс'':10A ''реальн'':8A ''решен'':19A ''создава'':4A ''соответств'':2A ''степен'':13A ''уровен'':1A ''явлен'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16803, 15236, 'Совокупность свойств программного средства, характеризующая наличие и степень достаточности обеспечиваемых им функций для решения задач в соответствии с его назначением.', '''достаточн'':9A ''задач'':15A ''назначен'':20A ''налич'':6A ''обеспечива'':10A ''программн'':3A ''решен'':14A ''свойств'':2A ''совокупн'':1A ''соответств'':17A ''средств'':4A ''степен'':8A ''функц'':12A ''характериз'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16804, 15237, 'Меры по разработке реализации политики защиты АСУ ВС, поддержанию уровня защиты АСУ ВС на этапах эксплуатации.', '''ас'':7A,12A ''вс'':8A,13A ''защит'':6A,11A ''мер'':1A ''поддержан'':9A ''политик'':5A ''разработк'':3A ''реализац'':4A ''уровн'':10A ''эксплуатац'':16A ''этап'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16805, 15240, 'Специальное должностное лицо (группа лиц), имеющее полное представление о базе данных и отвечающее за ее ведение, использование и развитие.', '''баз'':10A ''веден'':16A ''групп'':4A ''дан'':11A ''должностн'':2A ''имеющ'':6A ''использован'':17A ''лиц'':3A,5A ''отвеча'':13A ''полн'':7A ''представлен'':8A ''развит'':19A ''специальн'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16808, 15241, 'Субъект доступа, ответственный за защиту автоматизированной системы от несанкционированного доступа к информации.', '''автоматизирова'':6A ''доступ'':2A,10A ''защит'':5A ''информац'':12A ''несанкционирова'':9A ''ответствен'':3A ''систем'':7A ''субъект'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16809, 15242, 'Сотрудник службы защиты автоматизированной системы управления войсками (силами), ответственный за поддержание в установленный период времени достигнутого уровня защиты автоматизированной системы управления войсками (силами) на этапах ее эксплуатации.', '''автоматизирова'':4A,19A ''войск'':7A,22A ''времен'':15A ''достигнут'':16A ''защит'':3A,18A ''ответствен'':9A ''период'':14A ''поддержан'':11A ''сил'':8A,23A ''систем'':5A,20A ''служб'':2A ''сотрудник'':1A ''управлен'':6A,21A ''уровн'':17A ''установлен'':13A ''эксплуатац'':27A ''этап'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16810, 15243, 'Человек (или группа людей), имеющий(их) полное представление об одной или нескольких системах обеспечения безопасности и контролирующий(их) проектирование и их использование.', '''безопасн'':15A ''групп'':3A ''имеющ'':5A ''использован'':22A ''контролир'':17A ''люд'':4A ''нескольк'':12A ''обеспечен'':14A ''одн'':10A ''полн'':7A ''представлен'':8A ''проектирован'':19A ''систем'':13A ''человек'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16806, 15240, 'Лицо, отвечающее за выработку требований к базе данных, ее проектирование, реализацию, эффективное использование и сопровождение, включая управление учетными записями пользователей БД, защиту от несанкционированного доступа, поддержку целостности базы данных.', '''баз'':7A,28A ''бд'':21A ''включ'':16A ''выработк'':4A ''дан'':8A,29A ''доступ'':25A ''запис'':19A ''защит'':22A ''использован'':13A ''лиц'':1A ''несанкционирова'':24A ''отвеча'':2A ''поддержк'':26A ''пользовател'':20A ''проектирован'':10A ''реализац'':11A ''сопровожден'':15A ''требован'':5A ''управлен'':17A ''учетн'':18A ''целостн'':27A ''эффективн'':12A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16811, 15244, 'Выполнение функций определения, организации, управления и защиты данных в базе.', '''баз'':10A ''выполнен'':1A ''дан'':8A ''защит'':7A ''определен'':3A ''организац'':4A ''управлен'':5A ''функц'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16812, 15245, 'Уникальный идентификатор, присваиваемый сети или сетевому устройству для того, чтобы другие сети и устройства могли распознать его при обмене информацией. Адрес может быть как логическим, так и физическим. Примером логического адреса может служить IP-адрес, примером физического — МАС-адрес.', '''ip'':35A ''ip-адрес'':34A ''адрес'':21A,31A,36A,41A ''друг'':11A ''идентификатор'':2A ''информац'':20A ''логическ'':25A,30A ''мас'':40A ''мас-адрес'':39A ''могл'':15A ''обмен'':19A ''пример'':29A,37A ''присваива'':3A ''распозна'':16A ''сет'':4A,12A ''сетев'':6A ''служ'':33A ''уникальн'':1A ''устройств'':7A,14A ''физическ'':28A,38A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16813, 15246, 'Официальное признание правомочий осуществлять какую-либо деятельность в области сертификации защищенных изделий, технических средств и способов защиты информации.', '''деятельн'':8A ''защит'':18A ''защищен'':12A ''издел'':13A ''информац'':19A ''как'':6A ''какую-либ'':5A ''либ'':7A ''област'':10A ''осуществля'':4A ''официальн'':1A ''правомоч'':3A ''признан'':2A ''сертификац'':11A ''способ'':17A ''средств'':15A ''техническ'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16814, 15247, 'Мониторинг ИТ-услуги или конфигурационной единицы, использующий автоматизированные регулярные проверки для отслеживания текущего статуса объекта мониторинга.', '''автоматизирова'':9A ''единиц'':7A ''использ'':8A ''ит'':3A ''ит-услуг'':2A ''конфигурацион'':6A ''мониторинг'':1A,17A ''объект'':16A ''отслеживан'':13A ''проверк'':11A ''регулярн'':10A ''статус'':15A ''текущ'':14A ''услуг'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16815, 15248, 'В компьютерных науках модель акторов представляет собой математическую модель параллельных вычислений, которая трактует понятие «актор» как универсальный примитив параллельного численного расчета. В ответ на сообщения, которые он получает, актор может принимать локальные решения, создавать новых акторов, посылать свои сообщения, а также устанавливать, как следует реагировать на последующие сообщения.', '''актор'':5A,15A,29A,36A ''вычислен'':11A ''компьютерн'':2A ''котор'':12A,26A ''локальн'':32A ''математическ'':8A ''модел'':4A,9A ''наук'':3A ''нов'':35A ''ответ'':23A ''параллельн'':10A,19A ''получа'':28A ''понят'':14A ''послед'':47A ''посыла'':37A ''представля'':6A ''примит'':18A ''принима'':31A ''расчет'':21A ''реагирова'':45A ''решен'':33A ''сво'':38A ''след'':44A ''соб'':7A ''создава'':34A ''сообщен'':25A,39A,48A ''такж'':41A ''тракт'':13A ''универсальн'':17A ''устанавлива'':42A ''числен'':20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16816, 15249, 'Процесс, обеспечивающий постоянное внесение текущих изменений в состояние системы, базы данных или базы знаний.', '''баз'':10A,13A ''внесен'':4A ''дан'':11A ''знан'':14A ''изменен'':6A ''обеспечива'':2A ''постоя'':3A ''процесс'':1A ''систем'':9A ''состоян'':8A ''текущ'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17040, 15473, 'Нарушение средств управления специфической частью информационной системы, отвечающей за контроль целостности информации и доступа к системе. Может быть как преднамеренное в результате неправомерных действий злоумышленника, так и в результате сбоя в работе отдельных программ или технических компонентов системы. В любом случае следствием является облегчение доступа к информации или нарушение информации в результате неверной (неконтролируемой) работы программного обеспечения защиты данных от изменений.', '''дан'':59A ''действ'':24A ''доступ'':14A,45A ''защит'':58A ''злоумышленник'':25A ''изменен'':61A ''информац'':12A,47A,50A ''информацион'':6A ''компонент'':37A ''контрол'':10A ''люб'':40A ''нарушен'':1A,49A ''неверн'':53A ''неконтролируем'':54A ''неправомерн'':23A ''обеспечен'':57A ''облегчен'':44A ''отвеча'':8A ''отдельн'':33A ''преднамерен'':20A ''программ'':34A ''программн'':56A ''работ'':32A,55A ''результат'':22A,29A,52A ''сбо'':30A ''систем'':7A,16A,38A ''следств'':42A ''случа'':41A ''специфическ'':4A ''средств'':2A ''техническ'':36A ''управлен'':3A ''целостн'':11A ''част'':5A ''явля'':43A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17045, 15479, 'Свойство, используемое в базах данных и знаний и заключающееся в том, что если две информационные единицы соединены между собой отношениями типа «род-вид» или «класс-элемент», то информация, общая для всех видов, входящих в род, или для всех элементов, входящих в класс, содержится в информационной единице более высокого уровня и при необходимости наследуется единицей более низкого уровня. Наследование позволяет ликвидировать дублирование в хранении информации в базах данных и знаний.', '''баз'':4A,68A ''вид'':24A,34A ''входя'':35A,42A ''высок'':50A ''дан'':5A,69A ''две'':14A ''дублирован'':63A ''единиц'':16A,48A,56A ''заключа'':9A ''знан'':7A,71A ''информац'':30A,66A ''информацион'':15A,47A ''используем'':2A ''класс'':27A,44A ''класс-элемент'':26A ''ликвидирова'':62A ''наслед'':55A ''наследован'':60A ''необходим'':54A ''низк'':58A ''общ'':31A ''отношен'':20A ''позволя'':61A ''род'':23A,37A ''род-вид'':22A ''свойств'':1A ''соб'':19A ''содерж'':45A ''соедин'':17A ''тип'':21A ''уровн'':51A,59A ''хранен'':65A ''элемент'':28A,41A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17049, 15482, 'Показатель или совокупность показателей, характеризующая степень соответствия технических и экономических характеристик АСУ войсками (силами) современным достижениям науки и техники.', '''ас'':12A ''войск'':13A ''достижен'':16A ''наук'':17A ''показател'':1A,4A ''сил'':14A ''совокупн'':3A ''современ'':15A ''соответств'':7A ''степен'':6A ''техник'':19A ''техническ'':8A ''характериз'':5A ''характеристик'':11A ''экономическ'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17042, 15476, 'Физическое лицо или логический объект, случайно или преднамеренно совершивший действие, следствием которого является нарушение информационной безопасности организации.', '''безопасн'':16A ''действ'':10A ''информацион'':15A ''котор'':12A ''лиц'':2A ''логическ'':4A ''нарушен'':14A ''объект'':5A ''организац'':17A ''преднамерен'':8A ''следств'':11A ''случайн'':6A ''соверш'':9A ''физическ'':1A ''явля'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17050, 15483, 'Комплекс интегрированных информационных систем, предназначенный для предоставления органам исполнительной власти различного уровня, органам местного самоуправления, коммерческим организациям и физическим лицам услуг по модели облачных вычислений.', '''власт'':10A ''вычислен'':25A ''интегрирова'':2A ''информацион'':3A ''исполнительн'':9A ''коммерческ'':16A ''комплекс'':1A ''лиц'':20A ''местн'':14A ''модел'':23A ''облачн'':24A ''орган'':8A,13A ''организац'':17A ''предназначен'':5A ''предоставлен'':7A ''различн'':11A ''самоуправлен'':15A ''сист'':4A ''уровн'':12A ''услуг'':21A ''физическ'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16817, 15250, 'Поддержание данных в актуальном состоянии, т. е. приведение их в соответствие с состоянием отображаемых объектов предметной области. Актуализация включает в себя операции добавления, исключения, а также редактирования (в том числе — правки или исправления) записей.', '''актуализац'':18A ''актуальн'':4A ''включа'':19A ''дан'':2A ''добавлен'':23A ''е'':7A ''запис'':34A ''исключен'':24A ''исправлен'':33A ''област'':17A ''объект'':15A ''операц'':22A ''отобража'':14A ''поддержан'':1A ''правк'':31A ''предметн'':16A ''приведен'':8A ''редактирован'':27A ''соответств'':11A ''состоян'':5A,13A ''т'':6A ''такж'':26A ''числ'':30A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17052, 15486, 'Функциональные возможности программного обеспечения, не описанные или не соответствующие описанным в документации, при использовании которых возможно нарушение конфиденциальности, доступности или целостности обрабатываемой информации.
Реализацией недекларированных возможностей, в частности, являются программные закладки.', '''возможн'':2A,16A,26A ''документац'':12A ''доступн'':19A ''закладк'':31A ''информац'':23A ''использован'':14A ''конфиденциальн'':18A ''котор'':15A ''нарушен'':17A ''недекларирова'':25A ''обеспечен'':4A ''обрабатыва'':22A ''описа'':6A,10A ''программн'':3A,30A ''реализац'':24A ''соответств'':9A ''функциональн'':1A ''целостн'':21A ''частност'':28A ''явля'':29A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17056, 15489, 'Устройство переработки информации на основе принципов работы естественных нейронных систем. Проблематика нейрокомпьютеров заключается в построении реальных физических устройств, что позволит не просто моделировать искусственные нейронные сети на обычном компьютере, но так изменить принципы работы компьютера, что станет возможным говорить о том, что они работают в соответствии с теорией искусственных нейронных сетей.', '''возможн'':38A ''говор'':39A ''естествен'':8A ''заключа'':13A ''измен'':32A ''информац'':3A ''искусствен'':24A,49A ''компьютер'':29A,35A ''моделирова'':23A ''нейрокомпьютер'':12A ''нейрон'':9A,25A,50A ''обычн'':28A ''основ'':5A ''переработк'':2A ''позвол'':20A ''построен'':15A ''принцип'':6A,33A ''проблематик'':11A ''прост'':22A ''работ'':7A,34A ''работа'':44A ''реальн'':16A ''сет'':26A,51A ''сист'':10A ''соответств'':46A ''станет'':37A ''теор'':48A ''устройств'':1A,18A ''физическ'':17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17061, 15494, 'Рисковое событие, связанное с неблагоприятными внешними событиями природного и техногенного характера, а также с действиями субъектов (групп субъектов), приводящими к невозможности функционирования организации или ее служб/подразделений в обычном, регламентируемом соответствующими стандартами режиме.', '''внешн'':6A ''групп'':17A ''действ'':15A ''неблагоприятн'':5A ''невозможн'':21A ''обычн'':29A ''организац'':23A ''подразделен'':27A ''приводя'':19A ''природн'':8A ''регламентируем'':30A ''режим'':33A ''рисков'':1A ''связа'':3A ''служб'':26A ''событ'':2A,7A ''соответств'':31A ''стандарт'':32A ''субъект'':16A,18A ''такж'':13A ''техноген'':10A ''функционирован'':22A ''характер'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16818, 15251, 'Свойство информации (в том числе подлежащей последующей функциональной обработке или полученной в результате обработки) отражать текущее состояние объектов и процессов прикладной области информационной системы со степенью приближения, достаточной для получения на ее основе достоверной выходной информации в интересах конечного пользователя. Актуальность характеризует старение информации во времени.', '''актуальн'':41A ''времен'':46A ''выходн'':35A ''достаточн'':28A ''достоверн'':34A ''интерес'':38A ''информац'':2A,36A,44A ''информацион'':23A ''конечн'':39A ''област'':22A ''обработк'':9A,14A ''объект'':18A ''основ'':33A ''отража'':15A ''подлежа'':6A ''получен'':11A,30A ''пользовател'':40A ''послед'':7A ''приближен'':27A ''прикладн'':21A ''процесс'':20A ''результат'':13A ''свойств'':1A ''систем'':24A ''состоян'':17A ''старен'':43A ''степен'':26A ''текущ'':16A ''функциональн'':8A ''характериз'':42A ''числ'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16819, 15255, 'Совокупность четко определенных правил и последовательности их применения, предназначенных для решения задач.', '''задач'':12A ''определен'':3A ''последовательн'':6A ''прав'':4A ''предназначен'':9A ''применен'':8A ''решен'':11A ''совокупн'':1A ''четк'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17072, 15505, 'Технологии обработки данных, в которых компьютерные ресурсы предоставляются Интернет-пользователю как онлайн-сервис. Слово «облако» здесь присутствует как метафора, олицетворяющая сложную инфраструктуру, скрывающую за собой все технические детали.
Примечание — Особенностью облачных технологий является не привязанность к аппаратной платформе и географической территории, а возможность масштабируемости. Клиент может работать с облачными сервисами с любой точки планеты и с любого устройства, имеющего доступ в интернет, а также оперативно реагировать на изменяющиеся бизнес-задачи предприятия и потребности рынка.', '''аппаратн'':39A ''бизнес'':72A ''бизнес-задач'':71A ''возможн'':45A ''географическ'':42A ''дан'':3A ''дета'':30A ''доступ'':62A ''задач'':73A ''изменя'':70A ''имеющ'':61A ''интернет'':10A,64A ''интернет-пользовател'':9A ''инфраструктур'':24A ''клиент'':47A ''компьютерн'':6A ''котор'':5A ''люб'':54A,59A ''масштабируем'':46A ''метафор'':21A ''облак'':17A ''облачн'':33A,51A ''обработк'':2A ''олицетворя'':22A ''онлайн'':14A ''онлайн-сервис'':13A ''оперативн'':67A ''особен'':32A ''планет'':56A ''платформ'':40A ''пользовател'':11A ''потребн'':76A ''предоставля'':8A ''предприят'':74A ''привязан'':37A ''примечан'':31A ''присутств'':19A ''работа'':49A ''реагирова'':68A ''ресурс'':7A ''рынк'':77A ''сервис'':15A,52A ''скрыва'':25A ''слов'':16A ''сложн'':23A ''соб'':27A ''такж'':66A ''территор'':43A ''техническ'':29A ''технолог'':1A,34A ''точк'':55A ''устройств'':60A ''явля'':35A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17074, 15507, 'Передача данных между логическими объектами уровня в соответствии с установленным протоколом.', '''дан'':2A ''логическ'':4A ''объект'':5A ''передач'':1A ''протокол'':11A ''соответств'':8A ''уровн'':6A ''установлен'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17079, 15512, 'Действие или совокупность действий с персональными данными, с помощью или без помощи средств вычислительный техники, включая сбор, накопление, систематизацию, хранение, уточнение или изменение, извлечение, консультирование, использование, распространение (в том числе передачу или иное предоставление доступа), сверку или комбинирование, блокирование, удаление или уничтожение.', '''блокирован'':39A ''включ'':16A ''вычислительн'':14A ''дан'':7A ''действ'':1A,4A ''доступ'':35A ''извлечен'':24A ''изменен'':23A ''ин'':33A ''использован'':26A ''комбинирован'':38A ''консультирован'':25A ''накоплен'':18A ''передач'':31A ''персональн'':6A ''помощ'':9A,12A ''предоставлен'':34A ''распространен'':27A ''сбор'':17A ''сверк'':36A ''систематизац'':19A ''совокупн'':3A ''средств'':13A ''техник'':15A ''удален'':40A ''уничтожен'':42A ''уточнен'':21A ''хранен'':20A ''числ'':30A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16820, 15255, 'Упорядоченный конечный набор четко определенных правил для решения задач за конечное количество шагов.', '''задач'':9A ''количеств'':12A ''конечн'':2A,11A ''набор'':3A ''определен'':5A ''прав'':6A ''решен'':8A ''упорядочен'':1A ''четк'':4A ''шаг'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16821, 15255, 'Формальное предписание, однозначно определяющее содержание и последовательность операций, переводящих совокупность исходных данных в искомый результат.', '''дан'':12A ''иском'':14A ''исходн'':11A ''однозначн'':3A ''операц'':8A ''определя'':4A ''переводя'':9A ''последовательн'':7A ''предписан'':2A ''результат'':15A ''совокупн'':10A ''содержан'':5A ''формальн'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16822, 15255, 'Конечное упорядоченное множество точно определенных правил для решения конкретной задачи.', '''задач'':10A ''конечн'':1A ''конкретн'':9A ''множеств'':3A ''определен'':5A ''прав'':6A ''решен'':8A ''точн'':4A ''упорядочен'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17068, 15501, 'Осуществление взаимоувязанных правовых, организационных, оперативно-розыскных, разведывательных, контрразведывательных, научно-технических, информационно-аналитических, кадровых, экономических и иных мер по прогнозированию, обнаружению, сдерживанию, предотвращению, отражению информационных угроз и ликвидации последствий их проявления.', '''аналитическ'':15A ''взаимоувяза'':2A ''ин'':19A ''информацион'':14A,27A ''информационно-аналитическ'':13A ''кадров'':16A ''контрразведывательн'':9A ''ликвидац'':30A ''мер'':20A ''научн'':11A ''научно-техническ'':10A ''обнаружен'':23A ''оперативн'':6A ''оперативно-розыскн'':5A ''организацион'':4A ''осуществлен'':1A ''отражен'':26A ''последств'':31A ''правов'':3A ''предотвращен'':25A ''прогнозирован'':22A ''проявлен'':33A ''разведывательн'':8A ''розыскн'':7A ''сдерживан'':24A ''техническ'':12A ''угроз'':28A ''экономическ'':17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16823, 15256, 'Алгоритм маршрутизации, используемый для определения связующего дерева с кратчайшим путем. Иногда называется алгоритмом Дейкстры и часто используется в алгоритмах маршрутизации по состоянию связи.', '''алгоритм'':1A,13A,19A ''дейкстр'':14A ''дерев'':7A ''использ'':17A ''используем'':3A ''кратчайш'':9A ''маршрутизац'':2A,20A ''называ'':12A ''определен'':5A ''пут'':10A ''связ'':6A,23A ''состоян'':22A ''част'':16A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16824, 15257, 'Процесс определения наиболее предпочтительного пути пакета к адресату на основании данных таблиц маршрутизации. Простейшие алгоритмы маршрутизации выбирают путь с наименьшим числом переходов (транзитных узлов), например, протокол RIP (Routing Information Protocol); более сложные учитывают задержку, пропускную способность или реальную стоимость различных физических или логических каналов связи, например, IGRP (Interior Gateway Routing Protocol).', '''gateway'':49A ''igrp'':47A ''inform'':29A ''interior'':48A ''protocol'':30A,51A ''rip'':27A ''rout'':28A,50A ''адресат'':8A ''алгоритм'':15A ''выбира'':17A ''дан'':11A ''задержк'':34A ''канал'':44A ''логическ'':43A ''маршрутизац'':13A,16A ''наибол'':3A ''наименьш'':20A ''например'':25A,46A ''определен'':2A ''основан'':10A ''пакет'':6A ''переход'':22A ''предпочтительн'':4A ''пропускн'':35A ''прост'':14A ''протокол'':26A ''процесс'':1A ''пут'':5A,18A ''различн'':40A ''реальн'':38A ''связ'':45A ''сложн'':32A ''способн'':36A ''стоимост'':39A ''таблиц'':12A ''транзитн'':23A ''узл'':24A ''учитыва'':33A ''физическ'':41A ''числ'':21A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16825, 15258, 'Алгоритм, задающий условия и последовательность действий компонентов автоматизированной системы при выполнении ею своих функций.', '''автоматизирова'':8A ''алгоритм'':1A ''выполнен'':11A ''действ'':6A ''е'':12A ''зада'':2A ''компонент'':7A ''последовательн'':5A ''сво'':13A ''систем'':9A ''услов'':3A ''функц'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16826, 15259, 'Набор математических правил, определяющих содержание и последовательность операций, зависящих от ключевой переменной (ключ шифрования), по преобразованию исходной формы представления информации (открытый текст) к виду, обладающему секретом обратного преобразования (зашифрованный текст).', '''вид'':24A ''завися'':9A ''зашифрова'':29A ''информац'':20A ''исходн'':17A ''ключ'':13A ''ключев'':11A ''математическ'':2A ''набор'':1A ''облада'':25A ''обратн'':27A ''операц'':8A ''определя'':4A ''открыт'':21A ''перемен'':12A ''последовательн'':7A ''прав'':3A ''представлен'':19A ''преобразован'':16A,28A ''секрет'':26A ''содержан'':5A ''текст'':22A,30A ''форм'':18A ''шифрован'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17081, 15514, 'Часть ИИС — хранилище ИО, содержащих в произвольном формате информацию, требуемую для выпуска и поддержки технической документации, необходимой на всех стадиях ЖЦИ, для всех изделий, выпускаемых предприятием. Каждый ИО в ОБДИ идентифицируется уникальным кодом и может быть извлечен из ОБДИ для выполнения действий с ним.
ОБДИ обеспечивает информационное обслуживание и поддержку деятельности:
– заказчиков (владельцев) изделия;
– разработчиков (конструкторов), технологов, управленческого и производственного персонала предприятия-изготовителя;
– эксплуатационного и ремонтного персонала заказчика.
ОБДИ может состоять из нескольких разделов:
– нормативно-справочного;
– долговременного;
– актуального.', '''актуальн'':80A ''владельц'':53A ''выполнен'':41A ''выпуск'':12A ''выпуска'':25A ''действ'':42A ''деятельн'':51A ''документац'':16A ''долговремен'':79A ''жци'':21A ''заказчик'':52A,69A ''и'':4A,28A ''идентифицир'':31A ''извлеч'':37A ''изготовител'':64A ''издел'':24A,54A ''иис'':2A ''информац'':9A ''информацион'':47A ''кажд'':27A ''код'':33A ''конструктор'':56A ''необходим'':17A ''нескольк'':74A ''нормативн'':77A ''нормативно-справочн'':76A ''обд'':30A,39A,45A,70A ''обеспечива'':46A ''обслуживан'':48A ''персона'':61A,68A ''поддержк'':14A,50A ''предприят'':26A,63A ''предприятия-изготовител'':62A ''производствен'':60A ''произвольн'':7A ''раздел'':75A ''разработчик'':55A ''ремонтн'':67A ''содержа'':5A ''состоя'':72A ''справочн'':78A ''стад'':20A ''техническ'':15A ''технолог'':57A ''требуем'':10A ''уникальн'':32A ''управленческ'':58A ''формат'':8A ''хранилищ'':3A ''част'':1A ''эксплуатацион'':65A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17086, 15519, 'Количественная оценка характеристики услуги, полученная в результате измерений и/или опросов пользователей, с помощью которой оценивается показатель качества услуги.', '''измерен'':8A ''качеств'':18A ''количествен'':1A ''котор'':15A ''опрос'':11A ''оценива'':16A ''оценк'':2A ''показател'':17A ''получен'':5A ''пользовател'':12A ''помощ'':14A ''результат'':7A ''услуг'':4A,19A ''характеристик'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17087, 15520, 'Количественные и качественные характеристики информации, по которым ее можно оценить, классифицировать свойства информации. К этим свойствам относят содержание, качество, источник, охват, время, соответствие потребностям, язык, способ фиксации, стоимость.', '''врем'':22A ''информац'':5A,13A ''источник'':20A ''качеств'':19A ''качествен'':3A ''классифицирова'':11A ''количествен'':1A ''котор'':7A ''относ'':17A ''охват'':21A ''оцен'':10A ''потребн'':24A ''свойств'':12A,16A ''содержан'':18A ''соответств'':23A ''способ'':26A ''стоимост'':28A ''фиксац'':27A ''характеристик'':4A ''эт'':15A ''язык'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16827, 15260, 'Изложение информации в виде информационных образований, соединенных или расположенных в определенной логической последовательности.', '''вид'':4A ''изложен'':1A ''информац'':2A ''информацион'':5A ''логическ'':12A ''образован'':6A ''определен'':11A ''последовательн'':13A ''расположен'':9A ''соединен'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16828, 15261, 'Систематическое использование информации для выявления угроз безопасности информации, уязвимостей информационной системы и количественной оценки вероятностей реализации угроз с использованием уязвимостей и последствий реализации угроз для информации и информационной системы, предназначенной для обработки этой информации.', '''безопасн'':7A ''вероятн'':15A ''выявлен'':5A ''информац'':3A,8A,26A,34A ''информацион'':10A,28A ''использован'':2A,19A ''количествен'':13A ''обработк'':32A ''оценк'':14A ''последств'':22A ''предназначен'':30A ''реализац'':16A,23A ''систем'':11A,29A ''систематическ'':1A ''угроз'':6A,17A,24A ''уязвим'':9A,20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17113, 15546, 'Наличие в АС множества разнородных, но соподчиненных уровней общесистемного, системного и регионального, а также функциональных и обеспечивающих подсистем, КСА, технического, информационного, лингвистического и программного обеспечения.', '''ас'':3A ''информацион'':21A ''кса'':19A ''лингвистическ'':22A ''множеств'':4A ''налич'':1A ''обеспечен'':25A ''обеспечива'':17A ''общесистемн'':9A ''подсист'':18A ''программн'':24A ''разнородн'':5A ''региональн'':12A ''системн'':10A ''соподчинен'':7A ''такж'':14A ''техническ'':20A ''уровн'':8A ''функциональн'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17102, 15536, 'Извлечение знаний из онтологии для концептуализации предметной области и создание другой онтологии. Реинжиниринг онтологий в значительной мере опирается на методы реинжиниринга программного обеспечения и, по существу, адаптирует их к области проектирования онтологий.', '''адаптир'':27A ''знан'':2A ''значительн'':16A ''извлечен'':1A ''концептуализац'':6A ''мер'':17A ''метод'':20A ''обеспечен'':23A ''област'':8A,30A ''онтолог'':4A,12A,14A,32A ''опира'':18A ''предметн'':7A ''программн'':22A ''проектирован'':31A ''реинжиниринг'':13A,21A ''создан'':10A ''существ'':26A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16829, 15265, 'Совокупность данных, организованных по определенным правилам, предусматривающим общие принципы описания, хранения и манипулирования данными, независимая от прикладных программ.', '''дан'':2A,14A ''манипулирован'':13A ''независим'':15A ''общ'':8A ''описан'':10A ''определен'':5A ''организова'':3A ''правил'':6A ''предусматрива'':7A ''прикладн'':17A ''принцип'':9A ''программ'':18A ''совокупн'':1A ''хранен'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17092, 15525, 'Оверлейная компьютерная сеть, основанная на равноправии участников. Часто в такой сети отсутствуют выделенные серверы, а каждый узел (peer) является как клиентом, так и выполняет функции сервера. В отличие от архитектуры клиент-сервера, такая организация позволяет сохранять работоспособность сети при любом количестве и любом сочетании доступных узлов. Участниками сети являются пиры.', '''peer'':18A ''архитектур'':30A ''выделен'':13A ''выполня'':24A ''доступн'':46A ''кажд'':16A ''клиент'':21A,32A ''клиент-сервер'':31A ''количеств'':42A ''компьютерн'':2A ''люб'':41A,44A ''оверлейн'':1A ''организац'':35A ''основа'':4A ''отлич'':28A ''отсутств'':12A ''пир'':51A ''позволя'':36A ''работоспособн'':38A ''равноправ'':6A ''сервер'':14A,26A,33A ''сет'':3A,11A,39A,49A ''сохраня'':37A ''сочетан'':45A ''так'':34A ''узел'':17A ''узл'':47A ''участник'':7A,48A ''функц'':25A ''част'':8A ''явля'':19A,50A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17106, 15540, 'Структура данных, в которой данные представляются как таблицы соотношений.', '''дан'':2A,5A ''котор'':4A ''представля'':6A ''соотношен'':9A ''структур'':1A ''таблиц'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17107, 15540, 'Модель данных для представления данных с реляционной структурой.', '''дан'':2A,5A ''модел'':1A ''представлен'':4A ''реляцион'':7A ''структур'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17109, 15542, 'Совокупность технических, программных, телекоммуникационных и/или информационных ресурсов АС, предоставляемая должностным лицам подразделений организации или должностным лицам взаимодействующих с ним организаций для использования в функциональной деятельности.', '''ас'':9A ''взаимодейств'':18A ''деятельн'':26A ''должностн'':11A,16A ''информацион'':7A ''использован'':23A ''лиц'':12A,17A ''организац'':14A,21A ''подразделен'':13A ''предоставля'':10A ''программн'':3A ''ресурс'':8A ''совокупн'':1A ''телекоммуникацион'':4A ''техническ'':2A ''функциональн'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16831, 15265, 'Совокупность данных, организованных, систематизированных и представленных таким образом, чтобы эти данные могли быть найдены и обработаны с помощью ЭВМ.', '''дан'':2A,11A ''могл'':12A ''найд'':14A ''обработа'':16A ''образ'':8A ''организова'':3A ''помощ'':18A ''представлен'':6A ''систематизирова'':4A ''совокупн'':1A ''так'':7A ''эвм'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17117, 15550, 'Во-первых, невозможность по ряду причин при идентификации сложности элементов воздействия и восстановления построить математическую модель, адекватно описывающую их свойства и поведение в процессе формирования и поддержки сервисов (понятие математической сложности). Во-вторых, необходимость учитывать сложность характера реакции (уязвимости) элемента АС на множество внутренних и внешних угроз.', '''адекватн'':18A ''ас'':43A ''внешн'':48A ''внутрен'':46A ''во-втор'':33A ''во-перв'':1A ''воздейств'':12A ''восстановлен'':14A ''втор'':35A ''идентификац'':9A ''математическ'':16A,31A ''множеств'':45A ''модел'':17A ''невозможн'':4A ''необходим'':36A ''описыва'':19A ''перв'':3A ''поведен'':23A ''поддержк'':28A ''понят'':30A ''постро'':15A ''причин'':7A ''процесс'':25A ''реакц'':40A ''ряд'':6A ''свойств'':21A ''сервис'':29A ''сложност'':10A,32A,38A ''угроз'':49A ''учитыва'':37A ''уязвим'':41A ''формирован'':26A ''характер'':39A ''элемент'':11A,42A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17122, 15555, 'Средства установления взаимосвязей между терминологией пользователя и терминологией, используемой в информационной системе. Семантические технологии обеспечивают переход от потокового представления информации (гипертекст, изображения, видео) к семантическому. Данные, представленные в семантической форме, записываются в виде «подлежащее — сказуемое — дополнение». Такое информационное сообщение называется триплетом.', '''взаимосвяз'':3A ''вид'':33A ''виде'':23A ''гипертекст'':21A ''дан'':26A ''дополнен'':36A ''записыва'':31A ''изображен'':22A ''информац'':20A ''информацион'':11A,38A ''используем'':9A ''называ'':40A ''обеспечива'':15A ''переход'':16A ''подлежа'':34A ''пользовател'':6A ''потоков'':18A ''представлен'':19A,27A ''семантическ'':13A,25A,29A ''систем'':12A ''сказуем'':35A ''сообщен'':39A ''средств'':1A ''так'':37A ''терминолог'':5A,8A ''технолог'':14A ''триплет'':41A ''установлен'':2A ''форм'':30A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17125, 15558, 'В вычислительной сети — функциональное устройство, предоставляющее услуги рабочим станциям, персональным компьютерам или другим функциональным устройствам.
Примечание — Услуги могут быть выделенными услугами или услугами коллективного пользования.', '''выделен'':20A ''вычислительн'':2A ''друг'':13A ''коллективн'':24A ''компьютер'':11A ''могут'':18A ''персональн'':10A ''пользован'':25A ''предоставля'':6A ''примечан'':16A ''рабоч'':8A ''сет'':3A ''станц'':9A ''услуг'':7A,17A,21A,23A ''устройств'':5A,15A ''функциональн'':4A,14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17136, 15569, 'Ключевыми характеристиками, определяющими технические требования к восстановлению живучести АС, являются:
– «целевая точка восстановления» RPO (Recovery point objective) — согласованный с деятельностью организации интервал времени, предшествующий аварии (катастрофе), за который допускается потеря непрерывности функционирования организации, т. е. на какое-то время АС, ее системы, сети и данные могут потерять свою функциональность при возникновении угроз и чрезвычайной ситуации;
– «целевое время восстановления» RTO (Recovery time objective) — согласованный с организацией интервал времени, необходимый для восстановления доступности ИТ-услуг и АС в целом, т. е. период, в течение которого допустимо отсутствие доступа к системе;
– нагрузка, обеспечиваемая резервной системой RCO (Recovery capacity objective), показатель оценивается в процентах, транзакциях и т. п.
– минимальное время реакции на НШС, инцидент, аварию;
– минимальное время простоя организации за счет нарушения живучести АС;
– минимальное время на ликвидацию последствий аварии, катастрофы;
– минимальный ущерб организации за счет применения не эффективной системы восстановления АС.', '''capac'':97A ''object'':17A,63A,98A ''point'':16A ''rco'':95A ''recoveri'':15A,61A,96A ''rpo'':14A ''rto'':60A ''time'':62A ''авар'':25A,113A,128A ''ас'':9A,41A,77A,122A,140A ''возникновен'':52A ''восстановлен'':7A,13A,59A,71A,139A ''врем'':40A,58A,108A,115A,124A ''времен'':23A,68A ''дан'':46A ''деятельн'':20A ''допуска'':29A ''допустим'':86A ''доступ'':88A ''доступн'':72A ''е'':35A,81A ''живучест'':8A,121A ''интерва'':22A,67A ''инцидент'':112A ''ит'':74A ''ит-услуг'':73A ''как'':38A ''какое-т'':37A ''катастроф'':26A,129A ''ключев'':1A ''котор'':28A,85A ''ликвидац'':126A ''минимальн'':107A,114A,123A,130A ''могут'':47A ''нагрузк'':91A ''нарушен'':120A ''необходим'':69A ''непрерывн'':31A ''ншс'':111A ''обеспечива'':92A ''определя'':3A ''организац'':21A,33A,66A,117A,132A ''отсутств'':87A ''оценива'':100A ''п'':106A ''период'':82A ''показател'':99A ''последств'':127A ''потер'':30A ''потеря'':48A ''предшеств'':24A ''применен'':135A ''просто'':116A ''процент'':102A ''реакц'':109A ''резервн'':93A ''сет'':44A ''систем'':43A,90A,94A,138A ''ситуац'':56A ''согласова'':18A,64A ''счет'':119A,134A ''т'':34A,80A,105A ''техническ'':4A ''течен'':84A ''точк'':12A ''транзакц'':103A ''требован'':5A ''угроз'':53A ''услуг'':75A ''ущерб'':131A ''функциональн'':50A ''функционирован'':32A ''характеристик'':2A ''цел'':79A ''целев'':11A,57A ''чрезвычайн'':55A ''эффективн'':137A ''явля'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16833, 15266, 'База данных, запись в которой содержит данные об одной лексической единице и соответствует статье словаря.', '''баз'':1A ''дан'':2A,7A ''единиц'':11A ''зап'':3A ''котор'':5A ''лексическ'':10A ''одн'':9A ''словар'':15A ''содерж'':6A ''соответств'':13A ''стат'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16834, 15267, 'База данных, которая хранит информацию формируемого машиночитаемого словаря. В ней необходимо обеспечить быстрый, гибкий и удобный доступ. Записи, которые будут здесь храниться, должны иметь структурированный вид. Язык запросов к данной базе должен обеспечивать наиболее удобное добавление, изменение и удаление информации.', '''баз'':1A,31A ''будут'':20A ''быстр'':13A ''вид'':26A ''гибк'':14A ''дан'':2A,30A ''добавлен'':36A ''долж'':32A ''должн'':23A ''доступ'':17A ''запис'':18A ''запрос'':28A ''изменен'':37A ''имет'':24A ''информац'':5A,40A ''котор'':3A,19A ''машиночита'':7A ''наибол'':34A ''необходим'':11A ''обеспеч'':12A ''обеспечива'':33A ''словар'':8A ''структурирова'':25A ''удален'':39A ''удобн'':16A,35A ''формируем'':6A ''хран'':4A,22A ''язык'':27A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16835, 15268, 'Хранилище для сбора, обработки и анализа данных, полученных и использованных в процессах управления рисками.', '''анализ'':6A ''дан'':7A ''использова'':10A ''обработк'':4A ''получен'':8A ''процесс'':12A ''риск'':14A ''сбор'':3A ''управлен'':13A ''хранилищ'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16836, 15269, 'Централизованный репозиторий информации о компонентах ИТ-инфраструктуры и их взаимосвязях.', '''взаимосвяз'':11A ''информац'':3A ''инфраструктур'':8A ''ит'':7A ''ит-инфраструктур'':6A ''компонент'':5A ''репозитор'':2A ''централизова'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17025, 15458, 'Аппаратный маршрутизатор или программное обеспечение для сопряжения компьютерных сетей (например, локальной и глобальной), использующих разные протоколы. Он конвертирует протоколы одного типа физической среды в протоколы другой физической среды (сети).', '''аппаратн'':1A ''глобальн'':13A ''использ'':14A ''компьютерн'':8A ''конвертир'':18A ''локальн'':11A ''маршрутизатор'':2A ''например'':10A ''обеспечен'':5A ''одн'':20A ''программн'':4A ''протокол'':16A,19A,25A ''разн'':15A ''сет'':9A,29A ''сопряжен'':7A ''сред'':23A,28A ''тип'':21A ''физическ'':22A,27A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16840, 15273, 'База знаний, в которой описаны общие закономерности, характерные для некоторой проблемной области, а также способы постановки и решения задач в этой области.', '''баз'':1A ''задач'':19A ''закономерн'':7A ''знан'':2A ''котор'':4A ''некотор'':10A ''област'':12A,22A ''общ'':6A ''описа'':5A ''постановк'':16A ''проблемн'':11A ''решен'':18A ''способ'':15A ''такж'':14A ''характерн'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17137, 15570, 'Методы и инструменты для перевода необработанной информации в осмысленную, удобную форму. Технологии BI обрабатывают большие объемы неструктурированных данных, чтобы найти стратегические возможности для бизнеса. Цель BI — интерпретировать большое количество данных, заостряя внимание лишь на ключевых факторах эффективности, моделируя исход различных вариантов действий, отслеживая результаты принятия решений.', '''bi'':13A,26A ''бизнес'':24A ''больш'':15A,28A ''вариант'':41A ''вниман'':32A ''возможн'':22A ''дан'':18A,30A ''действ'':42A ''заостр'':31A ''инструмент'':3A ''интерпретирова'':27A ''информац'':7A ''исход'':39A ''ключев'':35A ''количеств'':29A ''лиш'':33A ''метод'':1A ''моделиру'':38A ''найт'':20A ''необработа'':6A ''неструктурирова'':17A ''обрабатыва'':14A ''объем'':16A ''осмыслен'':9A ''отслежив'':43A ''перевод'':5A ''принят'':45A ''различн'':40A ''результат'':44A ''решен'':46A ''стратегическ'':21A ''технолог'':12A ''удобн'':10A ''фактор'':36A ''форм'':11A ''цел'':25A ''эффективн'':37A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17143, 15576, 'Угроза преднамеренного несанкционированного изменения состояния системы.
Примечания:
1 Примерами активных угроз, относящихся к защите информации, могут служить модификация сообщений, дублирование сообщений, вставка ложных сообщений, маскирование какого-либо логического объекта под санкционированный логический объект и отклонение услуги.
2 Активные угрозы системе означают изменение информации, содержащейся в системе, либо изменения состояния или работы системы. Примером активной угрозы служит умышленное изменение таблиц маршрутизации системы неполномочным пользователем.', '''1'':8A ''2'':38A ''активн'':10A,39A,55A ''вставк'':22A ''дублирован'':20A ''защ'':14A ''изменен'':4A,43A,49A,59A ''информац'':15A,44A ''как'':27A ''какого-либ'':26A ''либ'':28A,48A ''логическ'':29A,33A ''ложн'':23A ''маршрутизац'':61A ''маскирован'':25A ''могут'':16A ''модификац'':18A ''неполномочн'':63A ''несанкционирова'':3A ''объект'':30A,34A ''означа'':42A ''отклонен'':36A ''относя'':12A ''пользовател'':64A ''преднамерен'':2A ''пример'':9A,54A ''примечан'':7A ''работ'':52A ''санкционирова'':32A ''систем'':6A,41A,47A,53A,62A ''служ'':17A,57A ''содержа'':45A ''сообщен'':19A,21A,24A ''состоян'':5A,50A ''таблиц'':60A ''угроз'':1A,11A,40A,56A ''умышлен'':58A ''услуг'':37A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16837, 15271, 'База данных, которая содержит правила логических выводов и информацию о человеческом опыте и знаниях экспертов в предметной области.
Примечание — В системах с самообучением база знаний содержит дополнительно информацию, получаемую из решения ранее встретившихся задач.', '''баз'':1A,24A ''встрет'':33A ''вывод'':7A ''дан'':2A ''дополнительн'':27A ''задач'':34A ''знан'':14A,25A ''информац'':9A,28A ''котор'':3A ''логическ'':6A ''област'':18A ''опыт'':12A ''получа'':29A ''прав'':5A ''предметн'':17A ''примечан'':19A ''ран'':32A ''решен'':31A ''самообучен'':23A ''систем'':21A ''содерж'':4A,26A ''человеческ'':11A ''эксперт'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16838, 15271, 'Особого рода база данных, разработанная для управления знаниями (их сбором, хранением, поиском и выдачей).', '''баз'':3A ''выдач'':14A ''дан'':4A ''знан'':8A ''особ'':1A ''поиск'':12A ''разработа'':5A ''род'':2A ''сбор'':10A ''управлен'':7A ''хранен'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16839, 15272, 'База знаний, содержимое которой в процессе функционирования остается неизменным, а логический вывод эквивалентен выводу в формальной системе.', '''баз'':1A ''вывод'':12A,14A ''знан'':2A ''котор'':4A ''логическ'':11A ''неизмен'':9A ''оста'':8A ''процесс'':6A ''систем'':17A ''содержим'':3A ''формальн'':16A ''функционирован'':7A ''эквивалент'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17145, 15580, 'Потенциальная возможность нарушения качественных характеристик (свойств) информации (секретности, конфиденциальности, доступности, целостности) при ее обработке техническими средствами.', '''возможн'':2A ''доступн'':10A ''информац'':7A ''качествен'':4A ''конфиденциальн'':9A ''нарушен'':3A ''обработк'':14A ''потенциальн'':1A ''свойств'':6A ''секретн'':8A ''средств'':16A ''техническ'':15A ''характеристик'':5A ''целостн'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16841, 15274, 'База знаний, позволяющая в процессе ее функционирования пополнять и обновлять ее содержимое. Свойство открытости приводит к тому, что истинность выведенных в ней утверждений может меняться в процессе работы системы с такой базой.', '''баз'':1A,32A ''выведен'':20A ''знан'':2A ''истин'':19A ''меня'':25A ''обновля'':10A ''открыт'':14A ''позволя'':3A ''пополня'':8A ''привод'':15A ''процесс'':5A,27A ''работ'':28A ''свойств'':13A ''систем'':29A ''содержим'':12A ''том'':17A ''утвержден'':23A ''функционирован'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16842, 15275, 'База данных с информацией об известных ошибках и способах их устранения.
Примечание — Может создаваться, например, в рамках системы управления конфигурациями или системы управления знаниями по ИТ-услугам.', '''баз'':1A ''дан'':2A ''знан'':24A ''известн'':6A ''информац'':4A ''ит'':27A ''ит-услуг'':26A ''конфигурац'':20A ''например'':15A ''ошибк'':7A ''примечан'':12A ''рамк'':17A ''систем'':18A,22A ''создава'':14A ''способ'':9A ''управлен'':19A,23A ''услуг'':28A ''устранен'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16843, 15276, 'База данных с исторической информацией, накопленными знаниями о результатах, принятых в прошлом решениях и их исполнениях.', '''баз'':1A ''дан'':2A ''знан'':7A ''информац'':5A ''исполнен'':16A ''историческ'':4A ''накоплен'':6A ''принят'':10A ''прошл'':12A ''результат'':9A ''решен'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16844, 15277, 'Хранилище данных, используемых управляющим программным обеспечением для сбора информации, поступающей от объектов управления.', '''дан'':2A ''информац'':9A ''используем'':3A ''обеспечен'':6A ''объект'':12A ''поступа'':10A ''программн'':5A ''сбор'':8A ''управлен'':13A ''управля'':4A ''хранилищ'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16845, 15278, 'Обработка файлов, дисков, каталогов, проводимая с использованием специальных программ, создающих условия, подобные тем, которые создаются определенным компьютерным вирусом, и затрудняющих повторное его появление.', '''вирус'':18A ''диск'':3A ''затрудня'':20A ''использован'':7A ''каталог'':4A ''компьютерн'':17A ''котор'':14A ''обработк'':1A ''определен'':16A ''повторн'':21A ''подобн'':12A ''появлен'':23A ''проводим'':5A ''программ'':9A ''созда'':10A,15A ''специальн'':8A ''услов'':11A ''файл'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17146, 15580, 'Совокупность условий и факторов, создающих потенциальную или реально существующую опасность, связанную с утечкой информации, и/или несанкционированными и/или непреднамеренными воздействиями на нее.', '''воздейств'':21A ''информац'':14A ''непреднамерен'':20A ''несанкционирова'':17A ''опасн'':10A ''потенциальн'':6A ''реальн'':8A ''связа'':11A ''совокупн'':1A ''созда'':5A ''существ'':9A ''услов'':2A ''утечк'':13A ''фактор'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16847, 15281, 'Валидация в контексте жизненного цикла системы является совокупностью действий, гарантирующих и обеспечивающих уверенность в том, что система способна выполнять заданные функции в соответствии с установленными целями и назначением в конкретных условиях функционирования.', '''валидац'':1A ''выполня'':19A ''гарантир'':10A ''действ'':9A ''жизнен'':4A ''зада'':20A ''конкретн'':30A ''контекст'':3A ''назначен'':28A ''обеспечива'':12A ''систем'':6A,17A ''совокупн'':8A ''соответств'':23A ''способн'':18A ''уверен'':13A ''услов'':31A ''установлен'':25A ''функц'':21A ''функционирован'':32A ''цел'':26A ''цикл'':5A ''явля'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16849, 15282, 'Единообразный локатор (определитель местонахождения) ресурса.', '''единообразн'':1A ''локатор'':2A ''местонахожден'':4A ''определител'':3A ''ресурс'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17147, 15580, 'Потенциальная причина инцидента, который может нанести ущерб системе или организации.', '''инцидент'':3A ''котор'':4A ''нанест'':6A ''организац'':10A ''потенциальн'':1A ''причин'':2A ''систем'':8A ''ущерб'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16850, 15283, 'Комплекс программно-аппаратных средств, при помощи которых пользователь общается с веб-сайтом или любым другим приложением.', '''аппаратн'':4A ''веб'':13A ''веб-сайт'':12A ''друг'':17A ''комплекс'':1A ''котор'':8A ''люб'':16A ''обща'':10A ''пользовател'':9A ''помощ'':7A ''приложен'':18A ''программн'':3A ''программно-аппаратн'':2A ''сайт'':14A ''средств'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16851, 15284, 'Процесс извлечения данных из Веб-ресурсов, который, как правило, имеет больше практическую составляющую, нежели теоретическую. Основная цель Веб-майнинга — сбор данных (парсинг) с последующим их сохранением в нужном формате. Технология Веб-майнинг охватывает методы, которые способны на основе данных сайта обнаружить новые, ранее неизвестные знания и которые в дальнейшем можно будет использовать на практике. Другими словами, технология Веб-майнинг применяет технологию интеллектуального анализа данных для анализа неструктурированной, неоднородной, распределенной и значительной по объему информации, содержащейся на Веб-узлах.', '''анализ'':67A,70A ''веб'':6A,20A,34A,62A,82A ''веб-майнинг'':19A,33A,61A ''веб-ресурс'':5A ''веб-узл'':81A ''дальн'':52A ''дан'':3A,23A,42A,68A ''друг'':58A ''знан'':48A ''значительн'':75A ''извлечен'':2A ''имеет'':11A ''интеллектуальн'':66A ''информац'':78A ''использова'':55A ''котор'':8A,38A,50A ''майнинг'':21A,35A,63A ''метод'':37A ''нежел'':15A ''неизвестн'':47A ''неоднородн'':72A ''неструктурирова'':71A ''нов'':45A ''нужн'':30A ''обнаруж'':44A ''объ'':77A ''основ'':41A ''основн'':17A ''охватыва'':36A ''парсинг'':24A ''послед'':26A ''прав'':10A ''практик'':57A ''практическ'':13A ''применя'':64A ''процесс'':1A ''ран'':46A ''распределен'':73A ''ресурс'':7A ''сайт'':43A ''сбор'':22A ''слов'':59A ''содержа'':79A ''составля'':14A ''сохранен'':28A ''способн'':39A ''теоретическ'':16A ''технолог'':32A,60A,65A ''узл'':83A ''формат'':31A ''цел'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16852, 15285, 'Идентифицируемая Веб-адресом программная система со стандартизированными интерфейсами. Веб-сервисы (Веб-службы, ИТ-службы) могут взаимодействовать друг с другом и со сторонними приложениями посредством сообщений, основанных на определенных протоколах (SOAP, XML-RPC, REST и т. д.).', '''rest'':38A ''rpc'':37A ''soap'':34A ''xml'':36A ''xml-rpc'':35A ''адрес'':4A ''веб'':3A,11A,14A ''веб-адрес'':2A ''веб-сервис'':10A ''веб-служб'':13A ''взаимодействова'':20A ''д'':41A ''друг'':21A,23A ''идентифицируем'':1A ''интерфейс'':9A ''ит'':17A ''ит-служб'':16A ''могут'':19A ''определен'':32A ''основа'':30A ''посредств'':28A ''приложен'':27A ''программн'':5A ''протокол'':33A ''сервис'':12A ''систем'':6A ''служб'':15A,18A ''сообщен'':29A ''стандартизирова'':8A ''сторон'':26A ''т'':40A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17148, 15581, 'Угроза несанкционированного раскрытия информации без изменения состояния системы. К пассивным угрозам относятся те, которые при их реализации не приводят к какой-либо модификации любой информации, содержащейся в системе(ах), и где работа и состояние системы не изменяются. Использование пассивного перехвата для анализа информации, передаваемой по каналам связи, представляет собой реализацию пассивной угрозы.', '''анализ'':43A ''ах'':30A ''изменен'':6A ''изменя'':38A ''информац'':4A,26A,44A ''использован'':39A ''какой-либ'':21A ''канал'':47A ''котор'':14A ''либ'':23A ''люб'':25A ''модификац'':24A ''несанкционирова'':2A ''относ'':12A ''пассивн'':10A,40A,52A ''передава'':45A ''перехват'':41A ''представля'':49A ''привод'':19A ''работ'':33A ''раскрыт'':3A ''реализац'':17A,51A ''связ'':48A ''систем'':8A,29A,36A ''соб'':50A ''содержа'':27A ''состоян'':7A,35A ''те'':13A ''угроз'':1A,11A,53A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17151, 15584, 'Унифицированная форма документа, установленная в соответствии с задачами, решаемыми органами военного управления, соединениями, воинскими частями и организациями Вооруженных Сил Российской Федерации в военной сфере деятельности.', '''воен'':11A,23A ''воинск'':14A ''вооружен'':18A ''деятельн'':25A ''документ'':3A ''задач'':8A ''орган'':10A ''организац'':17A ''реша'':9A ''российск'':20A ''сил'':19A ''соединен'':13A ''соответств'':6A ''сфер'':24A ''унифицирова'':1A ''управлен'':12A ''установлен'':4A ''федерац'':21A ''форм'':2A ''част'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17153, 15586, 'Унифицированная форма документа по персональному и количественному учету сведений военного назначения, установленная в соответствии с задачами, решаемыми органами военного управления, соединениями, воинскими частями и организациями Вооруженных Сил Российской Федерации в военной сфере деятельности.
Примечание — В документе персонального учета представлены сведения по одному объекту учета, а в документе количественного учета представлены обобщенные сведения по двум или более объектам учета.', '''воен'':10A,19A,31A ''воинск'':22A ''вооружен'':26A ''двум'':54A ''деятельн'':33A ''документ'':3A,36A,47A ''задач'':16A ''количествен'':7A,48A ''назначен'':11A ''обобщен'':51A ''объект'':43A,57A ''одн'':42A ''орган'':18A ''организац'':25A ''персональн'':5A,37A ''представл'':39A,50A ''примечан'':34A ''реша'':17A ''российск'':28A ''сведен'':9A,40A,52A ''сил'':27A ''соединен'':21A ''соответств'':14A ''сфер'':32A ''унифицирова'':1A ''управлен'':20A ''установлен'':12A ''учет'':8A,38A,44A,49A,58A ''федерац'':29A ''форм'':2A ''част'':23A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16853, 15286, 'Документ или информационный ресурс Интернета, доступ к которому осуществляется с помощью браузера. Несколько веб-страниц, объединенных общей темой и дизайном, а также связанных между собой ссылками и обычно находящихся на одном веб-сервере, образуют веб-сайт.', '''браузер'':12A ''веб'':15A,34A,38A ''веб-сайт'':37A ''веб-сервер'':33A ''веб-страниц'':14A ''дизайн'':21A ''документ'':1A ''доступ'':6A ''интернет'':5A ''информацион'':3A ''котор'':8A ''находя'':30A ''нескольк'':13A ''образ'':36A ''общ'':18A ''объединен'':17A ''обычн'':29A ''одн'':32A ''осуществля'':9A ''помощ'':11A ''ресурс'':4A ''сайт'':39A ''связа'':24A ''сервер'':35A ''соб'':26A ''ссылк'':27A ''страниц'':16A ''такж'':23A ''тем'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16854, 15287, 'Интегральное преобразование, которое представляет собой свертку вейвлет-функции с сигналом. Способ преобразования функции (или сигнала) в форму, которая или делает некоторые величины исходного сигнала более поддающимися изучению, или позволяет сжать исходный набор данных. Вейвлетное преобразование сигналов является обобщением спектрального анализа.', '''анализ'':41A ''вейвлет'':8A ''вейвлет-функц'':7A ''вейвлетн'':35A ''величин'':23A ''дан'':34A ''дела'':21A ''изучен'':28A ''интегральн'':1A ''исходн'':24A,32A ''котор'':3A,19A ''набор'':33A ''некотор'':22A ''обобщен'':39A ''подда'':27A ''позволя'':30A ''представля'':4A ''преобразован'':2A,13A,36A ''свертк'':6A ''сжат'':31A ''сигна'':16A,25A ''сигнал'':11A,37A ''соб'':5A ''спектральн'':40A ''способ'':12A ''форм'':18A ''функц'':9A,14A ''явля'':38A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16855, 15288, 'Способ представления знаний, когда из всех возможных невербальных форм обрабатываются только изображения и их сочетания с вербальным (словесным) текстом.', '''вербальн'':17A ''возможн'':7A ''знан'':3A ''изображен'':12A ''невербальн'':8A ''обрабатыва'':10A ''представлен'':2A ''словесн'':18A ''сочетан'':15A ''способ'':1A ''текст'':19A ''форм'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17163, 15596, 'Защита информации путем применения организационных мероприятий и совокупности средств, создающих препятствия для проникновения или доступа неуполномоченных физических лиц к объекту защиты.
Примечания:
1 Организационные мероприятия по обеспечению физической защиты информации предусматривают установление режимных, временных, территориальных, пространственных ограничений на условия использования и распорядок работы объекта защиты.
2 К объектам защиты информации могут быть отнесены: охраняемая территория, здание (сооружение), выделенное помещение, информация и (или) информационные ресурсы объекта информатизации.', '''1'':23A ''2'':46A ''времен'':34A ''выделен'':58A ''доступ'':15A ''защит'':1A,21A,29A,45A,49A ''здан'':56A ''информатизац'':66A ''информац'':2A,30A,50A,60A ''информацион'':63A ''использован'':40A ''лиц'':18A ''мероприят'':6A,25A ''могут'':51A ''неуполномочен'':16A ''обеспечен'':27A ''объект'':20A,44A,48A,65A ''ограничен'':37A ''организацион'':5A,24A ''отнес'':53A ''охраня'':54A ''помещен'':59A ''предусматрива'':31A ''препятств'':11A ''применен'':4A ''примечан'':22A ''проникновен'':13A ''пространствен'':36A ''пут'':3A ''работ'':43A ''распорядок'':42A ''режимн'':33A ''ресурс'':64A ''совокупн'':8A ''созда'':10A ''сооружен'':57A ''средств'':9A ''территор'':55A ''территориальн'':35A ''услов'':39A ''установлен'':32A ''физическ'':17A,28A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16856, 15294, 'Процессы оценки, используемые для подтверждения того, что меры безопасности для автоматизированной системы реализованы корректно, и их применение является эффективным.', '''автоматизирова'':11A ''безопасн'':9A ''используем'':3A ''корректн'':14A ''мер'':8A ''оценк'':2A ''подтвержден'':5A ''применен'':17A ''процесс'':1A ''реализова'':13A ''систем'':12A ''эффективн'':19A ''явля'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16857, 15294, 'Процесс сравнения двух уровней спецификации средств вычислительной техники или автоматизированных систем на надлежащее соответствие.', '''автоматизирова'':10A ''вычислительн'':7A ''двух'':3A ''надлежа'':13A ''процесс'':1A ''сист'':11A ''соответств'':14A ''спецификац'':5A ''сравнен'':2A ''средств'':6A ''техник'':8A ''уровн'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16858, 15294, 'Подтверждение, посредством предоставления объективных данных, что специфические требования были выполнены.', '''выполн'':10A ''дан'':5A ''объективн'':4A ''подтвержден'':1A ''посредств'':2A ''предоставлен'':3A ''специфическ'':7A ''требован'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17158, 15591, 'Процесс, отвечающий за предоставление общего хранилища точек зрения, идей, опыта, информации и обеспечение их доступности, когда это необходимо. Управление знаниями способствует принятию информированных решений и повышает эффективность, снижая необходимость в повторном поиске знаний.', '''доступн'':15A ''знан'':20A,33A ''зрен'':8A ''ид'':9A ''информац'':11A ''информирова'':23A ''необходим'':18A,29A ''обеспечен'':13A ''общ'':5A ''опыт'':10A ''отвеча'':2A ''повторн'':31A ''повыша'':26A ''поиск'':32A ''предоставлен'':4A ''принят'':22A ''процесс'':1A ''решен'':24A ''сниж'':28A ''способств'':21A ''точек'':7A ''управлен'':19A ''хранилищ'':6A ''эт'':17A ''эффективн'':27A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17172, 15605, 'Лицо, совершающее различного рода незаконные действия в сфере информатики: несанкционированное проникновение в чужие компьютерные сети и получение из них информации, незаконные снятие защиты с программных продуктов и их копирование, создание и распространение компьютерных вирусов и т. п..', '''..'':38A ''вирус'':34A ''действ'':6A ''защит'':23A ''информатик'':9A ''информац'':20A ''компьютерн'':14A,33A ''копирован'':29A ''лиц'':1A ''незакон'':5A,21A ''несанкционирова'':10A ''п'':37A ''получен'':17A ''программн'':25A ''продукт'':26A ''проникновен'':11A ''различн'':3A ''распространен'':32A ''род'':4A ''сет'':15A ''снят'':22A ''соверша'':2A ''создан'':30A ''сфер'':8A ''т'':36A ''чуж'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17099, 15533, 'Процесс выполнения прикладных программ группой систем. При этом пользователь получает возможность работать с сетевыми службами и прикладными процессами, расположенными в нескольких взаимосвязанных абонентских системах.', '''абонентск'':23A ''взаимосвяза'':22A ''возможн'':11A ''выполнен'':2A ''групп'':5A ''нескольк'':21A ''получа'':10A ''пользовател'':9A ''прикладн'':3A,17A ''программ'':4A ''процесс'':1A,18A ''работа'':12A ''расположен'':19A ''сетев'':14A ''сист'':6A ''систем'':24A ''служб'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16859, 15294, 'В программировании доказательство правильности программ. Различают два подхода к верификации: статические и конструктивные методы.', '''верификац'':10A ''доказательств'':3A ''конструктивн'':13A ''метод'':14A ''подход'':8A ''правильн'':4A ''программ'':5A ''программирован'':2A ''различа'':6A ''статическ'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16860, 15294, 'Процесс сопоставления двух уровней спецификаций системы (например, модели политики безопасности и спецификаций системы, спецификаций системы и исходных кодов, исходных кодов и выполняемых кодов) для установления необходимого соответствия между ними. Этот процесс может быть полностью или частично автоматизирован.', '''автоматизирова'':37A ''безопасн'':10A ''выполня'':22A ''двух'':3A ''исходн'':17A,19A ''код'':18A,20A,23A ''модел'':8A ''например'':7A ''необходим'':26A ''ним'':29A ''политик'':9A ''полност'':34A ''процесс'':1A,31A ''систем'':6A,13A,15A ''соответств'':27A ''сопоставлен'':2A ''спецификац'':5A,12A,14A ''уровн'':4A ''установлен'':25A ''частичн'':36A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16861, 15294, 'Процесс анализа, изучения, испытания, контроля, независимой экспертизы или иного процесса установления и документирования соответствия предметов, процессов, услуг или документов регламентированным требованиям.', '''анализ'':2A ''документ'':19A ''документирован'':13A ''изучен'':3A ''ин'':9A ''испытан'':4A ''контрол'':5A ''независим'':6A ''предмет'':15A ''процесс'':1A,10A,16A ''регламентирова'':20A ''соответств'':14A ''требован'':21A ''услуг'':17A ''установлен'':11A ''экспертиз'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16862, 15295, 'Специализированное устройство или приложение небольшого размера, которое подключается к более большим и сложным устройствам через стандартизированный интерфейс (разъем, порт) и не может работать в автономном режиме. Главное предназначение любого гаджета — расширение функционала устройства, к которому он подключается.', '''автономн'':25A ''больш'':11A ''гаджет'':30A ''главн'':27A ''интерфейс'':17A ''котор'':7A,35A ''люб'':29A ''небольш'':5A ''подключа'':8A,37A ''порт'':19A ''предназначен'':28A ''приложен'':4A ''работа'':23A ''размер'':6A ''разъ'':18A ''расширен'':31A ''режим'':26A ''сложн'':13A ''специализирова'':1A ''стандартизирова'':16A ''устройств'':2A,14A,33A ''функциона'':32A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16863, 15296, 'Выполнение предприятиями-изготовителями работ по обеспечению исправности АС, совершенствованию технического обслуживания и ремонта в период эксплуатации АС.', '''ас'':9A,18A ''выполнен'':1A ''изготовител'':4A ''исправн'':8A ''обеспечен'':7A ''обслуживан'':12A ''период'':16A ''предприят'':3A ''предприятиями-изготовител'':2A ''работ'':5A ''ремонт'':14A ''совершенствован'':10A ''техническ'':11A ''эксплуатац'':17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16864, 15297, 'Обязательство, что ИТ-услуга будет соответствовать согласованным требованиям. Это может быть как формальное соглашение (например, соглашение об уровне обслуживания или контракт), так и маркетинговое заявление или имидж бренда. Гарантия характеризует возможность услуги быть доступной тогда, когда она нужна, иметь необходимую мощность и надежность (в части безопасности и непрерывности). Гарантия — это то «как услуга предоставляется», она может использоваться для определения соответствия условиям использования услуги. Ценность ИТ-услуги для бизнеса создается при помощи комбинации полезности и гарантии.', '''безопасн'':47A ''бизнес'':70A ''бренд'':29A ''возможн'':32A ''гарант'':30A,50A,77A ''доступн'':35A ''заявлен'':26A ''имет'':40A ''имидж'':28A ''использова'':58A ''использован'':63A ''ит'':4A,67A ''ит-услуг'':3A,66A ''комбинац'':74A ''контракт'':22A ''маркетингов'':25A ''мощност'':42A ''надежн'':44A ''например'':16A ''необходим'':41A ''непрерывн'':49A ''нужн'':39A ''обслуживан'':20A ''обязательств'':1A ''определен'':60A ''полезн'':75A ''помощ'':73A ''предоставля'':55A ''согласова'':8A ''соглашен'':15A,17A ''созда'':71A ''соответств'':61A ''соответствова'':7A ''требован'':9A ''уровн'':19A ''услов'':62A ''услуг'':5A,33A,54A,64A,68A ''формальн'':14A ''характериз'':31A ''ценност'':65A ''част'':46A ''эт'':10A,51A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16867, 15300, 'Методы анализа данных, которые невозможно проанализировать стандартными методами. Как правило, используются для обработки больших объемов информации, построения прогнозных моделей. Используются в научных целях при имитационном моделировании.', '''анализ'':2A ''больш'':14A ''дан'':3A ''имитацион'':25A ''информац'':16A ''использ'':11A,20A ''котор'':4A ''метод'':1A,8A ''модел'':19A ''моделирован'':26A ''научн'':22A ''невозможн'':5A ''обработк'':13A ''объем'':15A ''построен'':17A ''прав'':10A ''проанализирова'':6A ''прогнозн'':18A ''стандартн'':7A ''цел'':23A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16865, 15299, 'Наличие сертификата соответствия для технического средства обработки информации или аттестата на объект информатики, подтверждающих, что безопасность обрабатываемой информации соответствует требованиям стандартов и других нормативных документов.', '''аттестат'':10A ''безопасн'':16A ''документ'':25A ''друг'':23A ''информатик'':13A ''информац'':8A,18A ''налич'':1A ''нормативн'':24A ''обрабатыва'':17A ''обработк'':7A ''объект'':12A ''подтвержда'':14A ''сертификат'':2A ''соответств'':3A,19A ''средств'':6A ''стандарт'':21A ''техническ'':5A ''требован'':20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16866, 15299, 'Формальное разрешение на возможность использования для работы данной конкретной вычислительной машины на месте ее установки только после обеспечения защиты от несанкционированного доступа.', '''возможн'':4A ''вычислительн'':10A ''дан'':8A ''доступ'':22A ''защит'':19A ''использован'':5A ''конкретн'':9A ''машин'':11A ''мест'':13A ''несанкционирова'':21A ''обеспечен'':18A ''работ'':7A ''разрешен'':2A ''установк'':15A ''формальн'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16868, 15301, 'Данные о географических объектах, явлениях природы, представленные в формализованном виде, пригодные для передачи и обработки в АС.', '''ас'':17A ''вид'':10A ''географическ'':3A ''дан'':1A ''обработк'':15A ''объект'':4A ''передач'':13A ''представлен'':7A ''пригодн'':11A ''природ'':6A ''формализова'':9A ''явлен'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16869, 15302, 'Наука, технология и производственная деятельность по научному обоснованию, проектированию, созданию, эксплуатации и использованию географических информационных систем, по разработке геоинформационных технологий, по приложению геоинформационной системы для практических и научных целей.', '''географическ'':14A ''геоинформацион'':19A,23A ''деятельн'':5A ''информацион'':15A ''использован'':13A ''наук'':1A ''научн'':7A,28A ''обоснован'':8A ''практическ'':26A ''приложен'':22A ''проектирован'':9A ''производствен'':4A ''разработк'':18A ''сист'':16A ''систем'':24A ''создан'':10A ''технолог'':2A,20A ''цел'':29A ''эксплуатац'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17170, 15605, 'Высококвалифицированный ИТ-специалист, человек, который понимает тонкости работы программ ЭВМ. В последнее время словом «хакер» часто называют всех сетевых взломщиков, создателей компьютерных вирусов и других компьютерных преступников. Многие компьютерные взломщики по праву могут называться хакерами, потому как действительно соответствуют всем (или почти всем) вышеперечисленным определениям слова «хакер».', '''взломщик'':21A,31A ''вирус'':24A ''врем'':14A ''всем'':41A,44A ''высококвалифицирова'':1A ''вышеперечислен'':45A ''действительн'':39A ''друг'':26A ''ит'':3A ''ит-специалист'':2A ''компьютерн'':23A,27A,30A ''котор'':6A ''мног'':29A ''могут'':34A ''называ'':18A,35A ''определен'':46A ''понима'':7A ''последн'':13A ''прав'':33A ''преступник'':28A ''программ'':10A ''работ'':9A ''сетев'':20A ''слов'':15A,47A ''создател'':22A ''соответств'':40A ''специалист'':4A ''тонкост'':8A ''хакер'':16A,36A,48A ''част'':17A ''человек'':5A ''эвм'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16870, 15305, 'Информационная система, оперирующая пространственными данными.
Примечание — По пространственному охвату различают глобальные, субконтинентальные, национальные, межнациональные, региональные, субрегиональные и локальные ГИС. В Российской Федерации принято различать федеральные ГИС (ФГИС), региональные (РГИС), муниципальные (МГИС) и локальные (ЛГИС).', '''гис'':19A,26A ''глобальн'':11A ''дан'':5A ''информацион'':1A ''лгис'':34A ''локальн'':18A,33A ''мгис'':31A ''межнациональн'':14A ''муниципальн'':30A ''национальн'':13A ''оперир'':3A ''охват'':9A ''примечан'':6A ''принят'':23A ''пространствен'':4A,8A ''различа'':10A,24A ''ргис'':29A ''региональн'':15A,28A ''российск'':21A ''систем'':2A ''субконтинентальн'':12A ''субрегиональн'':16A ''фгис'':27A ''федеральн'':25A ''федерац'':22A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17026, 15459, 'Комплекс аппаратных или программных средств, осуществляющий контроль и фильтрацию проходящих через него сетевых пакетов в соответствии с заданными правилами. Основной задачей сетевого экрана является защита компьютерных сетей или отдельных узлов от несанкционированного доступа.', '''аппаратн'':2A ''доступ'':33A ''зада'':18A ''задач'':21A ''защит'':25A ''комплекс'':1A ''компьютерн'':26A ''контрол'':7A ''несанкционирова'':32A ''основн'':20A ''осуществля'':6A ''отдельн'':29A ''пакет'':14A ''правил'':19A ''программн'':4A ''проходя'':10A ''сет'':27A ''сетев'':13A,22A ''соответств'':16A ''средств'':5A ''узл'':30A ''фильтрац'':9A ''экра'':23A ''явля'':24A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17177, 15610, 'Функция, осуществляющая отображение элементов некоторого множества (например, множества фамилий, множества файлов и т. д.) в индекс линейного множества. Примером простой хэш-функции является, например, широко известная функция CRC32. Особую роль в современной информатике играют односторонние хэш-функции, т. е. такие хэш-функции, зная результат отображения которых практически невозможно восстановить исходный элемент, преобразованный в известный результат. В отечественной литературе часто называются функциями расстановки.', '''crc32'':29A ''восстанов'':52A ''д'':14A ''е'':41A ''зна'':46A ''игра'':35A ''известн'':27A,57A ''индекс'':16A ''информатик'':34A ''исходн'':53A ''котор'':49A ''линейн'':17A ''литератур'':61A ''множеств'':6A,8A,10A,18A ''называ'':63A ''например'':7A,25A ''невозможн'':51A ''некотор'':5A ''односторон'':36A ''особ'':30A ''осуществля'':2A ''отечествен'':60A ''отображен'':3A,48A ''практическ'':50A ''преобразова'':55A ''пример'':19A ''прост'':20A ''расстановк'':65A ''результат'':47A,58A ''рол'':31A ''современ'':33A ''т'':13A,40A ''так'':42A ''файл'':11A ''фамил'':9A ''функц'':1A,23A,28A,39A,45A,64A ''хэш'':22A,38A,44A ''хэш-функц'':21A,37A,43A ''част'':62A ''широк'':26A ''элемент'':4A,54A ''явля'':24A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17184, 15617, 'Состояние базы данных, когда все значения данных правильны в том смысле, что отражают состояние реального мира (в пределах заданных ограничений по точности и временной согласованности) и подчиняются правилам взаимной непротиворечивости. Поддержание целостности базы данных включает проверку целостности и восстановление из любого неправильного состояния, которое может быть обнаружено; это входит в функции администратора базы данных.', '''администратор'':52A ''баз'':2A,33A,53A ''взаимн'':29A ''включа'':35A ''восстановлен'':39A ''времен'':24A ''вход'':49A ''дан'':3A,7A,34A,54A ''зада'':19A ''значен'':6A ''котор'':44A ''люб'':41A ''мир'':16A ''неправильн'':42A ''непротиворечив'':30A ''обнаруж'':47A ''ограничен'':20A ''отража'':13A ''поддержан'':31A ''подчиня'':27A ''правил'':28A ''правильн'':8A ''предел'':18A ''проверк'':36A ''реальн'':15A ''смысл'':11A ''согласован'':25A ''состоян'':1A,14A,43A ''точност'':22A ''функц'':51A ''целостн'':32A,37A ''эт'':48A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16871, 15305, 'Многофункциональная автоматизированная информационная система, предназначенная для сбора, обработки, моделирования и анализа пространственных данных, их отображения и использования при решении расчетных задач, подготовке и принятии решений. Основное назначение ГИС заключается в формировании знаний о Земле, отдельных территориях, местности, а также своевременном доведении необходимых и достаточных пространственных данных до пользователей с целью достижения наибольшей эффективности их работы.', '''автоматизирова'':2A ''анализ'':11A ''гис'':28A ''дан'':13A,46A ''доведен'':41A ''достаточн'':44A ''достижен'':51A ''задач'':21A ''заключа'':29A ''земл'':34A ''знан'':32A ''информацион'':3A ''использован'':17A ''местност'':37A ''многофункциональн'':1A ''моделирован'':9A ''назначен'':27A ''наибольш'':52A ''необходим'':42A ''обработк'':8A ''основн'':26A ''отдельн'':35A ''отображен'':15A ''подготовк'':22A ''пользовател'':48A ''предназначен'':5A ''принят'':24A ''пространствен'':12A,45A ''работ'':55A ''расчетн'':20A ''решен'':19A,25A ''сбор'':7A ''своевремен'':40A ''систем'':4A ''такж'':39A ''территор'':36A ''формирован'':31A ''цел'':50A ''эффективн'':53A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17188, 15621, 'Соответствие значений всех данных базы данных определенному непротиворечивому набору правил.', '''баз'':5A ''дан'':4A,6A ''значен'':2A ''набор'':9A ''непротиворечив'':8A ''определен'':7A ''прав'':10A ''соответств'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16876, 15309, 'Научно-техническое направление, объединяющее методы и средства интеграции информационных технологий сбора, обработки и использования пространственных данных, включая геоинформационные технологии.', '''включ'':18A ''геоинформацион'':19A ''дан'':17A ''интеграц'':9A ''информацион'':10A ''использован'':15A ''метод'':6A ''направлен'':4A ''научн'':2A ''научно-техническ'':1A ''обработк'':13A ''объединя'':5A ''пространствен'':16A ''сбор'':12A ''средств'':8A ''техническ'':3A ''технолог'':11A,20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16873, 15307, 'Совокупность приемов, способов и методов применения программно-технических средств обработки и передачи информации, позволяющая реализовать функциональные возможности геоинформационных систем.', '''возможн'':18A ''геоинформацион'':19A ''информац'':14A ''метод'':5A ''обработк'':11A ''передач'':13A ''позволя'':15A ''прием'':2A ''применен'':6A ''программн'':8A ''программно-техническ'':7A ''реализова'':16A ''сист'':20A ''совокупн'':1A ''способ'':3A ''средств'':10A ''техническ'':9A ''функциональн'':17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16874, 15307, 'Информационные технологии обработки географически организованной информации.', '''географическ'':4A ''информац'':6A ''информацион'':1A ''обработк'':3A ''организова'':5A ''технолог'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17187, 15621, 'Состояние, при котором данные, представленные в компьютере, в точности соответствуют данным в исходных документах. Свойство, относящееся к набору данных и означающее, что данные не могут быть изменены или разрушены без санкции на доступ. С сохранением целостности информации в базах данных связаны три аспекта: поддержание семантической целостности, управление параллельной обработкой данных, восстановление данных.', '''аспект'':43A ''баз'':39A ''восстановлен'':51A ''дан'':4A,11A,19A,23A,40A,50A,52A ''документ'':14A ''доступ'':33A ''измен'':27A ''информац'':37A ''исходн'':13A ''компьютер'':7A ''котор'':3A ''могут'':25A ''набор'':18A ''обработк'':49A ''означа'':21A ''относя'':16A ''параллельн'':48A ''поддержан'':44A ''представлен'':5A ''разруш'':29A ''санкц'':31A ''свойств'':15A ''связа'':41A ''семантическ'':45A ''соответств'':10A ''состоян'':1A ''сохранен'':35A ''точност'':9A ''управлен'':47A ''целостн'':36A,46A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17189, 15627, 'Состояние информации, при котором ее изменение осуществляется преднамеренно только субъектами, имеющими на него право.', '''изменен'':6A ''имеющ'':11A ''информац'':2A ''котор'':4A ''осуществля'':7A ''прав'':14A ''преднамерен'':8A ''состоян'':1A ''субъект'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17190, 15627, 'Свойство информации при ее обработке техническими средствами, обеспечивающее предотвращение ее несанкционированной модификации или несанкционированного уничтожения.', '''информац'':2A ''модификац'':12A ''несанкционирова'':11A,14A ''обеспечива'':8A ''обработк'':5A ''предотвращен'':9A ''свойств'':1A ''средств'':7A ''техническ'':6A ''уничтожен'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16877, 15310, 'Область научно-технической деятельности, которая на основе системного подхода интегрирует все средства сбора и управления пространственно-координированными данными для создания картографической информации. Французский словарь трактует геоматику как совокупность применений информатики для обработки географических данных, в частности, картографии.', '''географическ'':35A ''геоматик'':28A ''дан'':20A,36A ''деятельн'':5A ''интегрир'':11A ''информатик'':32A ''информац'':24A ''картограф'':39A ''картографическ'':23A ''координирова'':19A ''котор'':6A ''научн'':3A ''научно-техническ'':2A ''област'':1A ''обработк'':34A ''основ'':8A ''подход'':10A ''применен'':31A ''пространствен'':18A ''пространственно-координирова'':17A ''сбор'':14A ''системн'':9A ''словар'':26A ''совокупн'':30A ''создан'':22A ''средств'':13A ''техническ'':4A ''тракт'':27A ''управлен'':16A ''французск'':25A ''частност'':38A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17193, 15627, 'Состояние информации, при котором отсутствует любое ее изменение либо изменение осуществляется только преднамеренно субъектами, имеющими на него право.', '''изменен'':8A,10A ''имеющ'':15A ''информац'':2A ''котор'':4A ''либ'':9A ''люб'':6A ''осуществля'':11A ''отсутств'':5A ''прав'':18A ''преднамерен'':13A ''состоян'':1A ''субъект'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16878, 15311, 'Определение местоположения устройства с помощью IP-адреса, MAC-адреса, Wi-Fi, GPS, ГЛОНАСС.', '''fi'':14A ''gps'':15A ''ip'':7A ''ip-адрес'':6A ''mac'':10A ''mac-адрес'':9A ''wi'':13A ''wi-fi'':12A ''адрес'':8A,11A ''глонасс'':16A ''местоположен'':2A ''определен'':1A ''помощ'':5A ''устройств'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16879, 15312, 'Соотнесение информации с географическим фактором. Один из новых подходов к классификации, организации информационного поиска.', '''географическ'':4A ''информац'':2A ''информацион'':13A ''классификац'':11A ''нов'':8A ''организац'':12A ''подход'':9A ''поиск'':14A ''соотнесен'':1A ''фактор'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17194, 15627, 'Свойство информации, заключающееся в ее существовании в неискаженном виде (неизменном по отношению к некоторому фиксированному ее состоянию).', '''вид'':9A ''заключа'':3A ''информац'':2A ''неизмен'':10A ''неискажен'':8A ''некотор'':14A ''отношен'':12A ''свойств'':1A ''состоян'':17A ''существован'':6A ''фиксирова'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17197, 15630, 'Состояние системы, в котором существует полная гарантия того, что при любых условиях компьютерная система базируется на логически завершенных аппаратных и программных средствах, обеспечивающих работу защитных механизмов, логическую корректность и достоверность операционной системы и целостность данных.', '''аппаратн'':19A ''базир'':15A ''гарант'':7A ''дан'':35A ''достоверн'':30A ''завершен'':18A ''защитн'':25A ''компьютерн'':13A ''корректн'':28A ''котор'':4A ''логическ'':17A,27A ''люб'':11A ''механизм'':26A ''обеспечива'':23A ''операцион'':31A ''полн'':6A ''программн'':21A ''работ'':24A ''систем'':2A,14A,32A ''состоян'':1A ''средств'':22A ''существ'':5A ''услов'':12A ''целостн'':34A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17200, 15633, 'Объект АС, представляющий собой организационно-техническое объединение персонала, программно-технических средств и документации, предназначенное для контроля и управления ресурсами АС в целом путем координации деятельности нижестоящих пунктов управления в части задач оперативно-технического управления АС.', '''ас'':2A,22A,38A ''деятельн'':27A ''документац'':15A ''задач'':33A ''контрол'':18A ''координац'':26A ''нижестоя'':28A ''объединен'':8A ''объект'':1A ''оперативн'':35A ''оперативно-техническ'':34A ''организацион'':6A ''организационно-техническ'':5A ''персона'':9A ''предназначен'':16A ''представля'':3A ''программн'':11A ''программно-техническ'':10A ''пункт'':29A ''пут'':25A ''ресурс'':21A ''соб'':4A ''средств'':13A ''техническ'':7A,12A,36A ''управлен'':20A,30A,37A ''цел'':24A ''част'':32A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17209, 15642, 'Событие в АС или вне ее, произошедшее в результате действия обстоятельств непреодолимой силы (аварии, опасного природного явления, катастрофы, стихийного или иного бедствия), которое может повлечь или повлекло за собой человеческие жертвы, ущерб здоровью людей или окружающей среде, значительные материальные потери.', '''авар'':14A ''ас'':3A ''бедств'':22A ''вне'':5A ''действ'':10A ''жертв'':31A ''здоров'':33A ''значительн'':38A ''ин'':21A ''катастроф'':18A ''котор'':23A ''люд'':34A ''материальн'':39A ''непреодолим'':12A ''обстоятельств'':11A ''окружа'':36A ''опасн'':15A ''повлекл'':27A ''повлеч'':25A ''потер'':40A ''природн'':16A ''произошедш'':7A ''результат'':9A ''сил'':13A ''соб'':29A ''событ'':1A ''сред'':37A ''стихийн'':19A ''ущерб'':32A ''человеческ'':30A ''явлен'':17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16880, 15315, 'Информация в формализованном виде, пригодном для передачи, интерпретации, обработки и хранения в компьютерной системе.', '''вид'':4A ''интерпретац'':8A ''информац'':1A ''компьютерн'':13A ''обработк'':9A ''передач'':7A ''пригодн'':5A ''систем'':14A ''формализова'':3A ''хранен'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16881, 15315, 'Сведения, факты, показатели, выраженные как в числовой, так и любой другой форме.', '''выражен'':4A ''люб'':10A ''показател'':3A ''сведен'':1A ''факт'':2A ''форм'':12A ''числов'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17215, 15648, 'Полностью новая NGN, в которой все виды услуг доступны вне зависимости от местоположения абонента и используемых им интерфейсов (Ethernet, xDSL, WLAN и т. д.). Полностью новая NGN имеет открытую архитектуру и горизонтальную взаимосвязь на различных уровнях.', '''ethernet'':19A ''ngn'':3A,27A ''wlan'':21A ''xdsl'':20A ''абонент'':14A ''архитектур'':30A ''взаимосвяз'':33A ''вид'':7A ''вне'':10A ''горизонтальн'':32A ''д'':24A ''доступн'':9A ''зависим'':11A ''имеет'':28A ''интерфейс'':18A ''используем'':16A ''котор'':5A ''местоположен'':13A ''нов'':2A,26A ''открыт'':29A ''полност'':1A,25A ''различн'':35A ''т'':23A ''уровн'':36A ''услуг'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17217, 15651, 'Совокупность обратимых преобразований множества возможных открытых данных на множество возможных зашифрованных данных, осуществляемых по определенным правилам с применением ключей.', '''возможн'':5A,10A ''дан'':7A,12A ''зашифрова'':11A ''ключ'':19A ''множеств'':4A,9A ''обратим'':2A ''определен'':15A ''осуществля'':13A ''открыт'':6A ''правил'':16A ''преобразован'':3A ''применен'':18A ''совокупн'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16882, 15315, 'Информация, представленная в формализованном виде, пригодном для передачи, интерпретации или обработки с участием человека или автоматическими средствами.', '''автоматическ'':16A ''вид'':5A ''интерпретац'':9A ''информац'':1A ''обработк'':11A ''передач'':8A ''представлен'':2A ''пригодн'':6A ''средств'':17A ''участ'':13A ''формализова'':4A ''человек'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16883, 15316, 'Данные, введенные в систему обработки информации или в какую-то ее часть для сохранения или обработки.', '''введен'':2A ''дан'':1A ''информац'':6A ''как'':10A ''какую-т'':9A ''обработк'':5A,17A ''сист'':4A ''сохранен'':15A ''част'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16884, 15317, 'Данные, которые система обработки информации или какая-то ее часть передают из этой системы или части.', '''дан'':1A ''информац'':5A ''какая-т'':7A ''котор'':2A ''обработк'':4A ''переда'':12A ''систем'':3A,15A ''част'':11A,17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16885, 15318, 'Модель, отражающая логические взаимосвязи между элементами данных безотносительно их содержания и физической организации. При этом даталогическая модель разрабатывается с учетом конкретной реализации СУБД, также с учетом специфики конкретной предметной области на основе ее инфологической модели.', '''безотносительн'':8A ''взаимосвяз'':4A ''дан'':7A ''даталогическ'':16A ''инфологическ'':34A ''конкретн'':21A,28A ''логическ'':3A ''модел'':1A,17A,35A ''област'':30A ''организац'':13A ''основ'':32A ''отража'':2A ''предметн'':29A ''разрабатыва'':18A ''реализац'':22A ''содержан'':10A ''специфик'':27A ''субд'':23A ''такж'':24A ''учет'':20A,26A ''физическ'':12A ''элемент'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16886, 15319, 'Аппаратно реализованное устройство (элемент, блок), предназначенное для генерации случайных битовых последовательностей, обладающих необходимыми свойствами равновероятности порождаемой ключевой гаммы.', '''аппаратн'':1A ''битов'':10A ''блок'':5A ''гамм'':18A ''генерац'':8A ''ключев'':17A ''необходим'':13A ''облада'':12A ''порожда'':16A ''последовательн'':11A ''предназначен'':6A ''равновероятн'':15A ''реализова'':2A ''свойств'':14A ''случайн'':9A ''устройств'':3A ''элемент'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16887, 15320, 'Архитектура, в которой используется два типа сетевых объектов: клиенты (рабочие станции) и серверы (обслуживающие узлы сети). Установление соединения осуществляется по инициативе клиентов, посылающих запросы, а сетевые услуги предоставляют серверы. Такая структура сети позволяет более гибко распределять вычислительные ресурсы между рабочими станциями по сравнению с централизованной системой обслуживания типа «главный компьютер — периферийные станции».', '''архитектур'':1A ''вычислительн'':37A ''гибк'':35A ''главн'':49A ''запрос'':24A ''инициатив'':21A ''использ'':4A ''клиент'':9A,22A ''компьютер'':50A ''котор'':3A ''обслужива'':14A ''обслуживан'':47A ''объект'':8A ''осуществля'':19A ''периферийн'':51A ''позволя'':33A ''посыла'':23A ''предоставля'':28A ''рабоч'':10A,40A ''распределя'':36A ''ресурс'':38A ''сервер'':13A,29A ''сет'':16A,32A ''сетев'':7A,26A ''систем'':46A ''соединен'':18A ''сравнен'':43A ''станц'':11A,41A,52A ''структур'':31A ''так'':30A ''тип'':6A,48A ''узл'':15A ''услуг'':27A ''установлен'':17A ''централизова'':45A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16888, 15322, 'Манипулирование данными путем предоставления неполной или полной, но искаженной и недостоверной информации.', '''дан'':2A ''информац'':12A ''искажен'':9A ''манипулирован'':1A ''недостоверн'':11A ''неполн'':5A ''полн'':7A ''предоставлен'':4A ''пут'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16889, 15322, 'Заведомо ложные сведения, распространяемые с целью введения в заблуждение.', '''введен'':7A ''заблужден'':9A ''заведом'':1A ''ложн'':2A ''распространя'':4A ''сведен'':3A ''цел'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17218, 15651, 'Совокупность условных знаков, используемых для преобразования открытой информации в вид, исключающий ее восстановление (дешифрование), если наблюдающий (перехватывающий) не имеет сведений (ключа) для раскрытия шифра.', '''вид'':10A ''восстановлен'':13A ''дешифрован'':14A ''знак'':3A ''имеет'':19A ''информац'':8A ''исключа'':11A ''используем'':4A ''ключ'':21A ''наблюда'':16A ''открыт'':7A ''перехватыва'':17A ''преобразован'':6A ''раскрыт'':23A ''сведен'':20A ''совокупн'':1A ''условн'':2A ''шифр'':24A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16890, 15323, 'Устройство или программа, преобразующие закодированные данные в их исходный вид. Декодирование может означать перевод нечитаемых кодов (например, шифрованной информации) в читабельный текст.', '''вид'':10A ''дан'':6A ''декодирован'':11A ''закодирова'':5A ''информац'':19A ''исходн'':9A ''код'':16A ''например'':17A ''нечита'':15A ''означа'':13A ''перевод'':14A ''преобраз'':4A ''программ'':3A ''текст'':22A ''устройств'':1A ''читабельн'':21A ''шифрова'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16894, 15327, 'Технический прием, включающий преобразование объектного кода в исходный текст в целях изучения структуры и кодирования программы для ЭВМ.', '''включа'':3A ''изучен'':12A ''исходн'':8A ''код'':6A ''кодирован'':15A ''объектн'':5A ''преобразован'':4A ''при'':2A ''программ'':16A ''структур'':13A ''текст'':9A ''техническ'':1A ''цел'':11A ''эвм'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17223, 15656, 'Математическое, алгоритмическое (криптографическое) преобразование данных с целью получения шифрованного текста. Шифрование может быть предварительное (шифруется текст документа) и линейное (шифруется разговор). Кроме того, бывает шифрование блочное (каждый очередной блок шифруется независимо) и поточное (каждый знак шифруется независимо от других).', '''алгоритмическ'':2A ''блок'':29A ''блочн'':26A ''быва'':24A ''дан'':5A ''документ'':17A ''друг'':39A ''знак'':35A ''кажд'':27A,34A ''криптографическ'':3A ''кром'':22A ''линейн'':19A ''математическ'':1A ''независим'':31A,37A ''очередн'':28A ''получен'':8A ''поточн'':33A ''предварительн'':14A ''преобразован'':4A ''разговор'':21A ''текст'':10A,16A ''цел'':7A ''шифр'':15A,20A,30A,36A ''шифрова'':9A ''шифрован'':11A,25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16891, 15326, 'Технологии преобразования кодов знаковых форм в информацию.', '''знаков'':4A ''информац'':7A ''код'':3A ''преобразован'':2A ''технолог'':1A ''форм'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16892, 15326, 'Преобразование данных в исходную форму, которую они имели до кодирования; операция, обратная кодированию.', '''дан'':2A ''имел'':8A ''исходн'':4A ''кодирован'':10A,13A ''котор'':6A ''обратн'':12A ''операц'':11A ''преобразован'':1A ''форм'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16893, 15326, 'Операция восстановления сообщения по принятому сигналу.', '''восстановлен'':2A ''операц'':1A ''принят'':5A ''сигнал'':6A ''сообщен'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16897, 15330, 'Лексическая единица/ выражение, использующееся в качестве имени смысла.', '''выражен'':3A ''единиц'':2A ''имен'':7A ''использ'':4A ''качеств'':6A ''лексическ'':1A ''смысл'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16898, 15331, 'Любая конфигурационная единица, которая может быть причиной инцидента во время ее отказа, и для которой нет внедренной контрмеры. Единая точка отказа может быть сотрудником, или шагом в процессе или деятельности, также как и компонент ИТ-инфраструктуры.', '''внедрен'':17A ''врем'':10A ''деятельн'':30A ''един'':19A ''единиц'':3A ''инфраструктур'':37A ''инцидент'':8A ''ит'':36A ''ит-инфраструктур'':35A ''компонент'':34A ''контрмер'':18A ''конфигурацион'':2A ''котор'':4A,15A ''люб'':1A ''отказ'':12A,21A ''причин'':7A ''процесс'':28A ''сотрудник'':24A ''такж'':31A ''точк'':20A ''шаг'':26A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16899, 15332, 'Процессы на канальном уровне модели OSI. Модули PDU на транспортном уровне называются сегментами; на сетевом уровне — пакетами или дейтаграммами, а на канальном уровне — кадрами. Физический уровень использует биты.', '''osi'':6A ''pdu'':8A ''бит'':28A ''дейтаграмм'':19A ''использ'':27A ''кадр'':24A ''канальн'':3A,22A ''модел'':5A ''модул'':7A ''называ'':12A ''пакет'':17A ''процесс'':1A ''сегмент'':13A ''сетев'':15A ''транспортн'':10A ''уровен'':26A ''уровн'':4A,11A,16A,23A ''физическ'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16900, 15333, 'Затраты поставщика ИТ-услуг на предоставление единичного (отдельного) компонента ИТ-услуги. Например, затраты на одну рабочую станцию или на одну транзакцию.', '''единичн'':8A ''затрат'':1A,15A ''ит'':4A,12A ''ит-услуг'':3A,11A ''компонент'':10A ''например'':14A ''одн'':17A,22A ''отдельн'':9A ''поставщик'':2A ''предоставлен'':7A ''рабоч'':18A ''станц'':19A ''транзакц'':23A ''услуг'':5A,13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17228, 15662, 'Набор программ или программное обеспечение, которое выполняет функции эксперта при решении какой-либо задачи в области его компетенции. ЭС, как и эксперт-человек, в процессе своей работы оперирует со знаниями. Знания о предметной области, необходимые для работы ЭС, определенным образом формализованы и представлены в памяти ЭВМ в виде базы знаний, которая может изменяться и дополняться в процессе развития системы.', '''баз'':51A ''вид'':50A ''выполня'':7A ''дополня'':57A ''задач'':15A ''знан'':32A,33A,52A ''изменя'':55A ''какой-либ'':12A ''компетенц'':19A ''котор'':6A,53A ''либ'':14A ''набор'':1A ''необходим'':37A ''обеспечен'':5A ''област'':17A,36A ''образ'':42A ''оперир'':30A ''определен'':41A ''памят'':47A ''предметн'':35A ''представл'':45A ''программ'':2A ''программн'':4A ''процесс'':27A,59A ''работ'':29A,39A ''развит'':60A ''решен'':11A ''сво'':28A ''систем'':61A ''формализова'':43A ''функц'':8A ''человек'':25A ''эвм'':48A ''эксперт'':9A,24A ''эксперт-человек'':23A ''эс'':20A,40A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16901, 15334, 'Компоненты ИТ-услуги, которые обычно компонуются вместе и выпускаются в рамках одного релиза. Единица релиза обычно включает в себя компоненты, необходимые для выполнения какой-либо полезной функции. Например, единицей релиза может быть настольный компьютер, включающий в себя программное, аппаратное обеспечение, лицензии, документацию и т. п. Другим примером единицы релиза может служить целое приложение для расчета зарплаты, включая процедуры операционного управления ИТ и тренинги пользователей.', '''аппаратн'':41A ''включ'':59A ''включа'':18A,37A ''вмест'':8A ''выполнен'':24A ''выпуска'':10A ''документац'':44A ''друг'':48A ''единиц'':15A,31A,50A ''зарплат'':58A ''ит'':3A,63A ''ит-услуг'':2A ''какой-либ'':25A ''компон'':7A ''компонент'':1A,21A ''компьютер'':36A ''котор'':5A ''либ'':27A ''лиценз'':43A ''например'':30A ''настольн'':35A ''необходим'':22A ''обеспечен'':42A ''обычн'':6A,17A ''одн'':13A ''операцион'':61A ''п'':47A ''полезн'':28A ''пользовател'':66A ''приложен'':55A ''пример'':49A ''программн'':40A ''процедур'':60A ''рамк'':12A ''расчет'':57A ''релиз'':14A,16A,32A,51A ''служ'':53A ''т'':46A ''тренинг'':65A ''управлен'':62A ''услуг'':4A ''функц'':29A ''цел'':54A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17231, 15665, 'Компьютерная программа, фрагмент программного кода или последовательность команд, использующие уязвимости в программном обеспечении и применяемые для проведения атаки на вычислительную систему. Целью атаки может быть как захват контроля над системой (повышение привилегий), так и нарушение ее функционирования (DoS-атака). В зависимости от метода получения доступа к уязвимому программному обеспечению эксплойты подразделяются на удаленные (remote) и локальные (local).', '''dos'':39A ''dos-атак'':38A ''local'':58A ''remot'':55A ''атак'':18A,23A,40A ''вычислительн'':20A ''доступ'':46A ''зависим'':42A ''захват'':27A ''использ'':9A ''код'':5A ''команд'':8A ''компьютерн'':1A ''контрол'':28A ''локальн'':57A ''метод'':44A ''нарушен'':35A ''обеспечен'':13A,50A ''повышен'':31A ''подразделя'':52A ''получен'':45A ''последовательн'':7A ''привилег'':32A ''применя'':15A ''проведен'':17A ''программ'':2A ''программн'':4A,12A,49A ''сист'':21A ''систем'':30A ''удален'':54A ''уязвим'':10A,48A ''фрагмент'':3A ''функционирован'':37A ''цел'':22A ''эксплойт'':51A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16902, 15337, 'Совокупность баз и банков данных, технологий их ведения и использования, АС и сетей, функционирующих на основе единых принципов и по общим правилам, обеспечивающим информационное взаимодействие организаций и граждан, а также удовлетворение их информационных потребностей. Основные компоненты: информационные ресурсы, содержащие данные, сведения и знания, зафиксированные на соответствующих носителях информации; организационные структуры, обеспечивающие функционирование и развитие единого информационного пространства, в частности, сбор, обработку, хранение, распространение, поиск и передачу информации; средства информационного взаимодействия граждан и организаций, обеспечивающих им доступ к информационным ресурсам на основе соответствующих информационных технологий, включающие программно-технические средства и организационно-нормативные документы.', '''ас'':11A ''баз'':2A ''банк'':4A ''веден'':8A ''взаимодейств'':25A,70A ''включа'':85A ''гражда'':28A,71A ''дан'':5A,40A ''документ'':94A ''доступ'':76A ''един'':17A,55A ''зафиксирова'':44A ''знан'':43A ''информац'':48A,67A ''информацион'':24A,33A,37A,56A,69A,78A,83A ''использован'':10A ''компонент'':36A ''нормативн'':93A ''носител'':47A ''обеспечива'':23A,51A,74A ''обработк'':61A ''общ'':21A ''организац'':26A,73A ''организацион'':49A,92A ''организационно-нормативн'':91A ''основ'':16A,81A ''основн'':35A ''передач'':66A ''поиск'':64A ''потребн'':34A ''правил'':22A ''принцип'':18A ''программн'':87A ''программно-техническ'':86A ''пространств'':57A ''развит'':54A ''распространен'':63A ''ресурс'':38A,79A ''сбор'':60A ''сведен'':41A ''сет'':13A ''совокупн'':1A ''содержа'':39A ''соответств'':46A,82A ''средств'':68A,89A ''структур'':50A ''такж'':30A ''техническ'':88A ''технолог'':6A,84A ''удовлетворен'':31A ''функционир'':14A ''функционирован'':52A ''хранен'':62A ''частност'':59A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16905, 15338, 'Единое информационное пространство ВС РФ в широком смысле можно определить как специальным образом упорядоченную совокупность всей информации, имеющейся в Вооруженных Силах Российской Федерации, а в узком — как совокупность информационных ресурсов ВС РФ, упорядоченную по единым принципам и правилам формирования, формализации, хранения, распространения.', '''вооружен'':20A ''вс'':4A,31A ''все'':16A ''един'':1A,35A ''имеющ'':18A ''информац'':17A ''информацион'':2A,29A ''образ'':13A ''определ'':10A ''правил'':38A ''принцип'':36A ''пространств'':3A ''распространен'':42A ''ресурс'':30A ''российск'':22A ''рф'':5A,32A ''сил'':21A ''смысл'':8A ''совокупн'':15A,28A ''специальн'':12A ''узк'':26A ''упорядочен'':14A,33A ''федерац'':23A ''формализац'':40A ''формирован'':39A ''хранен'':41A ''широк'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16906, 15339, 'Централизованная, иерархическая, территориально распределенная структура, включающая силы и средства обнаружения и предупреждения компьютерных атак, а также органы управления различных уровней, в полномочия которых входят вопросы обеспечения безопасности автоматизированных систем управления КВО и иных элементов критической информационной инфраструктуры.', '''автоматизирова'':28A ''атак'':14A ''безопасн'':27A ''включа'':6A ''вопрос'':25A ''вход'':24A ''иерархическ'':2A ''ин'':33A ''информацион'':36A ''инфраструктур'':37A ''кво'':31A ''компьютерн'':13A ''котор'':23A ''критическ'':35A ''обеспечен'':26A ''обнаружен'':10A ''орга'':17A ''полномоч'':22A ''предупрежден'':12A ''различн'':19A ''распределен'':4A ''сил'':7A ''сист'':29A ''средств'':9A ''структур'':5A ''такж'':16A ''территориальн'':3A ''управлен'':18A,30A ''уровн'':20A ''централизова'':1A ''элемент'':34A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16907, 15340, 'Обработка траекторных сенсорных данных при помощи MapReduce.', '''mapreduc'':7A ''дан'':4A ''обработк'':1A ''помощ'':6A ''сенсорн'':3A ''траекторн'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17234, 15667, 'Уровень живучести АС, обеспечиваемый способностью системы эксплуатации АС реализовывать, поддерживать и восстанавливать функциональность систем (сетей), технических и программных средств по формированию и предоставлению ИТ-услуг пользователям при возникновении различного рода угроз и чрезвычайных ситуаций.', '''ас'':3A,8A ''возникновен'':29A ''восстанавлива'':12A ''живучест'':2A ''ит'':25A ''ит-услуг'':24A ''обеспечива'':4A ''поддержива'':10A ''пользовател'':27A ''предоставлен'':23A ''программн'':18A ''различн'':30A ''реализовыва'':9A ''род'':31A ''сет'':15A ''сист'':14A ''систем'':6A ''ситуац'':35A ''способн'':5A ''средств'':19A ''техническ'':16A ''угроз'':32A ''уровен'':1A ''услуг'':26A ''формирован'':21A ''функциональн'':13A ''чрезвычайн'':34A ''эксплуатац'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16908, 15341, 'Совокупность программных и аппаратных средств, обеспечивающих общение интеллектуальной системы с пользователем на ограниченных рамками проблемной области естественных языках. В состав естественно-языкового интерфейса входят словари, отражающие словарный состав и лексику языка, а также лингвистический процессор, осуществляющий анализ текстов (морфологический, синтаксический, семантический и прагматический) и синтез ответов пользователю.', '''анализ'':38A ''аппаратн'':4A ''вход'':25A ''естествен'':17A,22A ''естественно-языков'':21A ''интеллектуальн'':8A ''интерфейс'':24A ''лексик'':31A ''лингвистическ'':35A ''морфологическ'':40A ''обеспечива'':6A ''област'':16A ''общен'':7A ''ограничен'':13A ''осуществля'':37A ''ответ'':47A ''отража'':27A ''пользовател'':11A,48A ''прагматическ'':44A ''проблемн'':15A ''программн'':2A ''процессор'':36A ''рамк'':14A ''семантическ'':42A ''синтаксическ'':41A ''синтез'':46A ''систем'':9A ''словар'':26A ''словарн'':28A ''совокупн'':1A ''соста'':20A,29A ''средств'':5A ''такж'':34A ''текст'':39A ''язык'':18A,32A ''языков'':23A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16909, 15342, 'Алгоритм, заключающийся в принятии локально оптимальных решений на каждом этапе, ожидая, что конечное решение также окажется оптимальным.', '''алгоритм'':1A ''заключа'':2A ''кажд'':9A ''конечн'':13A ''локальн'':5A ''ожид'':11A ''окажет'':16A ''оптимальн'':6A,17A ''принят'':4A ''решен'':7A,14A ''такж'':15A ''этап'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16910, 15343, 'Свойство автоматизированной организации, при котором АС способна поддерживать бесперебойное функционирование организации и доступность ИТ-услуг, сохранять и восстанавливать свою функциональность с использованием специальных механизмов адаптации к условиям воздействия угроз.', '''автоматизирова'':2A ''адаптац'':26A ''ас'':6A ''бесперебойн'':9A ''воздейств'':29A ''восстанавлива'':19A ''доступн'':13A ''использован'':23A ''ит'':15A ''ит-услуг'':14A ''котор'':5A ''механизм'':25A ''организац'':3A,11A ''поддержива'':8A ''свойств'':1A ''сохраня'':17A ''специальн'':24A ''способн'':7A ''угроз'':30A ''услов'':28A ''услуг'':16A ''функциональн'':21A ''функционирован'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16911, 15344, 'Свойство АС, характеризуемое способностью выполнять установленный объем функций в условиях воздействий внешней среды и отказов компонентов системы в заданных пределах.', '''ас'':2A ''внешн'':12A ''воздейств'':11A ''выполня'':5A ''зада'':19A ''компонент'':16A ''объ'':7A ''отказ'':15A ''предел'':20A ''свойств'':1A ''систем'':17A ''способн'':4A ''сред'':13A ''услов'':10A ''установлен'':6A ''функц'':8A ''характеризуем'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16912, 15345, 'Свойство АСУ войсками (силами), характеризуемое способностью выполнять установленный объем функций в условиях воздействия внешней среды и отказов компонентов системы в заданных пределах.', '''ас'':2A ''внешн'':14A ''воздейств'':13A ''войск'':3A ''выполня'':7A ''зада'':21A ''компонент'':18A ''объ'':9A ''отказ'':17A ''предел'':22A ''свойств'':1A ''сил'':4A ''систем'':19A ''способн'':6A ''сред'':15A ''услов'':12A ''установлен'':8A ''функц'':10A ''характеризуем'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16913, 15346, 'Различные этапы в жизни ИТ-услуги, конфигурационной единицы, инцидента, проблемы, изменения и т. д. Жизненный цикл определяет категории для статуса и разрешенные переходы между статусами.', '''д'':15A ''единиц'':9A ''жизн'':4A ''жизнен'':16A ''изменен'':12A ''инцидент'':10A ''ит'':6A ''ит-услуг'':5A ''категор'':19A ''конфигурацион'':8A ''определя'':18A ''переход'':24A ''проблем'':11A ''различн'':1A ''разрешен'':23A ''статус'':21A,26A ''т'':14A ''услуг'':7A ''цикл'':17A ''этап'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16914, 15347, 'Совокупность взаимосвязанных процессов создания и последовательного изменения состояния АС от формирования исходных требований к ней до окончания эксплуатации и утилизации комплекса средств автоматизации АС.', '''автоматизац'':23A ''ас'':9A,24A ''взаимосвяза'':2A ''изменен'':7A ''исходн'':12A ''комплекс'':21A ''окончан'':17A ''последовательн'':6A ''процесс'':3A ''совокупн'':1A ''создан'':4A ''состоян'':8A ''средств'':22A ''требован'':13A ''утилизац'':20A ''формирован'':11A ''эксплуатац'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16915, 15348, 'Совокупность последовательных стадий, которые составляют процесс создания автоматизированной системы управления войсками (силами), включая проектирование, разработку, испытания, боевую эксплуатацию и снятие с эксплуатации.', '''автоматизирова'':8A ''боев'':17A ''включ'':13A ''войск'':11A ''испытан'':16A ''котор'':4A ''последовательн'':2A ''проектирован'':14A ''процесс'':6A ''разработк'':15A ''сил'':12A ''систем'':9A ''снят'':20A ''совокупн'':1A ''создан'':7A ''составля'':5A ''стад'':3A ''управлен'':10A ''эксплуатац'':18A,22A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16916, 15349, 'Жизненный цикл области существования и функционирования доверенных компонентов, в пределах которой предусматривается обеспечение необходимых условий непрерывности их жизнедеятельности и поддержания требуемого уровня доверия на всем протяжении его жизненного цикла.', '''всем'':25A ''довер'':23A ''доверен'':7A ''жизнедеятельн'':18A ''жизнен'':1A,28A ''компонент'':8A ''котор'':11A ''необходим'':14A ''непрерывн'':16A ''обеспечен'':13A ''област'':3A ''поддержан'':20A ''предел'':10A ''предусматрива'':12A ''протяжен'':26A ''существован'':4A ''требуем'':21A ''уровн'':22A ''услов'':15A ''функционирован'':6A ''цикл'':2A,29A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16917, 15350, 'Совокупность взаимоувязанных процессов последовательного изменения состояния изделий ВТ от формирования исходных требований к ним до снятия их с эксплуатации и списания.', '''взаимоувяза'':2A ''вт'':8A ''издел'':7A ''изменен'':5A ''исходн'':11A ''последовательн'':4A ''процесс'':3A ''снят'':16A ''совокупн'':1A ''состоян'':6A ''списан'':21A ''требован'':12A ''формирован'':10A ''эксплуатац'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16918, 15351, 'Период времени от возникновения замысла программирования системы до окончания ее эксплуатации.', '''возникновен'':4A ''времен'':2A ''замысл'':5A ''окончан'':9A ''период'':1A ''программирован'':6A ''систем'':7A ''эксплуатац'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17239, 15674, 'Специальное криптографическое средство обеспечения подлинности, целостности и авторства документа электронного (ДЭ) или документа технического электронного (ДТЭ). ЭП связывает содержание документа и идентификатор подписывающего лица и делает невозможным изменение документа без нарушения подлинности подписи. Формирование ЭП электронного документа или пакета документов (файла или файлов) при их подготовке и передаче, а также проверка наличия и неискаженности подписи обеспечиваются специальными программными средствами.', '''авторств'':8A ''дела'':26A ''документ'':9A,13A,20A,29A,37A,40A ''дтэ'':16A ''дэ'':11A ''идентификатор'':22A ''изменен'':28A ''криптографическ'':2A ''лиц'':24A ''налич'':52A ''нарушен'':31A ''невозможн'':27A ''неискажен'':54A ''обеспечен'':4A ''обеспечива'':56A ''пакет'':39A ''передач'':48A ''подготовк'':46A ''подлин'':5A,32A ''подпис'':33A,55A ''подписыва'':23A ''проверк'':51A ''программн'':58A ''связыва'':18A ''содержан'':19A ''специальн'':1A,57A ''средств'':3A,59A ''такж'':50A ''техническ'':14A ''файл'':41A,43A ''формирован'':34A ''целостн'':6A ''электрон'':10A,15A,36A ''эп'':17A,35A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16919, 15353, 'Конечный набор общих фаз и этапов, через которые система может проходить в течение своей истории жизни.', '''жизн'':16A ''истор'':15A ''конечн'':1A ''котор'':8A ''набор'':2A ''общ'':3A ''проход'':11A ''сво'':14A ''систем'':9A ''течен'':13A ''фаз'':4A ''этап'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16920, 15353, 'Развитие рассматриваемой системы во времени, начиная от замысла и заканчивая списанием.', '''времен'':5A ''заканчив'':10A ''замысл'':8A ''начин'':6A ''развит'':1A ''рассматрива'':2A ''систем'':3A ''списан'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17226, 15659, 'Информация, предназначенная для осуществления человеком в процессе интеллектуализированного человекоинформационного взаимодействия творческой деятельности, направленной на поиск и создание новых знаний.', '''взаимодейств'':10A ''деятельн'':12A ''знан'':19A ''интеллектуализирова'':8A ''информац'':1A ''направлен'':13A ''нов'':18A ''осуществлен'':4A ''поиск'':15A ''предназначен'':2A ''процесс'':7A ''создан'':17A ''творческ'':11A ''человек'':5A ''человекоинформацион'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16921, 15354, 'Документ, используемый для записи и описания или обозначения некоторых элементов во время выполнения процесса или операции. Обычно используется с уточнением, например: «журнал проблем», «журнал контроля качества», действие или дефект.', '''врем'':12A ''выполнен'':13A ''действ'':27A ''дефект'':29A ''документ'':1A ''журна'':22A,24A ''запис'':4A ''использ'':18A ''используем'':2A ''качеств'':26A ''контрол'':25A ''например'':21A ''некотор'':9A ''обозначен'':8A ''обычн'':17A ''операц'':16A ''описан'':6A ''пробл'':23A ''процесс'':14A ''уточнен'':20A ''элемент'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16922, 15355, 'Файлы, содержащие системную информацию работы сервера, используемую для анализа и оценки сайтов и их посетителей, в которых протоколируются все действия пользователя на сайте.', '''анализ'':9A ''действ'':20A ''информац'':4A ''используем'':7A ''котор'':17A ''оценк'':11A ''пользовател'':21A ''посетител'':15A ''протоколир'':18A ''работ'':5A ''сайт'':12A,23A ''сервер'':6A ''системн'':3A ''содержа'':2A ''файл'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16923, 15356, 'Поддержание специального файла-журнала, в который в последовательном и только последовательном режиме записывается информация обо всех изменениях файловой системы. Запись, как правило, производится порциями большого объема, что обеспечивает высокий уровень полезного использования дисковой памяти и высокую эффективность.', '''больш'':26A ''высок'':30A,37A ''дисков'':34A ''журна'':5A ''зап'':21A ''записыва'':14A ''изменен'':18A ''информац'':15A ''использован'':33A ''котор'':7A ''об'':16A ''обеспечива'':29A ''объем'':27A ''памят'':35A ''поддержан'':1A ''полезн'':32A ''порц'':25A ''последовательн'':9A,12A ''прав'':23A ''производ'':24A ''режим'':13A ''систем'':20A ''специальн'':2A ''уровен'':31A ''файл'':4A ''файла-журна'':3A ''файлов'':19A ''эффективн'':38A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16924, 15357, 'Процессы, выполняемые для формального завершения всех операций проекта или фазы и передачи полученного продукта другим, или для завершения остановленного проекта.', '''выполня'':2A ''друг'':15A ''завершен'':5A,18A ''операц'':7A ''остановлен'':19A ''передач'':12A ''получен'':13A ''продукт'':14A ''проект'':8A,20A ''процесс'':1A ''фаз'':10A ''формальн'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16925, 15358, 'Функция или часть функции АС, представляющая собой формализованную совокупность автоматических действий, выполнение которых приводит к результату заданного вида.', '''автоматическ'':10A ''ас'':5A ''вид'':18A ''выполнен'':12A ''действ'':11A ''зада'':17A ''котор'':13A ''представля'':6A ''привод'':14A ''результат'':16A ''соб'':7A ''совокупн'':9A ''формализова'':8A ''функц'':1A,4A ''част'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16926, 15359, 'Функция или часть функции АСУ войсками (силами), представляющая собой формализованную совокупность автоматических действий, выполнение которых приводит к результату заданного вида.', '''автоматическ'':12A ''ас'':5A ''вид'':20A ''войск'':6A ''выполнен'':14A ''действ'':13A ''зада'':19A ''котор'':15A ''представля'':8A ''привод'':16A ''результат'':18A ''сил'':7A ''соб'':9A ''совокупн'':11A ''формализова'':10A ''функц'':1A,4A ''част'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16927, 15360, 'Две признаковые структуры, имеющие в своем составе идентичные и достаточно информативные подструктуры, отражают один и тот же объект (или ситуацию) и могут быть объединены.', '''две'':1A ''достаточн'':10A ''идентичн'':8A ''имеющ'':4A ''информативн'':11A ''могут'':22A ''объедин'':24A ''объект'':18A ''отража'':13A ''подструктур'':12A ''признаков'':2A ''сво'':6A ''ситуац'':20A ''состав'':7A ''структур'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16928, 15361, 'Новая информация может синтезироваться с имеющейся в системе только при условии, что первая сочетает в себе новые данные с известными, и что та и другая имеют идентичную часть и объектовую структуру.', '''дан'':18A ''друг'':25A ''идентичн'':27A ''известн'':20A ''имеют'':26A ''имеющ'':6A ''информац'':2A ''нов'':1A,17A ''объектов'':30A ''перв'':13A ''синтезирова'':4A ''систем'':8A ''сочета'':14A ''структур'':31A ''та'':23A ''услов'':11A ''част'':28A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16929, 15362, 'Признаковая структура, отражающая индивидуальный объект, принадлежащий одному классу объектов, если она содержит подструктуру, принадлежащую достаточно информативной подструктуре описания этого класса.', '''достаточн'':15A ''индивидуальн'':4A ''информативн'':16A ''класс'':8A,20A ''объект'':5A,9A ''одн'':7A ''описан'':18A ''отража'':3A ''подструктур'':13A,17A ''признаков'':1A ''принадлежа'':6A,14A ''содерж'':12A ''структур'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16930, 15363, 'Две признаковые структуры, принадлежащие одному классу объектов, следует считать различными, если в них содержатся подструктуры с признаками, попарно идентичными по семантике и в то же время различными по синтактике.', '''врем'':26A ''две'':1A ''идентичн'':19A ''класс'':6A ''объект'':7A ''одн'':5A ''подструктур'':15A ''попарн'':18A ''признак'':17A ''признаков'':2A ''принадлежа'':4A ''различн'':10A,27A ''семантик'':21A ''синтактик'':29A ''след'':8A ''содержат'':14A ''структур'':3A ''счита'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16931, 15364, 'Некоторая признаковая структура отражает тот же объект, что и описание индивида, если она имеет тождественную с описанием подструктуру, и если последняя достаточно информативна, т. е. достаточна для выделения одного-единственного объекта.', '''выделен'':28A ''достаточн'':22A,26A ''е'':25A ''единствен'':31A ''имеет'':14A ''индивид'':11A ''информативн'':23A ''некотор'':1A ''объект'':7A,32A ''одн'':30A ''одного-единствен'':29A ''описан'':10A,17A ''отража'':4A ''подструктур'':18A ''последн'':21A ''признаков'':2A ''структур'':3A ''т'':24A ''тождествен'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16932, 15365, 'Данные, доступные ограниченному кругу пользователей.', '''дан'':1A ''доступн'':2A ''круг'':4A ''ограничен'':3A ''пользовател'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16933, 15366, 'Основная идея, раскрывающая состав, содержание, взаимосвязь и последовательность осуществления технических и организационных мероприятий, необходимых для достижения цели защиты информации.', '''взаимосвяз'':6A ''достижен'':16A ''защит'':18A ''иде'':2A ''информац'':19A ''мероприят'':13A ''необходим'':14A ''организацион'':12A ''основн'':1A ''осуществлен'':9A ''последовательн'':8A ''раскрыва'':3A ''содержан'':5A ''соста'':4A ''техническ'':10A ''цел'':17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16934, 15367, 'Уникальное имя, используемое для идентификации пользователя, человека или роли. Идентификатор используется для предоставления прав пользователю, человеку или роли. Пример идентификаторов — имя пользователя «i_ivanov» или роль «Менеджер изменений».', '''ivanov'':24A ''идентификатор'':10A,20A ''идентификац'':5A ''изменен'':28A ''им'':2A,21A ''использ'':11A ''используем'':3A ''менеджер'':27A ''пользовател'':6A,15A,22A ''прав'':14A ''предоставлен'':13A ''пример'':19A ''рол'':9A,18A,26A ''уникальн'':1A ''человек'':7A,16A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16935, 15368, 'Поле ячейки ATM, определяющее маршрут, которому принадлежит ячейка.', '''atm'':3A ''котор'':6A ''маршрут'':5A ''определя'':4A ''пол'':1A ''принадлеж'':7A ''ячейк'':2A,8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16936, 15369, 'Служебная часть пакета, по сути, логический идентификатор, который описывает тип, размер и время создания пакета, коммутируется вместе с пакетом и не имеет самостоятельного значения.', '''вмест'':17A ''врем'':13A ''значен'':24A ''идентификатор'':7A ''имеет'':22A ''коммутир'':16A ''котор'':8A ''логическ'':6A ''описыва'':9A ''пакет'':3A,15A,19A ''размер'':11A ''самостоятельн'':23A ''служебн'':1A ''создан'':14A ''сут'':5A ''тип'':10A ''част'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17240, 15674, 'Реквизит электронного документа, предназначенный для защиты данного электронного документа от подделки, полученный в результате криптографического преобразования информации с использованием закрытого ключа электронной подписи и позволяющий идентифицировать владельца сертификата ключа подписи, а также установить отсутствие искажения информации в электронном документе.', '''владельц'':27A ''дан'':7A ''документ'':3A,9A,39A ''закрыт'':20A ''защит'':6A ''идентифицирова'':26A ''информац'':17A,36A ''искажен'':35A ''использован'':19A ''ключ'':21A,29A ''криптографическ'':15A ''отсутств'':34A ''подделк'':11A ''подпис'':23A,30A ''позволя'':25A ''получен'':12A ''предназначен'':4A ''преобразован'':16A ''результат'':14A ''реквиз'':1A ''сертификат'':28A ''такж'':32A ''установ'':33A ''электрон'':2A,8A,22A,38A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17244, 15677, 'Документированная информация, представленная в электронной форме, то есть в виде, пригодном для восприятия человеком с использованием электронных вычислительных машин, а также для передачи по информационно-телекоммуникационным сетям или обработки в информационных системах.', '''вид'':10A ''восприят'':13A ''вычислительн'':18A ''документирова'':1A ''информац'':2A ''информацион'':26A,32A ''информационно-телекоммуникацион'':25A ''использован'':16A ''машин'':19A ''обработк'':30A ''передач'':23A ''представлен'':3A ''пригодн'':11A ''сет'':28A ''систем'':33A ''такж'':21A ''телекоммуникацион'':27A ''форм'':6A ''человек'':14A ''электрон'':5A,17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17251, 15684, 'Язык разметки документов для использования в сотовых телефонах и других мобильных устройствах по стандарту WAP (Wireless Application Protocol). По структуре напоминает несколько упрощенных HTML, но есть и ключевые отличия, поскольку WML ориентирован на устройства, не обладающие возможностями персональных компьютеров (небольшой экран, не все устройства могут отображать графику, небольшой размер памяти и т. д.).', '''applic'':17A ''html'':24A ''protocol'':18A ''wap'':15A ''wireless'':16A ''wml'':31A ''возможн'':37A ''график'':47A ''д'':53A ''документ'':3A ''друг'':10A ''использован'':5A ''ключев'':28A ''компьютер'':39A ''мобильн'':11A ''могут'':45A ''напомина'':21A ''небольш'':40A,48A ''нескольк'':22A ''облада'':36A ''ориентирова'':32A ''отлич'':29A ''отобража'':46A ''памят'':50A ''персональн'':38A ''поскольк'':30A ''размер'':49A ''разметк'':2A ''сотов'':7A ''стандарт'':14A ''структур'':20A ''т'':52A ''телефон'':8A ''упрощен'':23A ''устройств'':12A,34A,44A ''экра'':41A ''язык'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17262, 15695, 'Способ послойного изготовления практически любых предметов: от обуви до ювелирных изделий, оружия и аэрокосмических деталей. Основное правило 3D-печати в том, что это метод аддитивного производства, в отличие от механической обработки (токарная, фрезерная обработка и пиление — методы удаления ненужного).', '''3d'':19A ''3d-печати'':18A ''аддитивн'':26A ''аэрокосмическ'':14A ''детал'':15A ''изготовлен'':3A ''издел'':11A ''люб'':5A ''метод'':25A,38A ''механическ'':31A ''ненужн'':40A ''обработк'':32A,35A ''обув'':8A ''оруж'':12A ''основн'':16A ''отлич'':29A ''печат'':20A ''пилен'':37A ''послойн'':2A ''прав'':17A ''практическ'':4A ''предмет'':6A ''производств'':27A ''способ'':1A ''токарн'':33A ''удален'':39A ''фрезерн'':34A ''эт'':24A ''ювелирн'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17268, 15701, 'Концепция управления проактивными взаимоотношениями с покупателем. В терминах управления бизнесом предприятия это система организации работы фронт-офиса (front-office) с ориентировкой на потребности клиента, на проактивную работу с клиентом. В сравнении с ориентированием бизнеса на совершенствование работы бэк-офиса (back-office) путем использования преимуществ ERP систем CRM нацелен на совершенствование продаж, а не производства как такового.', '''back'':44A ''back-offic'':43A ''crm'':51A ''erp'':49A ''front'':20A ''front-offic'':19A ''offic'':21A,45A ''бизнес'':10A,36A ''бэк'':41A ''бэк-офис'':40A ''взаимоотношен'':4A ''использован'':47A ''клиент'':26A,31A ''концепц'':1A ''нацел'':52A ''организац'':14A ''ориентирован'':35A ''ориентировк'':23A ''офис'':18A,42A ''покупател'':6A ''потребн'':25A ''предприят'':11A ''преимуществ'':48A ''проактивн'':3A,28A ''продаж'':55A ''производств'':58A ''пут'':46A ''работ'':15A,29A,39A ''сист'':50A ''систем'':13A ''совершенствован'':38A,54A ''сравнен'':33A ''таков'':60A ''термин'':8A ''управлен'':2A,9A ''фронт'':17A ''фронт-офис'':16A ''эт'':12A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16937, 15372, 'Действия по присвоению субъектам и объектам доступа идентификаторов и (или) по сравнению предъявляемого идентификатора с перечнем присвоенных идентификаторов.', '''действ'':1A ''доступ'':7A ''идентификатор'':8A,14A,18A ''объект'':6A ''перечн'':16A ''предъявля'':13A ''присвоен'':3A,17A ''сравнен'':12A ''субъект'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16938, 15372, 'Процесс присвоения идентификатора (уникального имени); сравнение предъявляемого идентификатора с перечнем присвоенных идентификаторов.', '''идентификатор'':3A,8A,12A ''имен'':5A ''перечн'':10A ''предъявля'':7A ''присвоен'':2A,11A ''процесс'':1A ''сравнен'':6A ''уникальн'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16940, 15373, 'Определение характеристик знаний, необходимых для решения задач в АС.', '''ас'':9A ''задач'':7A ''знан'':3A ''необходим'':4A ''определен'':1A ''решен'':6A ''характеристик'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16941, 15374, 'Деятельность, отвечающая за сбор информации о конфигурационных единицах и их взаимоотношениях, и ввод этой информации в базу данных управления конфигурациями. Идентификация конфигурации также отвечает за маркировку самих конфигурационных единиц для того, чтобы иметь возможность найти соответствующие конфигурационные записи.', '''баз'':17A ''ввод'':13A ''взаимоотношен'':11A ''возможн'':34A ''дан'':18A ''деятельн'':1A ''единиц'':8A,29A ''запис'':38A ''идентификац'':21A ''имет'':33A ''информац'':5A,15A ''конфигурац'':20A,22A ''конфигурацион'':7A,28A,37A ''маркировк'':26A ''найт'':35A ''отвеча'':2A,24A ''сам'':27A ''сбор'':4A ''соответств'':36A ''такж'':23A ''управлен'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17252, 15685, 'Рекомендованный Консорциумом Всемирной паутины язык разметки. Спецификация XML описывает XML-документы и частично описывает поведение XML-процессоров (программ, читающих XML-документы и обеспечивающих доступ к их содержимому). XML разрабатывался как язык с простым формальным синтаксисом, удобный для создания и обработки документов программами и одновременно удобный для чтения и создания документов человеком с подчеркиванием нацеленности на использование в Интернете.', '''xml'':8A,11A,18A,23A,31A ''xml-документ'':10A,22A ''xml-процессор'':17A ''всемирн'':3A ''документ'':12A,24A,44A,53A ''доступ'':27A ''интернет'':61A ''использован'':59A ''консорциум'':2A ''нацелен'':57A ''обеспечива'':26A ''обработк'':43A ''одновремен'':47A ''описыва'':9A,15A ''паутин'':4A ''поведен'':16A ''подчеркиван'':56A ''программ'':20A,45A ''прост'':36A ''процессор'':19A ''разметк'':6A ''разрабатыва'':32A ''рекомендова'':1A ''синтаксис'':38A ''содержим'':30A ''создан'':41A,52A ''спецификац'':7A ''удобн'':39A,48A ''формальн'':37A ''частичн'':14A ''человек'':54A ''чита'':21A ''чтен'':50A ''язык'':5A,34A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16942, 15375, 'Действие по идентификации ресурсов, необходимых для выполнения выбранных действий, включая определение того, когда и где эти ресурсы потребуются.', '''включ'':10A ''выбра'':8A ''выполнен'':7A ''действ'':1A,9A ''идентификац'':3A ''необходим'':5A ''определен'':11A ''потреб'':18A ''ресурс'':4A,17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16943, 15376, 'Использование средств облачных систем, например, облачной базы данных человеческих лиц, для идентификации.', '''баз'':7A ''дан'':8A ''идентификац'':12A ''использован'':1A ''лиц'':10A ''например'':5A ''облачн'':3A,6A ''сист'':4A ''средств'':2A ''человеческ'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16944, 15377, 'Соглашение о наименовании, используемое для уникальной идентификации релиза. Идентификация релиза обычно включает в себя ссылку на соответствующую конфигурационную единицу и номер версии. Например, Microsoft Office 2010 SR2.', '''2010'':26A ''microsoft'':24A ''offic'':25A ''sr2'':27A ''верс'':22A ''включа'':12A ''единиц'':19A ''идентификац'':7A,9A ''используем'':4A ''конфигурацион'':18A ''наименован'':3A ''например'':23A ''номер'':21A ''обычн'':11A ''релиз'':8A,10A ''соглашен'':1A ''соответств'':17A ''ссылк'':15A ''уникальн'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16945, 15378, 'Определение того, какие риски способны повлиять на АС, и документирование характеристик этих рисков.', '''ас'':8A ''документирован'':10A ''как'':3A ''определен'':1A ''повлия'':6A ''риск'':4A,13A ''способн'':5A ''характеристик'':11A ''эт'':12A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17271, 15704, 'Термин, обозначающий ряд подходов, направленных на реализацию хранилищ баз данных, имеющих существенные отличия от моделей, используемых в традиционных реляционных СУБД с доступом к данным средствами языка SQL. Применяется к базам данных, в которых делается попытка решить проблемы масштабируемости (scalability) и доступности (availability) за счет атомарности (atomicity) и согласованности данных (consistency).', '''atom'':46A ''avail'':42A ''consist'':50A ''scalabl'':39A ''sql'':27A ''атомарн'':45A ''баз'':9A,30A ''дан'':10A,24A,31A,49A ''дела'':34A ''доступ'':22A ''доступн'':41A ''имеющ'':11A ''используем'':16A ''котор'':33A ''масштабируем'':38A ''модел'':15A ''направлен'':5A ''обознача'':2A ''отлич'':13A ''подход'':4A ''попытк'':35A ''применя'':28A ''проблем'':37A ''реализац'':7A ''реляцион'':19A ''реш'':36A ''ряд'':3A ''согласован'':48A ''средств'':25A ''субд'':20A ''существен'':12A ''счет'':44A ''термин'':1A ''традицион'':18A ''хранилищ'':8A ''язык'':26A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16946, 15379, 'Логическая модель данных в виде древовидной структуры, представляющая собой совокупность элементов, расположенных в порядке их подчинения от общего к частному и образующих перевернутое дерево (граф). Данная модель характеризуется такими параметрами, как уровни, узлы, связи. Принцип работы модели таков, что несколько узлов более низкого уровня соединяются при помощи связи с одним узлом более высокого уровня. Узел — информационная модель элемента, находящегося на данном уровне иерархии.', '''вид'':5A ''высок'':53A ''граф'':25A ''дан'':3A,26A,61A ''дерев'':24A ''древовидн'':6A ''иерарх'':63A ''информацион'':56A ''логическ'':1A ''модел'':2A,27A,37A,57A ''находя'':59A ''нескольк'':40A ''низк'':43A ''образ'':22A ''общ'':18A ''одн'':50A ''параметр'':30A ''перевернут'':23A ''подчинен'':16A ''помощ'':47A ''порядк'':14A ''представля'':8A ''принцип'':35A ''работ'':36A ''расположен'':12A ''связ'':34A,48A ''соб'':9A ''совокупн'':10A ''соединя'':45A ''структур'':7A ''так'':29A,38A ''узел'':55A ''узл'':33A,41A,51A ''уровн'':32A,44A,54A,62A ''характериз'':28A ''частн'':20A ''элемент'':11A,58A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16947, 15380, 'Информирование или вовлечение руководителей более высокого уровня в ходе эскалации.', '''вовлечен'':3A ''высок'':6A ''информирован'':1A ''руководител'':4A ''уровн'':7A ''ход'':9A ''эскалац'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16948, 15381, 'Протокол, в котором маршрут выбирается на основании информации о состоянии канала (link state). Данный протокол разработан на основе протокола RIP и является более эффективным в больших распределенных сетях. Протокол описан в документе RFC 1247 и является достаточно современной реализацией алгоритма состояния канала.', '''1247'':34A ''link'':12A ''rfc'':33A ''rip'':20A ''state'':13A ''алгоритм'':40A ''больш'':26A ''выбира'':5A ''дан'':14A ''документ'':32A ''достаточн'':37A ''информац'':8A ''кана'':11A,42A ''котор'':3A ''маршрут'':4A ''описа'':30A ''основ'':18A ''основан'':7A ''протокол'':1A,15A,19A,29A ''разработа'':16A ''распределен'':27A ''реализац'':39A ''сет'':28A ''современ'':38A ''состоян'':10A,41A ''эффективн'':24A ''явля'':22A,36A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17100, 15533, 'Обработка данных, при которой выполнение операций распределено по узлам вычислительной сети.
Примечание — Для распределенной обработки данных требуется коллективное сотрудничество, которое достигается путем обмена данными между узлами.', '''выполнен'':5A ''вычислительн'':10A ''дан'':2A,16A,24A ''достига'':21A ''коллективн'':18A ''котор'':4A,20A ''обм'':23A ''обработк'':1A,15A ''операц'':6A ''примечан'':12A ''пут'':22A ''распредел'':7A ''распределен'':14A ''сет'':11A ''сотрудничеств'':19A ''треб'':17A ''узл'':9A,26A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17029, 15462, 'Совокупность координатно-временных данных, характеризующих параметры местонахождения, скорости и направления движения транспортного средства, получаемая с помощью навигационной аппаратуры потребителей глобальных навигационных спутниковых систем и передаваемая в диспетчерский пункт по каналам данных.', '''аппаратур'':19A ''времен'':4A ''глобальн'':21A ''дан'':5A,32A ''движен'':12A ''диспетчерск'':28A ''канал'':31A ''координатн'':3A ''координатно-времен'':2A ''местонахожден'':8A ''навигацион'':18A,22A ''направлен'':11A ''параметр'':7A ''передава'':26A ''получа'':15A ''помощ'':17A ''потребител'':20A ''пункт'':29A ''сист'':24A ''скорост'':9A ''совокупн'':1A ''спутников'':23A ''средств'':14A ''транспортн'':13A ''характериз'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16949, 15383, 'Получение наиболее полного из возможных представлений о предметной области и связанных с ней проблем; процедура взаимодействия эксперта с источником знаний, в результате которой становятся явными процесс суждений специалистов при принятии решений и структура их представления о предметной области; получение информации о предметной области от специалистов и выражение ее на языке представления знаний. Совокупность коммутативных и других методов, используемых для воссоздания формализованной модели смысла предметной области, исходной информации (текста), необходимой для обработки в знание-ориентированной АС.', '''ас'':76A ''взаимодейств'':16A ''возможн'':5A ''воссоздан'':60A ''выражен'':47A ''друг'':56A ''знан'':20A,52A,74A ''знание-ориентирова'':73A ''информац'':40A,67A ''используем'':58A ''источник'':19A ''исходн'':66A ''коммутативн'':54A ''котор'':23A ''метод'':57A ''модел'':62A ''наибол'':2A ''необходим'':69A ''област'':9A,38A,43A,65A ''обработк'':71A ''ориентирова'':75A ''полн'':3A ''получен'':1A,39A ''предметн'':8A,37A,42A,64A ''представлен'':6A,35A,51A ''принят'':30A ''пробл'':14A ''процедур'':15A ''процесс'':26A ''результат'':22A ''решен'':31A ''связа'':11A ''смысл'':63A ''совокупн'':53A ''специалист'':28A,45A ''станов'':24A ''структур'':33A ''сужден'':27A ''текст'':68A ''формализова'':61A ''эксперт'':17A ''явн'':25A ''язык'':50A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16950, 15383, 'Процедура взаимодействия эксперта с источником знаний, в результате которой становятся явными процесс рассуждений специалистов при принятии решения и структура их представлений о предметной области.', '''взаимодейств'':2A ''знан'':6A ''источник'':5A ''котор'':9A ''област'':24A ''предметн'':23A ''представлен'':21A ''принят'':16A ''процедур'':1A ''процесс'':12A ''рассужден'':13A ''результат'':8A ''решен'':17A ''специалист'':14A ''станов'':10A ''структур'':19A ''эксперт'':3A ''явн'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16951, 15385, 'Особым образом сгруппированная группа битов физического уровня, к которой добавляется битовый заголовок, содержащий аппаратные адреса отправителя и получателя, контрольную сумму для определения целостности фрейма и некоторые флаги, управляющие процессом передачи.', '''адрес'':15A ''аппаратн'':14A ''бит'':5A ''битов'':11A ''групп'':4A ''добавля'':10A ''заголовок'':12A ''контрольн'':19A ''котор'':9A ''некотор'':26A ''образ'':2A ''определен'':22A ''особ'':1A ''отправител'':16A ''передач'':30A ''получател'':18A ''процесс'':29A ''сгруппирова'':3A ''содержа'':13A ''сумм'':20A ''управля'':28A ''уровн'':7A ''физическ'':6A ''флаг'':27A ''фрейм'':24A ''целостн'':23A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16952, 15385, 'Структура для описания стереотипной ситуации, состоящая из характеристик этой ситуации и их значений.', '''значен'':13A ''описан'':3A ''ситуац'':5A,10A ''состоя'':6A ''стереотипн'':4A ''структур'':1A ''характеристик'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16953, 15386, 'Состояние защищенности АС, при котором исключается недопустимый риск возникновения ущерба основной деятельности организации вследствие злоумышленных действий пользователей и персонала АС на этапах проектирования, создания и эксплуатации АС.', '''ас'':3A,20A,27A ''возникновен'':9A ''вследств'':14A ''действ'':16A ''деятельн'':12A ''защищен'':2A ''злоумышлен'':15A ''исключа'':6A ''котор'':5A ''недопустим'':7A ''организац'':13A ''основн'':11A ''персона'':19A ''пользовател'':17A ''проектирован'':23A ''риск'':8A ''создан'':24A ''состоян'':1A ''ущерб'':10A ''эксплуатац'':26A ''этап'':22A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16956, 15389, 'Интеллектуальный продукт, находящийся в корпоративной собственности и независимый от его индивидуального производителя.', '''индивидуальн'':11A ''интеллектуальн'':1A ''корпоративн'':5A ''находя'':3A ''независим'':8A ''продукт'':2A ''производител'':12A ''собствен'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16957, 15390, 'Процесс идентификации знаний и умений, необходимый для выработки решения.', '''выработк'':8A ''знан'':3A ''идентификац'':2A ''необходим'':6A ''процесс'':1A ''решен'':9A ''умен'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17101, 15534, 'Режим работы части АС, обусловленный нештатным состоянием одного из ресурсов (ошибка, сбой, отказ, инцидент), но не требующий проведения работ по его восстановлению на основании типового или уникального проекта.', '''ас'':4A ''восстановлен'':22A ''инцидент'':14A ''нештатн'':6A ''обусловлен'':5A ''одн'':8A ''основан'':24A ''отказ'':13A ''ошибк'':11A ''проведен'':18A ''проект'':28A ''работ'':2A,19A ''реж'':1A ''ресурс'':10A ''сбо'':12A ''состоян'':7A ''типов'':25A ''треб'':17A ''уникальн'':27A ''част'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16954, 15388, 'Второй уровень сетевой модели OSI. Этот уровень обеспечивает организацию, поддержку и разрыв связи на уровне передачи данных между элементами сети. Основной функцией уровня 2 является передача модулей информации или кадров и связанный с этим контроль ошибок.', '''2'':24A ''osi'':5A ''втор'':1A ''дан'':17A ''информац'':28A ''кадр'':30A ''контрол'':35A ''модел'':4A ''модул'':27A ''обеспечива'':8A ''организац'':9A ''основн'':21A ''ошибок'':36A ''передач'':16A,26A ''поддержк'':10A ''разр'':12A ''связ'':13A ''связа'':32A ''сет'':20A ''сетев'':3A ''уровен'':2A,7A ''уровн'':15A,23A ''функц'':22A ''элемент'':19A ''эт'':34A ''явля'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17030, 15463, 'Комплексное свойство АС сохранять во времени в установленных пределах значения всех параметров, характеризующих способность АС выполнять свои функции в заданных режимах и условиях эксплуатации.
Примечание — Надежность АС включает свойства безотказности и ремонтопригодности АС, а в некоторых случаях и долговечности технических средств АС.', '''ас'':3A,15A,27A,33A,42A ''безотказн'':30A ''включа'':28A ''времен'':6A ''выполня'':16A ''долговечн'':39A ''зада'':20A ''значен'':10A ''комплексн'':1A ''надежн'':26A ''некотор'':36A ''параметр'':12A ''предел'':9A ''примечан'':25A ''режим'':21A ''ремонтопригодн'':32A ''сво'':17A ''свойств'':2A,29A ''случа'':37A ''сохраня'':4A ''способн'':14A ''средств'':41A ''техническ'':40A ''услов'':23A ''установлен'':8A ''функц'':18A ''характериз'':13A ''эксплуатац'':24A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16958, 15391, 'Визуальное восприятие информационных образований на средствах отображения, динамически развивающихся во времени, пространстве, с использованием в различных сочетаниях образов, замещающих реальные объекты, знаков в сообщениях, представленных в картинном виде с возможным динамически развивающимся аудиальным, кинестетически воспринимаемым информационным сопровождением.', '''аудиальн'':33A ''вид'':28A ''визуальн'':1A ''возможн'':30A ''воспринима'':35A ''восприят'':2A ''времен'':11A ''динамическ'':8A,31A ''замеща'':19A ''знак'':22A ''информацион'':3A,36A ''использован'':14A ''картин'':27A ''кинестетическ'':34A ''образ'':18A ''образован'':4A ''объект'':21A ''отображен'':7A ''представлен'':25A ''пространств'':12A ''развива'':9A,32A ''различн'':16A ''реальн'':20A ''сообщен'':24A ''сопровожден'':37A ''сочетан'':17A ''средств'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17051, 15484, 'Деятельность в рамках процесса управления инцидентами, направленная на скорейшее восстановление предоставления ИТ-услуги пользователю за счет применения известных типовых решений диспетчерами.', '''восстановлен'':10A ''деятельн'':1A ''диспетчер'':22A ''известн'':19A ''инцидент'':6A ''ит'':13A ''ит-услуг'':12A ''направлен'':7A ''пользовател'':15A ''предоставлен'':11A ''применен'':18A ''процесс'':4A ''рамк'':3A ''решен'':21A ''скор'':9A ''счет'':17A ''типов'':20A ''управлен'':5A ''услуг'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17054, 15487, 'Функциональные возможности программного обеспечения, описание которых не представлено в документации на автоматизированную систему управления войсками (силами), при реализации которых может произойти нарушение конфиденциальности, доступности или целостности обрабатываемой информации.', '''автоматизирова'':12A ''возможн'':2A ''войск'':15A ''документац'':10A ''доступн'':24A ''информац'':28A ''конфиденциальн'':23A ''котор'':6A,19A ''нарушен'':22A ''обеспечен'':4A ''обрабатыва'':27A ''описан'':5A ''представл'':8A ''программн'':3A ''произойт'':21A ''реализац'':18A ''сил'':16A ''сист'':13A ''управлен'':14A ''функциональн'':1A ''целостн'':26A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17055, 15488, 'Область научных исследований, лежащая на пересечении нейронаук и информатики. В сферу нейроинформатики входит сбор результатов, полученных в ходе нейробиологических исследований, перевод этих результатов в формат баз данных для их последующего анализа с помощью вычислительных моделей и специализированных компьютерных аналитических программных инструментов, обеспечение совместимости между базами данных, форматами моделей и другими коллекциями данных для облегчения обмена информацией о различных аспектах функционирования и строения нервных систем.', '''анализ'':31A ''аналитическ'':39A ''аспект'':59A ''баз'':26A,45A ''вход'':13A ''вычислительн'':34A ''дан'':27A,46A,52A ''друг'':50A ''инструмент'':41A ''информатик'':9A ''информац'':56A ''исследован'':3A,20A ''коллекц'':51A ''компьютерн'':38A ''лежа'':4A ''модел'':35A,48A ''научн'':2A ''нейробиологическ'':19A ''нейроинформатик'':12A ''нейронаук'':7A ''нервн'':63A ''обеспечен'':42A ''област'':1A ''облегчен'':54A ''обм'':55A ''перевод'':21A ''пересечен'':6A ''получен'':16A ''помощ'':33A ''послед'':30A ''программн'':40A ''различн'':58A ''результат'':15A,23A ''сбор'':14A ''сист'':64A ''совместим'':43A ''специализирова'':37A ''строен'':62A ''сфер'':11A ''формат'':25A,47A ''функционирован'':60A ''ход'':18A ''эт'':22A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17053, 15486, 'Функциональные возможности средств вычислительной техники и программного обеспечения, не описанные или не соответствующие описанным в документации, которые могут привести к снижению или нарушению свойств безопасности информации.', '''безопасн'':25A ''возможн'':2A ''вычислительн'':4A ''документац'':16A ''информац'':26A ''котор'':17A ''могут'':18A ''нарушен'':23A ''обеспечен'':8A ''описа'':10A,14A ''привест'':19A ''программн'':7A ''свойств'':24A ''снижен'':21A ''соответств'':13A ''средств'':3A ''техник'':5A ''функциональн'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17132, 15565, 'Слово или словосочетание, являющееся названием некоторого понятия какой-нибудь области науки, техники, искусства и т. д..', '''..'':18A ''д'':17A ''искусств'':14A ''какой-нибуд'':8A ''назван'':5A ''наук'':12A ''некотор'':6A ''област'':11A ''понят'':7A ''слов'':1A ''словосочетан'':3A ''т'':16A ''техник'':13A ''явля'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16959, 15392, 'Совокупность взаимосвязанных картографических данных по определенной предметной области, представленная в цифровой форме при соблюдении общих правил описания, хранения и манипулирования данными. Картографическая база данных доступна многим пользователям, не зависит от характера прикладных программ и управляется системой управления базами данных (СУБД).', '''баз'':23A,38A ''взаимосвяза'':2A ''дан'':4A,21A,24A,39A ''доступн'':25A ''завис'':29A ''картографическ'':3A,22A ''манипулирован'':20A ''мног'':26A ''област'':8A ''общ'':15A ''описан'':17A ''определен'':6A ''пользовател'':27A ''прав'':16A ''предметн'':7A ''представлен'':9A ''прикладн'':32A ''программ'':33A ''систем'':36A ''соблюден'':14A ''совокупн'':1A ''субд'':40A ''управлен'':37A ''управля'':35A ''форм'':12A ''характер'':31A ''хранен'':18A ''цифров'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16960, 15393, 'Таблица или группа связанных таблиц, содержащих систематизированную информацию, имеющую долгосрочный характер и предназначенную для обработки данных в экранных формах методом выбора из каталога.', '''выбор'':21A ''групп'':3A ''дан'':16A ''долгосрочн'':10A ''имеющ'':9A ''информац'':8A ''каталог'':23A ''метод'':20A ''обработк'':15A ''предназначен'':13A ''связа'':4A ''систематизирова'':7A ''содержа'':6A ''таблиц'':1A,5A ''форм'':19A ''характер'':11A ''экра'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16961, 15394, 'База данных или структурированный документ, содержащий систематизированную информацию об ИТ-услугах в режиме эксплуатации АС, включая те ИТ-услуги, которые доступны для развертывания. Каталог ИТ-услуг включает в себя информацию о результатах, ценах, точках контакта, процессах выполнения заказов и запросов.', '''ас'':16A ''баз'':1A ''включ'':17A ''включа'':30A ''выполнен'':40A ''дан'':2A ''документ'':5A ''доступн'':23A ''заказ'':41A ''запрос'':43A ''информац'':8A,33A ''ит'':11A,20A,28A ''ит-услуг'':10A,19A,27A ''каталог'':26A ''контакт'':38A ''котор'':22A ''процесс'':39A ''развертыван'':25A ''режим'':14A ''результат'':35A ''систематизирова'':7A ''содержа'':6A ''структурирова'':4A ''те'':18A ''точк'':37A ''услуг'':12A,21A,29A ''цен'':36A ''эксплуатац'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16962, 15395, 'Работы по единообразному представлению, сбору, классификации, идентификации, кодированию, регистрации, обработке, хранению и распределению информации о продукции, поставляемой (заказываемой) для федеральных государственных нужд.', '''государствен'':21A ''единообразн'':3A ''заказыва'':18A ''идентификац'':7A ''информац'':14A ''классификац'':6A ''кодирован'':8A ''нужд'':22A ''обработк'':10A ''поставля'':17A ''представлен'':4A ''продукц'':16A ''работ'':1A ''распределен'':13A ''регистрац'':9A ''сбор'':5A ''федеральн'':20A ''хранен'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16963, 15396, 'Способность системы сохранять непрерывность сервисной поддержки критически важных процессов организации в условиях деградации архитектуры системы, вызванной уничтожением или выходом из строя ее компонентов, объектов и связей между ними в результате крупномасштабных аварий, катастроф и чрезвычайных ситуаций.', '''авар'':32A ''архитектур'':14A ''важн'':8A ''вызва'':16A ''выход'':19A ''деградац'':13A ''катастроф'':33A ''компонент'':23A ''критическ'':7A ''крупномасштабн'':31A ''непрерывн'':4A ''ним'':28A ''объект'':24A ''организац'':10A ''поддержк'':6A ''процесс'':9A ''результат'':30A ''связ'':26A ''сервисн'':5A ''систем'':2A,15A ''ситуац'':36A ''сохраня'':3A ''способн'':1A ''стро'':21A ''уничтожен'':17A ''услов'':12A ''чрезвычайн'':35A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16964, 15397, 'Уровень безопасности информации, определяемый установленными нормами в зависимости от важности (ценности) информации.', '''безопасн'':2A ''важност'':10A ''зависим'':8A ''информац'':3A,12A ''норм'':6A ''определя'':4A ''уровен'':1A ''установлен'':5A ''ценност'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16967, 15400, 'Определенная совокупность требований к защите автоматизированной системы управления войсками (силами), а также ее объектов в соответствии с требованиями нормативных документов по предотвращению утечки информации за счет побочных электромагнитных излучений и наводок.', '''автоматизирова'':6A ''войск'':9A ''документ'':20A ''защ'':5A ''излучен'':29A ''информац'':24A ''наводок'':31A ''нормативн'':19A ''объект'':14A ''определен'':1A ''побочн'':27A ''предотвращен'':22A ''сил'':10A ''систем'':7A ''совокупн'':2A ''соответств'':16A ''счет'':26A ''такж'':12A ''требован'':3A,18A ''управлен'':8A ''утечк'':23A ''электромагнитн'':28A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16965, 15399, 'Показатель, отражающий уровень важности защищаемой информации в соответствии с установленными нормами.', '''важност'':4A ''защища'':5A ''информац'':6A ''норм'':11A ''отража'':2A ''показател'':1A ''соответств'':8A ''уровен'':3A ''установлен'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16966, 15399, 'Качественный показатель, отражающий степень важности защиты информации в выбранной шкале ценностей.', '''важност'':5A ''выбра'':9A ''защит'':6A ''информац'':7A ''качествен'':1A ''отража'':3A ''показател'':2A ''степен'':4A ''ценност'':11A ''шкал'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16968, 15401, 'Задержка в работе компьютерного приложения, когда оно не реагирует на пользовательский ввод вовремя.', '''ввод'':12A ''воврем'':13A ''задержк'':1A ''компьютерн'':4A ''он'':7A ''пользовательск'':11A ''приложен'':5A ''работ'':3A ''реагир'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16969, 15402, 'Способ защиты информации от технических разведок, предусматривающий преднамеренное распространение и поддержание ложной информации о функциональном предназначении объекта защиты.', '''защит'':2A,18A ''информац'':3A,13A ''ложн'':12A ''объект'':17A ''поддержан'':11A ''предназначен'':16A ''преднамерен'':8A ''предусматрива'':7A ''разведок'':6A ''распространен'':9A ''способ'':1A ''техническ'':5A ''функциональн'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16970, 15403, 'Процесс, задача которого автоматически распознать, какой части речи принадлежит каждое слово в тексте (каждому слову поставить в соответствие лексико-грамматический класс).', '''автоматическ'':4A ''грамматическ'':21A ''задач'':2A ''кажд'':10A,14A ''класс'':22A ''котор'':3A ''лексик'':20A ''лексико-грамматическ'':19A ''постав'':16A ''принадлеж'':9A ''процесс'':1A ''распозна'':5A ''реч'':8A ''слов'':11A,15A ''соответств'':18A ''текст'':13A ''част'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16971, 15404, 'Обозначение отдельного понятия (в т. ч. слова, устойчивые словосочетания, аббревиатуры, символы, даты, общепринятые сокращения, лексически значимые компоненты сложных слов естественного языка, а также эквивалентные им кодовые или символические обозначения искусственного языка).', '''аббревиатур'':10A ''дат'':12A ''естествен'':20A ''значим'':16A ''искусствен'':30A ''кодов'':26A ''компонент'':17A ''лексическ'':15A ''обозначен'':1A,29A ''общепринят'':13A ''отдельн'':2A ''понят'':3A ''символ'':11A ''символическ'':28A ''слов'':7A,19A ''словосочетан'':9A ''сложн'':18A ''сокращен'':14A ''т'':5A ''такж'':23A ''устойчив'':8A ''ч'':6A ''эквивалентн'':24A ''язык'':21A,31A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16972, 15405, 'Переменная, значение которой определяется набором вербальных (словесных) характеристик некоторого семейства.', '''вербальн'':6A ''значен'':2A ''котор'':3A ''набор'':5A ''некотор'':9A ''определя'':4A ''перемен'':1A ''семейств'':10A ''словесн'':7A ''характеристик'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16973, 15406, 'Частная совместимость AC, xaрактеризуемая возможностью использования одних и тех же языковых средств общения персонала с комплексом средств автоматизации этих АС.', '''ac'':3A ''xaрактеризуем'':4A ''автоматизац'':18A ''ас'':20A ''возможн'':5A ''использован'':6A ''комплекс'':16A ''общен'':13A ''одн'':7A ''персона'':14A ''совместим'':2A ''средств'':12A,17A ''тех'':9A ''частн'':1A ''эт'':19A ''языков'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17063, 15497, 'Данные произвольные по форме, включающие тексты и графику, мультимедиа (видео, речь, аудио), которые непосредственно не могут быть подвергнуты машинной обработке.', '''ауд'':12A ''виде'':10A ''включа'':5A ''график'':8A ''дан'':1A ''котор'':13A ''машин'':19A ''могут'':16A ''мультимед'':9A ''непосредствен'':14A ''обработк'':20A ''подвергнут'':18A ''произвольн'':2A ''реч'':11A ''текст'':6A ''форм'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16974, 15407, 'Логические приемы и методические правила научного исследования и изобретательского творчества, которые способны приводить к цели в условиях неполноты исходной информации и отсутствия четкой программы управления процессом решения задачи и при этом используют афоризмы, пословицы и поговорки естественного языка.', '''афоризм'':33A ''естествен'':37A ''задач'':28A ''изобретательск'':9A ''информац'':20A ''использ'':32A ''исследован'':7A ''исходн'':19A ''котор'':11A ''логическ'':1A ''методическ'':4A ''научн'':6A ''неполнот'':18A ''отсутств'':22A ''поговорк'':36A ''пословиц'':34A ''прав'':5A ''привод'':13A ''прием'':2A ''программ'':24A ''процесс'':26A ''решен'':27A ''способн'':12A ''творчеств'':10A ''управлен'':25A ''услов'':17A ''цел'':15A ''четк'':23A ''язык'':38A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16975, 15410, 'Совокупность различных приемов анализа текста (и его языковых средств), с помощью которых в стилистике формируются знания о закономерностях функционирования языка в различных сферах общения; способы теоретического освоения наблюдаемого и выявленного в процессе исследования.', '''анализ'':4A ''выявлен'':30A ''закономерн'':18A ''знан'':16A ''исследован'':33A ''котор'':12A ''наблюда'':28A ''общен'':24A ''освоен'':27A ''помощ'':11A ''прием'':3A ''процесс'':32A ''различн'':2A,22A ''совокупн'':1A ''способ'':25A ''средств'':9A ''стилистик'':14A ''сфер'':23A ''текст'':5A ''теоретическ'':26A ''формир'':15A ''функционирован'':19A ''язык'':20A ''языков'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16976, 15410, 'Вид языкового анализа, направленного на выявление системы языковых средств, с помощью которых передается идейно-тематическое и эстетическое содержание литературно-художественного произведения. В этом случае лингвистический анализ смыкается с анализом литературоведческим.', '''анализ'':3A,28A,31A ''вид'':1A ''выявлен'':6A ''идейн'':15A ''идейно-тематическ'':14A ''котор'':12A ''лингвистическ'':27A ''литературн'':21A ''литературно-художествен'':20A ''литературоведческ'':32A ''направлен'':4A ''переда'':13A ''помощ'':11A ''произведен'':23A ''систем'':7A ''случа'':26A ''смыка'':29A ''содержан'':19A ''средств'':9A ''тематическ'':16A ''художествен'':22A ''эстетическ'':18A ''языков'':2A,8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16977, 15410, 'Вид языкового анализа, направленного на характеристику стилистических ресурсов текста.', '''анализ'':3A ''вид'':1A ''направлен'':4A ''ресурс'':8A ''стилистическ'':7A ''текст'':9A ''характеристик'':6A ''языков'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16979, 15412, 'Реализованная на ЭВМ формальная лингвистическая модель, способная понимать и производить тексты на любом языке. Она включает три основных массива правил — морфологический, синтаксический и семантический — и обслуживающие их словари. Эти компоненты обеспечивают пофразное преобразование текста в морфологические, синтаксические и семантические структуры и обратно.', '''включа'':16A ''компонент'':30A ''лингвистическ'':5A ''люб'':13A ''массив'':19A ''модел'':6A ''морфологическ'':21A,36A ''обеспечива'':31A ''обратн'':42A ''обслужива'':26A ''основн'':18A ''понима'':8A ''пофразн'':32A ''прав'':20A ''преобразован'':33A ''производ'':10A ''реализова'':1A ''семантическ'':24A,39A ''синтаксическ'':22A,37A ''словар'':28A ''способн'':7A ''структур'':40A ''текст'':11A,34A ''формальн'':4A ''эвм'':3A ''язык'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16983, 15416, 'Частная совместимость автоматизированной системы управления войсками (силами), xaрактеризуемая возможностью использования одних и тех же языковых средств общения персонала с комплексом средств автоматизации этих АСУ войсками (силами).', '''xaрактеризуем'':8A ''автоматизац'':22A ''автоматизирова'':3A ''ас'':24A ''возможн'':9A ''войск'':6A,25A ''использован'':10A ''комплекс'':20A ''общен'':17A ''одн'':11A ''персона'':18A ''сил'':7A,26A ''систем'':4A ''совместим'':2A ''средств'':16A,21A ''тех'':13A ''управлен'':5A ''частн'':1A ''эт'':23A ''языков'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16984, 15417, 'Основная ИТ-услуга или пакет ИТ-услуг с набором опций. Линейка ИТ-услуг управляется владельцем ИТ-услуги. Каждая опция ИТ-услуги проектируется для поддержки определенного сегмента рынка.', '''владельц'':18A ''ит'':3A,8A,15A,20A,25A ''ит-услуг'':2A,7A,14A,19A,24A ''кажд'':22A ''линейк'':13A ''набор'':11A ''определен'':30A ''опц'':12A,23A ''основн'':1A ''пакет'':6A ''поддержк'':29A ''проектир'':27A ''рынк'':32A ''сегмент'':31A ''управля'':17A ''услуг'':4A,9A,16A,21A,26A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16980, 15414, 'Совокупность средств и правил для формализации естественного языка, используемых при общении пользователей и эксплуатационного персонала АС с комплексом средств автоматизации при функционировании АС.', '''автоматизац'':20A ''ас'':16A,23A ''естествен'':7A ''используем'':9A ''комплекс'':18A ''общен'':11A ''персона'':15A ''пользовател'':12A ''прав'':4A ''совокупн'':1A ''средств'':2A,19A ''формализац'':6A ''функционирован'':22A ''эксплуатацион'':14A ''язык'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16982, 15415, 'Совокупность средств для формализации естественного языка и информационных языков, включающих языки общения должностных лиц органов военного управления, которые являются пользователями автоматизированной системы управления войсками (силами), и обслуживающего персонала при взаимодействии с комплексом средств автоматизации автоматизированной системы.
Примечания:
1 Средствами для формализации естественного языка являются: словари терминов в области систем управления войсками; словари, фиксирующие смысловые отношения между лексическими единицами естественного языка; правила формализации информации; методы и способы выделения, представления и сопоставления содержания информационных сообщений.
2 Информационные языки включают следующие группы языковых средств: описания данных; манипулирования данными; программирования; управления функционированием вычислительного процесса и его обслуживанием.', '''1'':38A ''2'':74A ''автоматизац'':34A ''автоматизирова'':21A,35A ''взаимодейств'':30A ''включа'':10A,77A ''воен'':16A ''войск'':24A,51A ''выделен'':67A ''вычислительн'':89A ''групп'':79A ''дан'':83A,85A ''должностн'':13A ''единиц'':58A ''естествен'':5A,42A,59A ''информац'':63A ''информацион'':8A,72A,75A ''комплекс'':32A ''котор'':18A ''лексическ'':57A ''лиц'':14A ''манипулирован'':84A ''метод'':64A ''област'':48A ''обслужива'':27A ''обслуживан'':93A ''общен'':12A ''описан'':82A ''орган'':15A ''отношен'':55A ''персона'':28A ''пользовател'':20A ''прав'':61A ''представлен'':68A ''примечан'':37A ''программирован'':86A ''процесс'':90A ''сил'':25A ''сист'':49A ''систем'':22A,36A ''след'':78A ''словар'':45A,52A ''смыслов'':54A ''совокупн'':1A ''содержан'':71A ''сообщен'':73A ''сопоставлен'':70A ''способ'':66A ''средств'':2A,33A,39A,81A ''термин'':46A ''управлен'':17A,23A,50A,87A ''фиксир'':53A ''формализац'':4A,41A,62A ''функционирован'':88A ''явля'':19A,44A ''язык'':6A,9A,11A,43A,60A,76A ''языков'':80A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16985, 15418, 'Деятельность, заключающаяся в проверке (экспертизе) возможностей юридического лица выполнять работы в области защиты информации в соответствии с установленными требованиями и выдаче разрешения на выполнения этих работ.', '''возможн'':6A ''выдач'':21A ''выполнен'':24A ''выполня'':9A ''деятельн'':1A ''заключа'':2A ''защит'':13A ''информац'':14A ''лиц'':8A ''област'':12A ''проверк'':4A ''работ'':10A,26A ''разрешен'':22A ''соответств'':16A ''требован'':19A ''установлен'':18A ''экспертиз'':5A ''эт'':25A ''юридическ'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17064, 15497, 'Неформализованные данные, произвольные по форме и содержанию, которые непосредственно не могут быть подвергнуты машинной обработке.', '''дан'':2A ''котор'':8A ''машин'':14A ''могут'':11A ''непосредствен'':9A ''неформализова'':1A ''обработк'':15A ''подвергнут'':13A ''произвольн'':3A ''содержан'':7A ''форм'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17065, 15498, 'Информация, не обладающая при предъявлении свойством однозначного ее восприятия.', '''восприят'':9A ''информац'':1A ''облада'':3A ''однозначн'':7A ''предъявлен'':5A ''свойств'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17066, 15499, 'Количественное значение критерия безопасности информации, устанавливаемое в зависимости от категории безопасности.', '''безопасн'':4A,11A ''зависим'':8A ''значен'':2A ''информац'':5A ''категор'':10A ''количествен'':1A ''критер'':3A ''устанавлива'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17067, 15500, 'Информация, заимствованная из нормативных документов и справочников и используемая при функционировании АС.', '''ас'':12A ''документ'':5A ''заимствова'':2A ''информац'':1A ''используем'':9A ''нормативн'':4A ''справочник'':7A ''функционирован'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17078, 15511, 'Совокупность операций, связанных с хранением, поиском, анализом, оценкой, воспроизведением информации с целью представления ее в виде данных, удобных для использования потребителями.', '''анализ'':7A ''вид'':16A ''воспроизведен'':9A ''дан'':17A ''информац'':10A ''использован'':20A ''операц'':2A ''оценк'':8A ''поиск'':6A ''потребител'':21A ''представлен'':13A ''связа'':3A ''совокупн'':1A ''удобн'':18A ''хранен'':5A ''цел'':12A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17227, 15660, 'Исследование соответствия технической документации установленным требованиям с оценкой совершенства заложенных в ней технических и художественных решений.', '''документац'':4A ''заложен'':10A ''исследован'':1A ''оценк'':8A ''решен'':16A ''совершенств'':9A ''соответств'':2A ''техническ'':3A,13A ''требован'':6A ''установлен'':5A ''художествен'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17088, 15521, 'Процесс поиска определенной информации в большом фрагменте текста, а также разбиение данных на смысловые части.', '''больш'':6A ''дан'':12A ''информац'':4A ''определен'':3A ''поиск'':2A ''процесс'':1A ''разбиен'':11A ''смыслов'':14A ''такж'':10A ''текст'':8A ''фрагмент'':7A ''част'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17089, 15522, 'Участок сети, составляющий «последнюю милю», для передачи сигналов по которому не требуются питаемые или активные электронные устройства.', '''активн'':15A ''котор'':10A ''мил'':5A ''передач'':7A ''пита'':13A ''последн'':4A ''сет'':2A ''сигнал'':8A ''составля'':3A ''треб'':12A ''устройств'':17A ''участок'':1A ''электрон'':16A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17090, 15523, 'Информация, предназначенная для автоматизированного внесения определенных изменений в компьютерные файлы.', '''автоматизирова'':4A ''внесен'':5A ''изменен'':7A ''информац'':1A ''компьютерн'':9A ''определен'':6A ''предназначен'':2A ''файл'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17091, 15524, 'Соответствие полученной информации информационной потребности пользователя.', '''информац'':3A ''информацион'':4A ''получен'':2A ''пользовател'':6A ''потребн'':5A ''соответств'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17093, 15526, 'Количественная характеристика свойств документооборота, по которому документооборот оценивается.', '''документооборот'':4A,7A ''количествен'':1A ''котор'':6A ''оценива'':8A ''свойств'':3A ''характеристик'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17094, 15527, 'Юридическое лицо или его структурное подразделение, наделенное правом получения, хранения и общественного использования обязательного экземпляра на безвозмездной основе.', '''безвозмездн'':17A ''использован'':13A ''лиц'':2A ''наделен'':7A ''обществен'':12A ''обязательн'':14A ''основ'':18A ''подразделен'':6A ''получен'':9A ''прав'':8A ''структурн'':5A ''хранен'':10A ''экземпляр'':15A ''юридическ'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17095, 15528, 'Стадия жизненного цикла АС, характеризующаяся выполнением совокупности работ по разработке технической документации на изделия ВТ, изготовлению и испытанию опытного образца или партии опытных образцов АС, корректировке и утверждению документации после их государственных испытаний.', '''ас'':4A,25A ''вт'':15A ''выполнен'':6A ''государствен'':32A ''документац'':12A,29A ''жизнен'':2A ''изготовлен'':16A ''издел'':14A ''испытан'':18A,33A ''корректировк'':26A ''образц'':20A,24A ''опытн'':19A,23A ''парт'':22A ''работ'':8A ''разработк'':10A ''совокупн'':7A ''стад'':1A ''техническ'':11A ''утвержден'':28A ''характериз'':5A ''цикл'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17096, 15530, 'Набор файлов (отношений), хранящихся в разных узлах информационной сети и логически связанных таким образом, чтобы составлять единую совокупность данных (связь может быть функциональной или через копии одного и того же файла).', '''дан'':19A ''един'':17A ''информацион'':8A ''коп'':26A ''логическ'':11A ''набор'':1A ''образ'':14A ''одн'':27A ''отношен'':3A ''разн'':6A ''связ'':20A ''связа'':12A ''сет'':9A ''совокупн'':18A ''составля'':16A ''так'':13A ''узл'':7A ''файл'':2A,31A ''функциональн'':23A ''храня'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16986, 15419, 'Логико-семантический анализ на системном уровне описывает взаимосвязь предоставляемых бизнес-процессу ИТ-услуг, исходя из состояния ресурсных и сервисных возможностей АС. В корпоративной модели данных, построенной в соответствии с моделью SID (Shared Information and Data Model), ресурсы тесно связаны с сервисами и ИТ-услугами. Ресурсы и сервисы представляют детализацию механизмов реализации ИТ-услуг, предоставляемых пользователям.', '''data'':38A ''inform'':36A ''model'':39A ''share'':35A ''sid'':34A ''анализ'':4A ''ас'':24A ''бизнес'':12A ''бизнес-процесс'':11A ''взаимосвяз'':9A ''возможн'':23A ''дан'':28A ''детализац'':53A ''исход'':17A ''ит'':15A,47A,57A ''ит-услуг'':14A,46A,56A ''корпоративн'':26A ''логик'':2A ''логико-семантическ'':1A ''механизм'':54A ''модел'':27A,33A ''описыва'':8A ''пользовател'':60A ''построен'':29A ''предоставля'':10A,59A ''представля'':52A ''процесс'':13A ''реализац'':55A ''ресурс'':40A,49A ''ресурсн'':20A ''связа'':42A ''семантическ'':3A ''сервис'':44A,51A ''сервисн'':22A ''системн'':6A ''соответств'':31A ''состоян'':19A ''тесн'':41A ''уровн'':7A ''услуг'':16A,48A,58A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17097, 15530, 'База данных, которая физически распространяется на две и более компьютерные системы.', '''баз'':1A ''дан'':2A ''две'':7A ''компьютерн'':10A ''котор'':3A ''распространя'':5A ''систем'':11A ''физическ'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16987, 15420, 'Процесс исследования технических ресурсных возможностей системы и алгоритмов формирования семантического содержания различных видов функциональных технических и информационных сервисов.', '''алгоритм'':8A ''вид'':13A ''возможн'':5A ''информацион'':17A ''исследован'':2A ''процесс'':1A ''различн'':12A ''ресурсн'':4A ''семантическ'':10A ''сервис'':18A ''систем'':6A ''содержан'':11A ''техническ'':3A,15A ''формирован'':9A ''функциональн'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16988, 15421, 'Представление базы данных на логическом уровне; совокупность внешнего (пользовательского) и концептуального представления данных.', '''баз'':2A ''внешн'':8A ''дан'':3A,13A ''концептуальн'':11A ''логическ'':5A ''пользовательск'':9A ''представлен'':1A,12A ''совокупн'':7A ''уровн'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16990, 15423, 'Блокирование, выполняемое в базах данных на логическом уровне.', '''баз'':4A ''блокирован'':1A ''выполня'':2A ''дан'':5A ''логическ'':7A ''уровн'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16991, 15424, 'Односерверное решение, в котором с помощью встроенной технологии создается и поддерживается копия группы хранения на втором наборе дисков, подключенных к тому же серверу, на котором находится производственная группа хранения. Локальная непрерывная репликация обеспечивает асинхронную доставку и преобразование журналов, а также быстрое ручное переключение на дополнительную копию данных.', '''асинхрон'':34A ''быстр'':41A ''встроен'':7A ''втор'':16A ''групп'':13A,28A ''дан'':47A ''диск'':18A ''дополнительн'':45A ''доставк'':35A ''журнал'':38A ''коп'':12A,46A ''котор'':4A,25A ''локальн'':30A ''набор'':17A ''наход'':26A ''непрерывн'':31A ''обеспечива'':33A ''односерверн'':1A ''переключен'':43A ''поддержива'':11A ''подключен'':19A ''помощ'':6A ''преобразован'':37A ''производствен'':27A ''репликац'':32A ''решен'':2A ''ручн'':42A ''сервер'':23A ''созда'':9A ''такж'':40A ''технолог'':8A ''том'':21A ''хранен'':14A,29A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16992, 15425, 'Секция жесткого диска компьютера, т. е. виртуальный диск, реально не существующий, но созданный для удобства работы.', '''виртуальн'':7A ''диск'':3A,8A ''е'':6A ''жестк'':2A ''компьютер'':4A ''работ'':16A ''реальн'':9A ''секц'':1A ''созда'':13A ''существ'':11A ''т'':5A ''удобств'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16993, 15426, 'Скрытый программный или аппаратный механизм, обычно создаваемый для тестирования и поиска неисправностей, который может быть использован для обхода защиты компьютера.', '''аппаратн'':4A ''защит'':19A ''использова'':16A ''компьютер'':20A ''котор'':13A ''механизм'':5A ''неисправн'':12A ''обход'':18A ''обычн'':6A ''поиск'':11A ''программн'':2A ''скрыт'':1A ''создава'':7A ''тестирован'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16994, 15427, 'Транспортная телекоммуникационная инфраструктура для предоставления услуг связи. Магистральная сеть связи выстраивается на собственных или арендованных волоконно-оптических линиях с использованием канального оборудования связи.', '''арендова'':15A ''волокон'':17A ''волоконно-оптическ'':16A ''выстраива'':11A ''инфраструктур'':3A ''использован'':21A ''канальн'':22A ''лин'':19A ''магистральн'':8A ''оборудован'':23A ''оптическ'':18A ''предоставлен'':5A ''связ'':7A,10A,24A ''сет'':9A ''собствен'':13A ''телекоммуникацион'':2A ''транспортн'':1A ''услуг'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17133, 15566, 'Свойство аппаратно-программного обеспечения сохранять свою устойчивость и быстро восстанавливать свои надежностные характеристики при возникновении внутренних угроз и дефектов.', '''аппаратн'':3A ''аппаратно-программн'':2A ''быстр'':10A ''внутрен'':17A ''возникновен'':16A ''восстанавлива'':11A ''дефект'':20A ''надежностн'':13A ''обеспечен'':5A ''программн'':4A ''сво'':12A ''свойств'':1A ''сохраня'':6A ''угроз'':18A ''устойчив'':8A ''характеристик'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16995, 15428, 'Упрощенное воспроизведение в определенном масштабе изделия военной техники или его составной части, на котором исследуются отдельные характеристики изделия, а также оценивается правильность принятых конструктивных и технических решений.', '''воен'':7A ''воспроизведен'':2A ''издел'':6A,18A ''исслед'':15A ''конструктивн'':24A ''котор'':14A ''масштаб'':5A ''определен'':4A ''отдельн'':16A ''оценива'':21A ''правильн'':22A ''принят'':23A ''решен'':27A ''составн'':11A ''такж'':20A ''техник'':8A ''техническ'':26A ''упрощен'':1A ''характеристик'':17A ''част'':12A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17098, 15531, 'Сеть, в которой каждый узел сети наделен «интеллектом», а все коммутаторы и маршрутизаторы располагают информацией о состоянии других элементов сети, что позволяет им самостоятельно выбирать оптимальные маршруты доставки сообщений.', '''выбира'':25A ''доставк'':28A ''друг'':18A ''интеллект'':8A ''информац'':15A ''кажд'':4A ''коммутатор'':11A ''котор'':3A ''маршрут'':27A ''маршрутизатор'':13A ''надел'':7A ''оптимальн'':26A ''позволя'':22A ''располага'':14A ''самостоятельн'':24A ''сет'':1A,6A,20A ''сообщен'':29A ''состоян'':17A ''узел'':5A ''элемент'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16996, 15429, 'Программы на языках (макроязыках), встроенных в некоторые системы обработки данных (текстовые редакторы, электронные таблицы и т. д.). Для своего размножения такие вирусы используют возможности макроязыков и при их помощи переносят себя из одного зараженного файла (документа или таблицы) в другие.', '''вирус'':22A ''возможн'':24A ''встроен'':5A ''д'':17A ''дан'':10A ''документ'':36A ''друг'':40A ''заражен'':34A ''использ'':23A ''макроязык'':4A,25A ''некотор'':7A ''обработк'':9A ''одн'':33A ''перенос'':30A ''помощ'':29A ''программ'':1A ''размножен'':20A ''редактор'':12A ''сво'':19A ''систем'':8A ''т'':16A ''таблиц'':14A,38A ''так'':21A ''текстов'':11A ''файл'':35A ''электрон'':13A ''язык'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16997, 15430, 'Период времени, по истечении которого существует угроза окончательной потери жизнеспособности организации в том случае, если поставка продукции и/или предоставление ИТ-услуг не будут возобновлены.', '''будут'':25A ''возобновл'':26A ''времен'':2A ''жизнеспособн'':10A ''истечен'':4A ''ит'':22A ''ит-услуг'':21A ''котор'':5A ''окончательн'':8A ''организац'':11A ''период'':1A ''поставк'':16A ''потер'':9A ''предоставлен'':20A ''продукц'':17A ''случа'':14A ''существ'':6A ''угроз'':7A ''услуг'':23A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16998, 15432, 'Разграничение доступа субъектов к объектам, основанное на характеризуемой меткой конфиденциальности информации, содержащейся в объектах, и официальном разрешении (допуске) субъектов обращаться к информации такого уровня конфиденциальности.', '''допуск'':18A ''доступ'':2A ''информац'':11A,22A ''конфиденциальн'':10A,25A ''метк'':9A ''обраща'':20A ''объект'':5A,14A ''основа'':6A ''официальн'':16A ''разграничен'':1A ''разрешен'':17A ''содержа'':12A ''субъект'':3A,19A ''так'':23A ''уровн'':24A ''характеризуем'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (16999, 15432, 'Концепция (модель) доступа субъектов к информационным ресурсам по грифу секретности разрешенной к пользованию информации, определяемому меткой секретности (конфиденциальности).', '''гриф'':9A ''доступ'':3A ''информац'':14A ''информацион'':6A ''конфиденциальн'':18A ''концепц'':1A ''метк'':16A ''модел'':2A ''определя'':15A ''пользован'':13A ''разрешен'':11A ''ресурс'':7A ''секретн'':10A,17A ''субъект'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17000, 15433, 'Показатель защищенности, определяющий правила разграничения доступа.
Примечание — Для реализации мандатного принципа контроля доступа каждому субъекту и каждому объекту присваивают классификационные метки, отражающие их место в соответствующей иерархии. С помощью этих меток субъектам и объектам должны быть назначены классификационные уровни, являющиеся комбинациями уровня иерархической классификации и иерархических категорий. Данные метки должны служить основой мандатного принципа разграничения доступа.', '''дан'':48A ''должн'':35A,50A ''доступ'':6A,13A,56A ''защищен'':2A ''иерарх'':27A ''иерархическ'':43A,46A ''кажд'':14A,17A ''категор'':47A ''классификац'':44A ''классификацион'':20A,38A ''комбинац'':41A ''контрол'':12A ''мандатн'':10A,53A ''мест'':24A ''метк'':21A,49A ''меток'':31A ''назнач'':37A ''объект'':18A,34A ''определя'':3A ''основ'':52A ''отража'':22A ''показател'':1A ''помощ'':29A ''прав'':4A ''примечан'':7A ''принцип'':11A,54A ''присваива'':19A ''разграничен'':5A,55A ''реализац'':9A ''служ'':51A ''соответств'':26A ''субъект'':15A,32A ''уровн'':39A,42A ''эт'':30A ''явля'':40A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17134, 15567, 'Частная совместимость АС, характеризуемая возможностью взаимодействия технических средств этих систем.', '''ас'':3A ''взаимодейств'':6A ''возможн'':5A ''сист'':10A ''совместим'':2A ''средств'':8A ''техническ'':7A ''характеризуем'':4A ''частн'':1A ''эт'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17001, 15434, 'Использование знаний для решения задач. К процессу манипулирования знаниями относятся: пополнение знаний, классификация знаний, обобщение и вывод на знаниях, рассуждения с помощью знаний, объяснение результатов семантического поиска, решение прикладных задач.', '''вывод'':17A ''задач'':5A,30A ''знан'':2A,9A,12A,14A,19A,23A ''использован'':1A ''классификац'':13A ''манипулирован'':8A ''обобщен'':15A ''объяснен'':24A ''относ'':10A ''поиск'':27A ''помощ'':22A ''пополнен'':11A ''прикладн'':29A ''процесс'':7A ''рассужден'':20A ''результат'':25A ''решен'':4A,28A ''семантическ'':26A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17004, 15437, 'Один из маршрутизаторов MPLS (Multiprotocol label switching), устанавливаемых между LER (Label edge router — граничный маршрутизатор меток), обеспечивающий создание LSP (Label switch path — путь коммутации меток).', '''edg'':12A ''label'':6A,11A,20A ''ler'':10A ''lsp'':19A ''mpls'':4A ''multiprotocol'':5A ''path'':22A ''router'':13A ''switch'':7A,21A ''граничн'':14A ''коммутац'':24A ''маршрутизатор'':3A,15A ''меток'':16A,25A ''обеспечива'':17A ''пут'':23A ''создан'':18A ''устанавлива'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17005, 15438, 'Процесс пересылки пакетов с логическими адресами из их локальной подсети к конечному пункту назначения. В крупных сетях существуют многочисленные промежуточные пункты назначения. Иногда пакет проходит их до того, как дойдет до своего пункта назначения.', '''адрес'':6A ''дойдет'':30A ''конечн'':12A ''крупн'':16A ''логическ'':5A ''локальн'':9A ''многочислен'':19A ''назначен'':14A,22A,34A ''пакет'':3A,24A ''пересылк'':2A ''подсет'':10A ''промежуточн'':20A ''проход'':25A ''процесс'':1A ''пункт'':13A,21A,33A ''сво'':32A ''сет'':17A ''существ'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17135, 15568, 'Частная совместимость АСУ войсками (силами), характеризуемая возможностью взаимодействия технических средств этих систем.', '''ас'':3A ''взаимодейств'':8A ''возможн'':7A ''войск'':4A ''сил'':5A ''сист'':12A ''совместим'':2A ''средств'':10A ''техническ'':9A ''характеризуем'':6A ''частн'':1A ''эт'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17002, 15436, 'Устройство, которое функционирует на сетевом уровне (на третьем уровне эталонной модели OSI) и служит для организации связи между сетями с одинаковыми сетевыми протоколами. Для передачи пакетов их адресатам оптимальным образом маршрутизатор использует протоколы маршрутизации.', '''osi'':12A ''адресат'':28A ''использ'':32A ''котор'':2A ''маршрутизатор'':31A ''маршрутизац'':34A ''модел'':11A ''образ'':30A ''одинаков'':21A ''оптимальн'':29A ''организац'':16A ''пакет'':26A ''передач'':25A ''протокол'':23A,33A ''связ'':17A ''сет'':19A ''сетев'':5A,22A ''служ'':14A ''трет'':8A ''уровн'':6A,9A ''устройств'':1A ''функционир'':3A ''эталон'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17006, 15439, 'Средство защиты информации, реализующее математический алгоритм преобразования информации, не использующее секретного ключа или передающее (хранящее) его вместе с сообщением.', '''алгоритм'':6A ''вмест'':17A ''защит'':2A ''информац'':3A,8A ''использ'':10A ''ключ'':12A ''математическ'':5A ''переда'':14A ''преобразован'':7A ''реализ'':4A ''секретн'':11A ''сообщен'':19A ''средств'':1A ''храня'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17007, 15440, 'Процесс идентификации конфиденциальных данных и наложения на них «защитной маски», которая сохраняет их «неприкосновенность» в базе данных, не нарушая при этом функциональной целостности приложения, использующего эти данные, т. е. это процесс обезличивания конфиденциальной информации, хранящейся в базе данных.', '''баз'':16A,37A ''дан'':4A,17A,27A,38A ''е'':29A ''защитн'':9A ''идентификац'':2A ''информац'':34A ''использ'':25A ''конфиденциальн'':3A,33A ''котор'':11A ''маск'':10A ''наложен'':6A ''наруш'':19A ''неприкосновен'':14A ''обезличиван'':32A ''приложен'':24A ''процесс'':1A,31A ''сохраня'':12A ''т'':28A ''функциональн'':22A ''храня'':35A ''целостн'':23A ''эт'':30A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17008, 15441, 'Совокупность однородных записей (т. е. наборов данных, характеризующих какой-либо объект управления, процесс и т. д.), рассматриваемых как одно целое и упорядоченных таким образом, что их описание (набор индексов) однозначно определяет положение каждого элемента или путь доступа к нему.', '''д'':17A ''дан'':7A ''доступ'':38A ''е'':5A ''запис'':3A ''индекс'':30A ''кажд'':34A ''какой-либ'':9A ''либ'':11A ''набор'':6A,29A ''нем'':40A ''образ'':25A ''объект'':12A ''одн'':20A ''однозначн'':31A ''однородн'':2A ''описан'':28A ''определя'':32A ''положен'':33A ''процесс'':14A ''пут'':37A ''рассматрива'':18A ''совокупн'':1A ''т'':4A,16A ''так'':24A ''упорядочен'':23A ''управлен'':13A ''характериз'':8A ''цел'':21A ''элемент'':35A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17009, 15442, 'Технология работы с большими данными. Данные разбиваются на небольшие группы и обрабатываются одновременно на многих узлах, что обеспечивает значительное ускорение работы. Вместо хранения информации в строках таблиц БД могут также использовать архитектуры столбцов, которые позволяют обрабатывать только столбцы с данными, необходимыми для формирования результатов запроса, и, кроме того, поддерживают хранение неструктурированной информации.', '''архитектур'':32A ''бд'':28A ''больш'':4A ''вмест'':22A ''групп'':10A ''дан'':5A,6A,40A ''запрос'':45A ''значительн'':19A ''информац'':24A,52A ''использова'':31A ''котор'':34A ''кром'':47A ''мног'':15A ''могут'':29A ''небольш'':9A ''необходим'':41A ''неструктурирова'':51A ''обеспечива'':18A ''обрабатыва'':12A,36A ''одновремен'':13A ''поддержива'':49A ''позволя'':35A ''работ'':2A,21A ''разбива'':7A ''результат'':44A ''столбц'':33A,38A ''строк'':26A ''таблиц'':27A ''такж'':30A ''технолог'':1A ''узл'':16A ''ускорен'':20A ''формирован'':43A ''хранен'':23A,50A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17010, 15443, 'Метод взаимодействия, используемый во многих приложениях. При работе с большим объемом данных этот метод хорош для представления данных в общем сжатом виде, и в то же время он предоставляет возможность отображения любой их части в более детальном виде. Масштабирование может заключаться не только в простом увеличении объектов, но и в изменении их представления на разных уровнях. Так, например, на нижнем уровне объект может быть представлен пикселем, на более высоком уровне — неким визуальным образом, а на следующем — текстовой меткой.
Метод интерактивного искажения поддерживает процесс исследования данных с помощью искажения масштаба данных при частичной детализации. Основная идея этого метода заключается в том, что часть данных отображается с высокой степенью детализации, а одновременно с этим остальные данные показываются с низким уровнем детализации.', '''больш'':10A ''взаимодейств'':2A ''вид'':22A,38A ''визуальн'':72A ''возможн'':30A ''врем'':27A ''высок'':69A,106A ''дан'':12A,18A,85A,90A,103A,114A ''детализац'':93A,108A,119A ''детальн'':37A ''заключа'':41A,98A ''иде'':95A ''изменен'':51A ''интерактивн'':80A ''искажен'':81A,88A ''используем'':3A ''исследован'':84A ''люб'':32A ''масштаб'':89A ''масштабирован'':39A ''метк'':78A ''метод'':1A,14A,79A,97A ''мног'':5A ''например'':58A ''нек'':71A ''нижн'':60A ''низк'':117A ''образ'':73A ''общ'':20A ''объект'':47A,62A ''объем'':11A ''одновремен'':110A ''основн'':94A ''остальн'':113A ''отобража'':104A ''отображен'':31A ''пиксел'':66A ''поддержива'':82A ''показыва'':115A ''помощ'':87A ''предоставля'':29A ''представл'':65A ''представлен'':17A,53A ''приложен'':6A ''прост'':45A ''процесс'':83A ''работ'':8A ''разн'':55A ''сжат'':21A ''след'':76A ''степен'':107A ''текстов'':77A ''увеличен'':46A ''уровн'':56A,61A,70A,118A ''хорош'':15A ''част'':34A,102A ''частичн'':92A ''эт'':112A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17011, 15444, 'Способность системы увеличивать производительность пропорционально дополнительным ресурсам.', '''дополнительн'':6A ''производительн'':4A ''пропорциональн'':5A ''ресурс'':7A ''систем'':2A ''способн'':1A ''увеличива'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17013, 15446, 'Совокупность математических методов, моделей, информационно-расчетных задач и алгоритмов, примененных в автоматизированной системе управления войсками (силами).', '''автоматизирова'':13A ''алгоритм'':10A ''войск'':16A ''задач'':8A ''информацион'':6A ''информационно-расчетн'':5A ''математическ'':2A ''метод'':3A ''модел'':4A ''применен'':11A ''расчетн'':7A ''сил'':17A ''систем'':14A ''совокупн'':1A ''управлен'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17014, 15447, 'Совокупность математических методов, моделей и алгоритмов для решения задач оценки опасности и мер защиты информации.', '''алгоритм'':6A ''задач'':9A ''защит'':14A ''информац'':15A ''математическ'':2A ''мер'':13A ''метод'':3A ''модел'':4A ''опасн'':11A ''оценк'':10A ''решен'':8A ''совокупн'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17015, 15448, 'Специализированный либо универсальный процессор с собственной памятью, выполняющий обработку запросов. Блок управления базой данных в информационных системах.', '''баз'':13A ''блок'':11A ''выполня'':8A ''дан'':14A ''запрос'':10A ''информацион'':16A ''либ'':2A ''обработк'':9A ''памят'':7A ''процессор'':4A ''систем'':17A ''собствен'':6A ''специализирова'':1A ''универсальн'':3A ''управлен'':12A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17016, 15449, 'Специализированный процессор (система процессоров), выполняющий обработку запросов и формирование ответов в некоторой предметной области на основе использования совокупностей фактов и знаний о предметной области, представляемых в виде правил, а также механизмов вывода. Блок управления базой знаний в машине пятого поколения.', '''баз'':35A ''блок'':33A ''вид'':27A ''вывод'':32A ''выполня'':5A ''запрос'':7A ''знан'':21A,36A ''использован'':17A ''машин'':38A ''механизм'':31A ''некотор'':12A ''област'':14A,24A ''обработк'':6A ''основ'':16A ''ответ'':10A ''поколен'':40A ''прав'':28A ''предметн'':13A,23A ''представля'':25A ''процессор'':2A,4A ''пят'':39A ''систем'':3A ''совокупн'':18A ''специализирова'':1A ''такж'':30A ''управлен'':34A ''факт'':19A ''формирован'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17017, 15450, 'Программа, которая выполняет логический вывод из предварительно построенной базы фактов и правил в соответствии с законами формальной логики. Для построения базы фактов и правил применяются формальные языки, обычно напоминающие естественный язык, но гораздо более строгие и ограниченные.', '''баз'':9A,21A ''вывод'':5A ''выполня'':3A ''горазд'':33A ''естествен'':30A ''закон'':16A ''котор'':2A ''логик'':18A ''логическ'':4A ''напомина'':29A ''обычн'':28A ''ограничен'':37A ''построен'':8A,20A ''прав'':12A,24A ''предварительн'':7A ''применя'':25A ''программ'':1A ''соответств'':14A ''строг'':35A ''факт'':10A,22A ''формальн'':17A,26A ''язык'':27A,31A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17018, 15451, 'Совокупность программно-аппаратных средств, способных обрабатывать базу знаний в целях решения поставленной задачи и объяснять механизм цепочки рассуждений.', '''аппаратн'':4A ''баз'':8A ''задач'':14A ''знан'':9A ''механизм'':17A ''обрабатыва'':7A ''объясня'':16A ''поставлен'':13A ''программн'':3A ''программно-аппаратн'':2A ''рассужден'':19A ''решен'':12A ''совокупн'':1A ''способн'':6A ''средств'':5A ''цел'':11A ''цепочк'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17019, 15452, 'Специализированный процессор (система процессоров), реализующий параллельно основные операции, характерные для вывода, основанного на знаниях.', '''вывод'':11A ''знан'':14A ''операц'':8A ''основа'':12A ''основн'':7A ''параллельн'':6A ''процессор'':2A,4A ''реализ'':5A ''систем'':3A ''специализирова'':1A ''характерн'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17020, 15453, 'Часть информационной базы АСУ войсками (силами), представляющая собой совокупность используемой в АСУ войсками (силами) информации на носителях данных.', '''ас'':4A,12A ''баз'':3A ''войск'':5A,13A ''дан'':18A ''информац'':15A ''информацион'':2A ''используем'':10A ''носител'':17A ''представля'':7A ''сил'':6A,14A ''соб'':8A ''совокупн'':9A ''част'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17021, 15454, 'Процесс перевода текстов (письменных, а в идеале и устных) с одного естественного языка на другой с помощью специальной компьютерной программы. Так же называется направление научных исследований, связанных с построением подобных систем.', '''естествен'':12A ''идеал'':7A ''исследован'':26A ''компьютерн'':19A ''называ'':23A ''направлен'':24A ''научн'':25A ''одн'':11A ''перевод'':2A ''письмен'':4A ''подобн'':30A ''помощ'':17A ''построен'':29A ''программ'':20A ''процесс'':1A ''связа'':27A ''сист'':31A ''специальн'':18A ''текст'':3A ''устн'':9A ''язык'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17023, 15456, 'Общее название технологий, которые позволяют машинам обмениваться информацией друг с другом или же передавать ее в одностороннем порядке.', '''друг'':9A,11A ''информац'':8A ''котор'':4A ''машин'':6A ''назван'':2A ''обменива'':7A ''общ'':1A ''односторон'':17A ''передава'':14A ''позволя'':5A ''порядк'':18A ''технолог'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17024, 15457, 'Взаимодействие вычислительных машин в неоднородной (гетерогенной) сети. Использование разных аппаратных и программных компонентов в гетерогенной сети ведет к проблеме обеспечения межсетевого взаимодействия. Источник проблемы — несовпадение используемых наборов коммуникационных протоколов. Подходы к обеспечению межсетевого взаимодействия: трансляция, мультиплексирование стеков, инкапсуляция.', '''аппаратн'':10A ''ведет'':17A ''взаимодейств'':1A,22A,34A ''вычислительн'':2A ''гетероген'':6A,15A ''инкапсуляц'':38A ''использован'':8A ''используем'':26A ''источник'':23A ''коммуникацион'':28A ''компонент'':13A ''машин'':3A ''межсетев'':21A,33A ''мультиплексирован'':36A ''набор'':27A ''неоднородн'':5A ''несовпаден'':25A ''обеспечен'':20A,32A ''подход'':30A ''проблем'':19A,24A ''программн'':12A ''протокол'':29A ''разн'':9A ''сет'':7A,16A ''стек'':37A ''трансляц'':35A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17241, 15674, 'Присоединенные данные или криптографическое преобразование строковых данных, которые доказывают подлинность и целостность строковых данных и защиту от подделок, например, получателем строковых данных.', '''дан'':2A,7A,14A,22A ''доказыва'':9A ''защит'':16A ''котор'':8A ''криптографическ'':4A ''например'':19A ''подделок'':18A ''подлин'':10A ''получател'':20A ''преобразован'':5A ''присоединен'':1A ''строков'':6A,13A,21A ''целостн'':12A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17032, 15465, 'Мера того, как долго ИТ-услуга или конфигурационная единица может сохранять работоспособность без перерывов в рамках согласованных функций. Обычно измеряется через MTBF (среднее между отказами) или MTBSI (среднее время между системными инцидентами). Термин надежность также может быть применен при фиксировании вероятности того, что процесс, функция и т. п. будут производить требуемые результаты на выходе.', '''mtbf'':23A ''mtbsi'':28A ''будут'':50A ''вероятн'':42A ''врем'':30A ''выход'':55A ''долг'':4A ''единиц'':10A ''измеря'':21A ''инцидент'':33A ''ит'':6A ''ит-услуг'':5A ''конфигурацион'':9A ''мер'':1A ''надежн'':35A ''обычн'':20A ''отказ'':26A ''п'':49A ''перерыв'':15A ''примен'':39A ''производ'':51A ''процесс'':45A ''работоспособн'':13A ''рамк'':17A ''результат'':53A ''системн'':32A ''согласова'':18A ''сохраня'':12A ''средн'':24A,29A ''т'':48A ''такж'':36A ''термин'':34A ''требуем'':52A ''услуг'':7A ''фиксирован'':41A ''функц'':19A,46A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17033, 15466, 'Свойство АС обеспечивать прием, автоматическую обработку запроса или команды и предоставление или принудительную выдачу выходной информации (реализацию технологической операции) согласно функциональному алгоритму при соблюдении эксплуатационных условий применения и технического обслуживания AС.', '''aс'':31A ''автоматическ'':5A ''алгоритм'':22A ''ас'':2A ''выдач'':14A ''выходн'':15A ''запрос'':7A ''информац'':16A ''команд'':9A ''обеспечива'':3A ''обработк'':6A ''обслуживан'':30A ''операц'':19A ''предоставлен'':11A ''при'':4A ''применен'':27A ''принудительн'':13A ''реализац'':17A ''свойств'':1A ''соблюден'':24A ''согласн'':20A ''техническ'':29A ''технологическ'':18A ''услов'':26A ''функциональн'':21A ''эксплуатацион'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17034, 15468, 'Характеристика способности программного обеспечения выполнять возложенные на него функции при поступлении требований на их выполнение.', '''возложен'':6A ''выполнен'':15A ''выполня'':5A ''обеспечен'':4A ''поступлен'':11A ''программн'':3A ''способн'':2A ''требован'':12A ''функц'':9A ''характеристик'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17035, 15468, 'Показатель качества, характеризующий свойства программного изделия выдавать одни и те же результаты при различных условиях функционирования. Надежность и правильность программы не одно и то же.', '''выдава'':7A ''издел'':6A ''качеств'':2A ''надежн'':17A ''одн'':8A,22A ''показател'':1A ''правильн'':19A ''программ'':20A ''программн'':5A ''различн'':14A ''результат'':12A ''свойств'':4A ''те'':10A ''услов'':15A ''функционирован'':16A ''характериз'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17036, 15469, 'Свойство программных средств обеспечивать вероятность безотказной работы не ниже заданной.', '''безотказн'':6A ''вероятн'':5A ''зада'':10A ''ниж'':9A ''обеспечива'':4A ''программн'':2A ''работ'':7A ''свойств'':1A ''средств'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17037, 15470, 'Программа, расширяющая функционал другой программы («ведущей») и написанная с использованием средств кодирования, предоставляемых, как правило, ведущей программой.', '''ведущ'':6A,16A ''использован'':10A ''кодирован'':12A ''написа'':8A ''прав'':15A ''предоставля'':13A ''программ'':1A,5A,17A ''расширя'':2A ''средств'':11A ''функциона'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17038, 15471, 'Невозможность оказания ИТ-услуг, установленных в соответствии с целями организации, или перебои в этой деятельности, вызванные нарушением функционирования АС или непредвиденным (например, отключение электрической энергии) событием или явлением.', '''ас'':20A ''вызва'':17A ''деятельн'':16A ''ит'':4A ''ит-услуг'':3A ''например'':23A ''нарушен'':18A ''невозможн'':1A ''непредвиден'':22A ''оказан'':2A ''организац'':11A ''отключен'':24A ''перебо'':13A ''событ'':27A ''соответств'':8A ''услуг'':5A ''установлен'':6A ''функционирован'':19A ''цел'':10A ''электрическ'':25A ''энерг'':26A ''явлен'':29A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17039, 15473, 'Событие, при котором компрометируется один или несколько аспектов — доступность, конфиденциальность, целостность и достоверность.', '''аспект'':8A ''достоверн'':13A ''доступн'':9A ''компрометир'':4A ''конфиденциальн'':10A ''котор'':3A ''нескольк'':7A ''событ'':1A ''целостн'':11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17041, 15476, 'Субъект, случайно или преднамеренно совершивший действие, следствием которого является возникновение и/или реализация угроз нарушения безопасности информации.', '''безопасн'':16A ''возникновен'':10A ''действ'':6A ''информац'':17A ''котор'':8A ''нарушен'':15A ''преднамерен'':4A ''реализац'':13A ''следств'':7A ''случайн'':2A ''соверш'':5A ''субъект'':1A ''угроз'':14A ''явля'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17043, 15476, 'Субъект, реализующий угрозы информационной безопасности организации путем нарушения предоставленных ему полномочий по доступу к активам организации или по распоряжению ими.', '''актив'':15A ''безопасн'':5A ''доступ'':13A ''им'':20A ''информацион'':4A ''нарушен'':8A ''организац'':6A,16A ''полномоч'':11A ''предоставлен'':9A ''пут'':7A ''распоряжен'':19A ''реализ'':2A ''субъект'':1A ''угроз'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17044, 15477, 'Субъект доступа, осуществляющий несанкционированный доступ к информации [8].', '''8'':8A ''доступ'':2A,5A ''информац'':7A ''несанкционирова'':4A ''осуществля'':3A ''субъект'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17046, 15479, 'Построение новых классов на основе существующих с возможностью добавления или переопределения данных и методов.', '''возможн'':8A ''дан'':12A ''добавлен'':9A ''класс'':3A ''метод'':14A ''нов'':2A ''основ'':5A ''переопределен'':11A ''построен'':1A ''существ'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17047, 15480, 'Метод, используемый для информационного обследования реальных (существующих) органов военного управления в реальном масштабе времени для получения необходимых параметров (характеристик) документооборота в ходе их функционирования.', '''воен'':9A ''времен'':14A ''документооборот'':20A ''информацион'':4A ''используем'':2A ''масштаб'':13A ''метод'':1A ''необходим'':17A ''обследован'':5A ''орган'':8A ''параметр'':18A ''получен'':16A ''реальн'':6A,12A ''существ'':7A ''управлен'':10A ''функционирован'':24A ''характеристик'':19A ''ход'':22A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17048, 15481, 'Комплекс теоретических и (или) экспериментальных исследований по изысканию перспективных принципов и путей создания изделия ВТ, а также исследование вопросов его эксплуатации.', '''вопрос'':19A ''вт'':15A ''издел'':14A ''изыскан'':8A ''исследован'':6A,18A ''комплекс'':1A ''перспективн'':9A ''принцип'':10A ''пут'':12A ''создан'':13A ''такж'':17A ''теоретическ'':2A ''экспериментальн'':5A ''эксплуатац'':21A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17057, 15490, 'Совокупность средств, созданных для обмена информацией между мозгом и компьютером.', '''информац'':6A ''компьютер'':10A ''мозг'':8A ''обм'':5A ''совокупн'':1A ''созда'':3A ''средств'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17058, 15491, 'Способ восстановления, также известный как горячее резервирование. Предусматривается восстановление ИТ-услуги без прерывания процесса ее предоставления. Немедленное восстановление обычно использует технологии зеркалирования, балансировки загрузки и разделения площадок установки оборудования.', '''балансировк'':24A ''восстановлен'':2A,9A,19A ''горяч'':6A ''загрузк'':25A ''зеркалирован'':23A ''известн'':4A ''использ'':21A ''ит'':11A ''ит-услуг'':10A ''немедлен'':18A ''оборудован'':30A ''обычн'':20A ''площадок'':28A ''предоставлен'':17A ''предусматрива'':8A ''прерыван'':14A ''процесс'':15A ''разделен'':27A ''резервирован'':7A ''способ'':1A ''такж'':3A ''технолог'':22A ''услуг'':12A ''установк'':29A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17059, 15492, 'Новое поколение средств и методов работы с геопространственной информацией, отличающееся от предыдущих (карт и ГИС) тремя основными признаками:
− использованием географических, а не картографических систем координат;
− применением растрового, а не векторного представления географической информации в качестве основного;
− использованием открытых гипертекстовых форматов представления геоданных.', '''векторн'':30A ''географическ'':20A,32A ''геода'':42A ''геопространствен'':8A ''гипертекстов'':39A ''гис'':15A ''информац'':9A,33A ''использован'':19A,37A ''карт'':13A ''картографическ'':23A ''качеств'':35A ''координат'':25A ''метод'':5A ''нов'':1A ''основн'':17A,36A ''открыт'':38A ''отлича'':10A ''поколен'':2A ''представлен'':31A,41A ''предыдущ'':12A ''признак'':18A ''применен'':26A ''работ'':6A ''растров'':27A ''сист'':24A ''средств'':3A ''трем'':16A ''формат'':40A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17060, 15493, 'Коллекция информационных ресурсов различной природы, каждая из которых имеет разную степень структурированности, тематическое многообразие и различную семантическую интерпретацию их содержания, поддерживаемых ими программных систем.', '''им'':22A ''имеет'':9A ''интерпретац'':18A ''информацион'':2A ''кажд'':6A ''коллекц'':1A ''котор'':8A ''многообраз'':14A ''поддержива'':21A ''природ'':5A ''программн'':23A ''различн'':4A,16A ''разн'':10A ''ресурс'':3A ''семантическ'':17A ''сист'':24A ''содержан'':20A ''степен'':11A ''структурирован'':12A ''тематическ'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17062, 15495, 'Состояние, при котором значение хотя бы одного параметра, характеризующего способность системы (комплекса, образца) военной техники в рассматриваемый момент времени выполнять заданные функции, не соответствуют требованиям конструкторской документации.', '''воен'':14A ''времен'':19A ''выполня'':20A ''документац'':27A ''зада'':21A ''значен'':4A ''комплекс'':12A ''конструкторск'':26A ''котор'':3A ''момент'':18A ''образц'':13A ''одн'':7A ''параметр'':8A ''рассматрива'':17A ''систем'':11A ''соответств'':24A ''состоян'':1A ''способн'':10A ''техник'':15A ''требован'':25A ''функц'':22A ''характериз'':9A ''хот'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17069, 15502, 'Лицо, самостоятельно создавшее информацию либо получившее на основании закона или договора право разрешать или ограничивать доступ к информации, определяемой по каким-либо признакам.', '''договор'':11A ''доступ'':16A ''закон'':9A ''информац'':4A,18A ''как'':22A ''каким-либ'':21A ''либ'':5A,23A ''лиц'':1A ''ограничива'':15A ''определя'':19A ''основан'':8A ''получ'':6A ''прав'':12A ''признак'':24A ''разреша'':13A ''самостоятельн'':2A ''созда'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17070, 15503, 'Технология, объединяющая облачные технологии и технологии Больших Данных.', '''больш'':7A ''дан'':8A ''облачн'':3A ''объединя'':2A ''технолог'':1A,4A,6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17071, 15504, 'Базы данных, которые запускаются на платформах облачных вычислений.', '''баз'':1A ''вычислен'':8A ''дан'':2A ''запуска'':4A ''котор'':3A ''облачн'':7A ''платформ'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17075, 15508, 'Совокупность приемов и методов, позволяющих в БЗ вводить новые знания, получаемые из имеющихся за счет кластеризации, введения гиперсобытий и гипотез.', '''бз'':7A ''введен'':17A ''ввод'':8A ''гиперсобыт'':18A ''гипотез'':20A ''знан'':10A ''имеющ'':13A ''кластеризац'':16A ''метод'':4A ''нов'':9A ''позволя'':5A ''получа'':11A ''прием'':2A ''совокупн'':1A ''счет'':15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17076, 15511, 'Сбор, хранение, обработка и воспроизведение данных средствами вычислительной техники.', '''воспроизведен'':5A ''вычислительн'':8A ''дан'':6A ''обработк'':3A ''сбор'':1A ''средств'':7A ''техник'':9A ''хранен'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17073, 15507, 'Физический перенос данных (цифрового битового потока) в виде сигналов от точки к точке или от точки к нескольким точкам средствами электросвязи по каналу передачи данных, как правило, для последующей обработки средствами вычислительной техники.', '''битов'':5A ''вид'':8A ''вычислительн'':32A ''дан'':3A,25A ''канал'':23A ''нескольк'':18A ''обработк'':30A ''передач'':24A ''перенос'':2A ''послед'':29A ''поток'':6A ''прав'':27A ''сигнал'':9A ''средств'':20A,31A ''техник'':33A ''точк'':11A,13A,16A,19A ''физическ'':1A ''цифров'':4A ''электросвяз'':21A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17077, 15511, 'Совокупность операций сбора, накопления, ввода, вывода, приема, передачи, записи, хранения, регистрации, уничтожения, преобразования, отображения информации.', '''ввод'':5A ''вывод'':6A ''запис'':9A ''информац'':15A ''накоплен'':4A ''операц'':2A ''отображен'':14A ''передач'':8A ''преобразован'':13A ''прием'':7A ''регистрац'':11A ''сбор'':3A ''совокупн'':1A ''уничтожен'':12A ''хранен'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17080, 15513, 'В процессе автоматической обработки информации, прежде всего, проводится семантико-синтаксический анализ текстов с целью формализованного представления их структуры — выделения в них единиц смысла и установления связей между этими единицами. Автоматическая обработка текстов позволяет создавать системы машинного перевода, системы составления и ведения словарей, системы автоматического составления аннотаций и т. п..', '''..'':51A ''автоматическ'':3A,31A,45A ''анализ'':12A ''аннотац'':47A ''веден'':42A ''выделен'':20A ''единиц'':23A,30A ''информац'':5A ''машин'':37A ''обработк'':4A,32A ''п'':50A ''перевод'':38A ''позволя'':34A ''представлен'':17A ''прежд'':6A ''провод'':8A ''процесс'':2A ''связ'':27A ''семантик'':10A ''семантико-синтаксическ'':9A ''синтаксическ'':11A ''систем'':36A,39A,44A ''словар'':43A ''смысл'':24A ''создава'':35A ''составлен'':40A,46A ''структур'':19A ''т'':49A ''текст'':13A,33A ''установлен'':26A ''формализова'':16A ''цел'':15A ''эт'':29A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17082, 15515, 'Автоматизированная система хранения и управления модулями данных, входящими в состав эксплуатационной документации на изделие, позволяющая по запросу получить конкретный электронный или бумажный эксплуатационный документ.', '''автоматизирова'':1A ''бумажн'':22A ''входя'':8A ''дан'':7A ''документ'':24A ''документац'':12A ''запрос'':17A ''издел'':14A ''конкретн'':19A ''модул'':6A ''позволя'':15A ''получ'':18A ''систем'':2A ''соста'':10A ''управлен'':5A ''хранен'':3A ''эксплуатацион'':11A,23A ''электрон'':20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17083, 15516, 'Блок данных, посланный по каналу связи.
Примечание — Каждый пакет может содержать в дополнение к фактическому сообщению информацию об отправителе, получателе, а также для контроля ошибок. Пакеты могут иметь фиксированную или переменную длину, а также могут быть повторно сформированы, в случае необходимости, по прибытии в пункт своего назначения.', '''блок'':1A ''дан'':2A ''длин'':32A ''дополнен'':13A ''имет'':28A ''информац'':17A ''кажд'':8A ''канал'':5A ''контрол'':24A ''могут'':27A,35A ''назначен'':47A ''необходим'':41A ''отправител'':19A ''ошибок'':25A ''пакет'':9A,26A ''перемен'':31A ''повторн'':37A ''получател'':20A ''посла'':3A ''прибыт'':43A ''примечан'':7A ''пункт'':45A ''сво'':46A ''связ'':6A ''случа'':40A ''содержа'':11A ''сообщен'':16A ''сформирова'':38A ''такж'':22A,34A ''фактическ'':15A ''фиксирова'':29A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17084, 15517, 'Обработка данных или выполнение заданий, накопленных заранее таким образом, что они объединяются в пакет и затем обрабатываются.', '''выполнен'':4A ''дан'':2A ''задан'':5A ''заран'':7A ''зат'':16A ''накоплен'':6A ''обрабатыва'':17A ''обработк'':1A ''образ'':9A ''объединя'':12A ''пакет'':14A ''так'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17085, 15518, 'Логические отношения, существующие между лексическими единицами языка независимо от контекста их конкретного употребления.', '''единиц'':6A ''конкретн'':12A ''контекст'':10A ''лексическ'':5A ''логическ'':1A ''независим'':8A ''отношен'':2A ''существ'':3A ''употреблен'':13A ''язык'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17103, 15536, 'Одно из направлений онтологического инжиниринга, в рамках которого происходит анализ концептуальной модели уже реализованной онтологии и отображение ее в другую, более подходящую для решения новых задач концептуальной модели, которая реализуется как новая онтология.', '''анализ'':10A ''друг'':20A ''задач'':26A ''инжиниринг'':5A ''концептуальн'':11A,27A ''котор'':8A,29A ''модел'':12A,28A ''направлен'':3A ''нов'':25A,32A ''одн'':1A ''онтолог'':15A,33A ''онтологическ'':4A ''отображен'':17A ''подходя'':22A ''происход'':9A ''рамк'':7A ''реализ'':30A ''реализова'':14A ''решен'':24A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17104, 15537, 'База данных, основанная на реляционной модели данных. Слово «реляционный» происходит от англ. Relation (отношение).', '''relat'':13A ''англ'':12A ''баз'':1A ''дан'':2A,7A ''модел'':6A ''основа'':3A ''отношен'':14A ''происход'':10A ''реляцион'':5A,9A ''слов'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17105, 15540, 'Логическая модель данных, прикладная теория построения баз данных, которая является приложением к задачам обработки данных таких разделов математики, как теории множеств и логика первого порядка. На реляционной модели данных строятся реляционные базы данных.', '''баз'':7A,32A ''дан'':3A,8A,15A,29A,33A ''задач'':13A ''котор'':9A ''логик'':23A ''логическ'':1A ''математик'':18A ''множеств'':21A ''модел'':2A,28A ''обработк'':14A ''перв'':24A ''порядк'':25A ''построен'':6A ''прикладн'':4A ''приложен'':11A ''раздел'':17A ''реляцион'':27A,31A ''стро'':30A ''так'':16A ''теор'':5A,20A ''явля'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17108, 15541, 'Базовый термин, который включает в себя ИТ-инфраструктуру, людей, деньги и все, что может способствовать предоставлению ИТ-услуги. Ресурсы рассматриваются как активы организации.', '''актив'':24A ''базов'':1A ''включа'':4A ''деньг'':11A ''инфраструктур'':9A ''ит'':8A,19A ''ит-инфраструктур'':7A ''ит-услуг'':18A ''котор'':3A ''люд'':10A ''организац'':25A ''предоставлен'':17A ''рассматрива'':22A ''ресурс'':21A ''способствова'':16A ''термин'':2A ''услуг'':20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17110, 15543, 'Риски, порождаемые нарушением непрерывности функционирования АС, приводящие к недоступности ИТ-услуг, ущербу или возникновению рисков в деятельности организации.', '''ас'':6A ''возникновен'':15A ''деятельн'':18A ''ит'':11A ''ит-услуг'':10A ''нарушен'':3A ''недоступн'':9A ''непрерывн'':4A ''организац'':19A ''порожда'':2A ''приводя'':7A ''риск'':1A,16A ''услуг'':12A ''ущерб'':13A ''функционирован'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17111, 15544, 'Процесс идентификации и получения данных от различных источников, группирования полученных данных и представление их в форме, необходимой для ввода в ЭВМ.', '''ввод'':19A ''группирован'':9A ''дан'':5A,11A ''идентификац'':2A ''источник'':8A ''необходим'':17A ''получен'':4A,10A ''представлен'':13A ''процесс'':1A ''различн'':7A ''форм'':16A ''эвм'':21A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17112, 15545, 'Наличие в АС в каждой системе (сети) и подсистеме большого количества разнородных аппаратно-программных средств, распределенных на большой территории (город, регион), между которыми существуют разнообразные информационно-технические связи.', '''аппаратн'':14A ''аппаратно-программн'':13A ''ас'':3A ''больш'':10A,19A ''город'':21A ''информацион'':28A ''информационно-техническ'':27A ''кажд'':5A ''количеств'':11A ''котор'':24A ''налич'':1A ''подсистем'':9A ''программн'':15A ''разнообразн'':26A ''разнородн'':12A ''распределен'':17A ''регион'':22A ''связ'':30A ''сет'':7A ''систем'':6A ''средств'':16A ''существ'':25A ''территор'':20A ''техническ'':29A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17114, 15547, 'Доступность ресурсов и сервисов для широкого круга пользователей и среды, порождающие внешние и внутренние факторы, которые способствуют или нарушают непрерывность функционирования АС или ее элементов.', '''ас'':22A ''внешн'':12A ''внутрен'':14A ''доступн'':1A ''котор'':16A ''круг'':7A ''наруша'':19A ''непрерывн'':20A ''пользовател'':8A ''порожда'':11A ''ресурс'':2A ''сервис'':4A ''способств'':17A ''сред'':10A ''фактор'':15A ''функционирован'':21A ''широк'':6A ''элемент'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17115, 15548, 'Способность АС в условиях угроз и в процессе эксплуатации приобретать новые ресурсно-сервисные возможности, адекватные характеру угроз.', '''адекватн'':16A ''ас'':2A ''возможн'':15A ''нов'':11A ''приобрета'':10A ''процесс'':8A ''ресурсн'':13A ''ресурсно-сервисн'':12A ''сервисн'':14A ''способн'':1A ''угроз'':5A,18A ''услов'':4A ''характер'':17A ''эксплуатац'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17116, 15549, 'Принципиальная невозможность точно предвидеть и однозначно спрогнозировать угрозы и их последствия на процесс предоставления сервисов и ИТ-услуг.', '''ит'':18A ''ит-услуг'':17A ''невозможн'':2A ''однозначн'':6A ''последств'':11A ''предвидет'':4A ''предоставлен'':14A ''принципиальн'':1A ''процесс'':13A ''сервис'':15A ''спрогнозирова'':7A ''точн'':3A ''угроз'':8A ''услуг'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17118, 15551, 'Процесс, позволяющий установить логическую связь между различными информационными объектами.', '''информацион'':8A ''логическ'':4A ''объект'':9A ''позволя'':2A ''процесс'':1A ''различн'':7A ''связ'':5A ''установ'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17119, 15552, 'Участок локальной сети, отделенный от других участков повторителем, концентратором, мостом или маршрутизатором. Все станции сегмента поддерживают один и тот же протокол доступа к среде передачи и делят ее общую пропускную способность.', '''дел'':27A ''доступ'':22A ''друг'':6A ''концентратор'':9A ''локальн'':2A ''маршрутизатор'':12A ''мост'':10A ''общ'':29A ''отделен'':4A ''передач'':25A ''повторител'':8A ''поддержива'':16A ''пропускн'':30A ''протокол'':21A ''сегмент'':15A ''сет'':3A ''способн'':31A ''сред'':24A ''станц'':14A ''участк'':7A ''участок'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17120, 15553, 'Семантическое (содержательно-смысловое, контентсенсентное) представление информации, непосредственно предназначенное для осуществления какой-либо информационно-интеллектуальной деятельности коммуникативного, эргатического, эвристического назначения.', '''деятельн'':18A ''интеллектуальн'':17A ''информац'':7A ''информацион'':16A ''информационно-интеллектуальн'':15A ''какой-либ'':12A ''коммуникативн'':19A ''контентсенсентн'':5A ''либ'':14A ''назначен'':22A ''непосредствен'':8A ''осуществлен'':11A ''предназначен'':9A ''представлен'':6A ''семантическ'':1A ''смыслов'':4A ''содержательн'':3A ''содержательно-смыслов'':2A ''эвристическ'':21A ''эргатическ'':20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17121, 15554, 'Мера, которая измеряет смысловое содержание информации. Наибольшее распространение получила тезаурусная мера, связывающая семантические свойства информации со способностью пользователя принимать поступившее сообщение.', '''измеря'':3A ''информац'':6A,15A ''котор'':2A ''мер'':1A,11A ''наибольш'':7A ''получ'':9A ''пользовател'':18A ''поступ'':20A ''принима'':19A ''распространен'':8A ''свойств'':14A ''связыва'':12A ''семантическ'':13A ''смыслов'':4A ''содержан'':5A ''сообщен'':21A ''способн'':17A ''тезаурусн'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17123, 15558, 'Компьютер, который связан с сетью и предоставляет программные функции, используемые другими компьютерами.', '''друг'':11A ''используем'':10A ''компьютер'':1A,12A ''котор'':2A ''предоставля'':7A ''программн'':8A ''связа'':3A ''сет'':5A ''функц'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17124, 15558, 'Аппаратное или программное средство, предоставляющее сетевые ресурсы клиентам.', '''аппаратн'':1A ''клиент'':8A ''предоставля'':5A ''программн'':3A ''ресурс'':7A ''сетев'':6A ''средств'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17126, 15559, 'Сервер, предназначенный для выполнения прикладных процессов. Сервер приложений взаимодействует с клиентами, получая задания, и с базами данных, выбирая данные, необходимые для обработки.', '''баз'':16A ''взаимодейств'':9A ''выбир'':18A ''выполнен'':4A ''дан'':17A,19A ''задан'':13A ''клиент'':11A ''необходим'':20A ''обработк'':22A ''получ'':12A ''предназначен'':2A ''прикладн'':5A ''приложен'':8A ''процесс'':6A ''сервер'':1A,7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17127, 15560, 'Характеристики, определяющие технические возможности автоматизированной системы управления войсками (силами) по обеспечению принятия решений органами военного управления.', '''автоматизирова'':5A ''воен'':15A ''возможн'':4A ''войск'':8A ''обеспечен'':11A ''определя'':2A ''орган'':14A ''принят'':12A ''решен'':13A ''сил'':9A ''систем'':6A ''техническ'':3A ''управлен'':7A,16A ''характеристик'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17128, 15561, 'Компьютерное немеханическое запоминающее устройство на основе микросхем памяти. Кроме них SSD содержит управляющий контроллер.', '''ssd'':11A ''запомина'':3A ''компьютерн'':1A ''контроллер'':14A ''кром'':9A ''микросх'':7A ''немеханическ'':2A ''основ'':6A ''памят'':8A ''содерж'':12A ''управля'':13A ''устройств'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17129, 15562, 'Совокупность взаимодействующих подсистем, решающих основную задачу — передачу данных из автоматизированных систем управления, интернет-трафика, различных файлов, электронных сообщений, видео и голоса.', '''автоматизирова'':10A ''взаимодейств'':2A ''виде'':20A ''голос'':22A ''дан'':8A ''задач'':6A ''интернет'':14A ''интернет-трафик'':13A ''основн'':5A ''передач'':7A ''подсист'':3A ''различн'':16A ''реша'':4A ''сист'':11A ''совокупн'':1A ''сообщен'':19A ''трафик'':15A ''управлен'':12A ''файл'':17A ''электрон'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17130, 15563, 'Оборудование, функционирующее с использованием цифровых технологий, предназначенное для обмена информацией в цифровой форме и способное устанавливать связь, поддерживать ее и разъединять, а также преобразовывать сигналы между каналом общего пользования и конечным оборудованием.', '''информац'':10A ''использован'':4A ''канал'':27A ''конечн'':31A ''обм'':9A ''оборудован'':1A,32A ''общ'':28A ''поддержива'':18A ''пользован'':29A ''предназначен'':7A ''преобразовыва'':24A ''разъединя'':21A ''связ'':17A ''сигнал'':25A ''способн'':15A ''такж'':23A ''технолог'':6A ''устанавлива'':16A ''форм'':13A ''функционир'':2A ''цифров'':5A,12A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17131, 15564, 'Поиск документов определенного вида (текстов, изображений, телепрограмм, спутниковых карт и т. д.), в определенных местах (например, в базах данных, на FTP-серверах, группах новостей и т. д.) и определенной тематической направленности.', '''ftp'':22A ''ftp-сервер'':21A ''баз'':18A ''вид'':4A ''групп'':24A ''д'':12A,28A ''дан'':19A ''документ'':2A ''изображен'':6A ''карт'':9A ''мест'':15A ''направлен'':32A ''например'':16A ''новост'':25A ''определен'':3A,14A,30A ''поиск'':1A ''сервер'':23A ''спутников'':8A ''т'':11A,27A ''текст'':5A ''телепрограмм'':7A ''тематическ'':31A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17138, 15571, 'Технологии, которые обеспечивают организацию баз данных, т. е. именованной совокупности данных, отражающей состояние объектов и их отношений в рассматриваемой предметной области; работу систем управления БД; решение задач, связанных с видом, хранением, сортировкой, отбором данных по заданному условию и группировкой записей однородной структуры.', '''баз'':5A ''бд'':25A ''вид'':30A ''группировк'':39A ''дан'':6A,11A,34A ''е'':8A ''зада'':36A ''задач'':27A ''запис'':40A ''именова'':9A ''котор'':2A ''обеспечива'':3A ''област'':21A ''объект'':14A ''однородн'':41A ''организац'':4A ''отбор'':33A ''отношен'':17A ''отража'':12A ''предметн'':20A ''работ'':22A ''рассматрива'':19A ''решен'':26A ''связа'':28A ''сист'':23A ''совокупн'':10A ''сортировк'':32A ''состоян'':13A ''структур'':42A ''т'':7A ''технолог'':1A ''управлен'':24A ''услов'':37A ''хранен'':31A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17139, 15572, 'Совокупность методов, процессов и программно-технических средств, объединенных в технологическую цепочку, обеспечивающую представление конкретных и обобщенных знаний, сведений и фактов для накопления и автоматической обработки современными компьютерами. Представление знаний в подобной явной форме позволяет компьютерам делать дедуктивные выводы из ранее сохраненного знания.', '''автоматическ'':25A ''вывод'':39A ''дедуктивн'':38A ''дела'':37A ''знан'':18A,30A,43A ''компьютер'':28A,36A ''конкретн'':15A ''метод'':2A ''накоплен'':23A ''обеспечива'':13A ''обобщен'':17A ''обработк'':26A ''объединен'':9A ''подобн'':32A ''позволя'':35A ''представлен'':14A,29A ''программн'':6A ''программно-техническ'':5A ''процесс'':3A ''ран'':41A ''сведен'':19A ''совокупн'':1A ''современ'':27A ''сохранен'':42A ''средств'':8A ''техническ'':7A ''технологическ'':11A ''факт'':21A ''форм'':34A ''цепочк'':12A ''явн'':33A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17140, 15573, 'Процесс преобразования речевого сигнала в цифровую информацию (например, текстовые данные). Обратной задачей является синтез речи.', '''дан'':10A ''задач'':12A ''информац'':7A ''например'':8A ''обратн'':11A ''преобразован'':2A ''процесс'':1A ''реч'':15A ''речев'':3A ''сигна'':4A ''синтез'':14A ''текстов'':9A ''цифров'':6A ''явля'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17141, 15574, 'Методами формализации знаний являются: естественно-языковое описание, лексикографическое описание, тезаурусное описание, формально-языковое описание.', '''естествен'':6A ''естественно-языков'':5A ''знан'':3A ''лексикографическ'':9A ''метод'':1A ''описан'':8A,10A,12A,16A ''тезаурусн'':11A ''формализац'':2A ''формальн'':14A ''формально-языков'':13A ''явля'':4A ''языков'':7A,15A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17142, 15575, 'Условие и/или фактор, определяющие воздействие на информацию и/или состояние системы, ее объекты и/или среду функционирования, которые могут привести к недопустимому ущербу или неспособности выполнения системой своих функций с требуемым качеством.', '''воздейств'':6A ''выполнен'':27A ''информац'':8A ''качеств'':33A ''котор'':19A ''могут'':20A ''недопустим'':23A ''неспособн'':26A ''объект'':14A ''определя'':5A ''привест'':21A ''сво'':29A ''систем'':12A,28A ''состоян'':11A ''сред'':17A ''требуем'':32A ''услов'':1A ''ущерб'':24A ''фактор'':4A ''функц'':30A ''функционирован'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17149, 15582, 'Элемент сети, соединенный с другими устройствами как часть компьютерной сети. Узлами могут быть компьютеры, мобильные телефоны, а также сетевые устройства, маршрутизатор, коммутатор, концентратор.', '''друг'':5A ''коммутатор'':22A ''компьютер'':14A ''компьютерн'':9A ''концентратор'':23A ''маршрутизатор'':21A ''мобильн'':15A ''могут'':12A ''сет'':2A,10A ''сетев'':19A ''соединен'':3A ''такж'':18A ''телефон'':16A ''узл'':11A ''устройств'':6A,20A ''част'':8A ''элемент'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17150, 15583, 'Восприятие информации, относящейся к рассматриваемому объекту, с мысленным представлением скрытых от обзора соответствующих технических сущностей этого объекта.', '''восприят'':1A ''информац'':2A ''мыслен'':8A ''обзор'':12A ''объект'':6A,17A ''относя'':3A ''представлен'':9A ''рассматрива'':5A ''скрыт'':10A ''соответств'':13A ''сущност'':15A ''техническ'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17161, 15594, 'Информация об объектах, процессах, явлениях, содержании образования, программах, методах обучения и воспитания и т. д. Следует отличать от документографической информации, т. е. информации о документах как таковых.', '''воспитан'':12A ''д'':15A ''документ'':25A ''документографическ'':19A ''е'':22A ''информац'':1A,20A,23A ''метод'':9A ''образован'':7A ''обучен'':10A ''объект'':3A ''отлича'':17A ''программ'':8A ''процесс'':4A ''след'':16A ''содержан'':6A ''т'':14A,21A ''таков'':27A ''явлен'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17144, 15580, 'Совокупность условий и факторов, создающих потенциальную или реально существующую опасность нарушения безопасности информации.', '''безопасн'':12A ''информац'':13A ''нарушен'':11A ''опасн'':10A ''потенциальн'':6A ''реальн'':8A ''совокупн'':1A ''созда'':5A ''существ'':9A ''услов'':2A ''фактор'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17152, 15585, 'Упорядоченная совокупность реквизитов документа, установленных в соответствии с правилами формализации и унификации.', '''документ'':4A ''правил'':9A ''реквизит'':3A ''совокупн'':2A ''соответств'':7A ''унификац'':12A ''упорядочен'':1A ''установлен'':5A ''формализац'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17154, 15587, 'Процесс определения, создания, ведения баз данных, а также манипулирование ими.', '''баз'':5A ''веден'':4A ''дан'':6A ''им'':10A ''манипулирован'':9A ''определен'':2A ''процесс'':1A ''создан'':3A ''такж'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17155, 15588, 'Деятельность командующих (командиров, начальников), штабов, служб и других органов управления по поддержанию постоянной боевой готовности войск (сил), подготовке операций и боевых действий и руководству войсками (силами) при выполнении поставленных задач.', '''боев'':14A,21A ''войск'':16A,25A ''выполнен'':28A ''готовн'':15A ''действ'':22A ''деятельн'':1A ''друг'':8A ''задач'':30A ''команд'':2A ''командир'':3A ''начальник'':4A ''операц'':19A ''орган'':9A ''подготовк'':18A ''поддержан'':12A ''поставлен'':29A ''постоя'':13A ''руководств'':24A ''сил'':17A,26A ''служб'':6A ''управлен'':10A ''штаб'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17156, 15591, 'Совокупность средств и функций, обеспечивающих пополнение, обновление и удаление знаний из базы знаний.', '''баз'':12A ''знан'':10A,13A ''обеспечива'':5A ''обновлен'':7A ''пополнен'':6A ''совокупн'':1A ''средств'':2A ''удален'':9A ''функц'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17157, 15591, 'Совокупность процессов, управляющих созданием, распространением, обработкой и использованием знаний.', '''знан'':9A ''использован'':8A ''обработк'':6A ''процесс'':2A ''распространен'':5A ''совокупн'':1A ''создан'':4A ''управля'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17159, 15592, 'Файловые вирусы, которые записывают свой код вместо кода заражаемого файла, уничтожая его содержимое.', '''вирус'':2A ''вмест'':7A ''записыва'':4A ''заража'':9A ''код'':6A,8A ''котор'':3A ''сво'':5A ''содержим'':13A ''уничтож'':11A ''файл'':10A ''файлов'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17160, 15593, 'Собирательное название одноранговых компьютерных сетей для совместного использования файлов, основанных на равноправии участвующих в обмене файлами, т. е. каждый участник одновременно является и клиентом, и сервером.', '''е'':18A ''использован'':8A ''кажд'':19A ''клиент'':24A ''компьютерн'':4A ''назван'':2A ''обмен'':15A ''одновремен'':21A ''однорангов'':3A ''основа'':10A ''равноправ'':12A ''сервер'':26A ''сет'':5A ''собирательн'':1A ''совместн'':7A ''т'':17A ''участв'':13A ''участник'':20A ''файл'':9A,16A ''явля'':22A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17164, 15597, 'Разновидность попыток несанкционированного доступа, когда жертву провоцируют на разглашение информации, посылая ей фальсифицированное электронное письмо с приглашением посетить веб-сайт, который, на первый взгляд, связан с законным источником.', '''веб'':20A ''веб-сайт'':19A ''взгляд'':25A ''доступ'':4A ''жертв'':6A ''закон'':28A ''информац'':10A ''источник'':29A ''котор'':22A ''несанкционирова'':3A ''перв'':24A ''письм'':15A ''попыток'':2A ''посет'':18A ''посыл'':11A ''приглашен'':17A ''провоцир'':7A ''разглашен'':9A ''разновидн'':1A ''сайт'':21A ''связа'':26A ''фальсифицирова'':13A ''электрон'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17165, 15598, 'Процесс представления данных в формализованном виде.', '''вид'':6A ''дан'':3A ''представлен'':2A ''процесс'':1A ''формализова'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17166, 15599, 'Отображение результатов анализа информации в точных понятиях или утверждениях. Использование аксиоматического метода в процессе формализации обеспечивает такую систематизацию знания, при которой его отдельные элементы не просто координируют друг с другом, а находятся в отношении субординации.', '''аксиоматическ'':11A ''анализ'':3A ''друг'':28A,30A ''знан'':19A ''информац'':4A ''использован'':10A ''координир'':27A ''котор'':21A ''метод'':12A ''наход'':32A ''обеспечива'':16A ''отдельн'':23A ''отношен'':34A ''отображен'':1A ''понят'':7A ''прост'':26A ''процесс'':14A ''результат'':2A ''систематизац'':18A ''субординац'':35A ''так'':17A ''точн'':6A ''утвержден'':9A ''формализац'':15A ''элемент'':24A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17167, 15600, 'Способность компонент системы и АС в целом сохранять во времени и в установленных пределах требуемый уровень бесперебойного функционирования и своих процессуальных возможностей по решению задач поддержки процессов, формирования и доступности ИТ-услуг, безотказности технических средств, работоспособность которых нарушена внутрисистемными угрозами, приводящими к возникновению НШС, инцидентов и аварий.', '''авар'':48A ''ас'':5A ''безотказн'':34A ''бесперебойн'':17A ''внутрисистемн'':40A ''возможн'':22A ''возникновен'':44A ''времен'':10A ''доступн'':30A ''задач'':25A ''инцидент'':46A ''ит'':32A ''ит-услуг'':31A ''компонент'':2A ''котор'':38A ''наруш'':39A ''ншс'':45A ''поддержк'':26A ''предел'':14A ''приводя'':42A ''процесс'':27A ''процессуальн'':21A ''работоспособн'':37A ''решен'':24A ''сво'':20A ''систем'':3A ''сохраня'':8A ''способн'':1A ''средств'':36A ''техническ'':35A ''требуем'':15A ''угроз'':41A ''уровен'':16A ''услуг'':33A ''установлен'':13A ''формирован'':28A ''функционирован'':18A ''цел'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17168, 15601, 'Способность АС противостоять воздействиям социально-политического, экономического характера и другим нетехнологическим воздействиям с помощью средств интеллектуального характера: организация труда, методы создания и введения информации, решение интеллектуальных задач и т. д..', '''..'':32A ''ас'':2A ''введен'':24A ''воздейств'':4A,13A ''д'':31A ''друг'':11A ''задач'':28A ''интеллектуальн'':17A,27A ''информац'':25A ''метод'':21A ''нетехнологическ'':12A ''организац'':19A ''политическ'':7A ''помощ'':15A ''противостоя'':3A ''решен'':26A ''создан'':22A ''социальн'':6A ''социально-политическ'':5A ''способн'':1A ''средств'':16A ''т'':30A ''труд'':20A ''характер'':9A,18A ''экономическ'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17169, 15602, 'Совокупность действий АС, направленная на достижение определенной цели.', '''ас'':3A ''действ'':2A ''достижен'':6A ''направлен'':4A ''определен'':7A ''совокупн'':1A ''цел'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17198, 15631, 'Заранее намеченный результат защиты информации.
Примечание — Результатом защиты информации может быть предотвращение ущерба обладателю информации из-за возможной утечки информации и (или) несанкционированного и непреднамеренного воздействия на информацию.', '''воздейств'':27A ''возможн'':19A ''заран'':1A ''защит'':4A,8A ''из-з'':16A ''информац'':5A,9A,15A,21A,29A ''намечен'':2A ''непреднамерен'':26A ''несанкционирова'':24A ''обладател'':14A ''предотвращен'':12A ''примечан'':6A ''результат'':3A,7A ''утечк'':20A ''ущерб'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17171, 15605, 'Пользователь, который пытается вносить изменения в системное программное обеспечение, зачастую не имея на это право. Хакером можно назвать программиста, который создает более или менее полезные вспомогательные программы, обычно плохо документированные и иногда вызывающие нежелательные побочные результаты.', '''внос'':4A ''вспомогательн'':26A ''вызыва'':33A ''документирова'':30A ''зачаст'':10A ''изменен'':5A ''име'':12A ''котор'':2A,20A ''мен'':24A ''назва'':18A ''нежелательн'':34A ''обеспечен'':9A ''обычн'':28A ''плох'':29A ''побочн'':35A ''полезн'':25A ''пользовател'':1A ''прав'':15A ''программ'':27A ''программист'':19A ''программн'':8A ''пыта'':3A ''результат'':36A ''системн'':7A ''созда'':21A ''хакер'':16A ''эт'':14A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17174, 15607, 'Способ организации структур данных (хеш-таблиц), обеспечивающий эффективный поиск и пополнение.', '''дан'':4A ''обеспечива'':8A ''организац'':2A ''поиск'':10A ''пополнен'':12A ''способ'':1A ''структур'':3A ''таблиц'':7A ''хеш'':6A ''хеш-таблиц'':5A ''эффективн'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17173, 15607, 'Порождение с помощью специальных алгоритмов по заданному набору данных уникальных (почти уникальных) значений некоторой функции (параметра) заданной длины. Минимальная длина хеш-параметра должна составлять, обычно, не менее 128 разрядов. Важной особенностью любого хорошего алгоритма хеширования является порождение очень трудноповторимых хеш-параметров. Чем больше длина хеш-параметра, тем он более трудно воспроизводим. Алгоритм MD5 порождает 128-разрядный хеш-код. Алгоритм SHA — 160-разрядный хеш-код. Для построения систем электронной подписи используют «односторонние алгоритмы хеширования».', '''128'':29A,58A ''160'':65A ''md5'':56A ''sha'':64A ''алгоритм'':5A,35A,55A,63A,77A ''важн'':31A ''воспроизвод'':54A ''дан'':9A ''длин'':18A,20A,46A ''должн'':24A ''зада'':7A,17A ''значен'':13A ''использ'':75A ''код'':62A,69A ''люб'':33A ''мен'':28A ''минимальн'':19A ''набор'':8A ''некотор'':14A ''обычн'':26A ''односторон'':76A ''особен'':32A ''очен'':39A ''параметр'':16A,23A,43A,49A ''подпис'':74A ''помощ'':3A ''порожда'':57A ''порожден'':1A,38A ''построен'':71A ''разряд'':30A ''разрядн'':59A,66A ''сист'':72A ''составля'':25A ''специальн'':4A ''трудн'':53A ''трудноповторим'':40A ''уникальн'':10A,12A ''функц'':15A ''хеш'':22A,42A,48A,61A,68A ''хеш-код'':60A,67A ''хеш-параметр'':21A,41A,47A ''хеширован'':36A,78A ''хорош'':34A ''электрон'':73A ''явля'':37A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17175, 15608, 'Слово или фраза, начинающаяся с символа #, с помощью которого сообщения объединяются в группу или по теме.', '''групп'':13A ''котор'':9A ''начина'':4A ''объединя'':11A ''помощ'':8A ''символ'':6A ''слов'':1A ''сообщен'':10A ''тем'':16A ''фраз'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17176, 15610, 'Функция, отображающая входное слово конечной длины в конечном алфавите в слово заданной, обычно фиксированной длины.', '''алфав'':9A ''входн'':3A ''длин'':6A,15A ''зада'':12A ''конечн'':5A,8A ''обычн'':13A ''отобража'':2A ''слов'':4A,11A ''фиксирова'':14A ''функц'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17178, 15611, 'Способ восстановления, также известный как холодное резервирование. При постепенном восстановлении обычно задействован мобильный или стационарный резервный центр, оснащенный элементами жизнеобеспечения и сетевой разводкой, без компьютерных систем. Аппаратное и программное обеспечение устанавливаются в рамках плана непрерывности ИТ-услуг. Постепенное восстановление обычно занимает более трех дней, а может занять и значительно больше времени.', '''аппаратн'':27A ''восстановлен'':2A,10A,40A ''времен'':52A ''дне'':45A ''жизнеобеспечен'':20A ''задействова'':12A ''занима'':42A ''заня'':48A ''значительн'':50A ''известн'':4A ''ит'':37A ''ит-услуг'':36A ''компьютерн'':25A ''мобильн'':13A ''непрерывн'':35A ''обеспечен'':30A ''обычн'':11A,41A ''оснащен'':18A ''план'':34A ''постепен'':9A,39A ''программн'':29A ''разводк'':23A ''рамк'':33A ''резервирован'':7A ''резервн'':16A ''сетев'':22A ''сист'':26A ''способ'':1A ''стационарн'':15A ''такж'':3A ''трех'':44A ''услуг'':38A ''устанавлива'':31A ''холодн'':6A ''центр'':17A ''элемент'':19A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17179, 15612, 'Любое устройство, предоставляющее сервисы формата «клиент-сервер» в режиме сервера по каким-либо интерфейсам и уникально определенное на этих интерфейсах.', '''интерфейс'':16A,22A ''как'':14A ''каким-либ'':13A ''клиент'':7A ''клиент-сервер'':6A ''либ'':15A ''люб'':1A ''определен'':19A ''предоставля'':3A ''режим'':10A ''сервер'':8A,11A ''сервис'':4A ''уникальн'':18A ''устройств'':2A ''формат'':5A ''эт'':21A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17180, 15613, 'Услуга по предоставлению вычислительных мощностей для размещения информации на площадке (сервере) сервис-провайдера, постоянно находящейся в сети (обычно Интернет).', '''вычислительн'':4A ''интернет'':20A ''информац'':8A ''мощност'':5A ''находя'':16A ''обычн'':19A ''площадк'':10A ''постоя'':15A ''предоставлен'':3A ''провайдер'':14A ''размещен'':7A ''сервер'':11A ''сервис'':13A ''сервис-провайдер'':12A ''сет'':18A ''услуг'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17181, 15614, 'Организация сетевых служб виртуализированного хранения и доступа к данным, основанная на требовании заданного уровня службы, что снимает границы масштабируемости, является самообеспечивающимся или не требующим обеспечения и оплачивается в зависимости от потребления.', '''виртуализирова'':4A ''границ'':18A ''дан'':9A ''доступ'':7A ''зависим'':29A ''зада'':13A ''масштабируем'':19A ''обеспечен'':25A ''оплачива'':27A ''организац'':1A ''основа'':10A ''потреблен'':31A ''самообеспечива'':21A ''сетев'':2A ''служб'':3A,15A ''снима'':17A ''треб'':24A ''требован'':12A ''уровн'':14A ''хранен'':5A ''явля'':20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17182, 15615, 'Предметно-ориентированная, интегрированная, вариантная по времени, не разрушаемая совокупность данных, предназначенная для поддержки принятия управленческих решений.', '''вариантн'':5A ''времен'':7A ''дан'':11A ''интегрирова'':4A ''ориентирова'':3A ''поддержк'':14A ''предметн'':2A ''предметно-ориентирова'':1A ''предназначен'':12A ''принят'':15A ''разруша'':9A ''решен'':17A ''совокупн'':10A ''управленческ'':16A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17183, 15616, 'Методика, используемая для выявления возможных причин каких-либо проблем. Все доступные данные о проблеме собираются и сортируются по дате и по времени с целью определения последовательности событий во всех деталях. Такой подход позволяет определить возможные причинно-следственные связи между событиями.', '''возможн'':5A,36A ''времен'':23A ''выявлен'':4A ''дан'':13A ''дат'':20A ''детал'':31A ''доступн'':12A ''используем'':2A ''как'':8A ''каких-либ'':7A ''либ'':9A ''методик'':1A ''определ'':35A ''определен'':26A ''подход'':33A ''позволя'':34A ''последовательн'':27A ''причин'':6A,38A ''причинно-следствен'':37A ''пробл'':10A ''проблем'':15A ''связ'':40A ''следствен'':39A ''собира'':16A ''событ'':28A,42A ''сортир'':18A ''цел'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17185, 15621, 'Способность данных не подвергаться изменению или аннулированию в результате несанкционированного доступа.', '''аннулирован'':7A ''дан'':2A ''доступ'':11A ''изменен'':5A ''несанкционирова'':10A ''подверга'':4A ''результат'':9A ''способн'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17186, 15621, 'Свойство, при выполнении которого данные сохраняют заранее определенный вид и качество при выполнении любой операции над ними, будь то передача, хранение или представление.', '''буд'':18A ''вид'':9A ''выполнен'':3A,13A ''дан'':5A ''заран'':7A ''качеств'':11A ''котор'':4A ''люб'':14A ''ним'':17A ''операц'':15A ''определен'':8A ''передач'':20A ''представлен'':23A ''свойств'':1A ''сохраня'':6A ''хранен'':21A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17191, 15627, 'Способность средства вычислительной техники или автоматизированной системы обеспечивать неизменность информации в условиях случайного и (или) преднамеренного искажения (разрушения).', '''автоматизирова'':6A ''вычислительн'':3A ''информац'':10A ''искажен'':17A ''неизмен'':9A ''обеспечива'':8A ''преднамерен'':16A ''разрушен'':18A ''систем'':7A ''случайн'':13A ''способн'':1A ''средств'':2A ''техник'':4A ''услов'':12A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17192, 15627, 'Неизменность и неразделимость информации при ее хранении и передаче внутри системы или сети.', '''внутр'':10A ''информац'':4A ''неизмен'':1A ''неразделим'':3A ''передач'':9A ''сет'':13A ''систем'':11A ''хранен'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17201, 15634, 'Цифровая модель поверхности, сформированная с учетом законов картографической генерализации в принятых для карт проекции, разграфке, системе координат и высот.', '''высот'':19A ''генерализац'':9A ''закон'':7A ''карт'':13A ''картографическ'':8A ''координат'':17A ''модел'':2A ''поверхн'':3A ''принят'':11A ''проекц'':14A ''разграфк'':15A ''систем'':16A ''сформирова'':4A ''учет'':6A ''цифров'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17202, 15635, 'Цифровая модель местности, созданная путем оцифровки картографических источников, фотограмметрической обработки данных дистанционного зондирования, цифровой регистрации. Цифровая карта — цифровая картографическая модель, содержание которой соответствует содержанию карты заданного вида и масштаба.', '''вид'':27A ''дан'':11A ''дистанцион'':12A ''зада'':26A ''зондирован'':13A ''источник'':8A ''карт'':17A,25A ''картографическ'':7A,19A ''котор'':22A ''масштаб'':29A ''местност'':3A ''модел'':2A,20A ''обработк'':10A ''оцифровк'':6A ''пут'':5A ''регистрац'':15A ''содержан'':21A,24A ''созда'':4A ''соответств'':23A ''фотограмметрическ'':9A ''цифров'':1A,14A,16A,18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17203, 15636, 'Сеть, которая позволяет осуществлять высокоскоростную передачу голосовых данных, информации или видео посредством существующих линий инфраструктуры (Broadband ISDN — широкополосная ISDN, Narrowband ISND — узкополосная ISDN).', '''broadband'':16A ''isdn'':17A,19A,23A ''isnd'':21A ''narrowband'':20A ''виде'':11A ''высокоскоростн'':5A ''голосов'':7A ''дан'':8A ''информац'':9A ''инфраструктур'':15A ''котор'':2A ''лин'':14A ''осуществля'':4A ''передач'':6A ''позволя'':3A ''посредств'':12A ''сет'':1A ''существ'':13A ''узкополосн'':22A ''широкополосн'':18A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17204, 15637, 'Выданный центром сертификации электронный или печатный документ, подтверждающий права владельца открытого ключа.', '''владельц'':10A ''выда'':1A ''документ'':7A ''ключ'':12A ''открыт'':11A ''печатн'':6A ''подтвержда'':8A ''прав'':9A ''сертификац'':3A ''центр'':2A ''электрон'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17205, 15638, 'Технологии, основанные на представлении сигналов дискретными полосами аналоговых уровней, а не в виде непрерывного спектра. Все уровни в пределах полосы представляют собой одинаковое состояние сигнала.', '''аналогов'':8A ''вид'':13A ''дискретн'':6A ''непрерывн'':14A ''одинаков'':23A ''основа'':2A ''полос'':7A,20A ''предел'':19A ''представлен'':4A ''представля'':21A ''сигна'':25A ''сигнал'':5A ''соб'':22A ''состоян'':24A ''спектр'':15A ''технолог'':1A ''уровн'':9A,17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17206, 15639, 'Доказательство правильности программ, учитывающее основные, но не все возможные факторы.', '''возможн'':9A ''доказательств'':1A ''основн'':5A ''правильн'':2A ''программ'':3A ''учитыва'':4A ''фактор'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17207, 15640, 'Предоставление SaaS, PaaS, IaaS и/или DaaS ограниченному числу пользователей, обычно принадлежащих к одной и той же организации.
Примечание — Частные облака создаются в целях безопасности.', '''daa'':7A ''iaa'':4A ''paa'':3A ''saa'':2A ''безопасн'':25A ''облак'':21A ''обычн'':11A ''ограничен'':8A ''одн'':14A ''организац'':18A ''пользовател'':10A ''предоставлен'':1A ''примечан'':19A ''принадлежа'':12A ''созда'':22A ''то'':16A ''цел'':24A ''частн'':20A ''числ'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17208, 15641, 'Деятельность в области ИТ, которая позволяет минимизировать ущерб для окружающей среды, добиваться экономии в потреблении электроэнергии и снижения объема выбросов углекислого газа, которые обычно сопровождают ее выработку.', '''выброс'':20A ''выработк'':27A ''газ'':22A ''деятельн'':1A ''добива'':12A ''ит'':4A ''котор'':5A,23A ''минимизирова'':7A ''област'':3A ''объем'':19A ''обычн'':24A ''окружа'':10A ''позволя'':6A ''потреблен'':15A ''снижен'':18A ''сопровожда'':25A ''сред'':11A ''углекисл'':21A ''ущерб'':8A ''эконом'':13A ''электроэнерг'':16A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17210, 15643, 'Режим работы АС (части АС), обусловленный действием обстоятельств непреодолимой силы: наличием чрезвычайной ситуации, чрезвычайного положения, военного положения. Чрезвычайный режим предусматривает особые меры по защите персонала и имущества и допускает на время чрезвычайной ситуации выполнение только критичных сервисов АС с понижением их уровня до минимального, предусмотренного для данного типа чрезвычайной ситуации. Работы по полному восстановлению штатного режима работы АС (части АС) могут не предусматриваться вплоть до прекращения действия обстоятельств непреодолимой силы.', '''ас'':3A,5A,38A,58A,60A ''воен'':16A ''восстановлен'':54A ''вплот'':64A ''врем'':31A ''выполнен'':34A ''дан'':47A ''действ'':7A,67A ''допуска'':29A ''защ'':24A ''имуществ'':27A ''критичн'':36A ''мер'':22A ''минимальн'':44A ''могут'':61A ''налич'':11A ''непреодолим'':9A,69A ''обстоятельств'':8A,68A ''обусловлен'':6A ''особ'':21A ''персона'':25A ''полн'':53A ''положен'':15A,17A ''понижен'':40A ''предусматрива'':20A,63A ''предусмотрен'':45A ''прекращен'':66A ''работ'':2A,51A,57A ''реж'':1A,19A ''режим'':56A ''сервис'':37A ''сил'':10A,70A ''ситуац'':13A,33A,50A ''тип'':48A ''уровн'':42A ''част'':4A,59A ''чрезвычайн'':12A,14A,18A,32A,49A ''штатн'':55A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17211, 15644, 'Сетевой протокол прикладного уровня, позволяющий производить удаленное управление операционной системой и туннелирование TCP-соединений (например, для передачи файлов). Схож по функциональности с протоколами Telnet и rlogin, но, в отличие от них, шифрует весь трафик, включая и передаваемые пароли. SSH допускает выбор различных алгоритмов шифрования. SSH-клиенты и SSH-серверы доступны для большинства сетевых операционных систем. SSH позволяет безопасно передавать в незащищенной среде практически любой другой сетевой протокол.', '''rlogin'':27A ''ssh'':40A,47A,51A,59A ''ssh-клиент'':46A ''ssh-сервер'':50A ''tcp'':14A ''tcp-соединен'':13A ''telnet'':25A ''алгоритм'':44A ''безопасн'':61A ''большинств'':55A ''ве'':34A ''включ'':36A ''выбор'':42A ''допуска'':41A ''доступн'':53A ''клиент'':48A ''люб'':67A ''например'':16A ''незащищен'':64A ''операцион'':9A,57A ''отлич'':30A ''парол'':39A ''передава'':38A,62A ''передач'':18A ''позволя'':5A,60A ''практическ'':66A ''прикладн'':3A ''производ'':6A ''протокол'':2A,24A,70A ''различн'':43A ''сервер'':52A ''сетев'':1A,56A,69A ''сист'':58A ''систем'':10A ''соединен'':15A ''сред'':65A ''схож'':20A ''трафик'':35A ''туннелирован'':12A ''удален'':7A ''управлен'':8A ''уровн'':4A ''файл'':19A ''функциональн'':22A ''шифр'':33A ''шифрован'':45A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17212, 15645, 'К шестому технологическому укладу относятся: биотехнологии; нанотехнологии; проектирование живого; вложения в человека; новое природопользование; новая медицина; робототехника; высокие гуманитарные технологии; проектирование будущего и управление им; технологии сборки и разрушения социальных субъектов.', '''биотехнолог'':6A ''будущ'':22A ''вложен'':10A ''высок'':18A ''гуманитарн'':19A ''жив'':9A ''медицин'':16A ''нанотехнолог'':7A ''нов'':13A,15A ''относ'':5A ''природопользован'':14A ''проектирован'':8A,21A ''разрушен'':29A ''робототехник'':17A ''сборк'':27A ''социальн'':30A ''субъект'':31A ''технолог'':20A,26A ''технологическ'':3A ''уклад'':4A ''управлен'':24A ''человек'':12A ''шест'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17213, 15646, 'Технология циркулярной передачи данных в компьютерных и социальных сетях, при которой информация предназначена для приема всеми участниками сети.', '''всем'':16A ''дан'':4A ''информац'':12A ''компьютерн'':6A ''котор'':11A ''передач'':3A ''предназнач'':13A ''прием'':15A ''сет'':9A,18A ''социальн'':8A ''технолог'':1A ''участник'':17A ''циркулярн'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17214, 15647, 'Условный адрес для обработки широковещательных пакетов в компьютерных сетях .', '''адрес'':2A ''компьютерн'':8A ''обработк'':4A ''пакет'':6A ''сет'':9A ''условн'':1A ''широковещательн'':5A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17224, 15657, 'Криптографический метод, в котором используются раздельные ключи для шифрования и дешифрования.', '''дешифрован'':11A ''использ'':5A ''ключ'':7A ''котор'':4A ''криптографическ'':1A ''метод'':2A ''раздельн'':6A ''шифрован'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17225, 15658, 'Направление теоретической информатики, имеющее целью создание новых информационных метатехнологий для решения задач глобального моделирования сложных природных явлений на основе эволюционного подхода.', '''глобальн'':13A ''задач'':12A ''имеющ'':4A ''информатик'':3A ''информацион'':8A ''метатехнолог'':9A ''моделирован'':14A ''направлен'':1A ''нов'':7A ''основ'':19A ''подход'':21A ''природн'':16A ''решен'':11A ''сложн'':15A ''создан'':6A ''теоретическ'':2A ''цел'':5A ''эволюцион'':20A ''явлен'':17A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17216, 15651, 'Совокупность методов и способов обратимого преобразования информации с целью ее защиты от несанкционированного доступа (обеспечения конфиденциальности информации).', '''доступ'':14A ''защит'':11A ''информац'':7A,17A ''конфиденциальн'':16A ''метод'':2A ''несанкционирова'':13A ''обеспечен'':15A ''обратим'':5A ''преобразован'':6A ''совокупн'':1A ''способ'':4A ''цел'':9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17219, 15653, 'Устройство, изменяющее характер представления информации за счет изменения принципов кодирования.', '''изменен'':8A ''изменя'':2A ''информац'':5A ''кодирован'':10A ''представлен'':4A ''принцип'':9A ''счет'':7A ''устройств'':1A ''характер'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17220, 15653, 'Блок ЭВМ, выполняющий преобразование входных сигналов.', '''блок'':1A ''входн'':5A ''выполня'':3A ''преобразован'':4A ''сигнал'':6A ''эвм'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17221, 15656, 'Процесс зашифрования или расшифрования.', '''зашифрован'':2A ''процесс'':1A ''расшифрован'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17222, 15656, 'Криптографическое преобразование данных для получения шифротекста.
Примечание — Шифрование может быть необратимым процессом, в связи, с чем соответствующий процесс дешифрования невозможно реализовать.', '''дан'':3A ''дешифрован'':19A ''криптографическ'':1A ''невозможн'':20A ''необратим'':11A ''получен'':5A ''преобразован'':2A ''примечан'':7A ''процесс'':12A,18A ''реализова'':21A ''связ'':14A ''соответств'':17A ''шифрован'':8A ''шифротекст'':6A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17229, 15662, 'Система, основанная на знаниях, которая обеспечивает решение задач в конкретной области знаний или в сфере приложений путем логических выводов, извлекаемых из базы знаний, разработанной на основании человеческого опыта.
Примечания:
1 Термин «экспертная система» иногда используется как синоним «системы, основанной на знаниях», но она должна придавать особое значение экспертным знаниям.
2 Некоторые экспертные системы способны улучшать свою базу знаний и создавать новые правила логических выводов на базе опыта решений предыдущих задач.', '''1'':30A ''2'':50A ''баз'':22A,57A,66A ''вывод'':19A,64A ''должн'':44A ''задач'':8A,70A ''знан'':4A,12A,23A,41A,49A,58A ''значен'':47A ''извлека'':20A ''использ'':35A ''конкретн'':10A ''котор'':5A ''логическ'':18A,63A ''некотор'':51A ''нов'':61A ''обеспечива'':6A ''област'':11A ''опыт'':28A,67A ''основа'':2A,39A ''основан'':26A ''особ'':46A ''прав'':62A ''предыдущ'':69A ''придава'':45A ''приложен'':16A ''примечан'':29A ''пут'':17A ''разработа'':24A ''решен'':7A,68A ''синон'':37A ''систем'':1A,33A,38A,53A ''создава'':60A ''способн'':54A ''сфер'':15A ''термин'':31A ''улучша'':55A ''человеческ'':27A ''экспертн'':32A,48A,52A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17230, 15663, 'Метод, основанный на комплексном использовании различного вида моделей и натурного метода при информационном обследовании органов военного управления для получения необходимых параметров (характеристик) документооборота в ходе их функционирования.', '''вид'':7A ''воен'':16A ''документооборот'':23A ''информацион'':13A ''использован'':5A ''комплексн'':4A ''метод'':1A,11A ''модел'':8A ''натурн'':10A ''необходим'':20A ''обследован'':14A ''орган'':15A ''основа'':2A ''параметр'':21A ''получен'':19A ''различн'':6A ''управлен'':17A ''функционирован'':27A ''характеристик'':22A ''ход'':25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17232, 15665, 'Программа, в которой содержатся данные или исполняемый код, позволяющие использовать одну или несколько уязвимостей в программном обеспечении на локальном или удаленном компьютере с заведомо вредоносной целью.', '''вредоносн'':25A ''дан'':5A ''заведом'':24A ''исполня'':7A ''использова'':10A ''код'':8A ''компьютер'':22A ''котор'':3A ''локальн'':19A ''нескольк'':13A ''обеспечен'':17A ''одн'':11A ''позволя'':9A ''программ'':1A ''программн'':16A ''содержат'':4A ''удален'':21A ''уязвим'':14A ''цел'':26A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17233, 15666, 'Часть рабочей документации на АС, предназначенная для использования при эксплуатации системы, определяющая правила действия персонала и пользователей системы при ее функционировании, проверке и обеспечении ее работоспособности.', '''ас'':5A ''действ'':14A ''документац'':3A ''использован'':8A ''обеспечен'':24A ''определя'':12A ''персона'':15A ''пользовател'':17A ''прав'':13A ''предназначен'':6A ''проверк'':22A ''работоспособн'':26A ''рабоч'':2A ''систем'':11A,18A ''функционирован'':21A ''част'':1A ''эксплуатац'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17235, 15668, 'Свойство системы обеспечить короткое время восстановления, которое позволяет системе быстро откатиться назад после обнаружения неисправности.', '''быстр'':10A ''восстановлен'':6A ''врем'':5A ''коротк'':4A ''котор'':7A ''назад'':12A ''неисправн'':15A ''обеспеч'':3A ''обнаружен'':14A ''откат'':11A ''позволя'':8A ''свойств'':1A ''систем'':2A,9A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17236, 15669, 'Информационная система, предоставляющая доступ к коллекциям электронных документов, баз данных, сервисов, методов, программ и т. д., снабженная средствами навигации и поиска.', '''баз'':9A ''д'':16A ''дан'':10A ''документ'':8A ''доступ'':4A ''информацион'':1A ''коллекц'':6A ''метод'':12A ''навигац'':19A ''поиск'':21A ''предоставля'':3A ''программ'':13A ''сервис'':11A ''систем'':2A ''снабжен'':17A ''средств'':18A ''т'':15A ''электрон'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17237, 15670, 'Цифровая карта, визуализированная с использованием программных и технических средств в принятой системе условных знаков, предназначенная для отображения и анализа, а также решения задач с использованием дополнительной информации.', '''анализ'':19A ''визуализирова'':3A ''дополнительн'':26A ''задач'':23A ''знак'':14A ''информац'':27A ''использован'':5A,25A ''карт'':2A ''отображен'':17A ''предназначен'':15A ''принят'':11A ''программн'':6A ''решен'':22A ''систем'':12A ''средств'':9A ''такж'':21A ''техническ'':8A ''условн'':13A ''цифров'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17238, 15674, 'Информация в электронной форме, которая присоединена к другой информации в электронной форме (подписываемой информации) или иным образом связана с такой информацией и которая используется для определения лица, подписывающего информацию.', '''ин'':16A ''информац'':1A,9A,14A,21A,29A ''использ'':24A ''котор'':5A,23A ''лиц'':27A ''образ'':17A ''определен'':26A ''подписыва'':13A,28A ''присоедин'':6A ''связа'':18A ''форм'':4A,12A ''электрон'':3A,11A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17242, 15675, 'Система структурированного хранения электронных документов, обеспечивающая надежность хранения, конфиденциальность и разграничение прав доступа, отслеживание истории использования документа, быстрый и удобный поиск.', '''быстр'':18A ''документ'':5A,17A ''доступ'':13A ''использован'':16A ''истор'':15A ''конфиденциальн'':9A ''надежн'':7A ''обеспечива'':6A ''отслеживан'':14A ''поиск'':21A ''прав'':12A ''разграничен'':11A ''систем'':1A ''структурирова'':2A ''удобн'':20A ''хранен'':3A,8A ''электрон'':4A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17246, 15679, 'Все те знания, о которых мы знаем, что можем их записать, сообщить другим и ввести в базу данных.', '''баз'':17A ''ввест'':15A ''дан'':18A ''друг'':13A ''записа'':11A ''зна'':7A ''знан'':3A ''котор'':5A ''мож'':9A ''сообщ'':12A ''те'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17247, 15680, 'Искусственный язык для описания действий, связанных с администрированием базы данных.', '''администрирован'':8A ''баз'':9A ''дан'':10A ''действ'':5A ''искусствен'':1A ''описан'':4A ''связа'':6A ''язык'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17243, 15677, 'Документ, в котором информация представлена в электронно-цифровой форме.', '''документ'':1A ''информац'':4A ''котор'':3A ''представл'':5A ''форм'':10A ''цифров'':9A ''электрон'':8A ''электронно-цифров'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17245, 15678, 'Совокупность автоматизированных процессов по работе с документами, представленными в электронном виде, с реализацией концепции «безбумажного делопроизводства».', '''автоматизирова'':2A ''безбумажн'':15A ''вид'':11A ''делопроизводств'':16A ''документ'':7A ''концепц'':14A ''представлен'':8A ''процесс'':3A ''работ'':5A ''реализац'':13A ''совокупн'':1A ''электрон'':10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17250, 15683, 'Стандартный язык разметки документов во Всемирной паутине. Большинство веб-страниц содержат описание разметки на языке HTML (или XHTML). Язык HTML интерпретируется браузерами и отображается в виде документа в удобной для человека форме.', '''html'':17A,21A ''xhtml'':19A ''большинств'':8A ''браузер'':23A ''веб'':10A ''веб-страниц'':9A ''вид'':27A ''всемирн'':6A ''документ'':4A,28A ''интерпретир'':22A ''описан'':13A ''отобража'':25A ''паутин'':7A ''разметк'':3A,14A ''содержат'':12A ''стандартн'':1A ''страниц'':11A ''удобн'':30A ''форм'':33A ''человек'':32A ''язык'':2A,16A,20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17248, 15682, 'Искусственный язык для описания процессов создания, ведения и использования баз данных.', '''баз'':10A ''веден'':7A ''дан'':11A ''искусствен'':1A ''использован'':9A ''описан'':4A ''процесс'':5A ''создан'':6A ''язык'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17249, 15682, 'Язык с использованием формального синтаксиса, предназначенный для определения, создания, организации доступа и поддержки базы данных.', '''баз'':14A ''дан'':15A ''доступ'':11A ''использован'':3A ''определен'':8A ''организац'':10A ''поддержк'':13A ''предназначен'':6A ''синтаксис'':5A ''создан'':9A ''формальн'':4A ''язык'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17253, 15687, 'Искусственный язык, на котором делаются запросы к базам данных и другим информационным системам, особенно к информационно-поисковым системам. Основные языки запросов: SQL, Language Integrated Query, XQuery, XPath.', '''integr'':25A ''languag'':24A ''queri'':26A ''sql'':23A ''xpath'':28A ''xqueri'':27A ''баз'':8A ''дан'':9A ''дела'':5A ''друг'':11A ''запрос'':6A,22A ''информацион'':12A,17A ''информационно-поисков'':16A ''искусствен'':1A ''котор'':4A ''основн'':20A ''особен'':14A ''поисков'':18A ''систем'':13A,19A ''язык'':2A,21A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17254, 15687, 'Искусственный язык для описания запросов, поиска данных в базах данных и действий над запросами.', '''баз'':9A ''дан'':7A,10A ''действ'':12A ''запрос'':5A,14A ''искусствен'':1A ''описан'':4A ''поиск'':6A ''язык'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17257, 15690, 'Язык, предназначенный для формулирования запросов на поиск, обмен данными между прикладной программой и базой данных, а также для расширения языка программирования либо как самостоятельный язык.', '''баз'':14A ''дан'':9A,15A ''запрос'':5A ''либ'':22A ''обм'':8A ''поиск'':7A ''предназначен'':2A ''прикладн'':11A ''программ'':12A ''программирован'':21A ''расширен'':19A ''самостоятельн'':24A ''такж'':17A ''формулирован'':4A ''язык'':1A,20A,25A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17259, 15692, 'Формальный язык, используемый для кодирования онтологии. Существует несколько подобных языков. Это такие языки как KRYPTON, Loom, CLASSIC, Ontolingua, F-Logic, SHOE, RDF(S), OWL и прочие.', '''classic'':17A ''f'':20A ''f-logic'':19A ''krypton'':15A ''logic'':21A ''loom'':16A ''ontolingua'':18A ''owl'':25A ''rdf'':23A ''shoe'':22A ''используем'':3A ''кодирован'':5A ''нескольк'':8A ''онтолог'':6A ''подобн'':9A ''проч'':27A ''существ'':7A ''так'':12A ''формальн'':1A ''эт'':11A ''язык'':2A,10A,13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17255, 15688, 'Специализированная знаковая система для записи необходимой информации из определенных областей науки и техники.', '''запис'':5A ''знаков'':2A ''информац'':7A ''наук'':11A ''необходим'':6A ''област'':10A ''определен'':9A ''систем'':3A ''специализирова'':1A ''техник'':13A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17256, 15690, 'Язык системы управления базами данных, предназначенный для определения действий по изменению значений хранимых данных и получению данных из базы.', '''баз'':4A,19A ''дан'':5A,14A,17A ''действ'':9A ''значен'':12A ''изменен'':11A ''определен'':8A ''получен'':16A ''предназначен'':6A ''систем'':2A ''управлен'':3A ''храним'':13A ''язык'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17260, 15693, 'Специальный язык, позволяющий представить данные в виде совокупности ИО. Регламентирован международным стандартом ИСО 8879.', '''8879'':14A ''вид'':7A ''дан'':5A ''и'':9A ''ис'':13A ''международн'':11A ''позволя'':3A ''представ'':4A ''регламентирова'':10A ''совокупн'':8A ''специальн'':1A ''стандарт'':12A ''язык'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17258, 15691, 'Язык системы управления базами данных, на котором определяются организация данных, связи между данными и форма представления данных.', '''баз'':4A ''дан'':5A,10A,13A,17A ''котор'':7A ''определя'':8A ''организац'':9A ''представлен'':16A ''связ'':11A ''систем'':2A ''управлен'':3A ''форм'':15A ''язык'':1A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17261, 15694, 'Процесс создания виртуальных объемных моделей любых объектов, позволяющий максимально точно представить форму, размер, текстуру объекта, оценить внешний вид и эргономику изделия.', '''вид'':18A ''виртуальн'':3A ''внешн'':17A ''издел'':21A ''люб'':6A ''максимальн'':9A ''модел'':5A ''объект'':7A,15A ''объемн'':4A ''оцен'':16A ''позволя'':8A ''представ'':11A ''процесс'':1A ''размер'':13A ''создан'':2A ''текстур'':14A ''точн'':10A ''форм'':12A ''эргономик'':20A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17263, 15696, 'Процесс перевода физической формы реального объекта в цифровую форму, т. е. получение трехмерной компьютерной модели объекта.', '''е'':11A ''компьютерн'':14A ''модел'':15A ''объект'':6A,16A ''перевод'':2A ''получен'':12A ''процесс'':1A ''реальн'':5A ''т'':10A ''трехмерн'':13A ''физическ'':3A ''форм'':4A,9A ''цифров'':8A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17264, 15697, 'Использование для создания реальных объектов не только трех измерений (XYZ), но и фактора времени (T) — четвертого измерения. Eсли в печатные объекты добавить специальные материалы, способные реагировать на внешние стимуляторы, например, жару или воду, то они смогут двигаться и изменяться со временем.', '''eсли'':18A ''xyz'':10A ''внешн'':28A ''вод'':33A ''времен'':14A,41A ''двига'':37A ''добав'':22A ''жар'':31A ''изменя'':39A ''измерен'':9A,17A ''использован'':1A ''материал'':24A ''например'':30A ''объект'':5A,21A ''печатн'':20A ''реагирова'':26A ''реальн'':4A ''смогут'':36A ''создан'':3A ''специальн'':23A ''способн'':25A ''стимулятор'':29A ''трех'':8A ''фактор'':13A ''четверт'':16A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17265, 15698, 'Распределенная система хранения структурированных данных, позволяющая хранить петабайты данных на тысячах серверов. При создании системы акцент делался на следующих характеристиках: универсальность, масштабируемость, высокая производительность и надежность. Во многом BigTable напоминает базу данных и использует многие стратегии реализации, применяемые в высокопроизводительных СУБД.', '''bigtabl'':29A ''акцент'':16A ''баз'':31A ''высок'':23A ''высокопроизводительн'':40A ''дан'':5A,9A,32A ''дела'':17A ''использ'':34A ''масштабируем'':22A ''мног'':28A,35A ''надежн'':26A ''напомина'':30A ''петабайт'':8A ''позволя'':6A ''применя'':38A ''производительн'':24A ''распределен'':1A ''реализац'':37A ''сервер'':12A ''систем'':2A,15A ''след'':19A ''создан'':14A ''стратег'':36A ''структурирова'':4A ''субд'':41A ''тысяч'':11A ''универсальн'':21A ''характеристик'':20A ''хран'':7A ''хранен'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17266, 15699, 'Технологии непрерывной информационной поддержки жизненного цикла продукции: Информационные технологии описания изделий, производственной среды и процессов, протекающих в этой среде. Данные, порождаемые и преобразуемые этими информационными технологиями, представляются в виде, оговоренном НД информационной поддержки жизненного цикла продукции, и служат для обмена или совместного использования различными участниками жизненного цикла продукции.', '''вид'':29A ''дан'':20A ''жизнен'':5A,34A,46A ''издел'':11A ''информацион'':3A,8A,25A,32A ''использован'':43A ''нд'':31A ''непрерывн'':2A ''обм'':40A ''оговорен'':30A ''описан'':10A ''поддержк'':4A,33A ''порожда'':21A ''представля'':27A ''преобразуем'':23A ''продукц'':7A,36A,48A ''производствен'':12A ''протека'':16A ''процесс'':15A ''различн'':44A ''служат'':38A ''совместн'':42A ''сред'':13A,19A ''технолог'':1A,9A,26A ''участник'':45A ''цикл'':6A,35A,47A ''эт'':24A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17267, 15700, 'Автоматизированное проектирование информационных систем, или технологии, позволяющие автоматизировать основные этапы и процедуры жизненного цикла информационных систем: от анализа исходного состояния и целей до проектирования интерфейсов, привычных проектировщику, пользователю и основных процедур функционирования системы; чем больше этапов и процедур автоматизируется, тем лучше и быстрее получается информационная система, тем шире ее приложения.', '''автоматизир'':39A ''автоматизирова'':1A,8A ''анализ'':18A ''быстр'':43A ''жизнен'':13A ''интерфейс'':25A ''информацион'':3A,15A,45A ''исходн'':19A ''основн'':9A,30A ''позволя'':7A ''получа'':44A ''пользовател'':28A ''привычн'':26A ''приложен'':50A ''проектирован'':2A,24A ''проектировщик'':27A ''процедур'':12A,31A,38A ''сист'':4A,16A ''систем'':33A,46A ''состоян'':20A ''технолог'':6A ''функционирован'':32A ''цел'':22A ''цикл'':14A ''шир'':48A ''этап'':10A,36A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17269, 15702, 'Компьютерные системы, созданные для обработки деловых операций организации и для содействия комплексному и оперативному (в режиме реального времени) планированию, производству и обслуживанию клиентов.', '''времен'':18A ''делов'':6A ''клиент'':23A ''комплексн'':12A ''компьютерн'':1A ''обработк'':5A ''обслуживан'':22A ''оперативн'':14A ''операц'':7A ''организац'':8A ''планирован'':19A ''производств'':20A ''реальн'':17A ''режим'':16A ''систем'':2A ''содейств'':11A ''созда'':3A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17270, 15703, 'Телефонная связь по протоколу IP. Технология, позволяющая использовать Интернет или другую IP-сеть в качестве средства организации и ведения международных и междугородных телефонных разговоров и передачи факсов в режиме реального времени.', '''ip'':5A,13A ''ip-сет'':12A ''веден'':20A ''времен'':32A ''друг'':11A ''интернет'':9A ''использова'':8A ''качеств'':16A ''междугородн'':23A ''международн'':21A ''организац'':18A ''передач'':27A ''позволя'':7A ''протокол'':4A ''разговор'':25A ''реальн'':31A ''режим'':30A ''связ'':2A ''сет'':14A ''средств'':17A ''телефон'':1A,24A ''технолог'':6A ''факс'':28A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17272, 15705, 'Всеобъемлющий набор интерфейсов, услуг и поддерживаемых форматов, а также подходов пользователей для обеспечения взаимодействия или переносимости приложений, данных или персонала в соответствии с требованиями стандартов и профилей по информационным технологиям.', '''взаимодейств'':14A ''всеобъемлющ'':1A ''дан'':18A ''интерфейс'':3A ''информацион'':29A ''набор'':2A ''обеспечен'':13A ''переносим'':16A ''персона'':20A ''поддержива'':6A ''подход'':10A ''пользовател'':11A ''приложен'':17A ''профил'':27A ''соответств'':22A ''стандарт'':25A ''такж'':9A ''технолог'':30A ''требован'':24A ''услуг'':4A ''формат'':7A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17273, 15706, 'Протокол установления сеанса — протокол передачи данных, который описывает способ установления и завершения пользовательского интернет-сеанса, включающего обмен мультимедийным содержимым (видео- и аудиоконференция, мгновенные сообщения, онлайн-игры).', '''аудиоконференц'':23A ''виде'':21A ''включа'':17A ''дан'':6A ''завершен'':12A ''игр'':28A ''интернет'':15A ''интернет-сеанс'':14A ''котор'':7A ''мгновен'':24A ''мультимедийн'':19A ''обм'':18A ''онлайн'':27A ''онлайн-игр'':26A ''описыва'':8A ''передач'':5A ''пользовательск'':13A ''протокол'':1A,4A ''сеанс'':3A,16A ''содержим'':20A ''сообщен'':25A ''способ'':9A ''установлен'':2A,10A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17274, 15707, 'Основной элемент IP мини-АТС, отвечающий за формирование всех вызовов SIP в сети. Сервер SIP также называют прокси-сервером SIP или регистратором. SIP-вызовы — телефонные вызовы с использованием технологии VoIP (Voice over IP — голос, передаваемый по интернет-протоколу).', '''ip'':3A,36A ''sip'':12A,16A,22A,26A ''sip-вызов'':25A ''voic'':34A ''voip'':33A ''атс'':6A ''вызов'':11A,27A,29A ''голос'':37A ''интернет'':41A ''интернет-протокол'':40A ''использован'':31A ''мин'':5A ''мини-атс'':4A ''называ'':18A ''основн'':1A ''отвеча'':7A ''передава'':38A ''прокс'':20A ''прокси-сервер'':19A ''протокол'':42A ''регистратор'':24A ''сервер'':15A,21A ''сет'':14A ''такж'':17A ''телефон'':28A ''технолог'':32A ''формирован'':9A ''элемент'':2A', NULL, NULL);
INSERT INTO znach (id, id_slova, znach, fts_v, comment, date_upd) VALUES (17275, 15708, 'Хорошо масштабируемый, полностью реляционный, быстродействующий многопользовательский сервер баз данных масштаба предприятия, способный обрабатывать большие объемы данных для клиент-серверных приложений.', '''баз'':8A ''больш'':14A ''быстродейств'':5A ''дан'':9A,16A ''клиент'':19A ''клиент-серверн'':18A ''масштаб'':10A ''масштабируем'':2A ''многопользовательск'':6A ''обрабатыва'':13A ''объем'':15A ''полност'':3A ''предприят'':11A ''приложен'':21A ''реляцион'':4A ''сервер'':7A ''серверн'':20A ''способн'':12A', NULL, NULL);


INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12670, 15188, 1, 'Abstracted information', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12671, 15189, 1, 'Abstract model', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12672, 15190, 1, 'Data abstraction', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12673, 15191, 1, 'Emergency operation of AS', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12675, 15193, 1, 'Emergency AS', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12676, 15194, 1, 'Unstructured information processing automation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12677, 15195, 1, 'Automated organization', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12679, 15197, 1, 'Automated system', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12680, 15198, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12681, 15199, 1, 'Automated text processing system', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12682, 15200, 1, 'High availability automated system', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12683, 15201, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12684, 15202, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12685, 15203, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12686, 15204, 1, 'Automated knowledge management system', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12687, 15205, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12688, 15206, 1, 'Automated maintenance of the information object dossier', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12689, 15207, 1, 'Automated workplace', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12690, 15208, 1, 'Automated workplace military command authority', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12691, 15209, 1, 'Automated control systems of the forth generation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12692, 15210, 1, 'Automated', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12694, 15212, 1, 'Automated information retrieval thesaurus', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12695, 15213, 1, 'Computer-aided text translation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12696, 15214, 1, 'Automated process', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12697, 15215, 1, 'Text automatic analysis', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12698, 15216, 1, 'Text automatic synthesis', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12699, 15217, 1, 'Automatic', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12700, 15218, 1, 'Key terms automatic extraction', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12701, 15219, 1, 'Automatic model', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12702, 15220, 1, 'Autonomous management system', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12707, 15225, 1, 'Authorization', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12708, 15226, 1, 'Data authorization', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12709, 15227, 1, 'Program authorization', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12710, 15228, 1, 'Author supervision of state AS', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12711, 15229, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12712, 15230, 1, 'Content aggregation from various sources of information', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12713, 15231, 1, 'Data aggregation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12714, 15232, 1, 'Software adaptation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12715, 15233, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12716, 15234, 1, 'AS adaptivity', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12717, 15235, 1, 'Information adequacy', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12718, 15236, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12719, 15237, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12722, 15240, 1, 'Data administrator', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12723, 15241, 1, 'Security administrator', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12724, 15242, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12725, 15243, 1, 'Security service administrator', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12726, 15244, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12727, 15245, 1, 'Address', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12728, 15246, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12729, 15247, 1, 'Active monitoring', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12730, 15248, 1, 'Actor', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12731, 15249, 1, 'Actualization', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12732, 15250, 1, 'Data updating', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12733, 15251, 1, 'Error-free information urgency', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12737, 15255, 1, 'Algorithm', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12738, 15256, 1, 'Shortest path first', 'SPF');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12739, 15257, 1, 'Routing algorithm', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12740, 15258, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12741, 15259, 1, 'Ciphering algorithm', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12742, 15260, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12743, 15261, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12747, 15265, 1, 'Database', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12748, 15266, 1, 'Lexicographic database', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12749, 15267, 1, 'Lexical database', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12750, 15268, 1, 'Risk database', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12751, 15269, 1, 'Configuration management database', 'CMDB');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12753, 15271, 1, 'Knowledge base, K-base', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12754, 15272, 1, 'Closed knowledge base', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12755, 15273, 1, 'Intensional knowledge base', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12756, 15274, 1, 'Opened knowledge base', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12757, 15275, 1, 'Known error database', 'KEDB');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12758, 15276, 1, 'Lessons learned knowledge base', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12759, 15277, 1, 'Management information base', 'MIB');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12760, 15278, 1, 'Vaccination', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12763, 15281, 1, 'Validation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12764, 15282, 1, 'Uniform Resource Identifier', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12765, 15283, 1, 'Web-interface', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12766, 15284, 1, 'Web-mining', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12767, 15285, 1, 'Web-service', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12768, 15286, 1, 'Web-page', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12769, 15287, 1, 'Wavelet transform', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12770, 15288, 1, 'Verbal and figurative knowledge representation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12776, 15294, 1, 'Verification', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12777, 15295, 1, 'Gadget', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12778, 15296, 1, 'Warranty inspection of AS', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12779, 15297, 1, 'IT service warranty', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12781, 15299, 1, 'Security accredidation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12782, 15300, 1, 'Genetic algorithms', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12783, 15301, 1, 'Geodata', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12784, 15302, 1, 'Geoinformatics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12787, 15305, 1, 'Geographic information system', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12789, 15307, 1, 'Geographic information technology', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12790, 15308, 1, 'Geocoding (spatial object)', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12791, 15309, 1, 'Geomatics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12792, 15310, 1, 'Geomatics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12793, 15311, 1, 'Geolocation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12794, 15312, 1, 'Georeference', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12797, 15315, 1, 'Data', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12798, 15316, 1, 'Input data', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12799, 15317, 1, 'Output data', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12800, 15318, 1, 'Database datalogical model', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12801, 15319, 1, 'Random numbers generator', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12802, 15320, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12804, 15322, 1, 'Disinformation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12805, 15323, 1, 'Decoder, decoding unit', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12808, 15326, 1, 'Decoding', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12809, 15327, 1, 'Computer software program decompilation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12811, 15329, 1, 'Descriptor', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12812, 15330, 1, 'Descriptor-sense', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12813, 15331, 1, 'Single point of failure', 'SPOF');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12814, 15332, 1, 'Protocol data unit', 'PDU');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12815, 15333, 1, 'Cost unit', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12816, 15334, 1, 'Release unit', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12819, 15337, 1, 'Unified information space', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12820, 15338, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12821, 15339, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12822, 15340, 1, 'E-infrastructure', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12823, 15341, 1, 'Natural language interface', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12824, 15342, 1, 'Greedy algorithm', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12825, 15343, 1, 'Automated organization survivability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12826, 15344, 1, 'AS survivability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12827, 15345, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12828, 15346, 1, 'Life cycle', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12829, 15347, 1, 'AS life cycle', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12830, 15348, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12831, 15349, 1, 'Trusted environment lifecycle', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12832, 15350, 1, 'Military equipment life cycle', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12833, 15351, 1, 'Program life cycle', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12835, 15353, 1, 'System life cycle', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12836, 15354, 1, 'Log', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12837, 15355, 1, 'Server log', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12838, 15356, 1, 'File system journalizing', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12839, 15357, 1, 'Closing processes', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12840, 15358, 1, 'AS problem', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12841, 15359, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12842, 15360, 1, 'Information association law in Information dynamics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12843, 15361, 1, 'Information succession law in Information dynamics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12844, 15362, 1, 'Affiliation law and interpretation in Information dynamics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12845, 15363, 1, 'Difference law in Information dynamics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12846, 15364, 1, 'Identity law and identification in Information dynamics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12847, 15365, 1, 'Closed (protected) data', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12848, 15366, 1, 'Information protection concept)', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12849, 15367, 1, 'Identifier', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12850, 15368, 1, 'Virtual path identifier', 'VPI');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12851, 15369, 1, 'Label', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12854, 15372, 1, 'Identification', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12855, 15373, 1, 'Knowledge identification', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12856, 15374, 1, 'Configuration identification', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12857, 15375, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12858, 15376, 1, 'Cloud services identification', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12859, 15377, 1, 'Release identification', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12860, 15378, 1, 'Risk identification in AS', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12861, 15379, 1, 'Hierarchic data model', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12862, 15380, 1, 'Hierarchic escalation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12863, 15381, 1, 'Open Shortest Path First', 'OSPF');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12865, 15383, 1, 'Knowledge mining', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12867, 15385, 1, 'Frame', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12868, 15386, 1, 'Personnel security', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12870, 15388, 1, 'Data link layer', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12871, 15389, 1, 'Knowledge capital', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12872, 15390, 1, 'Knowledge map', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12873, 15391, 1, 'Picture perception', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12874, 15392, 1, 'Cartographic database', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12875, 15393, 1, 'Directory (catalogue)', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12876, 15394, 1, 'IT services catalogue', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12877, 15395, 1, 'Cataloging of products (for federal needs)', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12878, 15396, 1, 'AS disaster recovery', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12879, 15397, 1, 'Information safety category', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12881, 15399, 1, 'Information protection category', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12882, 15400, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12883, 15401, 1, 'Lag', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12884, 15402, 1, 'Legendiring', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12885, 15403, 1, 'Lexical- morphological analysis', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12886, 15404, 1, 'Lexical unit', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12887, 15405, 1, 'Linguistic variable', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12888, 15406, 1, 'AS linguistic level compatibility', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12889, 15407, 1, 'Linguistic heuristic', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12892, 15410, 1, 'Linguistic analysis', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12893, 15411, 1, 'Linguistic retrieval', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12894, 15412, 1, 'Linguistic processor', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12896, 15414, 1, 'AS linguistic support', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12897, 15415, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12898, 15416, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12899, 15417, 1, 'Line of service', 'LOS');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12900, 15418, 1, 'Licensing in the field of information security', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12901, 15419, 1, 'Logical semantic analysis of the AS resource-service possibilities', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12902, 15420, 1, 'Logical semantic approach to the analysis of the AS resource and service capabilities', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12903, 15421, 1, 'Logical data model', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12904, 15422, 1, 'Logical disk', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12905, 15423, 1, 'Logical blocking', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12906, 15424, 1, 'Local continuous replication', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12907, 15425, 1, 'Local disc', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12908, 15426, 1, 'Luke', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12909, 15427, 1, 'Backbone network', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12910, 15428, 1, 'Model, layout', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12911, 15429, 1, 'Macroviruses', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12912, 15430, 1, 'Maximum tolerable period of disruption', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12914, 15432, 1, 'Mandatory access control', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12915, 15433, 1, 'Mandatory principle of monitoring of access', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12916, 15434, 1, 'Knowledge manipulation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12918, 15436, 1, 'Router', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12919, 15437, 1, 'Label switched router', 'LSR');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12920, 15438, 1, 'Routing', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12921, 15439, 1, 'Scrambler', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12922, 15440, 1, 'Digital data masking', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12923, 15441, 1, 'Array', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12924, 15442, 1, 'Massively parallel processing', 'MPP');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12925, 15443, 1, 'Data analysis scaling', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12926, 15444, 1, 'Scalability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12927, 15445, 1, 'Mathematical model of fighting', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12928, 15446, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12929, 15447, 1, 'Mathematical support of means of information protection', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12930, 15448, 1, 'Database machine', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12931, 15449, 1, 'Knowledge base machine', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12932, 15450, 1, 'Outputing machine', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12933, 15451, 1, 'Logical deduction machine', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12934, 15452, 1, 'Parallel output machine', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12935, 15453, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12936, 15454, 1, 'Computer translation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12937, 15455, 1, 'Media container', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12938, 15456, 1, 'Machine-to-Machine', 'M2M');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12939, 15457, 1, 'Network interaction', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12940, 15458, 1, 'Gateway', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12941, 15459, 1, 'Firewall', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12943, 15461, 1, 'Mainframe', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12944, 15462, 1, 'Navigation information', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12945, 15463, 1, 'AS reliability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12946, 15464, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12947, 15465, 1, 'IT service reliability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12948, 15466, 1, 'Information representation trustworthiness', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12950, 15468, 1, 'Software (program) reliability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12951, 15469, 1, 'Software eliability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12952, 15470, 1, 'Add-in', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12953, 15471, 1, 'Disruption', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12955, 15473, 1, 'Information system security violation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12958, 15476, 1, 'Information security violator', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12959, 15477, 1, 'Security policy violator', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12961, 15479, 1, 'Inheritance', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12962, 15480, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12963, 15481, 1, 'Research work on creation of ME', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12964, 15482, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12965, 15483, 1, 'National cloud platform', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12966, 15484, 1, 'Initial support', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12968, 15486, 1, 'Undeclared possibilities', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12969, 15487, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12970, 15488, 1, 'Neuroinformatics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12971, 15489, 1, 'Neurocomputer', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12972, 15490, 1, 'Neurocomputer interface', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12973, 15491, 1, 'Immediate recovery', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12974, 15492, 1, 'Neogeography', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12975, 15493, 1, 'Heterogeneous information resources', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12976, 15494, 1, 'Unforeseen situation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12977, 15495, 1, 'Inoperable military equipment (complex, sample) system', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12979, 15497, 1, 'Unstructured data', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12980, 15498, 1, 'Fuzzy information', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12981, 15499, 1, 'Security norm', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12982, 15500, 1, 'AS normative reference information', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12983, 15501, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12984, 15502, 1, 'Information owner', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12985, 15503, 1, 'Cloud analytics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12986, 15504, 1, 'Cloud database', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12987, 15505, 1, 'Cloud technologies', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12989, 15507, 1, 'Data communication', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12990, 15508, 1, 'Knowledge synthesizing', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12993, 15511, 1, 'Information processing', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12994, 15512, 1, 'Processing of personal data', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12995, 15513, 1, 'Text information processing', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12996, 15514, 1, 'Common product data base', 'CPDB');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12997, 15515, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12998, 15516, 1, 'Packet', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (12999, 15517, 1, 'Packet technology', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13000, 15518, 1, 'Paradigmatic relations', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13001, 15519, 1, 'Service quality parameter', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13002, 15520, 1, 'Information settings', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13003, 15521, 1, 'Parcing', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13004, 15522, 1, 'Passive optical network', 'PON');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13005, 15523, 1, 'Patch', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13006, 15524, 1, 'Pertinence', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13007, 15525, 1, 'Peer-to-peer', 'P2P');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13008, 15526, 1, 'Document turnover quality indicators', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13009, 15527, 1, 'Documents recipient', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13010, 15528, 1, 'Military equipment development', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13012, 15530, 1, 'Distributed database', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13013, 15531, 1, 'Distributed network intelligence', 'NGN');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13015, 15533, 1, 'Distributed data processing', 'DDP');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13016, 15534, 1, 'Incident operation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13018, 15536, 1, 'Ontology reengineering', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13019, 15537, 1, 'Relative databases', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13022, 15540, 1, 'Relational data model', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13023, 15541, 1, 'Resource', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13024, 15542, 1, 'AS resource', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13025, 15543, 1, 'AS risks', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13026, 15544, 1, 'Data collection', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13027, 15545, 1, 'AS large-scaleness property', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13028, 15546, 1, 'AS multilevelness property', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13029, 15547, 1, 'Openness property', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13030, 15548, 1, 'Self-organization property', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13031, 15549, 1, 'Weak predictability property', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13032, 15550, 1, 'Complexity property', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13033, 15551, 1, 'Linkage of information objects', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13034, 15552, 1, 'Network segment', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13035, 15553, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13036, 15554, 1, 'Semantic information measure', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13037, 15555, 1, 'Semantic technology', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13040, 15558, 1, 'Server', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13041, 15559, 1, 'Application server', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13042, 15560, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13043, 15561, 1, 'Solid-state drive', 'SSD');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13044, 15562, 1, 'Telecommunication infrastructure', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13045, 15563, 1, 'Telecommunication hardware', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13046, 15564, 1, 'Thematic retrieval', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13047, 15565, 1, 'Term', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13048, 15566, 1, 'AS technical survivability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13049, 15567, 1, 'AS hardware compatibility', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13050, 15568, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13051, 15569, 1, 'AS continuous functioning recovery technical characteristics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13052, 15570, 1, 'Business Intelligence technology', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13053, 15571, 1, 'Database technologies', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13054, 15572, 1, 'Knowledge representation technologies', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13055, 15573, 1, 'Speech recognition and synthesis technology', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13056, 15574, 1, 'Knowledge formalization technologies', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13057, 15575, 1, 'Threat', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13058, 15576, 1, 'Active threat', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13062, 15580, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13063, 15581, 1, 'Passive threat', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13064, 15582, 1, 'Network node', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13065, 15583, 1, 'Speculative perception of information', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13066, 15584, 1, 'Unified form of the military document', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13067, 15585, 1, 'Unified form of the document', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13068, 15586, 1, 'Unified form of the military purposes accounting information document', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13069, 15587, 1, 'Databases management', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13070, 15588, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13073, 15591, 1, 'Knowledge management', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13074, 15592, 1, 'File boot sector virus «overwriting»', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13075, 15593, 1, 'File sharing network', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13076, 15594, 1, 'Factual information', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13077, 15595, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13078, 15596, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13079, 15597, 1, 'Phishing', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13080, 15598, 1, 'Data formalization', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13081, 15599, 1, 'Information formalization', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13082, 15600, 1, 'AS functional survivability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13083, 15601, 1, 'Functional stability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13084, 15602, 1, 'AS function', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13087, 15605, 1, 'Hacker', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13089, 15607, 1, 'Hashing', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13090, 15608, 1, 'Hashtag', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13092, 15610, 1, 'Hash function', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13093, 15611, 1, 'Cold backup', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13094, 15612, 1, 'Host', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13095, 15613, 1, 'Hosting', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13096, 15614, 1, 'Data storage as a Service', 'DaaS');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13097, 15615, 1, 'Data Warehouse', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13098, 15616, 1, 'Chronological analysis', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13099, 15617, 1, 'Database integrity', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13103, 15621, 1, 'Data integrity', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13109, 15627, 1, 'Information integrity', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13112, 15630, 1, 'System integrity', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13113, 15631, 1, 'Information protection target', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13114, 15632, 1, 'Information value', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13115, 15633, 1, 'AS management centre', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13116, 15634, 1, 'Digital map', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13117, 15635, 1, 'Area digital map', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13118, 15636, 1, 'Integrated services digital network', 'ISDN');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13119, 15637, 1, 'Digital certificate', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13120, 15638, 1, 'Digital technology', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13121, 15639, 1, 'Partial verification', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13122, 15640, 1, 'Private cloud', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13123, 15641, 1, 'Pure IT technologies', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13124, 15642, 1, 'Extraordinary event', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13125, 15643, 1, 'AS extraordinary operation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13126, 15644, 1, 'Secure Shell', 'SSH');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13127, 15645, 1, 'Sixth technological mode', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13128, 15646, 1, 'Broadcasting', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13129, 15647, 1, 'Broadcast address', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13130, 15648, 1, 'Broadband multiservice network', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13133, 15651, 1, 'Cipher, cryptosystem', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13135, 15653, 1, 'Encoder, encipher', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13138, 15656, 1, 'Encryption, encipherment', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13139, 15657, 1, 'Public key cryptography', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13140, 15658, 1, 'Evoinformatics', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13141, 15659, 1, 'Heuristic information', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13142, 15660, 1, 'Expert examination of the technical documentation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13144, 15662, 1, 'Expert system', 'ES');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13145, 15663, 1, '', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13147, 15665, 1, 'Exploit', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13148, 15666, 1, 'Maintenance documentation of AS', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13149, 15667, 1, 'AS maintenance survivability', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13150, 15668, 1, 'Fault Resiliency', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13151, 15669, 1, 'Electronic library', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13152, 15670, 1, 'Digital map', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13156, 15674, 1, 'Digital signature', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13157, 15675, 1, 'Electronic archive', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13159, 15677, 1, 'Electronic document', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13160, 15678, 1, 'Electronic document circulation', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13161, 15679, 1, 'Explicit knowledge', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13162, 15680, 1, 'Database administration language', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13164, 15682, 1, 'Database language', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13165, 15683, 1, 'HyperText Markup Language', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13166, 15684, 1, 'Wireless markup language', 'WML');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13167, 15685, 1, 'eXtensible Markup Language', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13169, 15687, 1, 'Query language', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13170, 15688, 1, 'Artificial language', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13172, 15690, 1, 'Data manipulation language', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13173, 15691, 1, 'Data definition language', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13174, 15692, 1, 'Language for describing ontologies', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13175, 15693, 1, 'Standard Generalized Markup Language', 'SGML');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13176, 15694, 1, '3D-modeling', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13177, 15695, 1, '3D-printing', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13178, 15696, 1, '3D-scanning', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13179, 15697, 1, '4D-printing', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13180, 15698, 1, 'Большая таблица', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13181, 15699, 1, 'CALS-technology', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13182, 15700, 1, 'Computer-Aided System Еngineering', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13183, 15701, 1, 'Система Customer relationship management', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13184, 15702, 1, 'Enterprise Resource Planning systems', 'ERP');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13185, 15703, 1, 'IP-phone', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13186, 15704, 1, 'NoSQL Data Base', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13187, 15705, 1, 'Среда (окружение) открытой системы', 'СОС');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13188, 15706, 1, 'Session Initiation Protocol', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13189, 15707, 1, 'SIP-server', '');
INSERT INTO inslovo (id, id_slovo, id_lang, name, sokr) VALUES (13190, 15708, 1, 'SQL-server', '');


INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (3, 'Федеральный закон Российской Федерации «Об электронной подписи» от 6 апреля 2011 г. № 63-ФЗ (с изменениями на 30 декабря 2015 года).    ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (8, 'Защита от несанкционированного доступа к информации. Термины и определения. Сборник руководящих документов по защите информации от несанкционированного доступа.   Москва Гостехкомиссия России 1998 ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (10, 'Защита от несанкционированного доступа к информации. Часть 1. Программное обеспечение средств защиты информации. Классификация по уровню контроля отсутствия недекларированных возможностей: Руководящий документ (утв. решением Государственной технической комиссии при Президенте РФ от 4 июня 1999 г. № 114).  Москва Гостехкомиссия России 2000 ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (13, 'ГОСТ Р ИСО 9000–2008. Системы менеджмента качества. Основные положения и словарь [Текст]. — Введ. 2009–09–10.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (14, 'ГОСТ Р ИСО 10303-239–2008. Системы автоматизации производства и их интеграция. Представление данных об изделии и обмен этими данными. Часть 239. Прикладные протоколы. Поддержка жизненного цикла изделий [Текст]. — Введ. 2008–09–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (16, 'ГОСТ Р ИСО/МЭК 15288–2005. Информационная технология. Системная инженерия. Процессы жизненного цикла систем [Текст]. — Введ. 2007–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (18, 'ГОСТ Р ИСО/МЭК 17826–2015. Информационные технологии. Интерфейс управления облачными данными (CDMI) [Текст]. — Введ. 2016–06–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (19, 'ГОСТ 34.003–90. Информационная технология. Комплекс стандартов и руководящих документов на автоматизированные системы. Автоматизированные системы. Термины и определения [Текст]. — Введ. 1992–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (20, 'ГОСТ Р ИСО/МЭК ТО 19791–2008. Информационная технология. Методы и средства обеспечения безопасности. Оценка безопасности автоматизированных систем [Текст]. — Введ. 2009–10–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (22, 'ГОСТ Р 53647.1–2009. Менеджмент непрерывности бизнеса. Часть 1. Практическое руководство [Текст]. — Введ. 2010–12–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (23, 'ГОСТ Р 53647.2–2009. Менеджмент непрерывности бизнеса. Часть 2. Требования [Текст]. — Введ. 2010–12–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (25, 'ГОСТ Р 53131–2008. Защита информации. Рекомендации по услугам восстановления после чрезвычайных ситуаций функций и механизмов безопасности информационных и телекоммуникационных технологий. Общие положения [Текст]. — Введ. 2009–10–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (26, 'ГОСТ Р 50922–2006. Защита информации. Основные термины и определения [Текст]. — Введ. 2008–02–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (27, 'ГОСТ 2.601–2013. Единая система конструкторской документации. Эксплуатационные документы (с поправкой) [Текст]. — Введ. 2014–06–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (30, 'ГОСТ Р ИСО/ТС 18308–2008. Информатизация здоровья. Требования к архитектуре электронного учета здоровья [Текст]. — Введ. 2008–09–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (32, 'ГОСТ Р 51188–98. Защита информации. Испытания программных средств на наличие компьютерных вирусов. Типовое руководство [Текст]. — Введ. 1999–07–01.  Москва Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (35, 'ГОСТ Р 53114–2008. Защита информации. Обеспечение информационной безопасности в организации. Основные термины и определения [Текст]. — Введ. 2009–10–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (37, 'ГОСТ 28441–99. Картография цифровая. Термины и определения [Текст]. — Введ. 2000–07–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (41, 'ГОСТ Р 43.0.11–2014. Информационное обеспечение техники и операторской деятельности. Базы данных в технической деятельности [Текст]. — Введ. 2015–09–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (43, 'ГОСТ Р 43.0.4–2009. Информационное обеспечение техники и операторской деятельности. Информация в технической деятельности. Общие положения [Текст]. — Введ. 2011–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (48, 'ГОСТ Р 43.2.3–2009. Информационное обеспечение техники и операторской деятельности. Язык операторской деятельности. Виды и свойства знаковых компонентов [Текст]. — Введ. 2011–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (50, 'ГОСТ Р 43.2.5–2011. Информационное обеспечение техники и операторской деятельности. Язык операторской деятельности. Грамматика [Текст]. — Введ. 2013–07–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (52, 'ГОСТ Р 43.2.8–2014. Информационное обеспечение техники и операторской деятельности. Язык операторской деятельности. Форматы сообщений для технической деятельности [Текст]. — Введ. 2015–09–16.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (57, 'ГОСТ Р 56205–2014. Сети коммуникационные промышленные. Защищенность (кибербезопасность) сети и системы. Часть 1-1. Терминология, концептуальные положения и модели [Текст]. — Введ. 2016–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (58, 'ОСТ Р 52438–2005. ГГеографические информационные системы. Термины и определения [Текст]. — Введ. 2006–07–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (61, 'ГОСТ Р 51725.2–2012. Каталогизация продукции для федеральных государственных нужд. Термины и определения [Текст]. — Введ. 2013–07–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (64, 'ГОСТ Р 54722–2011. Глобальная навигационная спутниковая система. Системы диспетчерского управления городским пассажирским транспортом. Назначение, состав и характеристики подсистемы картографического обеспечения [Текст]. — Введ. 2012–09–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (65, 'ГОСТ 55036-2012/ISO/TS 25237:2008. Информатизация здоровья. Псевдонимизация [Текст]. — Введ. 2013–07–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (67, 'ГОСТ Р 53632–2009. Показатели качества услуг доступа в Интернет. Общие требования [Текст]. — Введ. 2010–12–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (75, 'ГОСТ Р 52292−2004. Электронный обмен информацией. Термины и определения [Текст]. — Введ. 2005–07–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (78, 'ИСО/МЭК ТО 10000-3–99. Информационная технология. Основы и таксономия международных функциональных стандартов. Часть 3. Принципы и таксономия профилей среды открытых систем [Текст]. — Введ. 2000–07–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (79, 'ГОСТ 7.74–96. Межгосударственный стандарт. Система стандартов по информации, библиотечному и издательскому делу. Информационно-поисковые языки. Термины и определения [Текст]. — Введ. 1997–07–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (82, 'ГОСТ Р ИСО 7498-2–99. Информационная технология. Взаимосвязь открытых систем. Базовая эталонная модель. Часть 2. Архитектура защиты информации [Текст] — Введ. 2000–01–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (83, 'ГОСТ Р 50.1.031–2001. Рекомендации по стандартизации. Информационные технологии поддержки жизненного цикла продукции. Терминологический словарь. Часть 1. Стадии жизненного цикла продукции. [Текст] — Введ. 2002–07–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (84, 'ГОСТ Р 50.1.053–2005. Рекомендации по стандартизации. Информационные технологии. Основные термины и определения в области технической защиты информации [Текст] — Введ. 2006–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (85, ' Стандарт Банка России СТО БР ИББС–1.0–2010. Обеспечение информационной безопасности организаций банковской системы Российской Федерации. Общие положения [Текст]. — Введ. 2010–06–21.  Москва  ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (110, 'Воройский Ф. С. Информатика. Новый систематизированный толковый словарь-справочник (Введение в современные информационные и телекоммуникационные технологии в терминах и фактах). — 3-е изд., перераб. и доп.  Москва Физматлит 760 с.', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (134, 'Приходько А. Я. Словарь-справочник по информационной безопасности [Текст]: словарь / А. Я. Приходько.  Москва СИНТЕГ 124 с.', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (135, 'Домарев В. В. Безопасность информационных технологий. Методология создания систем защиты. Киев ООО «ТИД «ДиаСофт» 688 с.', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (137, ' Информационные вызовы национальной и международной безопасности/ И. Ю. Алексеева и др. Под общ. ред. А. В. Федорова, В. Н. Цыгичко.  Москва ПИР-Центр 328 с.', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (138, 'Черемушкин А. В. Информационная безопасность. Глоссарий. Под ред. С. Пазизина.  Москва «Авангард Центр» 322 с.', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (140, 'Даве В., Кестел Д. и др. Руководство к Своду знаний по управлению проектами (РМВОК) 3-е изд.  Москва  ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (145, ' Словарь терминов и определений в области информационной безопасности. 2-е изд.  Москва ВАГШ ВС РФ, НИЦ информационной безопасности 256 с.', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (147, ' Сборник терминов и научно-технических понятий в области автоматизированных систем военного назначения. Министерство обороны Российской Федерации.  Москва 27 Центральный научно-исследовательский институт ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (165, ' Википедия.  http://ru.wikipedia.org. ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (187, 'РД 50-680–88. Методические указания. Автоматизированные системы. Основные положения [Текст] — Введ. 1990–01–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (188, 'ГОСТ РВ 52333.1–2005. Средства управления войсками и оружием. Системы управления войсками автоматизированные. Термины и определения / Федер. агентство по техн. регулированию и метрологии [Текст] — Введ. 2006–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (189, 'ГОСТ РВ 1210-003–2007. Автоматизированные системы управления войсками. Требования к математическому и программному обеспечению [Текст] — Введ. 2008–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (190, 'ГОСТ 26553–85. Обслуживание средств вычислительной техники централизованное комплексное. Термины и определения [Текст] — Введ. 1986–07–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (192, ' Закон РФ «О правовой охране программ для электронных вычислительных машин и баз данных» от 23 сентября 1992 г. № 3523-1.   ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (193, 'ГОСТ 28806–90. Качество программных средств. Термины и определения [Текст] — Введ. 1992–01–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (194, 'ГОСТ РВ 1210-002–2007. Автоматизированные системы управления войсками. Требования к информационному и лингвистическому обеспечению [Текст] — Введ. 2008–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (195, 'ГОСТ Р ИСО 15704–2008. Промышленные автоматизированные системы. Требования к стандартным архитектурам и методологиям предприятия [Текст] — Введ. 2010–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (201, 'ГОСТ Р 51583–2000. Защита информации. Порядок создания автоматизированных систем в защищенном исполнении. Общие положения [Текст] — Введ. 2001–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (203, 'ГОСТ 20886–85. Межгосударственный стандарт. Организация данных в системах обработки данных. Термины и определения [Текст] — Введ. 1986–07–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (204, 'ГОСТ 34.321–96. Информационные технологии. Система стандартов по базам данных. Эталонная модель управления данными [Текст] — Введ. 2001–07–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (210, 'ГОСТ РВ 5819-109–2007. Объединенная автоматизированная цифровая система связи Вооруженных Сил Российской Федерации. Общие требования к системе навигационного обеспечения [Текст] — Введ. 2006–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (213, ' Концепция единого информационного пространства Вооруженных Сил Российской Федерации.  Москва 2004. ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (217, 'ГОСТ РВ 52333.3–2006. Автоматизированные системы управления войсками. Требования к методам обследования органов военного управления [Текст] — Введ. 2007–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (224, ' Терминология в области защиты информации. Справочник.  Москва ВНИИ-стандарт 30 с.', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (225, 'ГОСТ РВ 5819-113–2009. Объединенная автоматизированная цифровая система связи Вооруженных Сил Российской Федерации. Пункты управления связью. Классификация и общие технические требования [Текст] — Введ. 2009–12–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (226, 'ГОСТ РВ 15.210–2001. \ Система разработки и постановки продукции на производство. Военная техника. Испытания опытных образцов изделий и опытных ремонтных образцов изделий. Основные положения [Текст] — Введ. 2003–01–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (227, 'ГОСТ Р 50739–95. Средства вычислительной техники. Защита от несанкционированного доступа к информации. Общие технические требования [Текст] — Введ. 1996–01–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (231, 'ГОСТ РВ 52333.2–2006. Автоматизированные системы управления войсками. Средства управления войсками и оружием. Общие технические требования (с Изменениями №1) [Текст] — Введ. 2007–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (232, 'ГОСТ РВ 52403–2005. Свойства и состояния систем, комплексов и образцов военной техники. Термины и определения [Текст] — Введ. 2006–07–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (234, 'ГОСТ Р 51275–99. Защита информации. Объект информатизации. Факторы, воздействующие на информацию. Общие положения [Текст] — Введ. 2000–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (239, ' Об обязательном экземпляре документов. Федеральный закон от 29 декабря 1994 г. № 77–ФЗ (с изменениями на 3 июля 2016 года).   ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (244, ' Информационная война и защита информации. Словарь основных терминов и определений.  Москва  ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (245, ' Основные направления государственной политики в области обеспечения безопасности автоматизированных систем управления производственными и технологическими процессами критически важных объектов инфраструктуры Российской Федерации (утв. Президентом РФ от 3 февраля 2012 г. № 803).   ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (252, ' Основные военно-научные термины и понятия.  Москва МО СССР ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (253, 'ГОСТ 28147–89. Система обработки информации. Защита криптографическая. Алгоритм криптографического преобразования [Текст] — Введ. 1990–07–01.  Москва  Издательство стандартов ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (255, ' Война и мир в терминах и определениях. Военно-технический словарь / Под ред. Д. О. Рогозина.  Москва ИД «ПоРог» ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (256, ' Безопасность России. Правовые, социально-экономические и научно-технические аспекты. Тематический блок «Национальная безопасность». Геополитика и безопасность. Энциклопедический словарь-справочник/ Под общ. ред. В. А. Баришпольца.  Москва МГОФ «Знание» 832 с.', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (258, 'ГОСТ Р 51624–2000. Защита информации. Автоматизированные системы в защищенном исполнении. Общие требования [Текст] — Введ. 2001–01–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (261, 'ГОСТ Р 50.1.056–2005. Техническая защита информации. Основные термины и определения [Текст] — Введ. 2006–06–01.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (262, 'Погорелов Б. А., Сачков В. Н. Словарь криптографических терминов.  Москва МЦНМО ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (270, 'Мордвинов В. А., Фомина А. Б. Защита информации и информационная безопасность. / МГДД(Ю)Т, МИРЭА, ГНИИ ИТТ «Информика».  Москва  ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (273, 'ГОСТ 33707–2016. Информационные технологии. Словарь [Текст]  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (275, 'ГОСТ РВ 50.1.023–2000. Рекомендации по стандартизации. Положение по организации разработки математического, программного, информационного и лингвистического обеспечения АС ВН, отвечающего требованиям информационной безопасности.  Москва Стандартинформ ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (276, ' Доктрина информационной безопасности Российской Федерации (утв. Президентом РФ от 5 декабря 2016 г. № 646).   ', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (277, ' Информационные технологии. Краткий терминологический словарь специальных терминов / Под ред. акад. РАН И. А. Соколова, доктора технических наук И. И. Быстрова.  Москва ФИЦ ИУ РАН 380 с.', NULL, NULL);
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (366, 'Специальные требования и рекомендации по технической защите конфиденциальной информации (СТР-К).', '', '');
INSERT INTO istochnik (id, name, opisanie, ssilka) VALUES (1, 'Федеральный закон Российской Федерации «Об информации, информационных технологиях и о защите информации» от 27 июля 2006 г. № 149-ФЗ. (с изменениями на 19 декабря 2016 года).    ', '', '');



INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (217, 'Общая терминология', 217, '12');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (117, 'Эффективность системы управления', 115, '01.02.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (118, 'Основные элементы системы управления', 113, '01.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (119, 'Свойства системы управления', 113, '01.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (120, 'Взаимодействие с внешней средой', 119, '01.04.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (121, 'Внутреннее состояние системы', 119, '01.04.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (123, 'Автоматизированные системы', NULL, '02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (124, 'Общая терминология', 123, '02.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (125, 'Основные компоненты АС', 123, '02.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (126, 'Свойства и показатели АС', 123, '02.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (127, 'Создание и функционирование АС', 123, '02.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (128, 'Электронное ТЗ', 127, '02.04.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (129, 'Технология САПР', 127, '02.04.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (130, 'CASE – технология', 127, '02.04.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (131, 'Управление требованиями', 127, '02.04.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (132, 'Документация на АС', 123, '02.05');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (134, 'Методическое обеспечение', 133, '02.06.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (135, 'Математическое обеспечение', 133, '02.06.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (136, 'Программное обеспечение', 133, '02.06.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (137, 'Техническое обеспечение', 133, '02.06.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (139, 'Организационное обеспечение', 133, '02.06.06');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (140, 'Правовое обеспечение', 133, '02.06.07');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (141, 'Эргономическое обеспечение', 133, '02.06.08');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (142, 'Информационное пространство', NULL, '03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (143, 'Общая терминология', 142, '03.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (145, 'Классификация и кодирование информации', 144, '03.02.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (146, 'Унифицированные системы документации', 144, '03.02.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (147, 'Информационные процессы', 142, '03.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (148, 'Информатизация', 142, '03.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (149, 'Инфокоммуникации', NULL, '04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (150, 'Общая терминология', 149, '04.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (151, 'Вычислительные сети', 149, '04.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (154, 'Кабельная продукция', 149, '04.05');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (155, 'Информационные технологии', NULL, '05');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (156, 'Общая терминология', 155, '05.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (157, 'Технологии обработки информации', 155, '05.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (159, 'Видеоинформационные технологии', 157, '05.02.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (160, 'Геоинформационные технологии', 157, '05.02.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (161, 'Интеллектуальные технологии', 157, '05.02.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (223, 'Технологии программирования', 157, '05.02.05');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (162, 'Технологии хранения информации', 155, '05.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (163, 'Технология баз данных', 162, '05.03.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (164, 'Технология баз знаний', 162, '05.03.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (222, 'Технологии оказания ИТ-услуг', 155, '05.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (165, 'Информационное право', NULL, '06');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (166, 'Общая терминология', 165, '06.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (167, 'Информационная безопасность', 165, '06.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (171, 'Субъекты обеспечения информационной безопасности', 167, '06.02.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (172, 'Информационная безопасность, интересы в информационной сфере', 167, '06.02.05');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (174, 'Защита информации', NULL, '07');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (173, 'Правовые нормы', 165, '06.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (175, 'Общая терминология', 174, '07.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (176, 'Защита государственной тайны', 174, '07.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (177, 'Угрозы безопасности информации', 174, '07.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (178, 'Субъекты защиты информации', 174, '07.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (179, 'Объекты защиты информации', 174, '07.05');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (180, 'Организация защиты информации', 174, '07.06');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (181, 'Способы и средства защиты информации', 174, '07.07');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (182, 'Техническая защита информации', 174, '07.08');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (184, 'Способы и средства технической защиты информации', 182, '07.08.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (185, 'Объекты технической защиты информации', 182, '07.08.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (186, 'Криптографическая защита информации', 174, '07.09');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (187, 'Вооружение и военная техника', NULL, '08');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (188, 'Общая терминология', 187, '08.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (196, 'Технические устройства обучения и подготовки военных кадров', 194, '08.04.02.01.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (197, 'Технические устройства военно-технической пропаганды', 194, '08.04.02.01.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (205, 'Стандартизация', 199, '09.06');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (206, 'Метрология', 199, '09.07');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (207, 'Испытания', 199, '09.08');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (208, 'Делопроизводство', NULL, '10');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (209, 'Общая терминология', 208, '10.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (224, 'Качество', NULL, '12');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (153, 'Средства проводной связи', 149, '04.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (158, 'Мультимедийные технологии', 157, '05.02.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (169, 'Угрозы информационной безопасности Российской Федерации в информационной сфере', 167, '06.02.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (170, 'Объекты информационной безопасности', 167, '06.02.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (226, '1115555', 226, '13');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (113, 'Системы управления', NULL, '01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (114, 'Общая терминология', 113, '01.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (195, 'Технические устройства обеспечения боевых действий войск (сил)', 194, '08.04.02.01.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (115, 'Характеристики функционирования системы управления', 113, '01.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (116, 'Качество системы управления', 115, '01.02.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (122, 'Общесистемные (интегральные) свойства системы', 119, '01.04.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (133, 'Виды обеспечения АС', 123, '02.06');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (198, 'Оборудование военных научно-исследовательских и испытательных учреждений', 194, '08.04.02.01.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (138, 'Информационное и лингвистическое обеспечение', 133, '02.06.05');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (199, 'Стандартизация и техническое регулирование', NULL, '09');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (144, 'Информационные ресурсы', 142, '03.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (152, 'Средства радиосвязи, радиовещания и телевидения', 149, '04.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (200, 'Общая терминология', 199, '09.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (168, 'Обеспечение информационной безопасности Российской Федерации', 167, '06.02.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (183, 'Угрозы безопасности информации в технических средствах ее обработки', 182, '07.08.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (201, 'Аккредитация', 199, '09.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (202, 'Аттестация', 199, '09.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (189, 'Теория военного дела', 187, '08.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (190, 'Виды вооружения', 187, '08.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (203, 'Сертификация', 199, '09.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (191, 'Боевая военная техника', 187, '08.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (192, 'Технические устройства доставки (носители) оружия к цели', 191, '08.04.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (204, 'Лицензирование', 199, '09.05');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (193, 'Технические устройства управления войсками (силами) и боевыми средствами', 191, '08.04.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (194, 'Вспомогательная военная техника', 193, '08.04.02.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (210, 'Организация архивного дела', 208, '10.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (211, 'Средства обработки, транспортировки и хранения документов', 208, '10.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (212, 'Документооборот', NULL, '11');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (213, 'Общая терминология', 212, '11.01');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (214, 'Электронный документооборот', 212, '11.02');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (215, 'Электронный архив', 212, '11.03');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (216, 'Электронная подпись', 212, '11.04');
INSERT INTO rubrikator (id, rubrika, par_id, num) VALUES (225, 'Общая терминология', 224, '12.01');


INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12062, 16755, 43);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12063, 16756, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12064, 16757, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12065, 16758, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12066, 16759, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12067, 16760, 244);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12068, 16761, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12069, 16762, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12070, 16763, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12071, 16763, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12072, 16764, 187);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12073, 16765, 275);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12074, 16766, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12075, 16767, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12076, 16769, 188);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12077, 16770, 194);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12078, 16771, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12079, 16772, 245);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12080, 16773, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12081, 16774, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12082, 16775, 188);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12083, 16778, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12084, 16779, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12085, 16780, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12086, 16781, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12087, 16782, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12088, 16783, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12089, 16785, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12090, 16788, 85);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12091, 16789, 244);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12092, 16791, 134);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12093, 16791, 244);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12094, 16792, 261);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12095, 16793, 134);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12096, 16794, 134);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12097, 16795, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12098, 16796, 188);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12099, 16797, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12100, 16798, 30);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12101, 16799, 190);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12102, 16800, 192);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12103, 16801, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12104, 16802, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12105, 16803, 193);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12106, 16804, 147);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12107, 16805, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12108, 16806, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12109, 16807, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12110, 16808, 8);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12111, 16810, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12112, 16811, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12113, 16812, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12114, 16813, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12115, 16814, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12116, 16816, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12117, 16817, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12118, 16818, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12119, 16819, 189);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12120, 16820, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12121, 16821, 145);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12122, 16822, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12123, 16823, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12124, 16824, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12125, 16826, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12126, 16827, 52);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12127, 16828, 26);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12128, 16829, 203);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12129, 16830, 204);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12130, 16831, 256);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12131, 16832, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12132, 16833, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12133, 16834, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12134, 16835, 140);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12135, 16836, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12136, 16837, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12137, 16840, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12138, 16845, 32);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12139, 16846, 13);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12140, 16847, 16);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12141, 16848, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12142, 16849, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12143, 16850, 165);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12144, 16851, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12145, 16852, 165);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12146, 16853, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12147, 16854, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12148, 16855, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12149, 16856, 20);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12150, 16857, 8);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12151, 16859, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12152, 16859, 145);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12153, 16860, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12154, 16861, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12155, 16863, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12156, 16864, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12157, 16865, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12158, 16866, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12159, 16867, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12160, 16868, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12161, 16869, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12162, 16870, 58);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12163, 16871, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12164, 16872, 210);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12165, 16873, 58);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12166, 16874, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12167, 16875, 58);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12168, 16876, 58);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12169, 16878, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12170, 16879, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12171, 16881, 110);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12172, 16882, 204);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12173, 16883, 75);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12174, 16884, 75);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12175, 16886, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12176, 16887, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12177, 16889, 256);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12178, 16890, 134);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12179, 16891, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12180, 16892, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12181, 16894, 192);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12182, 16895, 79);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12183, 16896, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12184, 16897, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12185, 16898, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12186, 16899, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12187, 16900, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12188, 16901, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12189, 16902, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12190, 16903, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12191, 16905, 213);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12192, 16906, 245);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12193, 16907, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12194, 16908, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12195, 16909, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12196, 16910, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12197, 16911, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12198, 16912, 231);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12199, 16913, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12200, 16914, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12201, 16915, 188);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12202, 16916, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12203, 16918, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12204, 16919, 195);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12205, 16920, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12206, 16921, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12207, 16922, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12208, 16923, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12209, 16924, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12210, 16925, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12211, 16927, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12212, 16928, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12213, 16929, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12214, 16930, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12215, 16931, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12216, 16932, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12217, 16933, 26);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12218, 16934, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12219, 16935, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12220, 16936, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12221, 16937, 84);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12222, 16938, 85);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12223, 16939, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12224, 16940, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12225, 16941, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12226, 16942, 14);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12227, 16943, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12228, 16944, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12229, 16945, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12230, 16946, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12231, 16947, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12232, 16948, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12233, 16949, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12234, 16950, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12235, 16951, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12236, 16952, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12237, 16953, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12238, 16954, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12239, 16955, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12240, 16956, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12241, 16957, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12242, 16958, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12243, 16959, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12244, 16960, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12245, 16961, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12246, 16962, 61);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12247, 16963, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12248, 16964, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12249, 16964, 224);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12250, 16965, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12251, 16966, 224);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12252, 16967, 188);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12253, 16968, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12254, 16969, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12255, 16970, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12256, 16972, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12257, 16973, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12258, 16974, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12259, 16975, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12260, 16976, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12261, 16977, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12262, 16978, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12263, 16979, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12264, 16980, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12265, 16981, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12266, 16982, 188);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12267, 16983, 231);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12268, 16984, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12269, 16985, 26);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12270, 16986, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12271, 16987, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12272, 16988, 225);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12273, 16989, 134);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12274, 16990, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12275, 16991, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12276, 16992, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12277, 16993, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12278, 16994, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12279, 16995, 226);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12280, 16996, 134);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12281, 16997, 22);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12282, 16997, 23);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12283, 16998, 8);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12284, 16999, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12285, 17000, 227);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12286, 17001, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12287, 17002, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12288, 17003, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12289, 17004, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12290, 17005, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12291, 17006, 270);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12292, 17007, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12293, 17008, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12294, 17009, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12295, 17010, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12296, 17011, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12297, 17012, 189);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12298, 17013, 189);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12299, 17014, 244);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12300, 17015, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12301, 17016, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12302, 17017, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12303, 17018, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12304, 17019, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12305, 17020, 231);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12306, 17021, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12307, 17022, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12308, 17023, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12309, 17024, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12310, 17025, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12311, 17026, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12312, 17027, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12313, 17028, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12314, 17029, 64);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12315, 17030, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12316, 17031, 231);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12317, 17032, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12318, 17033, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12319, 17034, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12320, 17034, 145);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12321, 17035, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12322, 17036, 231);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12323, 17037, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12324, 17038, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12325, 17039, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12326, 17040, 244);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12327, 17041, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12328, 17042, 35);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12329, 17043, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12330, 17045, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12331, 17046, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12332, 17047, 217);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12333, 17050, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12334, 17051, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12335, 17052, 10);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12336, 17053, 35);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12337, 17054, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12338, 17055, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12339, 17056, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12340, 17057, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12341, 17058, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12342, 17059, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12343, 17060, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12344, 17061, 25);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12345, 17062, 232);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12346, 17063, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12347, 17065, 50);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12348, 17066, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12349, 17067, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12350, 17068, 276);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12351, 17069, 1);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12352, 17070, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12353, 17071, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12354, 17072, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12355, 17074, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12356, 17075, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12357, 17077, 201);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12358, 17077, 234);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12359, 17078, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12360, 17079, 65);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12361, 17080, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12362, 17081, 83);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12363, 17082, 27);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12364, 17083, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12365, 17084, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12366, 17085, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12367, 17086, 67);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12368, 17087, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12369, 17088, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12370, 17089, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12371, 17090, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12372, 17091, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12373, 17092, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12374, 17094, 239);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12375, 17096, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12376, 17097, 204);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12377, 17098, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12378, 17099, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12379, 17100, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12380, 17101, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12381, 17102, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12382, 17103, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12383, 17104, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12384, 17105, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12385, 17106, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12386, 17107, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12387, 17108, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12388, 17109, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12389, 17110, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12390, 17111, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12391, 17112, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12392, 17113, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12393, 17114, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12394, 17115, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12395, 17116, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12396, 17117, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12397, 17118, 65);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12398, 17119, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12399, 17120, 41);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12400, 17121, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12401, 17122, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12402, 17123, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12403, 17124, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12404, 17125, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12405, 17126, 165);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12406, 17127, 188);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12407, 17128, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12408, 17129, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12409, 17130, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12410, 17131, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12411, 17132, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12412, 17133, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12413, 17134, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12414, 17135, 231);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12415, 17136, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12416, 17137, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12417, 17138, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12418, 17139, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12419, 17140, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12420, 17141, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12421, 17142, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12422, 17143, 82);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12423, 17144, 26);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12424, 17145, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12425, 17146, 258);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12426, 17147, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12427, 17148, 82);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12428, 17149, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12429, 17150, 48);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12430, 17151, 194);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12431, 17152, 194);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12432, 17153, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12433, 17154, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12434, 17155, 252);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12435, 17156, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12436, 17157, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12437, 17158, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12438, 17159, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12439, 17160, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12440, 17161, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12441, 17162, 26);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12442, 17162, 234);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12443, 17163, 26);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12444, 17164, 57);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12445, 17165, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12446, 17166, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12447, 17167, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12448, 17168, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12449, 17169, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12450, 17170, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12451, 17171, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12452, 17172, 256);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12453, 17173, 134);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12454, 17174, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12455, 17175, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12456, 17176, 262);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12457, 17177, 134);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12458, 17178, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12459, 17179, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12460, 17180, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12461, 17181, 18);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12462, 17182, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12463, 17183, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12464, 17184, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12465, 17185, 82);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12466, 17186, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12467, 17187, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12468, 17188, 204);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12469, 17189, 25);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12470, 17190, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12471, 17190, 145);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12472, 17191, 8);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12473, 17191, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12474, 17191, 244);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12475, 17192, 137);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12476, 17193, 261);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12477, 17194, 255);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12478, 17195, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12479, 17196, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12480, 17196, 145);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12481, 17197, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12482, 17198, 26);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12483, 17199, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12484, 17200, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12485, 17201, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12486, 17202, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12487, 17203, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12488, 17204, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12489, 17205, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12490, 17206, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12491, 17207, 18);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12492, 17208, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12493, 17209, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12494, 17210, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12495, 17211, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12496, 17212, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12497, 17213, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12498, 17214, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12499, 17215, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12500, 17216, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12501, 17217, 253);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12502, 17218, 244);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12503, 17219, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12504, 17220, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12505, 17221, 253);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12506, 17222, 82);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12507, 17223, 145);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12508, 17223, 244);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12509, 17224, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12510, 17225, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12511, 17226, 43);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12512, 17227, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12513, 17228, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12514, 17229, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12515, 17230, 217);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12516, 17231, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12517, 17232, 138);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12518, 17233, 19);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12519, 17234, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12520, 17235, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12521, 17236, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12522, 17237, 37);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12523, 17238, 3);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12524, 17239, 83);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12525, 17240, 255);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12526, 17241, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12527, 17243, 255);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12528, 17244, 1);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12529, 17245, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12530, 17246, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12531, 17247, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12532, 17248, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12533, 17249, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12534, 17250, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12535, 17251, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12536, 17252, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12537, 17253, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12538, 17254, 135);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12539, 17257, 273);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12540, 17259, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12541, 17260, 83);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12542, 17261, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12543, 17262, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12544, 17263, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12545, 17264, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12546, 17265, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12547, 17266, 83);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12548, 17267, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12549, 17268, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12550, 17269, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12551, 17270, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12552, 17271, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12553, 17272, 78);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12554, 17273, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12555, 17274, 277);
INSERT INTO k_ist (id, id_znach, id_ist) VALUES (12556, 17275, 277);

INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8763, 157, 16755);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8764, 157, 16756);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8765, 157, 16757);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8766, 124, 16758);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8767, 121, 16759);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8768, 124, 16759);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8769, 121, 16760);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8770, 124, 16760);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8771, 157, 16761);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8772, 115, 16762);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8773, 124, 16763);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8774, 124, 16764);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8775, 124, 16765);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8776, 157, 16766);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8777, 124, 16767);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8778, 114, 16768);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8779, 124, 16768);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8780, 114, 16769);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8781, 124, 16769);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8782, 193, 16769);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8783, 114, 16770);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8784, 124, 16770);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8785, 193, 16770);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8786, 161, 16771);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8787, 124, 16772);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8788, 163, 16773);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8789, 125, 16774);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8790, 125, 16775);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8791, 193, 16775);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8792, 124, 16776);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8793, 164, 16776);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8794, 161, 16776);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8795, 124, 16777);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8796, 157, 16778);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8797, 157, 16779);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8798, 161, 16780);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8799, 127, 16781);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8800, 161, 16782);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8801, 161, 16783);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8802, 114, 16784);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8803, 161, 16785);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8804, 135, 16786);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8805, 114, 16787);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8806, 184, 16788);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8807, 184, 16789);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8808, 184, 16790);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8809, 184, 16791);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8810, 184, 16792);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8811, 184, 16793);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8812, 184, 16794);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8813, 139, 16795);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8814, 140, 16795);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8815, 139, 16796);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8816, 162, 16797);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8817, 162, 16798);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8818, 157, 16799);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8819, 157, 16800);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8820, 127, 16801);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8821, 225, 16802);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8822, 225, 16803);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8823, 180, 16804);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8824, 125, 16805);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8825, 125, 16806);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8826, 125, 16807);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8827, 125, 16808);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8828, 178, 16808);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8829, 125, 16809);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8830, 171, 16810);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8831, 147, 16811);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8832, 157, 16812);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8833, 201, 16813);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8834, 180, 16813);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8835, 127, 16814);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8836, 135, 16815);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8837, 157, 16816);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8838, 162, 16816);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8839, 157, 16817);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8840, 225, 16818);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8841, 135, 16819);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8842, 148, 16819);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8843, 135, 16820);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8844, 148, 16820);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8845, 135, 16821);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8846, 148, 16821);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8847, 135, 16822);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8848, 148, 16822);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8849, 151, 16823);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8850, 151, 16824);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8851, 127, 16825);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8852, 186, 16826);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8853, 148, 16827);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8854, 172, 16828);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8855, 163, 16829);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8856, 163, 16830);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8857, 163, 16831);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8858, 163, 16832);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8859, 163, 16833);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8860, 157, 16834);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8861, 162, 16834);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8862, 157, 16835);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8863, 162, 16835);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8864, 157, 16836);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8865, 162, 16836);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8866, 164, 16837);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8867, 164, 16838);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8868, 164, 16839);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8869, 164, 16840);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8870, 164, 16841);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8871, 163, 16842);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8872, 163, 16843);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8873, 164, 16843);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8874, 163, 16844);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8875, 181, 16845);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8876, 184, 16846);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8877, 184, 16847);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8878, 184, 16848);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8879, 150, 16849);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8880, 150, 16850);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8881, 157, 16851);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8882, 222, 16851);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8883, 222, 16852);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8884, 144, 16853);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8885, 222, 16853);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8886, 134, 16854);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8887, 161, 16855);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8888, 225, 16856);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8889, 225, 16857);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8890, 225, 16858);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8891, 225, 16859);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8892, 225, 16860);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8893, 225, 16861);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8894, 222, 16862);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8895, 139, 16863);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8896, 140, 16863);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8897, 222, 16864);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8898, 180, 16865);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8899, 180, 16866);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8900, 135, 16867);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8901, 160, 16868);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8902, 160, 16869);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8903, 160, 16870);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8904, 160, 16871);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8905, 160, 16872);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8906, 160, 16873);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8907, 160, 16874);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8908, 160, 16875);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8909, 157, 16876);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8910, 157, 16877);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8911, 222, 16878);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8912, 147, 16879);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8913, 143, 16880);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8914, 143, 16881);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8915, 143, 16882);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8916, 143, 16883);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8917, 143, 16884);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8918, 163, 16885);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8919, 184, 16886);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8920, 151, 16887);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8921, 181, 16888);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8922, 181, 16889);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8923, 150, 16890);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8924, 150, 16891);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8925, 150, 16892);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8926, 150, 16893);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8927, 223, 16894);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8928, 163, 16895);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8929, 163, 16896);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8930, 164, 16897);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8931, 127, 16898);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8932, 151, 16899);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8933, 222, 16900);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8934, 222, 16901);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8935, 143, 16902);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8936, 143, 16903);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8937, 143, 16904);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8938, 143, 16905);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8939, 168, 16906);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8940, 175, 16906);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8941, 161, 16907);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8942, 161, 16908);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8943, 135, 16909);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8944, 126, 16910);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8945, 222, 16910);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8946, 126, 16911);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8947, 126, 16912);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8948, 127, 16913);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8949, 127, 16914);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8950, 127, 16915);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8951, 180, 16916);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8952, 127, 16917);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8953, 223, 16918);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8954, 127, 16919);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8955, 127, 16920);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8956, 181, 16921);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8957, 222, 16922);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8958, 163, 16922);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8959, 163, 16923);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8960, 147, 16924);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8961, 127, 16925);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8962, 127, 16926);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8963, 189, 16926);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8964, 163, 16927);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8965, 223, 16928);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8966, 223, 16929);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8967, 223, 16930);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8968, 223, 16931);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8969, 179, 16932);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8970, 180, 16933);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8971, 223, 16934);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8972, 151, 16935);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8973, 150, 16936);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8974, 184, 16937);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8975, 184, 16938);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8976, 184, 16939);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8977, 161, 16940);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8978, 222, 16941);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8979, 144, 16942);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8980, 161, 16943);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8981, 132, 16944);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8982, 132, 16945);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8983, 163, 16946);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8984, 222, 16947);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8985, 151, 16948);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8986, 161, 16949);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8987, 161, 16950);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8988, 161, 16951);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8989, 161, 16952);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8990, 168, 16953);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8991, 151, 16954);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8992, 151, 16955);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8993, 157, 16956);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8994, 162, 16956);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8995, 161, 16957);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8996, 159, 16958);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8997, 160, 16959);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8998, 144, 16960);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (8999, 144, 16961);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9000, 222, 16961);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9001, 145, 16962);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9002, 126, 16963);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9003, 169, 16964);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9004, 177, 16965);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9005, 177, 16966);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9006, 170, 16967);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9007, 126, 16968);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9008, 180, 16969);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9009, 161, 16970);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9010, 161, 16971);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9011, 135, 16972);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9012, 126, 16973);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9013, 161, 16974);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9014, 161, 16975);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9015, 161, 16976);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9016, 161, 16977);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9017, 161, 16978);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9018, 161, 16979);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9019, 138, 16980);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9020, 138, 16981);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9021, 138, 16982);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9022, 126, 16983);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9023, 222, 16984);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9024, 204, 16985);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9025, 222, 16986);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9026, 222, 16987);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9027, 163, 16988);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9028, 223, 16989);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9029, 163, 16990);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9030, 147, 16991);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9031, 223, 16992);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9032, 184, 16993);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9033, 150, 16994);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9034, 127, 16995);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9035, 177, 16996);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9036, 126, 16997);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9037, 181, 16998);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9038, 181, 16999);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9039, 181, 17000);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9040, 164, 17001);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9041, 151, 17002);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9042, 151, 17003);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9043, 151, 17004);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9044, 151, 17005);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9045, 184, 17006);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9046, 181, 17007);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9047, 138, 17008);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9048, 223, 17009);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9049, 157, 17010);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9050, 126, 17011);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9051, 135, 17013);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9052, 135, 17014);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9053, 181, 17014);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9054, 163, 17015);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9055, 164, 17016);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9056, 161, 17017);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9057, 161, 17018);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9058, 161, 17019);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9059, 163, 17020);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9060, 161, 17021);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9061, 158, 17022);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9062, 151, 17023);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9063, 151, 17024);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9064, 151, 17025);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9065, 184, 17026);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9066, 137, 17027);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9067, 137, 17028);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9068, 143, 17029);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9069, 126, 17030);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9070, 116, 17031);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9071, 222, 17032);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9072, 126, 17033);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9073, 136, 17034);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9074, 136, 17035);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9075, 136, 17036);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9076, 136, 17037);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9077, 124, 17038);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9078, 177, 17039);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9079, 177, 17040);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9080, 177, 17041);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9081, 177, 17042);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9082, 177, 17043);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9083, 177, 17044);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9084, 162, 17045);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9085, 162, 17046);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9086, 147, 17047);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9087, 147, 17048);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9088, 116, 17049);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9089, 151, 17050);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9090, 222, 17051);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9091, 177, 17052);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9092, 177, 17053);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9093, 169, 17054);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9094, 177, 17054);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9095, 161, 17055);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9096, 137, 17056);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9097, 161, 17057);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9098, 222, 17058);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9099, 160, 17059);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9100, 143, 17060);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9101, 177, 17061);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9102, 188, 17062);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9103, 143, 17063);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9104, 143, 17064);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9105, 143, 17065);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9106, 168, 17066);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9107, 180, 17066);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9108, 138, 17067);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9109, 168, 17068);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9110, 143, 17069);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9111, 156, 17070);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9112, 163, 17071);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9113, 156, 17072);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9114, 147, 17073);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9115, 147, 17074);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9116, 164, 17075);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9117, 147, 17076);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9118, 147, 17077);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9119, 147, 17078);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9120, 147, 17079);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9121, 147, 17080);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9122, 163, 17081);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9123, 163, 17082);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9124, 143, 17083);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9125, 156, 17084);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9126, 143, 17085);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9127, 225, 17086);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9128, 143, 17087);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9129, 147, 17088);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9130, 151, 17089);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9131, 143, 17090);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9132, 223, 17090);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9133, 143, 17091);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9134, 151, 17092);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9135, 213, 17093);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9136, 213, 17094);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9137, 124, 17095);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9138, 163, 17096);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9139, 163, 17097);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9140, 151, 17098);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9141, 147, 17099);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9142, 147, 17100);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9143, 124, 17101);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9144, 147, 17102);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9145, 147, 17103);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9146, 163, 17104);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9147, 163, 17105);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9148, 163, 17106);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9149, 163, 17107);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9150, 143, 17108);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9151, 125, 17109);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9152, 124, 17110);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9153, 147, 17111);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9154, 126, 17112);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9155, 126, 17113);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9156, 126, 17114);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9157, 126, 17115);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9158, 126, 17116);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9159, 126, 17117);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9160, 147, 17118);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9161, 151, 17119);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9162, 143, 17120);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9163, 143, 17121);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9164, 161, 17122);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9165, 137, 17123);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9166, 137, 17124);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9167, 137, 17125);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9168, 223, 17126);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9169, 116, 17127);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9170, 137, 17128);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9171, 150, 17129);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9172, 150, 17130);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9173, 147, 17131);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9174, 143, 17132);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9175, 126, 17133);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9176, 126, 17134);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9177, 120, 17135);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9178, 126, 17136);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9179, 163, 17138);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9180, 161, 17139);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9181, 161, 17140);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9182, 161, 17141);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9183, 177, 17142);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9184, 146, 17143);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9185, 177, 17144);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9186, 177, 17145);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9187, 177, 17146);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9188, 177, 17147);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9189, 177, 17148);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9190, 151, 17149);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9191, 147, 17150);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9192, 146, 17151);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9193, 146, 17152);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9194, 146, 17153);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9195, 163, 17154);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9196, 189, 17155);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9197, 164, 17156);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9198, 164, 17157);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9199, 164, 17158);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9200, 177, 17159);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9201, 151, 17160);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9202, 143, 17161);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9203, 175, 17162);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9204, 181, 17163);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9205, 177, 17164);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9206, 143, 17165);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9207, 143, 17166);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9208, 126, 17167);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9209, 126, 17168);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9210, 124, 17169);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9211, 175, 17170);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9212, 175, 17171);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9213, 175, 17172);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9214, 156, 17173);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9215, 156, 17174);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9216, 156, 17175);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9217, 156, 17176);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9218, 156, 17177);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9219, 156, 17178);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9220, 151, 17179);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9221, 151, 17180);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9222, 156, 17181);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9223, 156, 17182);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9224, 156, 17183);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9225, 163, 17184);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9226, 156, 17185);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9227, 156, 17186);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9228, 156, 17187);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9229, 156, 17188);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9230, 156, 17189);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9231, 156, 17190);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9232, 156, 17191);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9233, 156, 17192);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9234, 156, 17193);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9235, 156, 17194);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9236, 126, 17195);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9237, 126, 17196);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9238, 126, 17197);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9239, 175, 17198);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9240, 143, 17199);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9241, 124, 17200);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9242, 160, 17201);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9243, 160, 17202);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9244, 151, 17203);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9245, 203, 17204);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9246, 156, 17205);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9247, 203, 17206);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9248, 151, 17207);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9249, 156, 17208);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9250, 132, 17209);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9251, 132, 17210);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9252, 151, 17211);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9253, 156, 17212);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9254, 151, 17213);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9255, 151, 17214);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9256, 151, 17215);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9257, 186, 17216);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9258, 186, 17217);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9259, 186, 17218);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9260, 186, 17219);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9261, 186, 17220);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9262, 186, 17221);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9263, 186, 17222);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9264, 186, 17223);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9265, 186, 17224);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9266, 148, 17225);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9267, 143, 17226);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9268, 132, 17227);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9269, 161, 17228);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9270, 161, 17229);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9271, 147, 17230);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9272, 177, 17231);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9273, 177, 17232);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9274, 132, 17233);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9275, 126, 17234);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9276, 126, 17235);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9277, 214, 17236);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9278, 160, 17237);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9279, 216, 17238);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9280, 216, 17239);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9281, 216, 17240);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9282, 216, 17241);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9283, 215, 17242);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9284, 214, 17243);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9285, 214, 17244);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9286, 214, 17245);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9287, 161, 17246);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9288, 164, 17246);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9289, 163, 17247);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9290, 163, 17248);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9291, 163, 17249);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9292, 156, 17250);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9293, 156, 17251);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9294, 156, 17252);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9295, 163, 17253);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9296, 163, 17254);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9297, 143, 17255);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9298, 163, 17256);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9299, 138, 17256);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9300, 163, 17257);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9301, 138, 17257);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9302, 138, 17258);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9303, 163, 17258);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9304, 156, 17259);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9305, 156, 17260);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9306, 158, 17261);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9307, 161, 17261);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9308, 222, 17262);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9309, 158, 17263);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9310, 222, 17264);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9311, 163, 17265);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9312, 222, 17266);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9313, 130, 17267);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9314, 222, 17268);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9315, 161, 17269);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9316, 152, 17270);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9317, 163, 17271);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9318, 156, 17272);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9319, 151, 17273);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9320, 152, 17274);
INSERT INTO k_rub (id, id_rub, id_znach) VALUES (9321, 163, 17275);


INSERT INTO lang (id, name, abr) VALUES (1, 'Английский', 'en');



