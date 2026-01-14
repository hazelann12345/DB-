--
-- PostgreSQL database dump
--

\restrict I43819sFNeq9tJEvYoTsRbIDlFb1INUroWw8fZZJ8nQPnOluChyd1VArJfclbMT

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

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.users (userid, username, email, passwordhash, role, datecreated, status, departmentid) VALUES (1, 'admin01', 'admin@company.com', 'hashed_pw_1', 'Admin', '2026-01-05 02:02:05.501332', 'active', 1);
INSERT INTO public.users (userid, username, email, passwordhash, role, datecreated, status, departmentid) VALUES (2, 'acc_jane', 'jane@company.com', 'hashed_pw_2', 'Accountant', '2026-01-05 02:02:05.501332', 'active', 1);
INSERT INTO public.users (userid, username, email, passwordhash, role, datecreated, status, departmentid) VALUES (3, 'it_mike', 'mike@company.com', 'hashed_pw_3', 'Manager', '2026-01-05 02:02:05.501332', 'active', 2);
INSERT INTO public.users (userid, username, email, passwordhash, role, datecreated, status, departmentid) VALUES (4, 'ops_lara', 'lara@company.com', 'hashed_pw_4', 'Manager', '2026-01-05 02:02:05.501332', 'active', 3);
INSERT INTO public.users (userid, username, email, passwordhash, role, datecreated, status, departmentid) VALUES (5, 'viewer_tom', 'tom@company.com', 'hashed_pw_5', 'Viewer', '2026-01-05 02:02:05.501332', 'active', NULL);


--
-- Data for Name: auditlogs; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.auditlogs (logid, userid, entitytype, entityid, action, "timestamp", details) VALUES (1, 1, 'BudgetAllocations', 1, 'Added Allocation', '2026-01-05 02:04:17.915572', 'Initial allocation for IT Upgrade');
INSERT INTO public.auditlogs (logid, userid, entitytype, entityid, action, "timestamp", details) VALUES (2, 2, 'BudgetAllocations', 2, 'Added Allocation', '2026-01-05 02:04:17.915572', 'Audit salaries allocation');
INSERT INTO public.auditlogs (logid, userid, entitytype, entityid, action, "timestamp", details) VALUES (3, 3, 'Expenditures', 1, 'Recorded Expense', '2026-01-05 02:04:17.915572', 'Purchased routers');
INSERT INTO public.auditlogs (logid, userid, entitytype, entityid, action, "timestamp", details) VALUES (4, 4, 'Expenditures', 5, 'Recorded Expense', '2026-01-05 02:04:17.915572', 'Forklift maintenance expense');
INSERT INTO public.auditlogs (logid, userid, entitytype, entityid, action, "timestamp", details) VALUES (5, 1, 'Projects', 1, 'Updated Project', '2026-01-05 02:04:17.915572', 'Status changed to Ongoing');


--
-- Data for Name: budgetcategories; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.budgetcategories (categoryid, categoryname, description) VALUES (1, 'Equipment', 'Hardware, tools, and machines');
INSERT INTO public.budgetcategories (categoryid, categoryname, description) VALUES (2, 'Travel', 'Transportation, lodging, and travel reimbursements');
INSERT INTO public.budgetcategories (categoryid, categoryname, description) VALUES (3, 'Salaries', 'Employee and contractor compensation');
INSERT INTO public.budgetcategories (categoryid, categoryname, description) VALUES (4, 'Software & Licenses', 'Software subscriptions, licenses, renewals');
INSERT INTO public.budgetcategories (categoryid, categoryname, description) VALUES (5, 'Training', 'Workshops, seminars, conferences');


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.departments (departmentid, departmentname, managerid, contactemail) VALUES (1, 'Finance Department', 2, 'finance@company.com');
INSERT INTO public.departments (departmentid, departmentname, managerid, contactemail) VALUES (2, 'IT Department', 3, 'it@company.com');
INSERT INTO public.departments (departmentid, departmentname, managerid, contactemail) VALUES (3, 'Operations Department', 4, 'ops@company.com');


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.projects (projectid, departmentid, projectname, startdate, enddate, status, projectdesc) VALUES (1, 2, 'Network Infrastructure Upgrade', '2025-01-10', '2025-08-30', 'Ongoing', 'Upgrading company-wide routers, switches, and servers.');
INSERT INTO public.projects (projectid, departmentid, projectname, startdate, enddate, status, projectdesc) VALUES (2, 1, 'Financial Audit Improvement Program', '2025-02-01', '2025-06-15', 'Planned', 'Implementing automation tools and data analytics for audit improvement.');
INSERT INTO public.projects (projectid, departmentid, projectname, startdate, enddate, status, projectdesc) VALUES (3, 3, 'Warehouse Optimization Initiative', '2025-03-05', '2025-12-20', 'Ongoing', 'Improving warehouse layout and logistics efficiency.');


--
-- Data for Name: budgetallocations; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.budgetallocations (allocationid, departmentid, categoryid, projectid, allocationamount, allocationdate, fiscalyear, allocatedby) VALUES (1, 2, 1, 1, 500000.00, '2025-01-15', 2025, 1);
INSERT INTO public.budgetallocations (allocationid, departmentid, categoryid, projectid, allocationamount, allocationdate, fiscalyear, allocatedby) VALUES (2, 1, 3, 2, 300000.00, '2025-02-10', 2025, 2);
INSERT INTO public.budgetallocations (allocationid, departmentid, categoryid, projectid, allocationamount, allocationdate, fiscalyear, allocatedby) VALUES (3, 3, 1, 3, 150000.00, '2025-03-10', 2025, 4);
INSERT INTO public.budgetallocations (allocationid, departmentid, categoryid, projectid, allocationamount, allocationdate, fiscalyear, allocatedby) VALUES (4, 3, 5, 3, 50000.00, '2025-03-20', 2025, 4);
INSERT INTO public.budgetallocations (allocationid, departmentid, categoryid, projectid, allocationamount, allocationdate, fiscalyear, allocatedby) VALUES (5, 2, 4, 1, 120000.00, '2025-01-22', 2025, 1);


--
-- Data for Name: expenditures; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.expenditures (expenseid, allocationid, projectid, categoryid, expenseamount, expensedate, description, recordedby) VALUES (1, 1, 1, 1, 120000.00, '2025-02-05', 'Purchased Cisco routers', 3);
INSERT INTO public.expenditures (expenseid, allocationid, projectid, categoryid, expenseamount, expensedate, description, recordedby) VALUES (2, 1, 1, 1, 80000.00, '2025-03-18', 'Server rack installation', 3);
INSERT INTO public.expenditures (expenseid, allocationid, projectid, categoryid, expenseamount, expensedate, description, recordedby) VALUES (3, 2, 2, 3, 45000.00, '2025-02-20', 'Consultant fees', 2);
INSERT INTO public.expenditures (expenseid, allocationid, projectid, categoryid, expenseamount, expensedate, description, recordedby) VALUES (4, 2, 2, 3, 30000.00, '2025-03-10', 'Temporary staff payments', 2);
INSERT INTO public.expenditures (expenseid, allocationid, projectid, categoryid, expenseamount, expensedate, description, recordedby) VALUES (5, 3, 3, 1, 50000.00, '2025-04-01', 'Forklift maintenance', 4);
INSERT INTO public.expenditures (expenseid, allocationid, projectid, categoryid, expenseamount, expensedate, description, recordedby) VALUES (6, 4, 3, 5, 12000.00, '2025-04-15', 'Logistics training workshop', 4);
INSERT INTO public.expenditures (expenseid, allocationid, projectid, categoryid, expenseamount, expensedate, description, recordedby) VALUES (7, 5, 1, 4, 30000.00, '2025-02-25', 'Cloud service renewals', 3);


--
-- Name: auditlogs_logid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.auditlogs_logid_seq', 5, true);


--
-- Name: budgetallocations_allocationid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.budgetallocations_allocationid_seq', 5, true);


--
-- Name: budgetcategories_categoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.budgetcategories_categoryid_seq', 5, true);


--
-- Name: departments_departmentid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.departments_departmentid_seq', 3, true);


--
-- Name: expenditures_expenseid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.expenditures_expenseid_seq', 7, true);


--
-- Name: projects_projectid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.projects_projectid_seq', 3, true);


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_userid_seq', 5, true);


--
-- PostgreSQL database dump complete
--

\unrestrict I43819sFNeq9tJEvYoTsRbIDlFb1INUroWw8fZZJ8nQPnOluChyd1VArJfclbMT

