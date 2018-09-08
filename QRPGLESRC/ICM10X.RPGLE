     H DFTNAME(ICM10X) NOMAIN  ALWNULL(*USRCTL)
      // Contact selection pop-up window
     FICD10X    CF   E             WORKSTN USROPN
     FICP010    IF   E           K DISK    RENAME(ICP010:ICP010R) USROPN
      // Prototypes
     D/Copy QRPGLESRC,ICT100
      //---------------------------------------------------------------------
     P ICM10X          B                   EXPORT
      //
     D ICM10X          PI             2A
     D INDEX010                       9S 0
      // Stand Alone Fields
     D EOJ             S              2    INZ('  ')
     D HIT             S              2    INZ('  ')
     D NDX010          S              9S 0
     D Open010         S               N
     D Use             S               N
      //---------------------------------------------------------------------
      /FREE
       If NOT %Open(ICD10X);
         Open ICD10X;
       EndIf;
       // ICP010
       If NOT %Open(ICP010);
         Open ICP010;
         Open010 = *ON;
       Else;
         Open010 = *OFF;
       EndIf;
       // Get the Contact selected
       NDX010 = INDEX010;
       Chain NDX010 ICP010;
       If %Found(ICP010);
         //**
         DoW EOJ = *Blanks;
           //
           ExFmt ICD10XW1;
           //
           If *IN05 = *ON;
             EOJ = '**';
           EndIf;
           //
           If *IN12 = *ON;
             EOJ = '12';
           EndIf;
           //
         EndDo;
         //**
       EndIf;
       //
       Close ICD10X;
       // ICP010
       If Open010 = *ON;
         Close ICP010;
         Open010 = *OFF;
       EndIf;
       //
       Return EOJ;
       //
      /END-FREE
     P ICM10X          E
      //---------------------------------------------------------------------
