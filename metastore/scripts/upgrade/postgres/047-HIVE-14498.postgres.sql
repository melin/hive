CREATE TABLE "MV_CREATION_METADATA" (
    "MV_CREATION_METADATA_ID" bigint NOT NULL,
    "DB_NAME" character varying(128) NOT NULL,
    "TBL_NAME" character varying(256) NOT NULL,
    "TXN_LIST" text
);
CREATE TABLE "MV_TABLES_USED" (
    "MV_CREATION_METADATA_ID" bigint NOT NULL,
    "TBL_ID" bigint NOT NULL
);
ALTER TABLE ONLY "MV_CREATION_METADATA"
    ADD CONSTRAINT "MV_CREATION_METADATA_PK" PRIMARY KEY ("MV_CREATION_METADATA_ID");
CREATE INDEX "MV_UNIQUE_TABLE"
    ON "MV_CREATION_METADATA" USING btree ("TBL_NAME", "DB_NAME");
ALTER TABLE ONLY "MV_TABLES_USED"
    ADD CONSTRAINT "MV_TABLES_USED_FK1" FOREIGN KEY ("MV_CREATION_METADATA_ID") REFERENCES "MV_CREATION_METADATA" ("MV_CREATION_METADATA_ID") DEFERRABLE;
ALTER TABLE ONLY "MV_TABLES_USED"
    ADD CONSTRAINT "MV_TABLES_USED_FK2" FOREIGN KEY ("TBL_ID") REFERENCES "TBLS" ("TBL_ID") DEFERRABLE;

ALTER TABLE COMPLETED_TXN_COMPONENTS ADD COLUMN CTC_TIMESTAMP timestamp NULL;
UPDATE COMPLETED_TXN_COMPONENTS SET CTC_TIMESTAMP = CURRENT_TIMESTAMP;
ALTER TABLE COMPLETED_TXN_COMPONENTS ALTER COLUMN CTC_TIMESTAMP SET NOT NULL;
ALTER TABLE COMPLETED_TXN_COMPONENTS ALTER COLUMN CTC_TIMESTAMP SET DEFAULT CURRENT_TIMESTAMP;
CREATE INDEX COMPLETED_TXN_COMPONENTS_INDEX ON COMPLETED_TXN_COMPONENTS USING btree (CTC_DATABASE, CTC_TABLE, CTC_PARTITION);
