


# Lab helper
#### Versione: 1.0.0 - Ultimo aggiornamento: 18.11.2021

Questa repository contiene un helper (per Windows) che gli studenti frequentanti il corso di laurea in Informatica in Bicocca possono usare durante il laboratorio di Linguaggi e Computabilità per velocizzare le operazioni di compilazione dei file ed esecuzione degli stessi (file .l e .h).

Le istruzioni sotto riportate sono reperibili anche nel programma stesso.

## Regole 
L'helper funzionerà a patto che vengano rispettate due regole (che servono a definire la struttura sulla quale opera il programma). 
1. Crea la cartella home (col nome che preferisci e messa dove vuoi) che conterrà cartelle, il cui nome sarà strutturato così: 'Es#', dove # è un numero intero (senza segno) che identifica un esercizio del laboratorio. Per questo per ogni esercizio dovrai creare una nuova cartella 'Es#', con numero a tua scelta, e mettere al suo interno i file .l e .y. Puoi mettere anche altre cartelle o persino file all'interno della tua cartella home; l'importante è seguire la nomenclatura per tutte le directory relative agli esercizi. La mia cartella home, per esempio, è in C:\Users\ASUS\Desktop, si chiama LABLC e contiene le directory di cinque esercizi: 
	 - C: 
		 - Users 
			 - ASUS 
				 - Desktop 
					 - LABLC 
						 - Es1 
						 - Es2 
						 - Es4 
							 - InfDyck.l 
							 - InfDyck.y 
						 - Es5 

2. In ogni cartella 'Es#' metti i file di UN SOLO esercizio. Non mettere più file .y o .l: sebbene verrebbero compilati tutti avremmo un solo Parser (il primo verrebbe sovrascritto). 

## Configurazione 
Se è la prima volta che usi l'helper devi: 
- Impostare la cartella home: entra nel programma e digita 'p', poi segui tutte le istruzioni (devi inserire il percorso della cartella home e quindi riavviare il prompt). Chi vuole sapere di preciso cosa fa il programma sappia che questa operazione crea variabile d'ambiente chiamata PATH_HELPER_LAB (non la vedrai mai più, né dovrai preoccuparti: è utile nel programma). Volendo puoi modificarla anche dalle impostazioni avanzate di Windows. 
- [opzionale] Mettere questo file in una cartella (qualsiasi) e aggiungere il percorso della cartella nella variabile d'ambiente 'PATH'. In questo modo potrai eseguire questo helper da linea di comando ovunque tu sia semplicemente digitando il comando 'lab'. Altrimenti puoi copiare lab.bat sul Desktop e cliccarlo proprio come se fosse un programma. 

## Utilizzo 
Cosa puoi fare con l'helper: 
- Compilare i file .y, .l, .java 
- Eseguire il Parser
- Zippare i file .y e .l per la consegna (se c’è un omonimo .zip lo sovrascrive)

L'helper si sposta autonomamente tra le varie cartelle, quindi non devi preoccuparti del dove lo fai partire. I nuovi file creati saranno dentro alla cartella relativa all'esercizio. Inoltre, se ti compaiono dei messaggi di errore o di altro genere (tipo il saluto, quando esci), puoi avanzare velocemente premendo una lettera o invio. Avrai ogni volta un menù e potrai scegliere cosa fare; le spiegazioni sono (almeno spero) abbastanza chiare da non richiedere ulteriori spiegazioni.

Il comando per gli *expert users* è `lab # [-c/-r]`: puoi direttamente far partire la compilazione senza navigare fra i menù mettendo due parametri dopo il comando lab, ossia il numero dell'esercizio e '-c' se vuoi compilare (ed nel caso anche runnare) e '-r' se vuoi solo runnare Parser. Quindi, se si è aggiunto il percorso del file alla variabile PATH, si può chiamare il comando appena aperto il prompt, senza doversi spostare nelle cartelle. Se si vuole per esempio compilare e poi eseguire i file nella cartella 2, il comando è `lab 2 -c`.
