--
-- PostgreSQL database dump
--

\restrict qStuHsTb84qMQCI0ZYJfX7QHXAZv4LblxcdInp0Kx3QY8OsPvY49DB4xxxiGHBL

-- Dumped from database version 17.7 (e429a59)
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auditlogs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auditlogs (
    logid integer NOT NULL,
    userid integer NOT NULL,
    entitytype character varying(50) NOT NULL,
    entityid integer NOT NULL,
    action character varying(100) NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    details text
);


--
-- Name: auditlogs_logid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auditlogs_logid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auditlogs_logid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auditlogs_logid_seq OWNED BY public.auditlogs.logid;


--
-- Name: budgetallocations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.budgetallocations (
    allocationid integer NOT NULL,
    departmentid integer NOT NULL,
    categoryid integer NOT NULL,
    projectid integer,
    allocationamount numeric(12,2) NOT NULL,
    allocationdate date NOT NULL,
    fiscalyear integer NOT NULL,
    allocatedby integer NOT NULL
);


--
-- Name: budgetallocations_allocationid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.budgetallocations_allocationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: budgetallocations_allocationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.budgetallocations_allocationid_seq OWNED BY public.budgetallocations.allocationid;


--
-- Name: budgetcategories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.budgetcategories (
    categoryid integer NOT NULL,
    categoryname character varying(100) NOT NULL,
    description text
);


--
-- Name: budgetcategories_categoryid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.budgetcategories_categoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: budgetcategories_categoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.budgetcategories_categoryid_seq OWNED BY public.budgetcategories.categoryid;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.departments (
    departmentid integer NOT NULL,
    departmentname character varying(100) NOT NULL,
    managerid integer,
    contactemail character varying(100)
);


--
-- Name: departments_departmentid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.departments_departmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departments_departmentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.departments_departmentid_seq OWNED BY public.departments.departmentid;


--
-- Name: expenditures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.expenditures (
    expenseid integer NOT NULL,
    allocationid integer NOT NULL,
    projectid integer,
    categoryid integer NOT NULL,
    expenseamount numeric(12,2) NOT NULL,
    expensedate date NOT NULL,
    description text,
    recordedby integer NOT NULL
);


--
-- Name: expenditures_expenseid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.expenditures_expenseid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: expenditures_expenseid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.expenditures_expenseid_seq OWNED BY public.expenditures.expenseid;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    projectid integer NOT NULL,
    departmentid integer NOT NULL,
    projectname character varying(150) NOT NULL,
    startdate date,
    enddate date,
    status character varying(50),
    projectdesc text
);


--
-- Name: projects_projectid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_projectid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_projectid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_projectid_seq OWNED BY public.projects.projectid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    passwordhash character varying(255) NOT NULL,
    role character varying(50) NOT NULL,
    datecreated timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT 'active'::character varying,
    departmentid integer
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
-- Name: auditlogs logid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auditlogs ALTER COLUMN logid SET DEFAULT nextval('public.auditlogs_logid_seq'::regclass);


--
-- Name: budgetallocations allocationid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgetallocations ALTER COLUMN allocationid SET DEFAULT nextval('public.budgetallocations_allocationid_seq'::regclass);


--
-- Name: budgetcategories categoryid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgetcategories ALTER COLUMN categoryid SET DEFAULT nextval('public.budgetcategories_categoryid_seq'::regclass);


--
-- Name: departments departmentid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departments ALTER COLUMN departmentid SET DEFAULT nextval('public.departments_departmentid_seq'::regclass);


--
-- Name: expenditures expenseid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenditures ALTER COLUMN expenseid SET DEFAULT nextval('public.expenditures_expenseid_seq'::regclass);


--
-- Name: projects projectid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN projectid SET DEFAULT nextval('public.projects_projectid_seq'::regclass);


--
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- Name: auditlogs auditlogs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auditlogs
    ADD CONSTRAINT auditlogs_pkey PRIMARY KEY (logid);


--
-- Name: budgetallocations budgetallocations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgetallocations
    ADD CONSTRAINT budgetallocations_pkey PRIMARY KEY (allocationid);


--
-- Name: budgetcategories budgetcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgetcategories
    ADD CONSTRAINT budgetcategories_pkey PRIMARY KEY (categoryid);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (departmentid);


--
-- Name: expenditures expenditures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenditures
    ADD CONSTRAINT expenditures_pkey PRIMARY KEY (expenseid);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (projectid);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: auditlogs auditlogs_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auditlogs
    ADD CONSTRAINT auditlogs_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: budgetallocations budgetallocations_allocatedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgetallocations
    ADD CONSTRAINT budgetallocations_allocatedby_fkey FOREIGN KEY (allocatedby) REFERENCES public.users(userid);


--
-- Name: budgetallocations budgetallocations_categoryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgetallocations
    ADD CONSTRAINT budgetallocations_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.budgetcategories(categoryid);


--
-- Name: budgetallocations budgetallocations_departmentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgetallocations
    ADD CONSTRAINT budgetallocations_departmentid_fkey FOREIGN KEY (departmentid) REFERENCES public.departments(departmentid);


--
-- Name: budgetallocations budgetallocations_projectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgetallocations
    ADD CONSTRAINT budgetallocations_projectid_fkey FOREIGN KEY (projectid) REFERENCES public.projects(projectid);


--
-- Name: expenditures expenditures_allocationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenditures
    ADD CONSTRAINT expenditures_allocationid_fkey FOREIGN KEY (allocationid) REFERENCES public.budgetallocations(allocationid);


--
-- Name: expenditures expenditures_categoryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenditures
    ADD CONSTRAINT expenditures_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.budgetcategories(categoryid);


--
-- Name: expenditures expenditures_projectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenditures
    ADD CONSTRAINT expenditures_projectid_fkey FOREIGN KEY (projectid) REFERENCES public.projects(projectid);


--
-- Name: expenditures expenditures_recordedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expenditures
    ADD CONSTRAINT expenditures_recordedby_fkey FOREIGN KEY (recordedby) REFERENCES public.users(userid);


--
-- Name: departments fk_manager_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT fk_manager_user FOREIGN KEY (managerid) REFERENCES public.users(userid);


--
-- Name: users fk_user_department; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_user_department FOREIGN KEY (departmentid) REFERENCES public.departments(departmentid);


--
-- Name: projects projects_departmentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_departmentid_fkey FOREIGN KEY (departmentid) REFERENCES public.departments(departmentid);


--
-- PostgreSQL database dump complete
--

\unrestrict qStuHsTb84qMQCI0ZYJfX7QHXAZv4LblxcdInp0Kx3QY8OsPvY49DB4xxxiGHBL

