	IDENTIFICATION DIVISION.
	PROGRAM-ID. MUH99.
	AUTHOR. EROKOM AS.
*******************************************************************
*********  MUHGUN DEKI GUNLUK HAREKETLERI MUHYIL'A ILAVE ETME *****
********* SIRKET KODU   : 1                                   *****
********* HESAP NO TIPI : 283/3                               *****
********* FIRMA         : YUKSEL KAHVE                        *****
********* TARIH         : 21/04/1985                          *****
*******************************************************************
	ENVIRONMENT DIVISION.
	CONFIGURATION SECTION.
	SOURCE-COMPUTER. NCR-PC.
	OBJECT-COMPUTER. NCR-PC.
	SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
	INPUT-OUTPUT SECTION.
	FILE-CONTROL.
		SELECT MUHGUN ASSIGN TO RANDOM "GUNLUK.DAT"
			ORGANIZATION IS INDEXED
			ACCESS MODE IS SEQUENTIAL
			RECORD KEY IS HYUKNO
		       ALTERNATE RECORD KEY IS HFISKEY WITH DUPLICATES 
		       ALTERNATE RECORD KEY IS HFISNO  WITH DUPLICATES.
		SELECT MUHYIL ASSIGN TO RANDOM "YENI.DAT"
			ORGANIZATION IS INDEXED
			ACCESS MODE IS RANDOM
			RECORD KEY IS YHYUKNO
			ALTERNATE RECORD KEY YHFISNO  WITH DUPLICATES;
			ALTERNATE RECORD KEY YHFISKEY WITH DUPLICATES.
	DATA DIVISION.
	FILE SECTION.
		COPY "MUHGUN.COP".
	FD	MUHYIL	LABEL RECORDS STANDARD.
	01	YHARKAY.
		02 YHYUKNO			PIC X(5).
		02 YHFISKEY.
			03 YHTRH.
			   04 YHYIL		PIC X(2).
			   04 YHAY 		PIC X(2).
			   04 YHGUN		PIC X(2).
			03 YHFISNO		PIC X(5).
		02 YHHESNO			PIC X(9).
		02 YHIZH			PIC X(39).
		02 YHBA				PIC X(1).
		02 YHTL				PIC 9(9)V99 COMP-3.
	WORKING-STORAGE SECTION.
	77   CEV	PIC X(1) VALUE SPACES.
	77   SOKU	PIC 9(5) VALUE ZERO.
	77   SYAZ	PIC 9(5) VALUE ZERO.
	77	GOS	PIC Z(5).
	77	WBORC		PIC 9(11)V99 VALUE ZERO.
	77	WALAC		PIC 9(11)V99 VALUE ZERO.
	77	ZTL  		PIC ZZ.ZZZ.ZZZ.ZZZ,ZZ.
        77      WYUKNO          PIC 9(5) VALUE 70000.
	PROCEDURE DIVISION.
	BASLA.
		OPEN INPUT MUHGUN OUTPUT MUHYIL.
		DISPLAY SPACE ERASE.
		DISPLAY "BINDALLI/METMAK" LINE 1 POSITION 1 REVERSE.
		DISPLAY "GUNLUK MUHASEBE HAREKETLERINI YILLIGA TASIMA"
			LINE 2 POSITION 25.
		DISPLAY "--------------------------------------------"
			LINE 3 POSITION 25.
		DISPLAY "ISE BASLAMAK ICIN [ B ] GIRIN ? [   ]"
			LINE 5 POSITION 25.
		ACCEPT CEV LINE 5 POSITION 59 TAB.
		IF CEV NOT = "B" GO TO KAPAT.
		DISPLAY SPACES LINE 5 POSITION 1 SIZE 80.
		DISPLAY " OKUNAN GUNLUK HAREKET :" LINE 5 POSITION 25.
		DISPLAY "YAZILAN YILLIK HAREKET :" LINE 7 POSITION 25.
	OKU.
		READ MUHGUN WITH NO LOCK AT END GO TO SON.
		ADD 1 TO SOKU.
		MOVE SOKU TO GOS.
		DISPLAY GOS LINE 5 POSITION 49.
		ADD 1 TO WYUKNO.
		MOVE WYUKNO TO HYUKNO.
		MOVE HYUKNO TO YHYUKNO.
		MOVE HTRH TO YHTRH.
		MOVE HFISNO TO YHFISNO.
		MOVE HHESNO TO YHHESNO.
		MOVE HIZH TO YHIZH.
		MOVE HTL TO YHTL.
		MOVE HBA TO YHBA.
		WRITE YHARKAY INVALID KEY
			DISPLAY HYUKNO LINE 15 POSITION 1
			DISPLAY "SIRA NOLU GUNLUK KAYIT MUHYIL'DA VAR"
				LINE 15 POSITION 7
			GO TO OKU.
		IF HBA = "A" ADD HTL TO WALAC
			     ELSE
			     ADD HTL TO WBORC.
		MOVE WYUKNO TO GOS.
		DISPLAY GOS LINE 7 POSITION 49.
		GO TO OKU.
	SON.
		DISPLAY "TASINAN HAREKETLERIN YEKUNU"
			LINE 20 POSITION 25.
		DISPLAY "---------------------------"
			LINE 21 POSITION 25.
		DISPLAY "ALACAK :" LINE 22 POSITION 25.
		DISPLAY "  BORC :" LINE 23 POSITION 25.
		MOVE WALAC TO ZTL.
		DISPLAY ZTL LINE 22 POSITION 33.
		MOVE WBORC TO ZTL.
		DISPLAY ZTL LINE 23 POSITION 33.
		ACCEPT CEV LINE 24 POSITION 25.
	KAPAT.
		CLOSE MUHGUN MUHYIL.
		STOP RUN.
