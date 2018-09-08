       Ctl-Opt dftname(TEST10SEL) ;
       Ctl-Opt DEBUG ;
       Ctl-Opt Option(*NODEBUGIO :*SRCSTMT) ;
       //*  TEST10SEL - Test the A/E Customer Look module
     D/Copy QRPGLESRC,ICT10AG
       Dcl-DS *N                       PSDS;
          SUSER                    Char(10) Pos(254);
       End-DS;
       Dcl-DS *N;
          TStamp              TimeStamp INZ(*SYS);
          TScc                    Zoned(2:0) Overlay(TStamp);
          TSyy                    Zoned(2:0) Overlay(TStamp:3);
          TSmm                    Zoned(2:0) Overlay(TStamp:6);
          TSdd                    Zoned(2:0) Overlay(TStamp:9);
          DateIn                   Date Overlay(TStamp);
          TShr                    Zoned(2:0) Overlay(TStamp:12);
          TSmn                    Zoned(2:0) Overlay(TStamp:15);
          TSsc                    Zoned(2:0) Overlay(TStamp:18);
       End-DS;
       // Stand alone fields
       Dcl-S CBDATE      Zoned(6:0) Inz(090918);
       Dcl-S NDX002      Zoned(9:0) Inz ;
       Dcl-S USER        Char(30) Inz ;
       Dcl-S UsrName     Char(64) Inz ;
       Dcl-S UNLen      Int(10:0) Inz(30) ;
       // Get the A/E index
       Exec SQL
         Select IC002INDEX, IC0203 Into :NDX002, :USRNAME from ICP002
                Where IC0202 = :SUSER ;
       ICM10SELDS = ICM10SEL(NDX002:CBDATE) ;

       *INLR = *ON;
