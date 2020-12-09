ALTER TABLE ACCOUNT
    ADD COLUMN "CURRENCY" character(4) NOT NULL;

COMMENT ON COLUMN ACCOUNT."CURRENCY"
    IS 'Three letter code of this account''s currency. Example: USD, EUR.';

ALTER TABLE ${flyway:defaultSchema}.ACCOUNT
    ADD COLUMN "PARENT" integer;
ALTER TABLE ${flyway:defaultSchema}.ACCOUNT
    ADD CONSTRAINT "FK_PARENT_ACCOUNT" FOREIGN KEY ("PARENT")
    REFERENCES ACCOUNT ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

CREATE TABLE ${flyway:defaultSchema}.TRANSACTION
(
    "TRANID" bigserial,
    "HASH" character varying(127),
    "DESCRIPTION" character varying(252),
    "FLAGS" integer,
    CONSTRAINT "PK_TRANSACTION" PRIMARY KEY ("TRANID"),
    CONSTRAINT "UK_TRANSACTION_HASH" UNIQUE ("HASH")
);

CREATE TABLE ${flyway:defaultSchema}.ACCOUNT_ENTRIES
(
    "ACCOUNT_ID" INTEGER not null,
    "TRANID" bigint not null,
    "VALUE" NUMERIC(15,3),
    "FLAGS" integer,
    CONSTRAINT "PK_ACCOUNT_ENTRIES" PRIMARY KEY ("ACCOUNT_ID", "TRANID"),
    CONSTRAINT "FK_ENTRY_TRANSACTION" FOREIGN KEY ("TRANID") REFERENCES TRANSACTION("TRANID"),
    CONSTRAINT "FK_ENTRY_ACCOUNT" FOREIGN KEY ("ACCOUNT_ID") REFERENCES ACCOUNT("ID")
);

