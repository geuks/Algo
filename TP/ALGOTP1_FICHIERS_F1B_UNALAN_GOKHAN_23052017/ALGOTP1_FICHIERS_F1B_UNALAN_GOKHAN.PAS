{***************************BUT****PRINCIPAL****************************************
	*
	 *_CREATEUR:UNALAN Gökhan
	 *
	 *______BUT:Programme qui conjugues et créer les verbes 1er/2eme/3eme groupe dans un autre fichier
	 *
	 *___ENTREE:un fichier avec differents verbes
	 *
	 *___SORTIE:crér un fichier avec les verbes conjugué
	 *
	*
***********************************************************************************}
program ALGOTP1_FICHIERS_F1B_UNALAN_GOKHAN;

uses crt;

const
	VERBES='RIRE,RECEVOIR,ALLER,BOUILLIR,ENVOYER,PEINDRE,HABITER,PAYER,MOURIR,HAIR,VOULOIR,FINIR,S''AMUSER';

type
	groupe=(isok,premier,deuzieme,troizieme);
type
	tVerbe=array [1..50] of string;

{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT: affiche a l'écran les donnée d'un fichier
	 *__ENTREE: 1 fichier type Text, 1 chaine en parametre et 1 chaine en local
	 *__SORTIE:fichier afficher à l'écran
*********************************************************************************}
procedure afficher_fichier(var fichier:Text; chemin:string);
var
	nom:string;
begin
	nom:='';
	assign(fichier,chemin); 	// assigne
	reset(fichier);	//ouvrir
	while not EoF(fichier) do	//boucle pour chaque ligne jusqua la fin
	begin
		readln(fichier,nom);		//ecrire la ligne dans la variable
		writeln(nom);		//affiche la variable
	end;
	close(fichier);	//ferme le fichier
	readln;
	writeln('Appuiyer sur entree');
end;


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT: créer un fichier avec le nombre de verbes à l'interieur
	 *__ENTREE: 1 fichier type Text, 1 chaine , 1 entier et 1 type tVerbe en parametre
	*					1 chaine et 1 entier en local
	 *__SORTIE:fichier créer avec les verbes
*********************************************************************************}
procedure create_fichier(var fichier:Text; chemin:string; var nbrVerbe:integer; var listVerbe:tVerbe);
var
	verbe:string;
	i:integer;
begin
	verbe:='';
	nbrVerbe:=1;

	assign(fichier,chemin);
	rewrite(fichier);
	
	for i:=1 to Length(VERBES) do
	begin
		if VERBES[i]<>',' then
			verbe:=verbe+VERBES[i]
		else
		begin
			writeln(fichier,verbe);
			listVerbe[nbrVerbe]:=verbe;
			verbe:='';
			nbrVerbe:=nbrVerbe+1;
		end;
	end;
	close(fichier);
end;


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT: determine le groupe d'un verbe
	 *__ENTREE: 1 chaine en parametre et 1 chaine, 1 entier, 1 type groupe en local
	 *__SORTIE:1 type groupe
*********************************************************************************}
function groupe_verbe(verbe:string):groupe;
var
	terminaison:string;
  lgch:integer;
	test:groupe;
begin
	test:=isok;
	verbe:=lowercase(verbe);
	lgch:=length(verbe);
	terminaison:=copy(verbe,lgch-1,lgch);

	if (terminaison='er') and (verbe<>'aller') then
		test:=premier
	else	
		if (terminaison='ir') and (verbe<>'mourir') and (verbe<>'recevoir') then
			test:=deuzieme
		else
			test:=troizieme;
	groupe_verbe:=test;
end;


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT: ecrit dans un fichier le verbe du premier groupe conjugué
	 *__ENTREE: 1 fichier type text en parametre, 1 entier et 2 chaine en local
	 *__SORTIE:ecrit dans le fichier le verbe conjugué
*********************************************************************************}
procedure ecrit_premier(var fichier:Text; chemin,verbe:string);
var
  lgch:integer;
  terminaison,radical:string;
begin
	verbe:=lowercase(verbe);
	lgch:=length(verbe);
	terminaison:=copy(verbe,lgch-1,lgch);
	radical:=copy(verbe,0,lgch-2);

	assign(fichier,chemin);
	append(fichier);
	
	{if (verbe<>'aller') then
	begin
		if (verbe[1]<>'h') and (verbe[1]<>'e') then
			writeln(fichier,'je'+radical+'e')
		else
			writeln(fichier,'j'''+radical+'e');

		writeln(fichier,'tu '+radical+'es');
		writeln(fichier,'il/elle/on '+radical+'e');
		writeln(fichier,'nous '+radical+'ons');
		writeln(fichier,'vous '+radical+'ez');
		writeln(fichier,'ils '+radical+'ent');
	end
	else
	begin
		writeln(fichier,'je vais');
		writeln(fichier,'tu vas');
		writeln(fichier,'il/elle/on va');
		writeln(fichier,'nous allons');
		writeln(fichier,'vous allez');
		writeln(fichier,'ils vont');
	end;}
	
	close(fichier);
	
	if (verbe<>'aller') then
	begin
		if (verbe[1]<>'h') and (verbe[1]<>'e') then
			writeln('je'+radical+'e')
		else
			writeln('j'''+radical+'e');

		writeln('tu '+radical+'es');
		writeln('il/elle/on '+radical+'e');
		writeln('nous '+radical+'ons');
		writeln('vous '+radical+'ez');
		writeln('ils '+radical+'ent');
	end
	else
	begin
		writeln('je vais');
		writeln('tu vas');
		writeln('il/elle/on va');
		writeln('nous allons');
		writeln('vous allez');
		writeln('ils vont');
	end;
		
end;


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT: ecrit dans un fichier le verbe du second groupe conjugué
	 *__ENTREE:
	 *__SORTIE:
*********************************************************************************}
procedure ecrit_deuzieme(var fichier:Text; chemin,verbe:string);
var
	lgch:integer;
  terminaison,radical:string;
begin
	verbe:=lowercase(verbe);
	lgch:=length(verbe);
	terminaison:=copy(verbe,lgch-1,lgch);
	radical:=copy(verbe,0,lgch-2);
	
	assign(fichier,chemin);
	append(fichier);
	
	if (verbe<>'finir') and (verbe[Length(radical)]<>'o') and (verbe<>'recevoir')then
	begin
		writeln('je '+radical+'is');
		writeln('tu '+radical+'is');
		writeln('il/elle/on '+radical+'it');
		writeln('nous '+radical+'ons');
		writeln('vous '+radical+'ez');
		writeln('ils '+radical+'ent');
	end;
	{else
		if(verbe='finir') then
		begin
		
		end}
	close(fichier);
end;


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT: Test tout les verbes et les mets par groupe
	 *__ENTREE: 1 fichier type Text, 1 entier et 1 tableau tVerbe en parametre
	 *					1 type groupe, 1 entier et 1 chaine en local
	 *__SORTIE:
*********************************************************************************}
procedure conjuguer_fichier(var fichier2:Text; nbrVerbe:integer; listVerbe:tVerbe);
var
	grp:groupe;
  i:integer;
	nom:string;
begin
	
	for i:=1 to nbrVerbe-1 do
	begin
		grp:=isok;
		grp:=groupe_verbe(listVerbe[i]);

		case grp of
			premier:ecrit_premier(fichier2,'verbeconjuguer.txt',listVerbe[i]);
			deuzieme:ecrit_deuzieme(fichier2,'verbeconjuguer.txt',listVerbe[i]);
			troizieme:writeln('troizieme')
		end;
		
	end;
	writeln('Verbes conjuguer!');
	readln;
end;


var
	fichier1,fichier2:Text;
	listVerbe:tVerbe;
	choix,nbrVerbe,i:integer;
begin
	repeat
		clrscr;
		nbrVerbe:=1;
		
		create_fichier(fichier1,'verbes.txt',nbrVerbe,listVerbe);
		
		assign(fichier2,'verbeconjuguer.txt');
		rewrite(fichier2);
		write(fichier2,'Verbe Conjuguer');
		close(fichier2);
		
		writeln('1: Lire Fichier Verbe');
		writeln('2: Conjuguer le fichier');
		writeln('3: Afficher le fichier conjuguer');
		writeln('0: Quitter');
		
		write('Choix: ');
		readln(choix);
		
		case choix of
			1:afficher_fichier(fichier1, 'verbes.txt');
			2:conjuguer_fichier(fichier2,nbrVerbe, listVerbe);
			3:afficher_fichier(fichier2, 'verbeconjuguer.txt');
		end;
		
	until choix=0;
	
	readln;
end.


//**************************FIN****PRINCIPAL****************************************
