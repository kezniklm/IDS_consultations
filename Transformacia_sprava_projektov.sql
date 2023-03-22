-- -- Table Dropping --------------------------------------------

DROP TABLE OSOBA CASCADE CONSTRAINTS;
DROP TABLE PROJEKT CASCADE CONSTRAINTS;
DROP TABLE ORGANIZACIA CASCADE CONSTRAINTS;
DROP TABLE SUBOR CASCADE CONSTRAINTS;
DROP TABLE PRACUJE_V CASCADE CONSTRAINTS;
DROP TABLE JE_SPOLUPRACOVNIK CASCADE CONSTRAINTS;
DROP TABLE MOZE_MODIFIKOVAT CASCADE CONSTRAINTS;
DROP TABLE JE_SPRAVCA CASCADE CONSTRAINTS;
DROP TABLE JE_SPOLURIESITEL CASCADE CONSTRAINTS;
DROP TABLE JE_HLAVNY_RIESITEL CASCADE CONSTRAINTS;


-- -- Defining tables -------------------------------------------

CREATE TABLE OSOBA(
   LOGIN VARCHAR (8) NOT NULL, -- pk
   MENO VARCHAR(20) NOT NULL,
   ULICA VARCHAR(50),
   MESTO VARCHAR(35),
   PSC VARCHAR(6),
   DATUM_NARODENIA DATE NOT NULL,

   CONSTRAINT PK_LOGIN PRIMARY KEY (LOGIN)
);

CREATE TABLE ORGANIZACIA(
   SKRATKA VARCHAR(20) NOT NULL, --pk
   NAZOV VARCHAR(150) NOT NULL,
   TYP VARCHAR(30),

   CONSTRAINT PK_SKRATKA PRIMARY KEY (SKRATKA)
);

CREATE TABLE PROJEKT(
   KOD INTEGER NOT NULL, --pk
   NAZOV VARCHAR(150) NOT NULL,
   DATUM_ZAHAJENIA DATE NOT NULL,
   DATUM_UKONCENIA DATE NOT NULL,
   ANOTACIA VARCHAR(500),
   SKRATKA VARCHAR(20) NOT NULL,
   LOGIN VARCHAR (8) NOT NULL,
   MODIFIKOVAL_LOGIN VARCHAR (8) NOT NULL,
   DATUM_MODIFIKACIE DATE NOT NULL,
   VYTVORIL_LOGIN VARCHAR (8) NOT NULL,
   DATUM_VYTVORENIA DATE NOT NULL,

   CONSTRAINT PK_KOD PRIMARY KEY (KOD),
   CONSTRAINT FK_SKRATKA FOREIGN KEY (SKRATKA) REFERENCES ORGANIZACIA,
   CONSTRAINT FK_LOGIN FOREIGN KEY (LOGIN) REFERENCES OSOBA
   CONSTRAINT FK_MODIFIKOVAL_LOGIN FOREIGN KEY (MODIFIKOVAL_LOGIN) REFERENCES OSOBA
   CONSTRAINT FK_VYTVORIL_LOGIN FOREIGN KEY (VYTVORIL_LOGIN) REFERENCES OSOBA
);

CREATE TABLE SUBOR(
   SUBOR_ID INTEGER NOT NULL, --pk
   NAZOV VARCHAR(128) NOT NULL,
   PRISTUPOVE_PRAVA VARCHAR(30),
   KOD INTEGER,
   CONSTRAINT PK_SUBOR_ID PRIMARY KEY (SUBOR_ID),
   CONSTRAINT FK_KOD FOREIGN KEY (KOD) REFERENCES PROJEKT
);

CREATE TYPE DOKUMENT UNDER SUBOR (
   UMIESTNENIE VARCHAR(256),
);

CREATE TYPE ZLOZKA UNDER SUBOR (
   SUBOR_ID_FK INTEGER NOT NULL,
   CONSTRAINT FK_SUBOR_ID FOREIGN KEY (SUBOR_ID_FK) REFERENCES SUBOR
);

CREATE TABLE PRACUJE_V (
   LOGIN VARCHAR (8) NOT NULL, 
   SKRATKA VARCHAR(20) NOT NULL,
   CONSTRAINT FK_LOGIN_PRACUJE_V 
      FOREIGN KEY (LOGIN) REFERENCES OSOBA,
   CONSTRAINT FK_SKRATKA_PRACUJE_V 
      FOREIGN KEY (SKRATKA) REFERENCES ORGANIZACIA,
   CONSTRAINT PK_PRACUJE_V PRIMARY KEY (LOGIN, SKRATKA)
);

CREATE TABLE JE_SPOLUPRACOVNIK (
   LOGIN VARCHAR (8) NOT NULL,
   KOD INTEGER NOT NULL,
   PODIEL INTEGER,
   CONSTRAINT FK_LOGIN_JE_SPOLUPRACOVNIK FOREIGN KEY (LOGIN) REFERENCES OSOBA,
   CONSTRAINT FK_KOD_JE_SPOLUPRACOVNIK FOREIGN KEY (KOD) REFERENCES PROJEKT,
   CONSTRAINT PK_JE_SPOLUPRACOVNIK PRIMARY KEY (LOGIN, KOD)
);

CREATE TABLE MOZE_MODIFIKOVAT (
   LOGIN VARCHAR (8) NOT NULL,
   KOD INTEGER NOT NULL,
   CONSTRAINT FK_LOGIN_MOZE_MODIFIKOVAT FOREIGN KEY (LOGIN) REFERENCES OSOBA,
   CONSTRAINT FK_KOD_MOZE_MODIFIKOVAT FOREIGN KEY (KOD) REFERENCES PROJEKT,
   CONSTRAINT PK_MOZE_MODIFIKOVAT PRIMARY KEY (LOGIN, KOD)
);

CREATE TABLE JE_SPRAVCA (
   LOGIN VARCHAR (8) NOT NULL,
   SUBOR_ID INTEGER NOT NULL,
   CONSTRAINT FK_LOGIN_JE_SPRAVCA FOREIGN KEY (LOGIN) REFERENCES OSOBA,
   CONSTRAINT FK_SUBOR_ID_JE_SPRAVCA FOREIGN KEY (SUBOR_ID) REFERENCES SUBOR,
   CONSTRAINT PK_JE_SPRAVCA PRIMARY KEY (LOGIN, SUBOR_ID)
);

CREATE TABLE JE_SPOLURIESITEL (
   PODIEL NUMBER NOT NULL,
   LOGIN VARCHAR (8) NOT NULL,
   KOD INTEGER NOT NULL,
   SKRATKA VARCHAR(20) NOT NULL,
   CONSTRAINT FK_LOGIN_JE_SPOLURIESITEL FOREIGN KEY (LOGIN) REFERENCES OSOBA,
   CONSTRAINT FK_KOD_JE_SPOLURIESITEL FOREIGN KEY (KOD) REFERENCES PROJEKT,
   CONSTRAINT FK_SKRATKA_JE_SPOLURIESITEL FOREIGN KEY (SKRATKA) REFERENCES ORGANIZACIA,
   CONSTRAINT PK_JE_SPOLURIESITEL PRIMARY KEY (LOGIN, KOD, SKRATKA)
);

CREATE TABLE JE_HLAVNY_RIESITEL (
   LOGIN VARCHAR (8) NOT NULL,
   KOD INTEGER NOT NULL,
   SKRATKA VARCHAR(20) NOT NULL,
   CONSTRAINT FK_LOGIN_JE_HLAVNY_RIESITEL FOREIGN KEY (LOGIN) REFERENCES OSOBA,
   CONSTRAINT FK_KOD_JE_HLAVNY_RIESITEL FOREIGN KEY (KOD) REFERENCES PROJEKT,
   CONSTRAINT FK_SKRATKA_JE_HLAVNY_RIESITEL FOREIGN KEY (SKRATKA) REFERENCES ORGANIZACIA,
   CONSTRAINT PK_JE_HLAVNY_RIESITEL PRIMARY KEY (LOGIN, KOD, SKRATKA)
);


