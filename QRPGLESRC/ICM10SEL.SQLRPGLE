       Ctl-Opt DFTNAME(ICM1SEL) NOMAIN
               DEBUG
               OPTION(*NODEBUGIO: *SRCSTMT)
               COPYRIGHT('SHandB, LLC 2017/2024');
       // ******************************************************************
       // *  ICM10SEL - A/E Customer Look Moudle
       // ******************************************************************
       Dcl-F ICD10SEL       WORKSTN SFILE(SFL01:XRRNS1) INFDS(WSDS) USROPN;
       //  Prototypes
      /Copy QRPGLESRC,ICT10AG
      /Copy QRPGLESRC,ICT100
       Dcl-PR Close10S  End-PR;
       Dcl-PR FetchMult10S  Ind  End-PR;
       Dcl-PR Open10S  End-PR;
              // Prototypes
       //***************************************************************
       //            Prototype for QMHSNDPM-Send the message
       //****************************************************************
       Dcl-PR QMHSNDPM                 ExtPgm('QMHSNDPM');
          AwMSgId                  Char(7);
          AwMSgF                   Char(20);
          AwMSgDta                 Char(256);
          spLen                     Int(10:0);
          apTyp                    Char(10);
          apQue                    Char(10);
          spStk                     Int(10:0);
          spKy                      Int(10:0);
          spErr                     Int(10:0);
       End-PR;
       //***************************************************************
       //            Prototype for QMHRMVPM-Clear the message
       //****************************************************************
       Dcl-PR QMHRMVPM                 ExtPgm('QMHRMVPM');
          spStk1                   Char(10);
          spCsc                     Int(10:0);
          apMsk                    Char(4);
          apMsr                    Char(10);
          spErc                     Int(10:0);
       End-PR;
       //****************************************************************
       // Program status
       Dcl-DS *N                       PSDS;
          SPGM                     Char(10) Pos(001);
          SPARMS                  Zoned(3:0) Pos(037);
          SMSGDTA                  Char(80) Pos(91);
          SMSGID                   Char(4) Pos(171);
          SJOB                     Char(10) Pos(244);
          SUSER                    Char(10) Pos(254);
          SJOB#                   Zoned(6:0) Pos(264);
       End-DS;
       //  Stand Alone Fields - Global
       Dcl-S CoNameUC              Char(35);
       Dcl-S NDX002               Zoned(9:0);
       Dcl-S SflPg                  Int(5:0) inz(18);
       Dcl-C SFLPGC                    Const( 18 );
       Dcl-S SflPgx2                 Int(5:0) inz(36);
       Dcl-S SelStr                 Char(512);
       //  Data structures
       Dcl-DS WSDS  ;
         Choice                    Char(1) Pos(369);
         CsrLoc                  BinDec(2) Pos(370);
         CurRec                  BinDec(2) Pos(378);
       End-Ds;
       // ** This data structure must match the Select statement!
       Dcl-DS PgmData                  qualified  Dim( 6000 );
          ContIndex               Zoned(9:0);                               // IC010INDEX
          ContCo                   Char(35);                                // IC1007
          ContFirst                Char(15);                                // IC1004
          ContLast                 Char(17);                                // IC1003
          ContCity                 Char(20);                                // IC1011
          ContState                Char(2);                                 // IC1012
          ContZip                  Char(10);                                // IC1013
          ContPhone                Char(15);                                // IC1016
          ContCBD             TimeStamp ;                                   // IC1033
       End-DS;
       //  Data structures
       Dcl-DS *N;
          TStamp              TimeStamp;
          TScc                    Zoned(2:0) Overlay(TStamp);
          TSyy                    Zoned(2:0) Overlay(TStamp:3);
          TSmm                    Zoned(2:0) Overlay(TStamp:6);
          TSdd                    Zoned(2:0) Overlay(TStamp:9);
          DateIn                   Date Overlay(TStamp);
          TShr                    Zoned(2:0) Overlay(TStamp:12);
          TSmn                    Zoned(2:0) Overlay(TStamp:15);
          TSsc                    Zoned(2:0) Overlay(TStamp:18);
       End-DS;
       //  Character strings for lower to upper case string conversion
       Dcl-C UP                        CONST('ABCDEFGHIJKLMNOPQRS-
       TUVWXYZ');
       Dcl-C LO                        CONST('abcdefghijklmnopqrs-
       tuvwxyz');
       // Display file attributes
       // RI=Reverse Image, HI=Hi Intensity, BL=blink, UL=Underline
       // ND=Non Display
       // NON Protect fields
       Dcl-C NORMAL                    const(x'20');
       Dcl-C RI                        const(x'21');
       Dcl-C HI                        const(x'22');
       Dcl-C HIRI                      const(x'23');
       Dcl-C UL                        const(x'24');
       Dcl-C ULRI                      const(x'25');
       Dcl-C ULHI                      const(x'26');
       Dcl-C ND                        const(x'27');
       Dcl-C BL                        const(x'28');
       Dcl-C BLRI                      const(x'29');
       Dcl-C BLHI                      const(x'2A');
       Dcl-C BLHIRI                    const(x'2B');
       Dcl-C BLUL                      const(x'2C');
       Dcl-C BLULRI                    const(x'2D');
       Dcl-C BLULHI                    const(x'2E');
       Dcl-C LftBtnDblClick            const(x'73');
       //  Stand Alone Fields - Local
       Dcl-S Ap          Char(1) Inz(X'7D') ;
       Dcl-S AwMSgF                Char(20) INZ('QCPFMSG   *LIBL');
       Dcl-S AwMSgId               Char(7);
       Dcl-S AwMSgDta              Char(256);
       Dcl-S apMsk                 Char(4) INZ(*Blanks);
       Dcl-S apMsr                 Char(10) INZ('*ALL');
       Dcl-S apQue                 Char(10) INZ('*');
       Dcl-S apTyp                 Char(10) INZ('*DIAG');
       Dcl-S BS01CBD             Packed(6:0);
       Dcl-S BS01COIN              Char(30);
       Dcl-S BS01CFN               Char(15);
       Dcl-S BS01CITY              Char(20);
       Dcl-S BS01CLN               Char(17);
       Dcl-S BS01PAC               Char(3);
       Dcl-S BS01SCANYN            Char(1);
       Dcl-S BS01ST                Char(2);
       Dcl-S BS01ZIP               Char(5);
       Dcl-S Cma                   Char(1) Inz(X'6B'); // comma ','
       Dcl-S Colm                   Int(5:0);
       Dcl-S CsrLocZ              Zoned(15:0);
       Dcl-S CsrSel                Char(1024);
       Dcl-S Date8               Packed(8:0);
       Dcl-S EOJ                   Char(2);
       Dcl-S ErrorOn                Ind;
       Dcl-S HS01CBD             Packed(6:0);
       Dcl-S HS01COIN              Char(30);
       Dcl-S HS01CFN               Char(15);
       Dcl-S HS01CITY              Char(20);
       Dcl-S HS01CLN               Char(17);
       Dcl-S HS01PAC               Char(3);
       Dcl-S HS01SCANYN            Char(1);
       Dcl-S HS01ST                Char(2);
       Dcl-S HS01ZIP               Char(5);
       Dcl-S LastX                  Int(10:0);
       Dcl-S LastCust              Char(35);
       Dcl-S LastRRN                   Like(XRRNS1);
       Dcl-S LenStr              Packed(4:0);
       Dcl-S Line                   Int(5:0);
       Dcl-S Loop                   Ind;
       Dcl-S Mult_Row               Int(5:0) Inz(6000);
       Dcl-S NDX010               Zoned(9:0);
       Dcl-S NoRecords              Ind;
       Dcl-S O                      Int(5:0);
       Dcl-S Okay                   Ind;
       Dcl-S Open002                Ind;
       Dcl-S Open010                Ind;
       Dcl-S P                      Int(5:0);
       Dcl-S Pos                    Int(5:0);
       Dcl-S Rc                     Ind;
       Dcl-S RelNumb                Int(10:0);
       Dcl-S RRN1                  Like(RelNumb);
       Dcl-S S                      Int(5:0);
       Dcl-S SelCoin               Char(30);
       Dcl-S SelCFN                Char(15);
       Dcl-S SelCLN                Char(17);
       Dcl-S Sf1Last                Int(5:0);
       Dcl-S Sfl1Pg                 Int(5:0) inz(18);
       Dcl-S Sfl1Pgx2               Int(5:0) inz(36);
       Dcl-S Sfl1B                  Int(5:0) inz;
       Dcl-S Sfl1Ind                Ind;
       Dcl-S Sfl1T                  Int(5:0) inz;
       Dcl-S SIZE                 Zoned(2:0) INZ(18);
       Dcl-S Sp                    Char(1) INZ(X'40');
       Dcl-S spCsc                  Int(10:0) INZ(*Zeros);
       Dcl-S spErc                  Int(10:0) INZ(*Zero);
       Dcl-S spErr                  Int(10:0) INZ(*Zeros);
       Dcl-S spKy                   Int(10:0) INZ(*Zeros);
       Dcl-S spLen                  Int(10:0);
       Dcl-S spStk                  Int(10:0) INZ(*Zeros);
       Dcl-S spStk1                Char(10) INZ('*');
       Dcl-S Tot_Read               Int(5:0);
       Dcl-S Type                  Char(2);
       Dcl-S UseName               Char(35);
       // ---------------------------------------------------------------------
       Dcl-Proc ICM10SEL EXPORT;
          Dcl-PI *N                   Char(11);
            UserIndex               Zoned(9:0);
            CBDate                  Zoned(6:0);
          End-PI;
          // Store the user index and get the user's name
          NDX002 = UserIndex;
          // Get the A/E name
          Exec SQL
            Select IC0203 Into :USER
              From ICP002
              Where IC002INDEX = :NDX002;
          // Initial pass will be by call back date
          If Not %Open(ICD10SEL);
            Open ICD10SEL;
          EndIf;
          S01CBD = CBDate;
          HS01CBD = CBDate;
          ExSR GetCBD;
          ROW = 5;
          COL = 2;
          SFL1IND = *ON;
          Exsr Screen01; //* Process
          //*
          If SFL1Ind = *OFF;
             Close ICD10SEL ;
             //*
             EOJ10SEL = EOJ;
             If EOJ <> '**' ;
                INDEX10SEL = *Zeros ;
             Else;
                INDEX10SEL = NDX010;
             EndIf;
             Return ICM10SELDS;
          EndIf;
       //----------------------------------------------------------------------
       // LoadSFL01 - Load the subfile 01                      -
       //----------------------------------------------------------------------
       BegSr LoadSFL01 ;
          // Clear out the subfile
          *in29 = *On;
          Write CTL01;
          *in29 = *Off;
          XRRNS1 = *ZERO;
          // Build the window subfile
          If P < Tot_Read;
             For O = 1 to Sfl1Pg ;
                If P < Tot_Read ;
                   P += 1 ;
                   SF1H01 = PgmData(P).ContINDEX ;
                   SF1CO = PgmData(P).ContCo ;
                   SF1CNAM = %Trim(PgmData(P).ContFirst) + Sp +
                             %Trim(PgmData(P).ContLast) ;
                   SF1CITY = PgmData(P).ContCity ;
                   SF1ST = PgmData(P).ContState ;
                   SF1ZIP = PgmData(P).ContZip ;
                   SF1PHONE = PgmData(P).ContPhone ;
                   TStamp = PgmData(P).ContCBD ;
                   Date8 = %dec(%char(DateIn:*usa0):8:0);
                   SF1CBD = Date8 ;
                   XRRNS1 += 1;
                   If XRRNS1 = 1;
                      SFL1T = P;
                   EndIf;
                   SFL1B = P;
                   Write SFL01 ;
                EndIf;
             EndFor;
          EndIf;
          If SFL1B = Tot_Read;
            *IN30 = *ON;
          Else;
            *IN30 = *OFF;
          EndIf;
       EndSr;
       //--------------------------------------------------------
       // Screen01 - subfile display routine
       //--------------------------------------------------------
       BegSr Screen01;
          //*
          DoW Sfl1Ind = *ON;
             Write SCRN01;
             If ErrorOn = *ON;
               Write MSGCTL;
             EndIf;
             If NoRecords = *ON;
             *IN28 = *ON ;
             Exfmt CTL01;
             *IN28 = *OFF ;
             Else;
             XRRNS1 = 1;
             *IN27 = *ON ;
             *IN28 = *ON ;
             Exfmt CTL01;
             *IN27 = *OFF ;
             *IN28 = *OFF ;
             EndIf;
             Read SCRN01;
             If ErrorOn = *ON;
               ExSR CLRMSG;
               ErrorON = *OFF;
               NoRecords = *OFF;
             EndIf;
             // Process screen 01
             Select;
               When Choice = LftBtnDblClick ; // Sort the display
                 Select;
                   When Fld = 'S01COIN   ' ;
                     ExSR SortCoName;
                   When Fld = 'S01CFN    ' ;
                     ExSR SortFname;
                   When Fld = 'S01CLN    ' ;
                     ExSR SortLname;
                   When Fld = 'S01CITY   ' ;
                     ExSR SortCity;
                   When Fld = 'S01ST     ' ;
                     ExSR SortST;
                   When Fld = 'S01ZIP    ' ;
                     ExSR SortZip;
                   When Fld = 'S01PAC    ' ;
                     ExSR SortPhone;
                   When Fld = 'S01CBD    ' ;
                     ExSR SortCBD;
                 EndSl;
               When S01COIN <> *Blanks AND S01COIN <> HS01COIN;
                 ExSR GetCompany;
               When S01CFN <> *Blanks AND S01CFN <> HS01CFN;
                 ExSR GetFN;
               When S01CLN <> *Blanks AND S01CLN <> HS01CLN;
                 ExSR GetLN;
               When S01CITY <> *Blanks AND S01CITY <> HS01CITY;
                 ExSR GetCity;
               When S01ST <> *Blanks AND S01ST <> HS01ST;
                 ExSR GetST;
               When S01ZIP <> *Blanks AND S01ZIP <> HS01ZIP;
                 ExSR GetZIP;
               When S01PAC <> *Blanks AND S01PAC <> HS01PAC;
                 ExSR GetPAC;
               When S01CBD <> *Zeros AND S01CBD <> HS01CBD;
                 ExSR GetCBD;
               When *IN12 = *ON; // Previous was selected
                  SFL1Ind = *Off;
                  EOJ = '12';
               When *IN26 = *ON;  // Roll Up  (page down)
                  If P < Tot_Read;
                     Exsr LoadSFL01;
                  EndIf;
               When *IN25 = *ON; //  Roll Down  (page up)
                  If SFL1B > SFL1Pg;
                     If SFL1B > SFL1pgX2;
                        P = P - Sfl1PgX2 ;
                        Exsr LoadSFL01;
                        Else;   //* Go to the top
                        P = *Zero;
                        Exsr LoadSFL01;
                     EndIf;
                     Else;   //* Go to the top
                     P = *Zero;
                     Exsr LoadSFL01;
                  EndIf;
                  Other;  // See if a record(s) were selected for display
                  If RelRec > *Zero;
                     Chain RelRec SFL01;
                     If %Found() ;
                        NDX010 = SF1H01;
                        If SF1SEL <> *Blank;
                           SF1SEL = *Blank;
                           Update SFL01;
                        EndIf;
                        // Validate the selection!!!!
                        EOJ = ICM10X(NDX010);
                        If EOJ = '**';
                           SFL1Ind = *OFF;
                        EndIf;
                     EndIf;
                  EndIf;
            EndSl;
          EndDo;
          //
       EndSr;
       //*-------------------------------------------------------
       //* Get Customers by Call Back Date
       //*-------------------------------------------------------
       BegSr GetCBD ;
         BS01CBD = S01CBD;
         ExSR ClearPD;
         ExSR ResetS01;
         Type = 'CB';
         S01CBD = BS01CBD;
         HS01CBD = BS01CBD;
         S01CBDAB = ULHI;
         S01CBDTAB = HI;
         TStamp = *Loval;
         DateIn = %Date(S01CBD:*MDY);
         Exsr Crtcursor; //* Create the SQL cursor
         Open10S(); //* Open the SQL cursor
         Rc = FetchMult10S() ; //* Get all of the customers
         Close10S() ; //* Close the SQL cursor
         If Tot_Read > *Zero ;
           P = *Zero ;
           Exsr LoadSFL01 ; //* load the subfile
         Else;
           ERRORON = *ON;
           NoRecords = *ON;
           AwMSgDta = *Blanks;
           AwMSgDta = 'No Customers for the selected Call Back Date' ;
           ExSR SendMsg ;
         EndIf;
       EndSr;
       //*-------------------------------------------------------
       //* Get Customers by City Name
       //*-------------------------------------------------------
       BegSr GetCity ;
         BS01CITY = S01CITY;
         ExSR ClearPD;
         ExSR ResetS01;
         Type = 'CT';
         S01CITY = BS01CITY;
         HS01CITY = BS01CITY;
         S01CITTAB = HI;
         S01CITYAB = ULHI;
         Exsr Crtcursor; //* Create the SQL cursor
         Open10S(); //* Open the SQL cursor
         Rc = FetchMult10S() ; //* Get all of the customers
         Close10S() ; //* Close the SQL cursor
         If Tot_Read > *Zero ;
           P = *Zero ;
           Exsr LoadSFL01 ; //* load the subfile
         Else;
           ERRORON = *ON;
           NoRecords = *ON;
           AwMSgDta = *Blanks;
           AwMSgDta = 'No Customers for the selected city' ;
           ExSR SendMsg ;
         EndIf;
       EndSr;
       //*-------------------------------------------------------
       //* Get Customers by Company Name
       //*-------------------------------------------------------
       BegSr GetCompany ;
         BS01COIN = S01COIN;
         BS01SCANYN = S01SCANYN;
         ExSR ClearPD;
         ExSR ResetS01;
         S01COIN = BS01COIN;
         HS01COIN = BS01COIN;
         S01SCANYN = BS01SCANYN;
         HS01SCANYN = BS01SCANYN;
         S01COITAB = HI;
         S01SCANAB = HI;
         S01COINAB = ULHI;
         If S01SCANYN <> *Blanks;
           Type = 'CS';
           S01SCANAB = HI;
         Else;
           Type = 'CO';
         EndIf;
         SelCoin = %Xlate(Lo:Up:S01COIN);
         Exsr Crtcursor; //* Create the SQL cursor
         Open10S(); //* Open the SQL cursor
         Rc = FetchMult10S() ; //* Get all of the customers
         Close10S() ; //* Close the SQL cursor
         If Tot_Read > *Zero   ;
           P = *Zero ;
           Exsr LoadSFL01 ; //* load the subfile
         Else;
           ERRORON = *ON;
           NoRecords = *ON;
           AwMSgDta = *Blanks;
           AwMSgDta = 'No Customers found for the selected company name' ;
           ExSR SendMsg ;
         EndIf;
       EndSr;
       //*-------------------------------------------------------
       //* Get Customers by Contact First Name
       //*-------------------------------------------------------
       BegSr GetFN ;
         BS01CFN  = S01CFN;
         ExSR ClearPD;
         ExSR ResetS01;
         Type = 'FN';
         S01CFN = BS01CFN ;
         HS01CFN = BS01CFN;
         S01COFLAB = HI;
         S01CFNAB = ULHI;
         SelCFN  = %Xlate(Lo:Up:S01CFN);
         Exsr Crtcursor; //* Create the SQL cursor
         Open10S(); //* Open the SQL cursor
         Rc = FetchMult10S() ; //* Get all of the customers
         Close10S() ; //* Close the SQL cursor
         If Tot_Read > *Zero ;
           P = *Zero ;
           Exsr LoadSFL01 ; //* load the subfile
         Else;
           ERRORON = *ON;
           NoRecords = *ON;
           AwMSgDta = *Blanks;
           AwMSgDta = 'No Customers found for the First Name selected' ;
           ExSR SendMsg ;
         EndIf;
       EndSr;
       //*-------------------------------------------------------
       //* Get Customers by Contact Last Name
       //*-------------------------------------------------------
       BegSr GetLN ;
         BS01CLN  = S01CLN;
         ExSR ClearPD;
         ExSR ResetS01;
         Type = 'LN';
         S01CLN = BS01CLN ;
         HS01CLN = BS01CLN;
         S01COFLAB = HI;
         S01CLNAB = ULHI;
         SelCLN  = %Xlate(Lo:Up:S01CLN);
         Exsr Crtcursor; //* Create the SQL cursor
         Open10S(); //* Open the SQL cursor
         Rc = FetchMult10S() ; //* Get all of the customers
         Close10S() ; //* Close the SQL cursor
         If Tot_Read > *Zero ;
           P = *Zero ;
           Exsr LoadSFL01 ; //* load the subfile
         Else;
           ERRORON = *ON;
           NoRecords = *ON;
           AwMSgDta = *Blanks;
           AwMSgDta = 'No Customers found for the Last Name selected' ;
           ExSR SendMsg ;
         EndIf;
       EndSr;
       //*-------------------------------------------------------
       //* Get Customers by Phone Area Code
       //*-------------------------------------------------------
       BegSr GetPAC ;
         BS01PAC  = S01PAC;
         ExSR ClearPD;
         ExSR ResetS01;
         Type = 'PA';
         S01PAC = BS01PAC ;
         HS01PAC = BS01PAC;
         S01PACTAB = HI;
         S01PACAB = ULHI;
         Exsr Crtcursor; //* Create the SQL cursor
         Open10S(); //* Open the SQL cursor
         Rc = FetchMult10S() ; //* Get all of the customers
         Close10S() ; //* Close the SQL cursor
         If Tot_Read > *Zero ;
           P = *Zero ;
           Exsr LoadSFL01 ; //* load the subfile
         Else;
           ERRORON = *ON;
           NoRecords = *ON;
           AwMSgDta = *Blanks;
           AwMSgDta = 'No Customers found for the Area Code selected' ;
           ExSR SendMsg ;
         EndIf;
       EndSr;
       //*-------------------------------------------------------
       //* Get Customers by State
       //*-------------------------------------------------------
       BegSr GetST ;
         BS01ST = S01ST ;
         ExSR ClearPD;
         ExSR ResetS01;
         Type = 'ST';
         S01ST = BS01ST ;
         HS01ST = BS01ST;
         S01STTAB = HI;
         S01STAB = ULHI;
         Exsr Crtcursor; //* Create the SQL cursor
         Open10S(); //* Open the SQL cursor
         Rc = FetchMult10S() ; //* Get all of the customers
         Close10S() ; //* Close the SQL cursor
         If Tot_Read > *Zero ;
           P = *Zero ;
           Exsr LoadSFL01 ; //* load the subfile
         Else;
           ERRORON = *ON;
           NoRecords = *ON;
           AwMSgDta = *Blanks;
           AwMSgDta = 'No Customers found for the State Code selected' ;
           ExSR SendMsg ;
         EndIf;
       EndSr;
       //*-------------------------------------------------------
       //* Get Customers by Zip Code
       //*-------------------------------------------------------
       BegSr GetZip ;
         BS01ZIP = S01ZIP ;
         ExSR ClearPD;
         ExSR ResetS01;
         Type = 'ZC';
         S01ZIP = BS01ZIP ;
         HS01ZIP = BS01ZIP;
         S01ZIPTAB = HI;
         S01ZIPAB = ULHI;
         Exsr Crtcursor; //* Create the SQL cursor
         Open10S(); //* Open the SQL cursor
         Rc = FetchMult10S() ; //* Get all of the customers
         Close10S() ; //* Close the SQL cursor
         If Tot_Read > *Zero ;
           P = *Zero ;
           Exsr LoadSFL01 ; //* load the subfile
         Else;
           ERRORON = *ON;
           NoRecords = *ON;
           AwMSgDta = *Blanks;
           AwMSgDta = 'No Customers found for the Zip Code selected' ;
           ExSR SendMsg ;
         EndIf;
       EndSr;
       //*-------------------------------------------------------
       //* Sort by Customer By Call Back Date
       //*-------------------------------------------------------
       BegSr SortCBD ;
         SortA %Subarr(PgmData(*).ContCBD:1:Tot_Read);
         P = *Zero;
         ExSR LoadSFL01;
       EndSr;
       //*-------------------------------------------------------
       //* Sort by Customer By City
       //*-------------------------------------------------------
       BegSr SortCity ;
         SortA %Subarr(PgmData(*).ContCity:1:Tot_Read);
         P = *Zero;
         ExSR LoadSFL01;
       EndSr;
       //*-------------------------------------------------------
       //* Sort by Customer Company Name
       //*-------------------------------------------------------
       BegSr SortCoName ;
         SortA %Subarr(PgmData(*).ContCo:1:Tot_Read);
         P = *Zero;
         ExSR LoadSFL01;
       EndSr;
       //*-------------------------------------------------------
       //* Sort by Customer Contact First Name
       //*-------------------------------------------------------
       BegSr SortFName ;
         SortA %Subarr(PgmData(*).ContFirst:1:Tot_Read);
         P = *Zero;
         ExSR LoadSFL01;
       EndSr;
       //*-------------------------------------------------------
       //* Sort by Customer Contact Last Name
       //*-------------------------------------------------------
       BegSr SortLName ;
         SortA %Subarr(PgmData(*).ContLast:1:Tot_Read);
         P = *Zero;
         ExSR LoadSFL01;
       EndSr;
       //*-------------------------------------------------------
       //* Sort by Customer By Phone Number
       //*-------------------------------------------------------
       BegSr SortPhone ;
         SortA %Subarr(PgmData(*).ContPhone:1:Tot_Read);
         P = *Zero;
         ExSR LoadSFL01;
       EndSr;
       //*-------------------------------------------------------
       //* Sort by Customer By State Code
       //*-------------------------------------------------------
       BegSr SortST ;
         SortA %Subarr(PgmData(*).ContState:1:Tot_Read);
         P = *Zero;
         ExSR LoadSFL01;
       EndSr;
       //*-------------------------------------------------------
       //* Sort by Customer By Zip Code
       //*-------------------------------------------------------
       BegSr SortZip ;
         SortA %Subarr(PgmData(*).ContZip:1:Tot_Read);
         P = *Zero;
         ExSR LoadSFL01;
       EndSr;
       //*-------------------------------------------------------
       //* Clear PgmData
       //*-------------------------------------------------------
       BegSr ClearPD ;
          For S = 1 to Tot_Read;
             PgmData(S).ContIndex = *Zero;
             PgmData(S).ContCo = *Blanks ;
             PgmData(S).ContFirst = *Blanks ;
             PgmData(S).ContLast = *Blanks ;
             PgmData(S).ContCity = *Blanks ;
             PgmData(S).ContState = *Blanks ;
             PgmData(S).ContZip = *Blanks ;
             PgmData(S).ContPhone = *Blanks ;
             PgmData(S).ContCBD = *LoVal ;
          EndFor;
       EndSr;
       //*-------------------------------------------------------
       //* Reset Screen 01
       //*-------------------------------------------------------
       BegSr ResetS01;
         S01COITAB = Normal;
         S01COINAB = UL;
         S01COIN = *Blanks;
         HS01COIN = *Blanks;
         S01SCANYN = *Blank;
         S01SCANAB = Normal;
         S01SCANFAB = UL;
         S01COFLAB = Normal;
         S01CFNAB = UL;
         S01CFN = *Blanks;
         HS01CFN = *Blanks;
         S01CLNAB = UL;
         S01CLN = *Blanks;
         HS01CLN = *Blanks;
         S01CITTAB = Normal;
         S01CITYAB = UL;
         S01CITY = *Blanks;
         HS01CITY = *Blanks;
         S01STTAB = Normal;
         S01STAB = UL;
         S01ST = *Blanks;
         HS01ST = *Blanks;
         S01ZIPTAB = Normal;
         S01ZIPAB = UL;
         S01ZIP = *Blanks;
         HS01ZIP = *Blanks;
         S01PACTAB = Normal;
         S01PACAB = UL;
         S01PAC = *Blanks;
         HS01PAC = *Blanks;
         S01CBDTAB = Normal;
         S01CBDAB = UL;
         S01CBD = *Zeros;
         HS01CBD = *Zeros;
       EndSr;
       //--------------------------------------------------------
       // Crtcrsr - create the SQL cursor
       //--------------------------------------------------------
       BegSr Crtcursor;
          //
          Select;
          When Type = 'CB';
            CsrSel =
                'Select M.IC010Index, M.IC1007, ' +
                'M.IC1004, M.IC1003, M.IC1011, ' +
                'M.IC1012, M.IC1013, M.IC1016, M.IC1033 ' +
                'From ICP010 AS M ' +
                'Where M.IC1028 = ' + Ap + %EditC(NDX002:'X') + Ap + Sp +
                                  ' AND M.IC1033 <= ' + Ap + %Char(TStamp) +
                                    Ap + ' AND M.IC1034 < ' + Ap +
                                    %Char(TStamp) + Ap + Sp +
                'Order By M.IC1033, M.IC1013 ' +
                'For Read Only ' ;
          When Type = 'CO';
            CsrSel =
                'Select M.IC010Index, M.IC1007, ' +
                'M.IC1004, M.IC1003, M.IC1011, ' +
                'M.IC1012, M.IC1013, M.IC1016, M.IC1033 ' +
                'From ICP010 AS M ' +
                'Where M.IC1028 = ' + Ap + %EditC(NDX002:'X') + Ap + Sp +
                                  'AND M.IC1032 >= ' + Ap + %Trim(SelCoin) +
                                   Ap + Sp +
                'Order By M.IC1032, M.IC1013 ' +
                'For Read Only' ;
          When Type = 'CS';
            CsrSel =
                'Select M.IC010Index, M.IC1007, ' +
                'M.IC1004, M.IC1003, M.IC1011, ' +
                'M.IC1012, M.IC1013, M.IC1016, M.IC1033 ' +
                'From ICP010 AS M ' +
                'Where M.IC1028 = ' + Ap + %EditC(NDX002:'X') + Ap + Sp +
                                  'AND Locate (' + Ap + %TRIM(SelCoin) + Ap +
                                   Cma + 'M.IC1032,1) <> 0' + Sp +
                'Order By M.IC1032, M.IC1013 ' +
                'For Read Only' ;
          When Type = 'CT';
            CsrSel =
                'Select M.IC010Index, M.IC1007, ' +
                'M.IC1004, M.IC1003, M.IC1011, ' +
                'M.IC1012, M.IC1013, M.IC1016, M.IC1033 ' +
                'From ICP010 AS M ' +
                'Where M.IC1028 = ' + Ap + %EditC(NDX002:'X') + Ap + Sp +
                                  'AND M.IC1011 = ' + Ap + %Trim(S01CITY) +
                                   Ap + Sp +
                'Order By M.IC1033, M.IC1013 ' +
                'For Read Only' ;
          When Type = 'FN';
            CsrSel =
                'Select M.IC010Index, M.IC1007, ' +
                'M.IC1004, M.IC1003, M.IC1011, ' +
                'M.IC1012, M.IC1013, M.IC1016, M.IC1033 ' +
                'From ICP010 AS M ' +
                'Where M.IC1028 = ' + Ap + %EditC(NDX002:'X') + Ap + Sp +
                                  'AND M.IC1037 = ' + Ap + %Trim(SELCFN) +
                                   Ap + Sp +
                'Order By M.IC1037, M.IC1013 ' +
                'For Read Only' ;
          When Type = 'LN';
            CsrSel =
                'Select M.IC010Index, M.IC1007, ' +
                'M.IC1004, M.IC1003, M.IC1011, ' +
                'M.IC1012, M.IC1013, M.IC1016, M.IC1033 ' +
                'From ICP010 AS M ' +
                'Where M.IC1028 = ' + Ap + %EditC(NDX002:'X') + Ap + Sp +
                                  'AND M.IC1038 = ' + Ap + %Trim(SELCLN) +
                                   Ap + Sp +
                'Order By M.IC1038, M.IC1013 ' +
                'For Read Only' ;
          When Type = 'PA';
            CsrSel =
                'Select M.IC010Index, M.IC1007, ' +
                'M.IC1004, M.IC1003, M.IC1011, ' +
                'M.IC1012, M.IC1013, M.IC1016, M.IC1033 ' +
                'From ICP010 AS M ' +
                'Where M.IC1028 = ' + Ap + %EditC(NDX002:'X') + Ap + Sp +
                                  'AND SUBSTRING(M.IC1016, 2, 3)  >= ' + Ap +
                                   S01PAC + Ap + Sp +
                'Order By SUBSTRING(M.IC1016,2,3), M.IC1032 ' +
                'For Read Only' ;
          When Type = 'ST';
            CsrSel =
                'Select M.IC010Index, M.IC1007, ' +
                'M.IC1004, M.IC1003, M.IC1011, ' +
                'M.IC1012, M.IC1013, M.IC1016, M.IC1033 ' +
                'From ICP010 AS M ' +
                'Where M.IC1028 = ' + Ap + %EditC(NDX002:'X') + Ap + Sp +
                                  'AND M.IC1012 >= ' + Ap + %Trim(S01ST) +
                                   Ap + Sp +
                'Order By M.IC1012, M.IC1013 ' +
                'For Read Only' ;
          When Type = 'ZC';
            CsrSel =
                'Select M.IC010Index, M.IC1007, ' +
                'M.IC1004, M.IC1003, M.IC1011, ' +
                'M.IC1012, M.IC1013, M.IC1016, M.IC1033 ' +
                'From ICP010 AS M ' +
                'Where M.IC1028 = ' + Ap + %EditC(NDX002:'X') + Ap + Sp +
                                  'AND M.IC1013 >= ' + Ap + %Trim(S01ZIP) +
                                   Ap + Sp +
                'Order By M.IC1013, M.IC1011 ' +
                'For Read Only' ;
          EndSl;
       EndSr;
       //*-------------------------------------------------------
       // SendMsg: Send to the Message Subfile
       BegSr SendMsg;

          SpLen = %LEN(AwMSgDta);

          CallP QMHSNDPM(AwMsgID
                 :AwMsgF
                 :AwMsgDta
                 :SpLen
                 :apTyp
                 :apQue
                 :SpStk
                 :SpKy
                 :spErr);

       EndSr;
       //* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** **
       // ClrMsg: Clear the Message Subfile
       BegSr ClrMsg;

          CallP QMHRMVPM(SpStk1
                 :SpCsc
                 :apMsk
                 :apMsr
                 :spErc);

       EndSr;
       //* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** **
       End-Proc ICM10SEL;
       //--------------------------------------------------------
       //  close10S - Close the table cursor
       //--------------------------------------------------------
       Dcl-Proc close10S ;
       Dcl-PI close10S  End-PI ;
         Exec SQL close Cursor;
         End-Proc;
       //--------------------------------------------------------
       //  fetchMult10S - read the entire table
       //--------------------------------------------------------
       Dcl-Proc fetchMult10S ;
       Dcl-PI fetchMult10S IND End-PI ;
       Exec SQL
         fetch next from Cursor
         For :Mult_Row rows
         into :PgmData;
       Exec SQL Get Diagnostics :Tot_Read = ROW_COUNT ;
       //
       If SQLSTT < '020000';
          Return *ON;
       Else;
          Return *OFF;
       EndIf;
       //
       End-Proc;
       //---------------------------------------------------------------------
       //  open10S  - Open a cursor to read the filter code file
       //---------------------------------------------------------------------
       Dcl-Proc open10S ;

       Dcl-PI Open10S  End-PI ;
       Exec SQL prepare wkStatement from :CsrSel ;
       //
       Exec SQL declare Cursor cursor for wkStatement ;
       // *
       Exec SQL open Cursor ;
       // *
       End-Proc;
       // ---------------------------------------------------------------------
