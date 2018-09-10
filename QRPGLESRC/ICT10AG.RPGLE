     ?*====  ICM10A - List Contacts (A/E) =======
     ?*====           By Call Back Date   =======
     d ICM10A          PR            11A
     d UserIndex                      9S 0
     d CBDate                         6S 0
     D ICM10ADS        DS            11
     D INDEX10A                       9S 0 OVERLAY(ICM10ADS)
     D EOJ10A                         2A   OVERLAY(ICM10ADS:10)
     ?*====  ICM10B - List Contacts (A/E) =======
     ?*====           By Company Name     =======
     d ICM10B          PR            11A
     d UserIndex                      9S 0
     d CompName                      35A
     d ScanYN                         1A
     D ICM10BDS        DS            11
     D INDEX10B                       9S 0 OVERLAY(ICM10BDS)
     D EOJ10B                         2A   OVERLAY(ICM10BDS:10)
     ?*====  ICM10C - List Contacts (A/E) =======
     ?*====           By Last Name        =======
     d ICM10C          PR            11A
     d UserIndex                      9S 0
     d LastNm                        17A
     D ICM10CDS        DS            11
     D INDEX10C                       9S 0 OVERLAY(ICM10CDS)
     D EOJ10C                         2A   OVERLAY(ICM10CDS:10)
     ?*====  ICM10D - List Contacts (A/E) =======
     ?*====           By First Name       =======
     d ICM10D          PR            11A
     d UserIndex                      9S 0
     d FirstNm                       15A
     D ICM10DDS        DS            11
     D INDEX10D                       9S 0 OVERLAY(ICM10DDS)
     D EOJ10D                         2A   OVERLAY(ICM10DDS:10)
     ?*====  ICM10E - List Contacts (A/E) =======
     ?*====           By State            =======
     d ICM10E          PR            11A
     d UserIndex                      9S 0
     d State                          2A
     D ICM10EDS        DS            11
     D INDEX10E                       9S 0 OVERLAY(ICM10EDS)
     D EOJ10E                         2A   OVERLAY(ICM10EDS:10)
     ?*====  ICM10F - List Contacts (A/E) =======
     ?*====           By Zip Code         =======
     d ICM10F          PR            11A
     d UserIndex                      9S 0
     d ZipCd                          5A
     D ICM10FDS        DS            11
     D INDEX10F                       9S 0 OVERLAY(ICM10FDS)
     D EOJ10F                         2A   OVERLAY(ICM10FDS:10)
     ?*====  ICM10G - List Contacts (A/E) =======
     ?*====           By Phone Area Code  =======
     d ICM10G          PR            11A
     d UserIndex                      9S 0
     d PhnAc                          3S 0
     D ICM10GDS        DS            11
     D INDEX10G                       9S 0 OVERLAY(ICM10GDS)
     D EOJ10G                         2A   OVERLAY(ICM10GDS:10)
     ?*====  ICM10SEL - List Contacts (A/E) =======
     d ICM10SEL        PR            11A
     d UserIndex                      9S 0
     d CBDate                         6S 0
     D ICM10SELDS      DS            11
     D INDEX10SEL                     9S 0 OVERLAY(ICM10SELDS)
     D EOJ10SEL                       2A   OVERLAY(ICM10SELDS:10)
     ?*====  ICM10X - Validate Contact Selection  ====
     d ICM10X          PR             2A
     d ContIndex                      9S 0
