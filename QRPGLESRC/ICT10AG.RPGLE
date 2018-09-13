       //====  ICM10A - List Contacts (A/E) =======
       //====           By Call Back Date   =======
       Dcl-PR ICM10A               Char(11);
          UserIndex               Zoned(9:0);
          CBDate                  Zoned(6:0);
       End-PR;
       Dcl-DS ICM10ADS              Len(11);
          INDEX10A                Zoned(9:0) Pos(1);
          EOJ10A                   Char(2) Pos(10);
       End-DS;
       //====  ICM10B - List Contacts (A/E) =======
       //====           By Company Name     =======
       Dcl-PR ICM10B               Char(11);
          UserIndex               Zoned(9:0);
          CompName                 Char(35);
          ScanYN                   Char(1);
       End-PR;
       Dcl-DS ICM10BDS              Len(11);
          INDEX10B                Zoned(9:0) Pos(1);
          EOJ10B                   Char(2) Pos(10);
       End-DS;
       //====  ICM10C - List Contacts (A/E) =======
       //====           By Last Name        =======
       Dcl-PR ICM10C               Char(11);
          UserIndex               Zoned(9:0);
          LastNm                   Char(17);
       End-PR;
       Dcl-DS ICM10CDS              Len(11);
          INDEX10C                Zoned(9:0) Pos(1);
          EOJ10C                   Char(2) Pos(10);
       End-DS;
       //====  ICM10D - List Contacts (A/E) =======
       //====           By First Name       =======
       Dcl-PR ICM10D               Char(11);
          UserIndex               Zoned(9:0);
          FirstNm                  Char(15);
       End-PR;
       Dcl-DS ICM10DDS              Len(11);
          INDEX10D                Zoned(9:0) Pos(1);
          EOJ10D                   Char(2) Pos(10);
       End-DS;
       //====  ICM10E - List Contacts (A/E) =======
       //====           By State            =======
       Dcl-PR ICM10E               Char(11);
          UserIndex               Zoned(9:0);
          State                    Char(2);
       End-PR;
       Dcl-DS ICM10EDS              Len(11);
          INDEX10E                Zoned(9:0) Pos(1);
          EOJ10E                   Char(2) Pos(10);
       End-DS;
       //====  ICM10F - List Contacts (A/E) =======
       //====           By Zip Code         =======
       Dcl-PR ICM10F               Char(11);
          UserIndex               Zoned(9:0);
          ZipCd                    Char(5);
       End-PR;
       Dcl-DS ICM10FDS              Len(11);
          INDEX10F                Zoned(9:0) Pos(1);
          EOJ10F                   Char(2) Pos(10);
       End-DS;
       //====  ICM10G - List Contacts (A/E) =======
       //====           By Phone Area Code  =======
       Dcl-PR ICM10G               Char(11);
          UserIndex               Zoned(9:0);
          PhnAc                   Zoned(3:0);
       End-PR;
       Dcl-DS ICM10GDS              Len(11);
          INDEX10G                Zoned(9:0) Pos(1);
          EOJ10G                   Char(2) Pos(10);
       End-DS;
       //====  ICM10SEL - List Contacts (A/E) =======
       Dcl-PR ICM10SEL             Char(11);
          *N                      Zoned(9:0); // User Index
          *N                      Zoned(6:0); // Call Back Date
       End-PR;
       Dcl-DS ICM10SELDS            Len(11);
          INDEX10SEL              Zoned(9:0) Pos(1);
          EOJ10SEL                 Char(2) Pos(10);
       End-DS;
       //====  ICM10X - Validate Contact Selection  ====
       Dcl-PR ICM10X               Char(2);
          ContIndex               Zoned(9:0);
       End-PR;
