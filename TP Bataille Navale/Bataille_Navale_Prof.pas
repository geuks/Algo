//BUT:le jeu de la bataille navale
//ENTREE:1 coordonnée
//SORTIE:touché coulé
program Bataille_Navale_Prof;

uses crt,sysutils;

//Constantes
CONST
	NBBATEAU=5;	//nbr bateau max
	MAXCASE=5;	//nbr de case par bateau (MIN:3)
	MINL=1;	//nbr ligne minimum de la map
	MAXL=50;	//nbr ligne maximum de la map
	MINC=1;	//nbr de colonne minimum
	MAXC=50;	//nbr de colonne maximum

//Type énum
Type
	positionBateau=(enLigne,enColonne,enDiag);	//position du bateau
	etatBateau=(toucher,couler);	//l'état d'un bateau si il est touché ou non
	etatFlotte=(aFlot,aSombrer);	//l'état d'une flotte si elle a sombrer ou non
	etatJoueur=(gagne,perd);	//l'état des joueurs si il gagne ou perde


//Type enregistrement
type
	cellule=record
		ligne:integer;
		col:integer;
	end;
	
	bateau=record
		nCase:array [1..MAXCASE] of cellule;
		taille:integer;
	end;
	
	flotte=record
		nBateau:array [1..NBBATEAU] of bateau;
	end;
	

//Fonction & Procédures
//BUT:calcul la taille d'un bateau
//ENTREE:1 type bateau 2 entier
//SORTIE:1 entier (taille du bateau)
function tailleBateau(nBateau:bateau):integer;
var
	i:integer; //boucle
	cpt:integer;	//compteur (case)
begin
	cpt:=0;

	for i:=1 to MAXCASE do
	begin
		
		//si la case est differente de 0 alors on incrément cpt
		if (nBateau.nCase[i].ligne<>0) or (nBateau.nCase[i].col<>0) then
			cpt:=cpt+1;
	end;
	
	tailleBateau:=cpt;
end;


//BUT:renvoi l'état du bateau si coulé
//ENTREE:1 type bateau 1 entier
//SORTIE:1 etatBateau (toucher ou non)
function etatBat(nBateau:bateau):etatBateau;
var
	etat:integer;		//taille du bateau apres etre toucher
begin
	etat:=tailleBateau(nBateau);
	//si etat(taille) du bateau est inferieur a la taille du bateau de base
	if (etat<nBateau.taille) and (etat>0) then etatBat:=toucher
	else if (etat=0) then etatBat:=couler;
end;


//BUT:renvoi l'état de la flotte si sombré
//ENTREE:1 type flotte 2 entier
//SORTIE:1 etatFlotte (sombré ou non)
function etatFlot(player:flotte):etatFlotte;
var
	i:integer;	//boucle
	cpt:integer;	//compteur de bateau
begin
	cpt:=0;

	for i:=1 to NBBATEAU do
	begin
		//si etatBat = couler on incrémente cpt
		if (etatBat(player.nBateau[i])=couler) then	cpt:=cpt+1;
		delay(10);//Monsieur si vous lisez ceci, il y a un probleme lorsque on enleve le writeln/ou le delay, le jeu fonctionne mal,
							//si un bateau coule le jeu se termine, alors que si on met un writeln ou un delay le jeu fonctionne correctement, c'est illogique.
	end;
	
	if cpt=NBBATEAU then etatFlot:=aSombrer
	else
		etatFlot:=aFlot;
end;



//BUT:Affecte les valeur x y a Pos
//ENTREE:1 tableau type PosCellule, 2 entier
//SORTIE:Tableau N valeur
PROCEDURE CreateCase(l,c:integer; VAR nCellule:cellule);
begin
	nCellule.ligne:=l;
	nCellule.col:=c;
end;


//BUT:Compare 2 cases
//ENTREE:2 variable type cases
//SORTIE:1 boolean
FUNCTION cmpCase(nCellule,tCellule:cellule):boolean;
begin
	//si les cellules correspondent
	if ((nCellule.col=tCellule.col) and (nCellule.ligne=tCellule.ligne)) then
		cmpCase:=true
	else
		cmpCase:=false;
end;


//BUT:initialise les valeur des bateaux
//ENTREE:2 variable type case 3 entier 1 variable type positionBateau
//SORTIE:1 variable bateau
FUNCTION createBateau(nCellule:cellule; taille:integer):bateau;
var
	res:bateau;	//on renvoie le bateau a createBateau
	posBateau:positionBateau;	//position du bateau
	i:integer;	//boucle
	pos:integer;	//aleatoire

begin
	
	pos:=Random(3);
	posBateau:=positionBateau(pos);
	res.taille:=taille;
	
	for i:=1 to MAXCASE do
	begin
		//si i est inferieur ou egale a la taille du bateau alors on affecte les valeurs
		if (i<=taille) then
		begin
			res.nCase[i].ligne:=nCellule.ligne;
			res.nCase[i].col:=nCellule.col;
		end
		else
		begin
			res.nCase[i].ligne:=0;
			res.nCase[i].col:=0;
		end;
		
		//position du bateau
		//en ligne
		if (posBateau=enLigne) then
			nCellule.col:=nCellule.col+1
		else
			//en colonne
			if (posBateau=enColonne) then
				nCellule.ligne:=nCellule.ligne+1
			else
				//en diagonale
				if (posBateau=enDiag) then
				begin
					nCellule.ligne:=nCellule.ligne+1;
					nCellule.col:=nCellule.col+1;
				end;
	end;

	createBateau:=res;
end;


//BUT: créer la flotte de chaque player
//ENTREE:1 type bateau 1 type cellule
//SORTIE:flotte rempli
procedure fPlayer (var nBateau:bateau;var nCellule:cellule);
begin
	
	repeat
		nBateau.taille:=Random(MAXCASE)+3;//probleme avec le random si je fais pas un repeat until,
																			//il reussit a avoir une valeur au dessu de MAXCASE, illogique x2
	until (nBateau.taille>2) and (nBateau.taille<=MAXCASE);
	
	
	//une fois le random donné on créer la case pour le bateau en les MAXL et MAXC
	repeat
		CreateCase((Random(MAXL)+MINL),(Random(MAXC)+MINL),nCellule);
	until (nCellule.ligne>=MINL) and (nCellule.ligne<=MAXL-nBateau.taille) and (nCellule.col>=MINC) and (nCellule.col<=MAXC-nBateau.taille);

	nBateau:=createBateau(nCellule,nBateau.taille);
end;


//BUT:initialisation des flottes
//ENTREE:1 type flotte 1 type cellule 2 entier
//SORTIE:flotte init
procedure initfPlayer(var player:flotte; nCellule:cellule);
var
  i,j:integer;	//boucle
begin
	for i:=1 to NBBATEAU do
	begin
		fPlayer(player.nBateau[i],nCellule);
		
		
		//debug
		 for j:=1 to MAXCASE do 
			begin 
			 write(format('[%d,%d] ' , [player.nBateau[i].nCase[j].ligne,player.nBateau[i].nCase[j].col])); 
			end; 
			writeln; 
	end;
end;


//BUT:gere les attaque entre les joueurs
//ENTREE:1 type flotte 1 type cellule 1 booleen 2 entier
//SORTIE:si toucher ou non
procedure attaquerBateau(var player:flotte);
var
	nCellule:cellule;	//cellule tapper du joueur
	test:boolean;	//test si les case sont les memes
	i,j:integer;	//boucle
begin
	
	repeat
		writeln('Entrez la ligne [1-50]');
		readln(nCellule.ligne);
		if (nCellule.ligne<1) or (nCellule.ligne>50) then writeln('erreur [1-50]');
	until (nCellule.ligne>0) and (nCellule.ligne<=50);
	
	repeat
		writeln('Entrez la colonne [1-50]');
		readln(nCellule.col);
		if (nCellule.col<1) or (nCellule.col>50) then writeln('erreur [1-50]');
	until (nCellule.col>0) and (nCellule.col<=50);
	
	for i:=1 to NBBATEAU do
	begin
		for j:=1 to player.nBateau[i].taille do
		begin
			test:=false;
			
			test:=cmpCase(nCellule,player.nBateau[i].nCase[j]);
		
			if test then
			begin
				writeln('touche ! ');
				CreateCase(0,0,player.nBateau[i].nCase[j]);
				if etatBat(player.nBateau[i])=couler then writeln('couler ! ');
			end;
		end;
	
	end;
end;


//Debut programme principal
var
	nCellule:cellule;	//cellule pour l'init
	i:integer;	//boucle
	joueur1,joueur2:flotte;	//joueurs
	etat1,etat2:etatJoueur;	//etats des joueurs
	etatfl1,etatfl2:etatFlotte;	//etats des flottes

	
begin
	clrscr;
	randomize;
	etat1:=gagne;
	etat2:=gagne;
	etatfl1:=aFlot;
	etatfl2:=aFlot;
	
	writeln('Initialisation des donnees du joueur 1.');
	delay(500);
	initfPlayer(joueur1,nCellule);
	writeln('Initialisation des donnees du joueur 2.');
	delay(500);
	initfPlayer(joueur2,nCellule);
	

	repeat
		
		//si aucun des deux na perdu
		if (etat1=gagne) and (etat2=gagne) then
		begin
			writeln('Joueur 1 : ');
			attaquerBateau(joueur1);
		end;
		
		etatfl1:=etatFlot(joueur1);		
		
		//si la flotte na pas sombré donc le joueur na pas perdu
		if etatfl1=aSombrer then
			etat2:=perd;
		
		//si aucun des deux na perdu
		if (etat1=gagne) and (etat2=gagne) then
		begin
			writeln('Joueur 2 : ');
			attaquerBateau(joueur2);
		end;
			
		etatfl2:=etatFlot(joueur2);
		
		//si la flotte na pas sombré donc le joueur na pas perdu
		if etatfl2=aSombrer then
			etat1:=perd;
		
	until ((etat1=perd) or (etat2=perd)) and ((etatfl1=aSombrer) or (etatfl2=aSombrer));
	
	if etat1=perd then writeln('Joueur 2 a gagner')
	else writeln('Joueur 1 a gagner');
	
	readln;
end.




