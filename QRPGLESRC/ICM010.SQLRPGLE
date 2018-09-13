       Ctl-Opt DFTNAME(ICM010) BNDDIR('ICB010')  ALWNULL(*USRCTL)
               DEBUG
               OPTION(*NODEBUGIO: *SRCSTMT)
               COPYRIGHT('SHandB, LLC 2009/2012');
       //  Customer demographic maintenance and quick quote
       // ************************************************************************
       // *  This is the "A/E" version that selects contacts that belong to     **
       // *  the A/E that is "signed on".                                       **
       // *  The primary search is by call back date                            **
       // *  Today's date will be used for the default when the program starts  **
       // ************************************************************************
       Dcl-F ICD010         WORKSTN INFDS(DSPDS);
       //  Prototypes
       Dcl-PR $command                 extpgm('QCMDEXC');
          command                  Char(5000) options(*varsize);
          Length                 Packed(15:5);
       End-PR;
      /Copy QRPGLESRC,ICT001
      /Copy QRPGLESRC,ICT10AG
      /Copy QRPGLESRC,ICT100
      /Copy QRPGLESRC,UTT001
       //  Array definitions
       Dcl-S NW7                   Char(1) DIM(7);                          // RIGHT ADJ CONTNO.
       Dcl-S NW10                  Char(1) DIM(10);                         // FULL CONT. CHAR.
       //  Data structures
       Dcl-DS *N;
          DATE8                   Zoned(8:0);
          CC8                     Zoned(2:0) Pos(1);
          YY8                     Zoned(2:0) Pos(3);
          YEAR4                    Char(4) Pos(1);
          MM8                     Zoned(2:0) Pos(5);
          MMC                      Char(2) Pos(5);
          DD8                     Zoned(2:0) Pos(7);
          DDC                      Char(2) Pos(7);
       End-DS;
       Dcl-DS *N;
          DATE6                   Zoned(6:0);
          MM6                     Zoned(2:0) Pos(1);
          DD6                     Zoned(2:0) Pos(3);
          YY6                     Zoned(2:0) Pos(5);
       End-DS;

       Dcl-DS *N;
          CS7                      Char(7);
          CUS7                     Char(7) Pos(1);
       End-DS;
       Dcl-DS *N;
          CALTXT                   Char(100) Pos(1);
       End-DS;
       Dcl-DS DSPDS;
          CSRLOC                 BinDec(4:0) Pos(370);
          SF1CRN                 BinDec(4:0) Pos(376);
       End-DS;
       Dcl-DS SDS                      PSDS;
          Pgmnam                       *PROC;
          PgmPar                  Zoned(3:0) Pos(37);
          Wkstid                   Char(10) Pos(244);
          PGMUSR                   Char(10) Pos(254);
       End-DS;
       //  CHARACTER STRINGS FOR LOWER TO UPPER CASE STRING CONVERSION
       Dcl-C UP                        CONST('ABCDEFGHIJKLMNOPQRS-
       TUVWXYZ');
       Dcl-C LO                        CONST('abcdefghijklmnopqrs-
       tuvwxyz');
       //  Stand Alone Fields
       Dcl-S AC                  Packed(2:0);
       Dcl-S ARCUST                Char(10);
       Dcl-S CALDAT                Char(6);
       Dcl-S CBDATE6              Zoned(6:0);
       Dcl-S COIN                  Char(30);
       Dcl-S CUSTCITY              Char(20);
       Dcl-S CUSTFN                Char(15);
       Dcl-S CUSTLN                Char(17);
       Dcl-S CUSTPAC               Char(3);
       Dcl-S CUSTST                Char(2);
       Dcl-S CUSTZIP               Char(5);
       Dcl-S COLM                   Int(5:0);
       Dcl-S CONTIN6              Zoned(6:0);
       Dcl-S CUSTNO               Zoned(6:0) ;
       Dcl-S EOJ                   Char(2);
       Dcl-S First                  Ind Inz(*ON);
       Dcl-S LINE                   Int(5:0);
       Dcl-S NDX002               Zoned(9:0) ;
       Dcl-S NDX010               Zoned(9:0);
       Dcl-S SCANYN                Char(1);
       Dcl-S Scrn#                  Int(3:0) Inz(1);
       Dcl-S Sp                    Char(1) INZ(' ');
       Dcl-S Today                 Date INZ(*Sys);
       //  First cycle only
          If First = *ON;
            // Get the program user's information
            Exec SQL
                 Select IC002INDEX, IC0203 Into :NDX002, :USER
                 From ICP002
                 Where IC0202 = :PGMUSR ;
            If NDX002 = *Zero;
              Exfmt ICD010ER;
              Scrn# = *Zero;
            EndIf;
            // get today's date
            CBDATE = %Dec(Today:*mdy);
            //
            Row = 6;
            Col = 42;
            //
            First = *OFF;
            //
          EndIf;
          // M A I N   L I N E
          DoW SCRN# = 1;
            ExFmt ICD01001;
            Error65 = *blanks;
            //*
            Select;
            // E.O.J. selected                                                         *IN03
            When *IN03 = *ON;
              SCRN# = *ZERO;
            // Calendar look up was selected
            When *IN04 = *ON;
              Line = %Div(CSRLOC:256);
              If Line = 8;
                UTMCALDS = UTMCAL(Year4:MMc:DDc);
                If EOJCAL = '**';
                  Year4 = p_outYear;
                  MMC = p_outMth;
                  DDC = p_out;
                  MM6 = MM8;
                  DD6 = DD8;
                  YY6 = YY8;
                  CBDATE = DATE6;
                EndIf;
              EndIf;
              Row = 8;
              Col = 42;
          // Add a new contact was selected
          When *IN06 = *ON;
            Exsr AddCust;
          When ContIN <> *Zeros;
            NDX010 = *Zeros;
            CONTIN6 = CONTIN;
            Exec SQL
              Select IC010INDEX Into :NDX010
                From ICP010
                Where IC1002 = :ContIn6;
            If NDX010 = *Zeros;
              Error65 = 'Invalid Customer Number was entered';
            Else;
              ExSR UpdCust;
            EndIf;
          Other;
            CBDATE6 = CBDATE;
            ICM10SELDS = ICM10SEL(NDX002:CBDATE6);
          EndSl;
        EndDo;
        If Scrn# = *Zero;
          *INLR = *ON;
        EndIf;
       //  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **
       // Call the add program
       BegSr AddCust;
         //
         ICM012DS = ICM012(NDX002);
         //
         Select;
           When EOJ012 = '**';
             NDX010 = INDEX012;
             Exec SQL
               Select IC1002 INTO :CUSTNO
               From ICP010
               Where IC010INDEX = :NDX010;
                 Error65 = 'Customer No: ' +
                     %EditC(CUSTNO:'Z') + ' has been added';
              //
           When EOJ012 = '12';
             Error65 = 'Previous was selected';
         EndSl;
         //
       EndSr;
       //  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **
       // Call the update program
       BegSr UpdCust;
         //
         EOJ = ICM011(NDX002:NDX010);
         //
         If CONTIN = *Zeros;
           Exec SQL
             Select IC1002 INTO :CONTIN
               From ICP010
               Where IC010INDEX = :NDX010;
         EndIf;
         Select;
           When EOJ = '**';
             Error65 = 'Contact No: ' +
                       %Trim(%EditC(CONTIN:'Z')) + ' has been updated';
           When EOJ = '12';
              Error65 = 'Previous was selected';
         EndSl;
         ContIN = *Zeros;
         //
       EndSr;
       //******************************************************************
