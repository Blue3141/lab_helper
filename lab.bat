@echo off
title Helper laboratorio

if not "%1" == "" (
  if 1%1 NEQ +1%1 goto FLAGERR
  set Scelta=%1
  cd "%PATH_HELPER_LAB%\Es%1"
  if "%2"=="-c" goto COMPILA
  if "%2"=="-r" goto RUNNA
  goto FLAGERR
  timeout 3 > nul
  goto RICHIESTA
)

:RICHIESTA
cls
color 0A
echo.
echo -----------------------------------
echo   Helper per il laboratorio di LC
echo -----------------------------------
echo.
echo [ # ] - Apri le opzioni per l'esercizio n. #
echo [ p ] - Cambia il percorso della cartella home
echo [ g ] - Guida per l'utilizzo
echo [ e ] - Esci
echo.
set /p "Scelta=Scegli un'opzione: "
cls
if "%Scelta%"=="g" goto GUIDA
if "%Scelta%"=="p" goto PATHD
if "%Scelta%"=="e" goto ESCI
if 1%Scelta% NEQ +1%Scelta% goto RICHIESTAERR
if not exist "%PATH_HELPER_LAB%\Es%Scelta%" goto RICHIESTAERR
goto FILED

:RICHIESTAERR
cls
color 0C
echo.
echo -----------------------------------
echo   Helper per il laboratorio di LC
echo -----------------------------------
echo.
echo Inserisci un'opzione o un numero valido!
timeout 3 > nul
goto RICHIESTA

:FLAGERR
cls
color 0C
echo.
echo -----------------------------------
echo   Flag manager
echo -----------------------------------
echo.
echo Flag invalida! Avvio menu' normale.
timeout 3 > nul
goto RICHIESTA

:FILED
cd "%PATH_HELPER_LAB%\Es%Scelta%"
cls
color 0B
echo.
echo -----------------------------------
echo   Operazioni sull'esercizio n. %Scelta%
echo -----------------------------------
echo.
echo [ c ] - Compila i file .l e .y
echo [ r ] - Esegui il file Parser
echo [ z ] - Crea il file .zip da consegnare
echo [ h ] - Torna al menu' principale
echo [ e ] - Esci
echo.
set /p "Sceltafile=Scegli un'opzione: "
if "%Sceltafile%"=="c" goto COMPILA
if "%Sceltafile%"=="z" goto ZIPPA
if "%Sceltafile%"=="r" goto RUNNA
if "%Sceltafile%"=="h" goto RICHIESTA
if "%Sceltafile%"=="e" goto ESCI
goto FILEDERR

:COMPILA
cls
color 0B
echo.
echo -----------------------------------
echo   Compilazione file
echo -----------------------------------
echo.
echo Compilazione file .y ...
if not exist "%cd%\*.y" goto COMPILAERRY
for %%G in (""%cd%\*.y"") do (
    if "%%~xG"==".y" yacc -J %%~nxG && echo -- %%~nxG
)
echo -- Compilazione file .y completata!
echo.
echo Compilazione file .l ...
if not exist "%cd%\*.l" goto COMPILAERRL
for %%G in ("%cd%\*.l") do (
    if "%%~xG"==".l" echo -- %%~nxG && cmd.exe /c jflex %%~nxG
)
echo -- Compilazione file .l completata!
echo.
echo Compilazione file .java...
javac *.java
echo Compilazione file .java completata!
echo.
goto CUSTOMCM

:CUSTOMCM
echo Vuoi eseguire altri comandi?
set /p "Altro=(scrivili qui, oppure 'n' se no): "
if not "%Altro%"=="n" (
  cmd.exe /c %Altro%
  echo Eseguito!
  echo.
  goto CUSTOMCM
)
echo. Vuoi eseguire il Parser?
set /p "Esegui=('r' per si', altra lettera se no): "
if "%Esegui%"=="r" goto RUNNA
goto FILED

:ZIPPA
cls
color 0B
echo.
echo -----------------------------------
echo   Crea zip per la consegna
echo -----------------------------------
echo.
echo [ h ] - Torna al menu' principale
echo [ e ] - Esci
echo.
set /p "nome=Inserisci il nome desiderato per il file .zip: "
if "%nome%"=="h" goto RICHIESTA
if "%nome%"=="e" goto ESCI
if exist "%cd%\%nome%.zip" del "%cd%\%nome%.zip"
mkdir "%cd%\%nome%temp" > nul
for %%G in ("%cd%\*.y") do xcopy %%G "%cd%\%nome%temp" > nul
for %%G in ("%cd%\*.l") do xcopy %%G "%cd%\%nome%temp" > nul
powershell Compress-Archive "%cd%\%nome%temp\*" "%cd%\%nome%.zip" > nul 1 > nul
del /f /s /q "%cd%\%nome%temp" > nul
rmdir /s /q "%cd%\%nome%temp" > nul
echo.
echo File .zip creato!
timeout 5 > nul
goto FILED


:RUNNA
cls
color
echo.
cmd.exe /c java Parser
echo.
set /p "check=Premi 'r' per eseguire di nuovo, un altro tasto per uscire: "
if "%check%"=="r" goto RUNNA
goto FILED

:COMPILAERRY
cls
color 0C
echo.
echo -----------------------------------
echo   Compilazione file
echo -----------------------------------
echo.
echo Non c'e' alcun file .y nella tua directory!
timeout 3 > nul
goto FILED

:COMPILAERRL
cls
color 0C
echo.
echo -----------------------------------
echo   Compilazione file
echo -----------------------------------
echo.
echo Non c'e' alcun file .l nella tua directory!
timeout 3 > nul
goto FILED

:FILEDERR
cls
color 0C
echo.
echo -----------------------------------
echo   Operazioni sull'esercizio n. %Scelta%
echo -----------------------------------
echo.
echo Inserisci un'opzione valida!
timeout 3 > nul
goto FILED

:PATHD
cls
color 0E
echo.
echo -----------------------------------
echo   Imposta la home directory
echo -----------------------------------
echo.
echo Inserisci il percorso alla cartella contenente le varie
echo cartelle Es1, Es2,... in modo che il programma si possa
echo spostare nella cartella home per compilare i tuoi file.
echo Metti il percorso completo, per esempio C:\Users\ASUS\
echo.
echo [ h ] - Torna al menu' principale
echo [ e ] - Esci
echo.
echo Percorso attuale:
if "%PATH_HELPER_LAB%"=="" echo Non impostato
if not "%PATH_HELPER_LAB%"=="" echo %PATH_HELPER_LAB%
echo.
set /p "Pathd=Percorso: "
if "%Pathd%"=="h" goto RICHIESTA
if "%Pathd%"=="e" goto ESCI
if not exist "%Pathd%" goto PATHDERR
setx PATH_HELPER_LAB "%Pathd%"
echo.
echo Grazie! Dovrai chiudere e i seguito riavviare il prompt
echo dei comandi affinche' il cambio abbia effetto. L'helper
echo terminera' ora.
timeout 6 > nul
goto ESCI

:PATHDERR
cls
color 0C
echo.
echo -----------------------------------
echo   Imposta la home directory
echo -----------------------------------
echo.
echo Inserisci una directory valida!
timeout 3 > nul
goto PATHD

:GUIDA
cls
color 0E
echo.
echo -----------------------------------
echo   Guida all'uso dell'helper
echo -----------------------------------
echo.
echo ^<Versione: 1.0.0^>
echo ^<Ultimo aggiornamento: 18.11.2021^>
echo.
echo.
echo Questo e' un helper che ti puo' aiutare nella  gestione
echo e compilazione dei file per il laboratorio (.l e .h).
echo.
echo --------------------------
echo #1. Regole
echo.
echo L'helper funzionera' a patto che vengano rispettate due
echo regole (che servono a definire la struttura sulla quale
echo opera il programma).
echo.
echo %TAB% 1. Crea la cartella home (col nome che preferisci
echo %TAB% e messa dove vuoi) che conterra' cartelle, il cui
echo %TAB% nome sara' strutturato cosi': 'Es#', dove # e' un
echo %TAB% numero intero (senza segno please) che identifica
echo %TAB% un esercizio del laboratorio. Per questo per ogni
echo %TAB% esercizio dovrai creare una nuova cartella 'Es#',
echo %TAB% con numero a tua scelta, e mettere al suo interno
echo %TAB% i file .l e .y. La mia cartella per esempio e' in
echo %TAB% C:\Users\ASUS\Desktop, si chiama LABLC e contiene
echo %TAB% le directory di cinque esercizi:
echo.
echo %TAB% C:
echo %TAB% - Users
echo %TAB%   - ASUS
echo %TAB%     - Desktop
echo %TAB%       - LABLC
echo %TAB%         - Es1
echo %TAB%         - Es2
echo %TAB%         - Es3
echo %TAB%         - Es4
echo %TAB%           - InfDyck.l
echo %TAB%           - InfDyck.y
echo %TAB%         - Es5
echo.
echo %TAB% Puoi mettere anche altre cartelle o persino files
echo %TAB% all'interno della tua cartella home; l'importante
echo %TAB% e' seguire la nomenclatura per tutte le directory
echo %TAB% relative agli esercizi.
echo.
echo %TAB% 2. In ogni cartella 'Es#' metti i file di UN SOLO
echo %TAB% esercizio. Non mettere piu' file .y o .l: sebbene
echo %TAB% verrebbero compilati tutti avremmo un solo Parser
echo %TAB% (il primo verrebbe sovrascritto).
echo.
echo Finite le premesse occupiamoci della configurazione!
echo.
echo.
echo -------------------
echo #2. Configurazione
echo.
echo Se e' la prima volta che usi l'helper, devi:
echo.
echo %TAB% - Impostare la cartella home: entra nel programma
echo %TAB% e digita 'p', poi segui tutte le istruzioni (devi
echo %TAB% inserire il percorso della cartella home e quindi
echo.%TAB% riavviare il prompt). Chi vuole sapere di preciso
echo %TAB% cosa fa il programma sappia che questa operazione
echo %TAB% crea variabile d'ambiente chiamata
echo.
echo %TAB% PATH_HELPER_LAB
echo.
echo %TAB% (non la vedrai mai piu', ne' dovrai preoccuparti:
echo %TAB% e' utile nel programma). Volendo puoi modificarla
echo %TAB% anche dalle impostazioni avanzate di Windows.
echo.
echo %TAB% - [opzionale] Mettere questo file in una cartella
echo %TAB% (qualsiasi) e aggiungi il percorso della cartella
echo %TAB% nella variabile d'ambiente 'PATH'. In questo modo
echo %TAB% potrai eseguire questo helper da linea di comando
echo %TAB% ovunque tu sia semplicemente digitando il comando
echo %TAB% 'lab'. Forte, no? Altrimenti puoi copiare lab.bat
echo %TAB% sul Desktop e cliccarlo proprio  come se fosse un
echo %TAB% programma. A te la scelta!
echo.
echo.
echo -------------------
echo #3. Utilizzo
echo.
echo Cosa puoi fare con l'helper:
echo %TAB% - Compilare i file .y, .l, .java CON UN COMANDO!;
echo %TAB% - Eseguire il Parser;
echo %TAB% - Zippare i file .y e .l per la consegna (se c'e'
echo %TAB%   un omonimo .zip lo sovrascrive).
echo.
echo L'helper si sposta autonomamente tra le varie cartelle,
echo quindi non devi preoccuparti del dove lo fai partire. I
echo nuovi file creati saranno dentro alla cartella relativa
echo all'esercizio. Inoltre, se ti compaiono dei messaggi di
echo errore o di altro genere (tipo il saluto, quando esci),
echo puoi avanzare velocemente premendo una lettera o invio.
echo.
echo Avrai ogni volta un menu' e potrai scegliere cosa fare;
echo le spiegazioni sono (almeno spero) abbastanza chiare da
echo non richiedere ulteriori spiegazioni; se avtee domande,
echo sapete chi sono, avete il mio numero (o, almeno, il mio
echo  Telegram)...scrivimi.
echo Tanto sono abituata alla gente che mi scrive :)
echo.
echo TUTTAVIA, per la gente brava che ha letto fin qui, ecco
echo THE MASTER'S COMMAND: 'lab # [-c/-r]'. In pratica: puoi
echo direttamente far partire la compilazione senza navigare
echo fra i menu' mettendo due parametri dopo il comando lab,
echo ossia il numero dell'esercizio e '-c' se vuoi compilare
echo (ed nel caso anche runnare) e '-r' se vuoi solo runnare
echo Parser. Quest'ultimo e' comodo perche' puoi eseguire il
echo tuo Parser senza navigare fino alla cartella (sempre se
echo  hai messo questo meraviglioso bat nel PATH). Questa e'
echo l'apoteosi della velocita'!
echo.
echo.
echo.
echo -------------------------------------------------------
echo.
echo Spero che ti sia utile; se hai domande scrivimi!
echo.
echo - Chiara [CdL Informatica @UNIMIB - II anno]
echo ( che ringrazia il prof. Dominoni per aver annullato la
echo   la lezione e aver quindi concesso un poco di tempo in
echo   piu' per dormire...ah no, per programmare )
echo.
echo -------------------------------------------------------
echo.
echo Premi qualsiasi lettera per tornare al menu' principale
pause > nul
goto RICHIESTA

:ESCI
cls
color 0F
echo.
echo -----------------------------------
echo   Grazie per aver usato l'helper!
echo -----------------------------------
echo.
timeout 3 > nul
cls
color
title Linea di comando
exit /b
