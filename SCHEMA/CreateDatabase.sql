-- Create Database TheKnowledgeBank on the server instance localhost with PostgreSQL
CREATE DATABASE TheKnowledgeBank_db WITH OWNER = postgres ENCODING = 'UTF8' TABLESPACE = pg_default CONNECTION
LIMIT = -1 IS_TEMPLATE = False;
-- Create schema TheKnowledgeBank
DROP SCHEMA IF EXISTS TheKnowledgeBank CASCADE;
CREATE SCHEMA IF NOT EXISTS TheKnowledgeBank AUTHORIZATION postgres;
-- Create schema StoreKnowledgeBank
DROP SCHEMA IF EXISTS StoreKnowledgeBank CASCADE;
CREATE SCHEMA IF NOT EXISTS StoreKnowledgeBank AUTHORIZATION postgres;
-- Create schema Auth
DROP SCHEMA IF EXISTS Auth CASCADE;
CREATE SCHEMA IF NOT EXISTS Auth AUTHORIZATION postgres;