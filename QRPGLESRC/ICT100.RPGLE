     ?* Prototypes for Contact look up programs
     ?*====  ICMW10 - Contact Master Selection Verif. ====
     d ICMW10          PR            11A
     d INDEX010                       9S 0
     D ICMW10DS        DS            11
     D INDEXW10                       9S 0 OVERLAY(ICMW10DS)
     D EOJW10                         2A   OVERLAY(ICMW10DS:10)
     ?*====  ICMW50 - Distributor look up   ====
     d ICMW50          PR            11A
     D ICMW50DS        DS            11
     D INDEXW50                       9S 0 OVERLAY(ICMW50DS)
     D EOJW50                         2A   OVERLAY(ICMW50DS:10)
     ?*====  ICM10Q - Dealer/Broker Look Up  ====
     d ICM10Q          PR            11A
     D ICM10QDS        DS            11
     D INDEX10Q                       9S 0 OVERLAY(ICM10QDS)
     D EOJ10Q                         2A   OVERLAY(ICM10QDS:10)
     ?*====  ICM15A - List Contacts (A/E) =======
     ?*====           By Call Back Date   =======
     d ICM15A          PR            11A
     d UserIndex                      9S 0
     d CBDate                         6S 0
     D ICM15ADS        DS            11
     D INDEX15A                       9S 0 OVERLAY(ICM15ADS)
     D EOJ15A                         2A   OVERLAY(ICM15ADS:10)
     ?*====  ICM15B - L/U by Contact Company (A/E) =======
     d ICM15B          PR            11A
     d UserIndex                      9S 0
     d CompName                      35A
     D ICM15BDS        DS            11
     D INDEX15B                       9S 0 OVERLAY(ICM15BDS)
     D EOJ15B                         2A   OVERLAY(ICM15BDS:10)
     ?*==== ICM15BS - List Contacts (A/E) =======
     ?*====           By Company - Scan   =======
     d ICM15BS         PR            11A
     d UserIndex                      9S 0
     d Scan10BS                      30A
     D ICM15BSDS       DS            11
     D INDEX15BS                      9S 0 OVERLAY(ICM15BSDS)
     D EOJ15BS                        2A   OVERLAY(ICM15BSDS:10)
     ?*====  ICM15C - List Contacts (A/E) =======
     ?*====           By Last Name        =======
     d ICM15C          PR            11A
     d UserIndex                      9S 0
     d LastNm                        17A
     D ICM15CDS        DS            11
     D INDEX15C                       9S 0 OVERLAY(ICM15CDS)
     D EOJ15C                         2A   OVERLAY(ICM15CDS:10)
     ?*====  ICM15D - List Contacts (A/E) =======
     ?*====           By First Name       =======
     d ICM15D          PR            11A
     d UserIndex                      9S 0
     d FirstNm                       15A
     D ICM15DDS        DS            11
     D INDEX15D                       9S 0 OVERLAY(ICM15DDS)
     D EOJ15D                         2A   OVERLAY(ICM15DDS:10)
     ?*====  ICM15E - List Contacts (A/E) =======
     ?*====           By State            =======
     d ICM15E          PR            11A
     d UserIndex                      9S 0
     d State                          2A
     D ICM15EDS        DS            11
     D INDEX15E                       9S 0 OVERLAY(ICM15EDS)
     D EOJ15E                         2A   OVERLAY(ICM15EDS:10)
     ?*====  ICM15F - List Contacts (A/E) =======
     ?*====           By Zip Code         =======
     d ICM15F          PR            11A
     d UserIndex                      9S 0
     d ZipCd                          5A
     D ICM15FDS        DS            11
     D INDEX15F                       9S 0 OVERLAY(ICM15FDS)
     D EOJ15F                         2A   OVERLAY(ICM15FDS:10)
     ?*====  ICM15G - List Contacts (A/E) =======
     ?*====           By Phone Area Code  =======
     d ICM15G          PR            11A
     d UserIndex                      9S 0
     d PhoneAC                        3A
     D ICM15GDS        DS            11
     D INDEX15G                       9S 0 OVERLAY(ICM15GDS)
     D EOJ15G                         2A   OVERLAY(ICM15GDS:10)
     ?*====  ICM15H - List Contacts  =======
     ?*====           Call Back Date =======
     d ICM15H          PR            11A
     d CBDate                         6S 0
     D ICM15HDS        DS            11
     D INDEX15H                       9S 0 OVERLAY(ICM15HDS)
     D EOJ15H                         2A   OVERLAY(ICM15HDS:10)
     ?*====  ICM15I - List Contacts  =======
     ?*====           Call Company   =======
     d ICM15I          PR            11A
     d CompName                      35A
     D ICM15IDS        DS            11
     D INDEX15I                       9S 0 OVERLAY(ICM15IDS)
     D EOJ15I                         2A   OVERLAY(ICM15IDS:10)
     ?*==== ICM15IS - List Contacts (A/E) =======
     ?*====           By Company - Scan   =======
     d ICM15IS         PR            11A
     d Scan10IS                      30A
     D ICM15ISDS       DS            11
     D INDEX15IS                      9S 0 OVERLAY(ICM15ISDS)
     D EOJ15IS                        2A   OVERLAY(ICM15ISDS:10)
     ?*====  ICM15J - List Contacts  =======
     ?*====           Last Name      =======
     d ICM15J          PR            11A
     d LastNm                        17A
     D ICM15JDS        DS            11
     D INDEX15J                       9S 0 OVERLAY(ICM15JDS)
     D EOJ15J                         2A   OVERLAY(ICM15JDS:10)
     ?*====  ICM15K - List Contacts  =======
     ?*====           First Name     =======
     d ICM15K          PR            11A
     d FirstNm                       15A
     D ICM15KDS        DS            11
     D INDEXK0L                       9S 0 OVERLAY(ICM15KDS)
     D EOJ15K                         2A   OVERLAY(ICM15KDS:10)
     ?*====  ICM15L - List Contacts  =======
     ?*====           State Code     =======
     d ICM15L          PR            11A
     d State                          2A
     D ICM15LDS        DS            11
     D INDEX15L                       9S 0 OVERLAY(ICM15LDS)
     D EOJ15L                         2A   OVERLAY(ICM15LDS:10)
     ?*====  ICM15M - List Contacts  =======
     ?*====           Zip Code       =======
     d ICM15M          PR            11A
     d Zip                            5A
     D ICM15MDS        DS            11
     D INDEX15M                       9S 0 OVERLAY(ICM15MDS)
     D EOJ15M                         2A   OVERLAY(ICM15MDS:10)
     ?*====  ICM15N - L/U by Phone Area Code  =======
     d ICM15N          PR            11A
     d PhoneAC                        3A
     D ICM15NDS        DS            11
     D INDEX15N                       9S 0 OVERLAY(ICM15NDS)
     D EOJ15N                         2A   OVERLAY(ICM15NDS:10)
     ?*====  ICM15S - L/U by State  =======
     d ICM15S          PR            11A
     d INDEX15IN                      9S 0
     d StateIn                        2A
     D ICM15SDS        DS            11
     D INDEX15S                       9S 0 OVERLAY(ICM15SDS)
     D EOJ15S                         2A   OVERLAY(ICM15SDS:10)
     ?*====  ICM15T - L/U by Customer ID  ====
     d ICM15T          PR            11A
     d INDEX010                       9S 0
     D ICM15TDS        DS            11
     D INDEX15T                       9S 0 OVERLAY(ICM15TDS)
     D EOJ15T                         2A   OVERLAY(ICM15TDS:10)
     ?*====  ICM15V - Validate Contact  ======
     d ICM15V          PR            11A
     d INDEX15V                       9S 0
     D ICM15VDS        DS            11
     D INDEX15V                       9S 0 OVERLAY(ICM15VDS)
     D EOJ15V                         2A   OVERLAY(ICM15VDS:10)
     ?*====  ICM15W - Add Addl Contact  =======
     ?*====           (A/E)             =======
     d ICM15W          PR            11A
     d NDX002                         9S 0
     d NDX010                         9S 0
     D ICM15WDS        DS            11
     D INDEX15W                       9S 0 OVERLAY(ICM15WDS)
     D EOJ15W                         2A   OVERLAY(ICM15WDS:10)
     ?*====  ICM15X - Validate Contact Selection  ====
     d ICM15X          PR             2A
     d ContIndex                      9S 0
     ?*====  ICM15Y - Select Additional Contact  ====
     d ICM15Y          PR            11A
     d INDEX010Y                      9S 0
     D ICM15YDS        DS            11
     D Y015INDEX                      9S 0 OVERLAY(ICM15YDS)
     D Y015EOJ                        2A   OVERLAY(ICM15YDS:10)
