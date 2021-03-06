/* Drop the ICDATA.ICP010 Contact Master Table */   DROP TABLE ICDATA.ICP010 ;

/* Create the ICDATA.ICP010 Contact Master Table */
CREATE TABLE ICDATA.ICP010 (
        IC010INDEX INT GENERATED ALWAYS AS IDENTITY (START WITH 1 ,
        INCREMENT BY 1) NOT NULL ,
        IC1001 CHAR(1) NOT NULL DEFAULT '' ,
        IC1002 NUMERIC(6, 0) NOT NULL DEFAULT 0 ,
        IC1003 CHAR(17) CCSID 37 NOT NULL DEFAULT '' ,
        IC1004 CHAR(15) CCSID 37 NOT NULL DEFAULT '' ,
        IC1005 CHAR(3) CCSID 37 NOT NULL DEFAULT '' ,
        IC1006 CHAR(3) CCSID 37 NOT NULL DEFAULT '' ,
        IC1007 CHAR(35) CCSID 37 NOT NULL DEFAULT '' ,
        IC1008 CHAR(35) CCSID 37 NOT NULL DEFAULT '' ,
        IC1009 CHAR(35) CCSID 37 NOT NULL DEFAULT '' ,
        IC1010 CHAR(35) CCSID 37 NOT NULL DEFAULT '' ,
        IC1011 CHAR(20) CCSID 37 NOT NULL DEFAULT '' ,
        IC1012 CHAR(2) CCSID 37 NOT NULL DEFAULT '' ,
        IC1013 CHAR(10) CCSID 37 NOT NULL DEFAULT '' ,
        IC1014 CHAR(25) CCSID 37 NOT NULL DEFAULT '' ,
        IC1015 CHAR(10) CCSID 37 NOT NULL DEFAULT '' ,
        IC1016 CHAR(15) CCSID 37 NOT NULL DEFAULT '' ,
        IC1017 CHAR(7) CCSID 37 NOT NULL DEFAULT '' ,
        IC1018 CHAR(15) CCSID 37 NOT NULL DEFAULT '' ,
        IC1019 CHAR(15) CCSID 37 NOT NULL DEFAULT '' ,
        IC1020 CHAR(15) CCSID 37 NOT NULL DEFAULT '' ,
        IC1021 INT ,
        IC1022 INT ,
        IC1023 INT ,
        IC1024 INT ,
        IC1025 CHAR(11) CCSID 37 NOT NULL DEFAULT '' ,
        IC1026 INT ,
        IC1027 INT ,
        IC1028 INT ,
        IC1029 INT ,
        IC1030 INT ,
        IC1032 CHAR(30) CCSID 37 NOT NULL DEFAULT '' ,
        IC1033 TIMESTAMP NOT NULL ,
        IC1034 TIMESTAMP NOT NULL ,
        IC1035 CHAR(1) CCSID 37 NOT NULL DEFAULT '' ,
        IC1036 CHAR(15) CCSID 37 NOT NULL DEFAULT '' ,
        IC1037 CHAR(15) CCSID 37 NOT NULL DEFAULT '' ,
        IC1038 CHAR(17) CCSID 37 NOT NULL DEFAULT '' ,
        IC1039 DATE NOT NULL DEFAULT CURRENT_DATE ,
        IC1040 INT ,
        IC1041 INT ,
        IC1042 TIMESTAMP NOT NULL  ,
        IC1043 TIMESTAMP NOT NULL  ,
        IC1044 CHAR(40) CCSID 37 NOT NULL DEFAULT '' ,
        IC1045 CHAR(40) CCSID 37 NOT NULL DEFAULT '' ,
        IC1046 NUMERIC(2, 0) NOT NULL DEFAULT 0 ,
        IC1047 NUMERIC(11, 0) NOT NULL DEFAULT 0 ,
        PRIMARY KEY( IC010INDEX ) ) ;

LABEL ON TABLE ICDATA.ICP010
        IS 'Contact Master' ;

LABEL ON COLUMN ICDATA.ICP010 ( IC010INDEX  IS 'Unique Key' ,        IC1001 IS 'Del' ,         IC1002 IS 'Cont ID' ,         IC1003 IS 'Last Name' ,         IC1004 IS 'Fist Name' ,         IC1005 IS 'Sal' ,         IC1006 IS 'Sfx' ,         IC1007 IS 'Company' ,         IC1008 IS 'Address Line 1' ,         IC1009 IS 'Address Line 2' ,         IC1010 IS 'Address Line 3' ,         IC1011 IS 'City' ,         IC1012 IS 'St' ,         IC1013 IS 'Zip Code' ,         IC1014 IS 'Country' ,         IC1015 IS 'forgn Zip' ,         IC1016 IS 'Phone' ,         IC1017 IS 'Extn' ,         IC1018 IS 'Fax No.' ,         IC1019 IS 'foreign Phone' ,         IC1020 IS 'foreign Fax' ,         IC1021 IS 'Supplier' ,         IC1022 IS 'A/P                 Vend' ,         IC1023 IS 'A/R                 Cust' ,         IC1024 IS 'A/R                 Ship 2' ,         IC1025 IS 'Resale No' ,         IC1026 IS 'Cont                Type' ,         IC1027 IS 'Distributor' ,         IC1028 IS 'Acct Exec.' ,         IC1029 IS 'Tech.' ,         IC1030 IS 'Pre Sales' ,         IC1032 IS 'Alpha Search' ,         IC1033 IS 'Call Back' ,         IC1034 IS 'Last Called' ,         IC1035 IS 'Corp                Y/N' ,         IC1036 IS 'User Info' ,         IC1037 IS 'Search F/N' ,         IC1038 IS 'Search L/N' ,         IC1039 IS 'Cont                Est' ,         IC1040 IS 'Buss.               Type' ,         IC1041 IS 'Cont                Pos' ,         IC1042 IS 'Appointment' ,         IC1043 IS 'Posted to Calendar' ,         IC1044 IS 'Web Page URL' ,         IC1045 IS 'E:mail Addr.' ,         IC1046 IS 'Carr                Rte' ,         IC1047 IS 'Post Net' ) ;

LABEL ON COLUMN ICDATA.ICP010
( IC010INDEX TEXT IS 'UNIQUE INDEX/KEY' ,
        IC1001 TEXT IS 'DELETE FLAG' ,         IC1002 TEXT IS 'CONTACT ID' ,
        IC1003 TEXT IS 'CONT. LAST NAME' ,
        IC1004 TEXT IS 'CONT. FIRST NAME' ,
        IC1005 TEXT IS 'CONT. SALUTATION' ,
        IC1006 TEXT IS 'CONT. NAME SUFFIX' ,
        IC1007 TEXT IS 'CONTACT COMPANY' ,
        IC1008 TEXT IS 'ADDRESS LINE 1' ,
        IC1009 TEXT IS 'ADDRESS LINE 2' ,
        IC1010 TEXT IS 'ADDRESS LINE 3' ,
        IC1011 TEXT IS 'CITY NAME' ,
        IC1012 TEXT IS 'STATE CODE' ,
        IC1013 TEXT IS 'ZIP CODE' ,
        IC1014 TEXT IS 'COUNTRY' ,
        IC1015 TEXT IS 'FOREIGN ZIP CODE' ,
        IC1016 TEXT IS 'PHONE NUMBER' ,
        IC1017 TEXT IS 'PHONE EXTENSION' ,
        IC1018 TEXT IS 'FAX NUMBER' ,
        IC1019 TEXT IS 'FOREIGN PHONE' ,
        IC1020 TEXT IS 'FOREIGN FAX' ,
        IC1021 TEXT IS 'Supplier ID' ,
        IC1022 TEXT IS 'A/P Vend. ID' ,
        IC1023 TEXT IS 'A/R Cust. ID' ,
        IC1024 TEXT IS 'A/R Cust. SHIP TO' ,
        IC1025 TEXT IS 'RESALE NUMBER' ,
        IC1026 TEXT IS 'MAJOR CONTACT TYPE' ,
        IC1027 TEXT IS 'DISTRIBUTOR ASSIGNED' ,
        IC1028 TEXT IS 'ACCOUNT EXEC. ASSIGNED' ,
        IC1029 TEXT IS 'TECHNICIAN ASSIGNED' ,
        IC1030 TEXT IS 'PRE-SALES ASSIST ASGN.' ,
        IC1032 TEXT IS 'ALPH SEARCH NAME' ,
        IC1033 TEXT IS 'CALL BACK T/S' ,
        IC1034 TEXT IS 'LAST CALLED T/S' ,
        IC1035 TEXT IS 'CORP. HDQ.' ,
        IC1036 TEXT IS 'USER INFORMATION' ,
        IC1037 TEXT IS 'SEARCH FIRST NAME' ,
        IC1038 TEXT IS 'SEARCH LAST NAME' ,
        IC1039 TEXT IS 'CONT ESTABLISHED' ,
        IC1040 TEXT IS 'BUSINESS TYPE' ,
        IC1041 TEXT IS 'CONTACT POS. CODE' ,
        IC1042 TEXT IS 'APPOINTMENT T/S' ,
        IC1043 TEXT IS 'POSTED TO CAL. T/S' ,
        IC1044 TEXT IS 'WEB PAGE URL' ,
        IC1045 TEXT IS 'E:MAIL ADDRESS' ,
        IC1046 TEXT IS 'CARRIER ROUTE' ,
        IC1047 TEXT IS 'POST NET' ) ;

/* R/I to Supplier table */
ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1021) REFERENCES IADATA.POPSUP
(SUPINDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ;

/* R/I to Vendor table */
ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1022) REFERENCES IADATA.POPVND
(VNDINDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ;

/* R/I to A/R Customer table */
/* ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1023) REFERENCES IADATA.POPSUP
(SUPINDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ; */

/* R/I to A/R Ship To table */
/* ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1024) REFERENCES IADATA.POPVND
(VNDINDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ; */

/* R/I to Contact Type table */
ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1026) REFERENCES ICDATA.ICP003
(IC003INDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ;

/* R/I to Distributor table */
ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1027) REFERENCES ICDATA.ICP050
(IC050INDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ;

/* R/I to internal user table (A/E) */
ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1028) REFERENCES ICDATA.ICP002
(IC002INDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ;

/* R/I to internal user table (Tech.) */
ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1029) REFERENCES ICDATA.ICP002
(IC002INDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ;

/* R/I to internal user table (Pre-Sales) */
ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1030) REFERENCES ICDATA.ICP002
(IC002INDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ;

/* R/I to business type table */
ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1040) REFERENCES ICDATA.ICP009
(IC009INDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ;

/* R/I to position code table */
ALTER TABLE ICDATA.ICP010 ADD FOREIGN KEY (IC1041) REFERENCES ICDATA.ICP007
(IC007INDEX) ON DELETE NO ACTION ON UPDATE NO ACTION ;

/* Creating index ICDATA.ICX010B */CREATE INDEX ICDATA.ICX010B ON ICDATA.ICP010 ( IC1032 ASC );

/* Setting comment text for ICDATA.ICX010B */
COMMENT ON INDEX ICDATA.ICX010B IS 'Index on Company Name';

/* Creating index ICDATA.ICX010C */CREATE INDEX ICDATA.ICX010C ON ICDATA.ICP010 ( IC1038 ASC );

/* Setting comment text for ICDATA.ICX010C */
COMMENT ON INDEX ICDATA.ICX010C IS 'Index on Search Last Name';

/* Creating index ICDATA.ICX010CX */CREATE INDEX ICDATA.ICX010CX ON ICDATA.ICP010 (IC1002 ASC );

/* Setting comment text for ICDATA.ICX010CX */
COMMENT ON INDEX ICDATA.ICX010CX IS 'Index on Contact ID Number';

/* Creating index ICDATA.ICX010D */CREATE INDEX ICDATA.ICX010D ON ICDATA.ICP010 ( IC1037 ASC );

/* Setting comment text for ICDATA.ICX010D */
COMMENT ON INDEX ICDATA.ICX010D IS 'Index on search First Name';

/* Creating index ICDATA.ICX010E */CREATE INDEX ICDATA.ICX010E ON ICDATA.ICP010 ( IC1012 ASC );

/* Setting comment text for ICDATA.ICX010E */
COMMENT ON INDEX ICDATA.ICX010E IS 'Index on State';

/* Creating index ICDATA.ICX010F */CREATE INDEX ICDATA.ICX010F ON ICDATA.ICP010 ( IC1013 ASC );

/* Setting comment text for ICDATA.ICX010F */
COMMENT ON INDEX ICDATA.ICX010F IS 'Index on Zip Code';

/* Creating index ICDATA.ICX010G */CREATE INDEX ICDATA.ICX010G ON ICDATA.ICP010 ( IC1016 ASC );

/* Setting comment text for ICDATA.ICX010G */
COMMENT ON INDEX ICDATA.ICX010G IS 'Index on Phone Number';

/* Creating index ICDATA.ICX010AE */CREATE INDEX ICDATA.ICX010AE ON ICDATA.ICP010 ( IC1028 ASC );

/* Setting comment text for ICDATA.ICX010AE */
COMMENT ON INDEX ICDATA.ICX010AE IS 'Index on Account Executive';

/* Creating index ICDATA.ICX010EA */CREATE INDEX ICDATA.ICX010EA ON ICDATA.ICP010 (IC1028 ASC, IC1033 ASC );

/* Setting comment text for ICDATA.ICX010EA */
COMMENT ON INDEX ICDATA.ICX010EA IS 'Index on A/E and call back date';

/* Creating index ICDATA.ICX010EB */CREATE INDEX ICDATA.ICX010EB ON ICDATA.ICP010 (IC1028 ASC, IC1032 ASC );

/* Setting comment text for ICDATA.ICX010EB */
COMMENT ON INDEX ICDATA.ICX010EB IS 'Index on A/E and Company Name';

/* Creating index ICDATA.ICX010EC */CREATE INDEX ICDATA.ICX010EC ON ICDATA.ICP010 (IC1028 ASC, IC1038 ASC );

/* Setting comment text for ICDATA.ICX010EC */
COMMENT ON INDEX ICDATA.ICX010EC IS 'Index on A/E and Search Last Name';

/* Creating index ICDATA.ICX010ED */CREATE INDEX ICDATA.ICX010ED ON ICDATA.ICP010 (IC1028 ASC, IC1037 ASC );

/* Setting comment text for ICDATA.ICX010ED */
COMMENT ON INDEX ICDATA.ICX010ED IS 'Index on A/E and search First Name';

/* Creating index ICDATA.ICX010EE */CREATE INDEX ICDATA.ICX010EE ON ICDATA.ICP010 (IC1028 ASC, IC1012 ASC );

/* Setting comment text for ICDATA.ICX010EE */
COMMENT ON INDEX ICDATA.ICX010EE IS 'Index on A/E and State';

/* Creating index ICDATA.ICX010EF */CREATE INDEX ICDATA.ICX010EF ON ICDATA.ICP010 (IC1028 ASC, IC1013 ASC );

/* Setting comment text for ICDATA.ICX010EF */
COMMENT ON INDEX ICDATA.ICX010EF IS 'Index on A/E and Zip Code';

/* Creating index ICDATA.ICX010EG */CREATE INDEX ICDATA.ICX010EG ON ICDATA.ICP010 (IC1028 ASC, IC1016 ASC );

/* Setting comment text for ICDATA.ICX010EG */
COMMENT ON INDEX ICDATA.ICX010EG IS 'Index on A/E and Phone Number';
