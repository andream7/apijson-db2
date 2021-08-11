create table "Access"
(
    "alias" VARGRAPHIC(20) not null,
    "date" TIMESTAMP(6) default CURRENT TIMESTAMP,
    "debug" INTEGER default '0',
    "delete" VARGRAPHIC(100) default '["OWNER", "ADMIN"]',
    "detail" VARGRAPHIC(1000),
    "get" VARGRAPHIC(100) default '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]',
    "gets" VARGRAPHIC(100) default '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]',
    "head" VARGRAPHIC(100) default '["UNKNOWN", "LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]',
    "heads" VARGRAPHIC(100) default '["LOGIN", "CONTACT", "CIRCLE", "OWNER", "ADMIN"]',
    "id" BIGINT generated always as identity
        constraint PK_ACCESS
            primary key,
    "name" VARGRAPHIC(50) not null,
    "post" VARGRAPHIC(100) default '["OWNER", "ADMIN"]',
    "put" VARGRAPHIC(100) default '["OWNER", "ADMIN"]'
);

create table "Comment"
(
    "content" VARGRAPHIC(1000),
    "date" TIMESTAMP(6) default CURRENT TIMESTAMP,
    "id" BIGINT not null
        constraint PK_COMMENT
            primary key,
    "momentId" BIGINT,
    "toId" BIGINT default '0',
    "userId" BIGINT
);

create table "Document"
(
    "date" TIMESTAMP(6) default CURRENT TIMESTAMP,
    "header" DBCLOB(1048576),
    "id" BIGINT generated always as identity
        constraint PK_DOCUMENT
            primary key,
    "name" VARGRAPHIC(100),
    "request" DBCLOB(1048576),
    "testAccountId" BIGINT default '0',
    "type" VARGRAPHIC(5) default 'JSON',
    "url" VARGRAPHIC(250),
    "userId" BIGINT,
    "version" INTEGER default '3'
);

create table "Function"
(
    "arguments" VARGRAPHIC(100),
    "back" VARGRAPHIC(45),
    "date" TIMESTAMP(6) default CURRENT TIMESTAMP,
    "demo" VARCHAR(255),
    "detail" VARGRAPHIC(1000),
    "id" BIGINT generated always as identity
        constraint PK_FUNCTION
            primary key,
    "methods" VARGRAPHIC(50),
    "name" VARGRAPHIC(50),
    "tag" VARGRAPHIC(20),
    "type" VARGRAPHIC(50) default 'Object',
    "userId" BIGINT,
    "version" INTEGER default '0'
);

create table "Login"
(
    "date" TIMESTAMP(6) default CURRENT TIMESTAMP,
    "id" BIGINT not null
        constraint PK_LOGIN
            primary key,
    "type" INTEGER,
    "userId" BIGINT
);

create table "Method"
(
    CLASS VARGRAPHIC(50) default 'DemoFunction',
    CLASSARGS DBCLOB(1048576),
    DATE TIMESTAMP(6) default CURRENT TIMESTAMP,
    DEMO VARCHAR(255),
    DETAIL VARGRAPHIC(1000),
    EXCEPTIONS VARGRAPHIC(500),
    GENERICCLASSARGS DBCLOB(1048576),
    GENERICEXCEPTIONS VARGRAPHIC(500),
    GENERICMETHODARGS DBCLOB(1048576),
    GENERICTYPE VARGRAPHIC(50),
    ID BIGINT generated always as identity
        constraint PK_METHOD
            primary key,
    METHOD VARGRAPHIC(50),
    METHODARGS DBCLOB(1048576),
    PACKAGE VARGRAPHIC(500) default 'apijson/demo/server',
    REQUEST DBCLOB(1048576),
    STATIC INTEGER default '0',
    TYPE VARGRAPHIC(50),
    USERID BIGINT
);

create table "Moment"
(
    "content" VARGRAPHIC(300),
    "date" TIMESTAMP(6) default CURRENT TIMESTAMP,
    "id" BIGINT not null
        constraint PK_MOMENT
            primary key,
    "pictureList" VARCHAR(255),
    "praiseUserIdList" VARCHAR(255),
    "userId" BIGINT
);

create table "Praise"
(
    DATE TIMESTAMP(6) default CURRENT TIMESTAMP,
    ID BIGINT generated always as identity
        constraint PK_PRAISE
            primary key,
    MOMENTID BIGINT,
    USERID BIGINT
);

create table "Random"
(
    CONFIG VARGRAPHIC(5000),
    COUNT INTEGER default '1',
    DATE TIMESTAMP(6) default CURRENT TIMESTAMP,
    DOCUMENTID BIGINT,
    ID BIGINT not null
        constraint PK_RANDOM
            primary key,
    NAME VARGRAPHIC(100),
    TOID BIGINT default '0',
    USERID BIGINT
);

create table "Request"
(
    DATE TIMESTAMP(6) default CURRENT TIMESTAMP,
    DETAIL VARGRAPHIC(10000),
    ID BIGINT not null
        constraint PK_REQUEST
            primary key,
    METHOD VARGRAPHIC(10) default 'GETS',
    STRUCTURE VARCHAR(255),
    TAG VARGRAPHIC(20),
    VERSION INTEGER default '1'
);

create table "Response"
(
    DATE TIMESTAMP(6) default CURRENT TIMESTAMP,
    DETAIL VARGRAPHIC(10000),
    ID BIGINT not null
        constraint PK_RESPONSE
            primary key,
    METHOD VARGRAPHIC(10) default 'GET',
    MODEL VARGRAPHIC(20),
    STRUCTURE VARCHAR(255)
);

create table "TestRecord"
(
    COMPARE DBCLOB(1048576),
    DATE TIMESTAMP(6) default CURRENT TIMESTAMP,
    DOCUMENTID BIGINT,
    DURATION BIGINT,
    HOST VARGRAPHIC(1000),
    ID BIGINT not null
        constraint PK_TESTRECORD
            primary key,
    MAXDURATION BIGINT,
    MINDURATION BIGINT,
    RANDOMID BIGINT default '0',
    RESPONSE DBCLOB(1048576),
    STANDARD DBCLOB(1048576),
    TESTACCOUNTID BIGINT default '0',
    USERID BIGINT
);

create table "Verify"
(
    DATE TIMESTAMP(6) default CURRENT TIMESTAMP,
    ID BIGINT generated always as identity
        constraint PK_VERIFY
            primary key,
    PHONE BIGINT,
    TYPE INTEGER default '0',
    VERIFY INTEGER
);

create table "_Visit"
(
    "date" TIMESTAMP(6) default CURRENT TIMESTAMP,
    "id" BIGINT,
    "model" VARGRAPHIC(15),
    "operate" INTEGER
);

create table "apijson_privacy"
(
    "_password" VARGRAPHIC(20),
    "_payPassword" INTEGER default '123456',
    "balance" DECIMAL(10,2) default '0.00',
    "certified" INTEGER default '0',
    "id" BIGINT not null
        constraint PK_APIJSON_PRIVACY
            primary key,
    "phone" BIGINT not null
);

create table "apijson_user"
(
    "contactIdList" VARCHAR(255),
    "date" TIMESTAMP(6) default CURRENT TIMESTAMP,
    "head" VARGRAPHIC(300) default 'https://raw.githubusercontent.com/TommyLemon/StaticResources/master/APIJSON_Logo.png',
    "id" BIGINT generated always as identity
        constraint PK_APIJSON_USER
            primary key,
    "name" VARGRAPHIC(20),
    "pictureList" VARCHAR(255),
    "sex" INTEGER default '0',
    "tag" VARGRAPHIC(45)
);

