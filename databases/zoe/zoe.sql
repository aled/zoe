--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(50),
    password character varying(50)
);


--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- Name: zeserviceslog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.zeserviceslog (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    requesturl character varying(100) NOT NULL,
    requestmethod character varying(4) NOT NULL,
    requestbody json,
    requesttimestamp timestamp without time zone NOT NULL,
    responsebody json,
    responsetimestamp timestamp without time zone
);


--
-- Name: zeserviceslog_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.zeserviceslog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: zeserviceslog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.zeserviceslog_id_seq OWNED BY public.zeserviceslog.id;


--
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- Name: zeserviceslog id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zeserviceslog ALTER COLUMN id SET DEFAULT nextval('public.zeserviceslog_id_seq'::regclass);


--
-- PostgreSQL database dump complete
--

