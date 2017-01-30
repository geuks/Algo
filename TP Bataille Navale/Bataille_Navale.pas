//BUT:Le jeu de la bataille Navale
//ENTREE:2 coordonne
//SORTIE:affiche si les coordonne touche un bateau
program BatailleNavale;

uses crt;

CONST
	MAX=10;	//taille de la map
	MAXNAVIRE=5;	//nombre de navire MAX=8
	MAXTAILLENAVIRE=6;	//taille des navires MAX=10

//Debut type
Type
	cellule = record
		ligne:integer;
		colonne:integer;
	end;
	
Type
	navire = record
		n:cellule;
		taille:integer;
		nom:string;
	end;
	
Type
	flotte = record
		n1:navire;
	end;
	
Type
	marge = record
		x:integer;
		y:integer;
	end;

Type
	Tcellule=array [1..100] of cellule;
	Tbateau=array[1..100] of navire;
	TFlotte=array[1..MAXNAVIRE,1..100] of flotte;
	Tnom=array[1..8] of string;
	T=array[1..20] of integer;
// FIN type


	//init tableau
//BUT:Initialisation a 0 des position des cellules
//ENTREE:1 tableau d'entier, 1 entier, 1 constante
//SORTIE:1 tableau d'entier avec valeur 0
procedure InitCellule(Var PosCellule,CelluleTouche:Tcellule);
var
	i:integer;
begin
	for i:=1 to MAX do
	begin
		PosCellule[i].colonne:=0;
		PosCellule[i].ligne:=0;
		CelluleTouche[i].colonne:=0;
		CelluleTouche[i].ligne:=0;
	end;
end;
//


//BUT:Initialisation a 0 de la flotte
//ENTREE:2 tableau avec 1 sous type Tflotte, et 1 sous type Tbateau
//SORTIE:2 tableau avec valeur 0
procedure InitFlotte(var Bateau:Tbateau; var Ensemble:TFlotte);
var
	i,j:integer;
begin
	for i:=1 to MAX do
	begin
		Bateau[i].n.colonne:=0;
		Bateau[i].n.ligne:=0;
		for j:=1 to MAXNAVIRE do
		begin
			Ensemble[j,i].n1.n.colonne:=0;
			Ensemble[j,i].n1.n.ligne:=0;
		end;
	end;
end;
//
	//fin init	
	
	
	//Toutes les procedures d'affichage
//BUT:Affiche la map du jeu
//ENTREE:3 entier
//SORTIE:affichage 
procedure AfficheMap();
var
	cpt,i,j:integer;

begin
		cpt:=7;
	for i:=1 to MAX do		//Afficher 1-10 horizontal
	begin
		GotoXY(cpt,5);
		write(i);
		cpt:=cpt+4;
	end;
	
	
	cpt:=8;
	for i:=1 to MAX do		//Affiche 1-10 vertical
	begin
		for j:=1 to MAX*3 do
		begin
			GotoXY(3,cpt);
			write(Chr(i+64));
		end;
		cpt:=cpt+3;
	end;
	
	
	cpt:=6;
	for i:=1 to MAX+1 do		//Affiche les _
	begin
		for j:=6 to (MAX*4)+4 do
		begin
			GotoXY(j,cpt);
			write('_');
		end;
		cpt:=cpt+3;
	end;
	
	
	for i:=7 to (MAX*3)+6 do		//Affiche les |
	begin
		cpt:=5;
		for j:=0 to MAX do
		begin
			GotoXY(cpt,i);
			write('|');
			cpt:=cpt+4;
		end;
	end;
	
end;
//taille map : x = Constante MAX * 4 (+5 marge largeur)
//             y = Constante MAX * 3 (+6 marge hauteur)


//BUT:Affiche le menu lateral
//ENTREE:1 entier
//SORTIE:affichage
procedure AfficheLateral();
var
	i:integer;
begin

	for i:=MAX to (MAX*3) do
	begin
		GotoXY((MAX*5)-2,i);		//Affiche les | menu lateral
		write('|');
		
		GotoXY((MAX*7)+2,i);
		write('|');
	end;

	for i:=(MAX*5)-1 to (MAX*7)+1 do
	begin
		GotoXY(i,MAX-1);		//Affiche les _ menu lateral
		write('_');
		
		GotoXY(i,(MAX*3));
		write('_');
	end;
end;
// x1: (MAX*5)-2 = 48	x2:(MAX*7)+2 = 72
// y1: (MAX) = 10			y2:MAX*3 = 30


//BUT:affiche le nombre de cellule restante a la flotte
//ENTREE:2 entier
//SORTIE:affichage
procedure AfficherFlotte(Bateau:Tbateau; margin:marge; tailleB:T);
var
	i,cpt:integer;
begin
	cpt:=5;
	for i:=1 to MAXNAVIRE do
	begin
		GotoXY(margin.x,margin.y+cpt);					//Affiche par
		if tailleB[i]<0 then									//Exemple: Porte-Avion:5
		begin
			write(Bateau[i].nom,':','X');
		end
		else
		begin
			write(Bateau[i].nom,':',tailleB[i]);
		end;	
		cpt:=cpt+1;
	end;
	
	textcolor(red);
	GotoXY(Margin.x,Margin.y+4);
	write('Case restantes:');
	textcolor(white);
end;
//
	//FIN affichage


	//Toute les procedure pour effacer les textes
//BUT:effacer le texte (remplace par un espace )
//ENTREE:2 entier
//SORTIE:affichage
procedure Clrtxt();
var
	i,j:integer;
begin

	for i:=10 to 29 do
	begin
		for j:=49 to 71 do
		begin
			GotoXY(j,i);
			write(' ');
		end;
	end;

end;
//


//BUT:effacer le texte (remplace par un espace )
//ENTREE:2 entier
//SORTIE:affichage
procedure Clrtxt2();
var
	i,j:integer;
begin

	for i:=13 to 29 do
	begin
		for j:=49 to 71 do
		begin
			GotoXY(j,i);
			write(' ');
		end;
	end;

end;


//BUT:effacer le texte (remplace par un espace )
//ENTREE:2 entier
//SORTIE:affichage
procedure Clrtxt3();
var
	i,j:integer;
begin

	for i:=34 to 35 do
	begin
		for j:=49 to 85 do
		begin
			GotoXY(j,i);
			write(' ');
		end;
	end;

end;
	//FIN texte


	//Tout les fonctions test
//BUT:Test les cases suivante dans la direction X pour chaque taille d'un bateau
//ENTREE:1 tableau type Tbateau, 1 tableay type Tcellule,5 entier, 2 boolean
//SORTIE:1 boolean
function TestCaseLigne(Bateau:Tbateau;PosCellule:Tcellule;x,y,i:integer):boolean;
var
	j:integer;
	test,test2:boolean;
begin
	test:=false;
	test2:=true;
	for j:=1 to Bateau[i].taille do
	begin
		//Si la cellule bateau y <> de la position y Et que la cellule bateau x <> de la position x +j
		if (Bateau[j].n.colonne<>PosCellule[y].colonne) AND (Bateau[j].n.ligne<>PosCellule[(x+(j-1))].ligne) then
		begin
			test:=true;	
		end;
		
		if test=false then
		begin
			test2:=false;
		end;
	end;
	
	if test2=false then
	begin
		test:=false;
	end;
	
		TestCaseLigne:=test;

end;
//


	//Tout les fonctions test
//BUT:Test les cases suivante dans la direction y pour chaque taille d'un bateau
//ENTREE:1 tableau type Tbateau, 1 tableay type Tcellule,5 entier, 2 boolean
//SORTIE:1 boolean
function TestCaseColonne(Bateau:Tbateau;PosCellule:Tcellule;x,y,i:integer):boolean;
var
	j:integer;
	test,test2:boolean;
begin

	test:=false;	
	for j:=1 to Bateau[i].taille do
	begin
		if (Bateau[j].n.colonne<>PosCellule[(y+(j-1))].colonne) AND (Bateau[j].n.ligne<>PosCellule[x].ligne) then
		begin
			test:=true;	
		end;
		
		if test=false then
		begin
			test2:=false;
		end;
	end;
	
	if test2=false then
	begin
		test:=false;
	end;

	TestCaseColonne:=test;

end;
//


//BUT:Test pour que les bateaux de se superpose pas
//ENTREE:1 tableau type Tbateau,1 tableau type Tflotte, 4 entier, 1 booleen
//SORTIE:1 boolean
function TestCase(Bateau:Tbateau; Ensemble:TFlotte):boolean;
var
	i,j,l,k:integer;
	test:boolean;
begin
	test:=true;
	
	for i:=1 to MAXNAVIRE do
	begin
		for j:=1 to MAXNAVIRE do
		begin
			for k:=1 to Bateau[i].taille do
			begin
				for l:=1 to Bateau[i].taille do
				begin
					if (Ensemble[i,k].n1.n.ligne=Ensemble[j,l].n1.n.ligne) AND (Ensemble[i,k].n1.n.colonne=Ensemble[j,l].n1.n.colonne) AND (j<>i) then
					begin
						test:=false;
					end;
				end;
			end;
		end;
	end;
	TestCase:=test;
end;
//


//BUT:converti les chaine (caractere) en entier (Ex:'10'>10)
//ENTREE:1 string
//SORTIE:1 entier
function one1(car:string):integer; 
begin
		if length(car)=1 then
		begin
			if(ord(car[1])>=48) AND (ord(car[1])<=57) then
			begin
				one1:=ord(car[1])-48
			end
				else
					begin
					one1:=0;
					end;
		end
		else
			if length(car)=2 then
			begin
				
				if (ord(car[1])=49) AND (ord(car[2])=48)then
				begin
					one1:=10
				end
					else
					begin
						one1:=0;
					end;
			end;
			
			
end;
//


//BUT:convertir les caractere en entier
//ENTREE:1 caractere
//SORTIE:1 entier
function a1(car:char):integer;
begin
	if(ord(car)>=97) AND (ord(car)<97+MAX) then
	begin	
		a1:=ord(car)-96
	end
		else
			a1:=11;
end;
//


//BUT:Test Si les coord entrer existe
//ENTREE:1 tableau type TFlotte, 1 tableau type Tbateau, 1 tableau type Tcellule, 3 entier
//SORTIE:1 boolean
function trouver(Ensemble:TFlotte;Bateau:Tbateau;PosCellule:Tcellule;x,y:integer;var nbr:integer):boolean;
var
	i,j:integer;
	test:boolean;
begin
	test:=false;
	for i:=1 to MAXNAVIRE do
	begin
		for j:=1 to Bateau[i].taille do
		begin
			if (Ensemble[i,j].n1.n.colonne=PosCellule[y].colonne) AND (Ensemble[i,j].n1.n.ligne=PosCellule[x].ligne) then
			begin
				test:=true;
				nbr:=i;//Si la position entree = a la position du bateau
			end;
		end;
	end;
	trouver:=test;
end;
//


//BUT:Test si tout les bateau on coule
//ENTREE:1 tableau type T
//SORTIE:1 boolean
function Final(Nb:T):boolean;
var
	i,cpt:integer;
	test:boolean;
begin
	test:=false;
	cpt:=0;
	for i:=1 to MAXNAVIRE do
	begin
		if Nb[i]<1 then
		begin
			cpt:=cpt+1;
			if cpt=MAXNAVIRE then
			begin
				test:=true;
			end;
		end;
	end;
	
	Final:=test;

end;
//
	//FIN test


	//tout les procedure de creation
//BUT:Affecte les valeur x y a Pos
//ENTREE:1 tableau type PosCellule, 2 entier
//SORTIE:Tableau N valeur
procedure CreateCellule(Var PosCellule:Tcellule);
var
	cpt,i:integer;
begin	
	
	cpt:=7;
	for i:=1 to MAX do	//Valeur des cases y
	begin
		PosCellule[i].ligne:=cpt;
		cpt:=cpt+4;
	end;

	cpt:=8;
	for i:=1 to MAX do	//Valeur des cases x
	begin
		PosCellule[i].colonne:=cpt;
		cpt:=cpt+3;
	end;


end;
//


//BUT:Affecte les valeur des cellules a bateau
//ENTREE:1 tableau type Tcellule, 1 tableau type Tbateau, 4 entier, 1 boolean
//SORTIE:1 tableau N cellule
procedure CreateNavire (PosCellule:Tcellule;var Bateau:Tbateau;i:integer);
var
	j,x,y,randdirection:integer;
	test:boolean;
begin

	repeat
	begin
	Randomize;
	
	
		RandDirection:=Random(2)+1;//Pour choisir le positionnement au hasard
	
		case RandDirection of
			1:begin		//Positionnement bateau vertical
	
					repeat
					begin
						x:=Random(MAX)+1;//positionnement au hasard
						y:=Random(MAX)+1;
					end;
					until (y<=MAX-Bateau[i].taille);
					
					test:=TestCaseColonne(Bateau,PosCellule,x,y,i);	//test si les cases sont vide pour le bateau
					if test=true then
					begin
						
						for j:=1 to Bateau[i].taille do
						begin
							Bateau[j].n.colonne:=PosCellule[(y+j)-1].colonne;
							Bateau[j].n.ligne:=PosCellule[x].ligne;
						end;
					end;
					
				end;
			
			2:begin//Positionnement horizontal
			
					repeat
					begin
						x:=Random(MAX)+1;//positionnement au hasard
						y:=Random(MAX)+1;
					end;
					until (x<=MAX-Bateau[i].taille);
					
					test:=TestCaseLigne(Bateau,PosCellule,x,y,i);	//test si les cases sont vide pour le bateau
					if test=true then
					begin
						
						for j:=1 to Bateau[i].taille do
						begin
							Bateau[j].n.colonne:=PosCellule[y].colonne;
							Bateau[j].n.ligne:=PosCellule[(x+j)-1].ligne;
						end;
					end;
				
				end;
		end;

	end;
	until (test=true);

end;
//


//BUT:defini la taille d'une bateau
//ENTREE:1 tableau type Tbateau, un tableau typea T, 2 entier
//SORTIE:un tableau type T avec N entier
procedure TailleBateau(Var Bateau:Tbateau;var tailleB:T);
var
	i,nbr:integer;
begin
	
	Randomize;
	
	for i:=1 to MAXNAVIRE do
	begin
		repeat
			nbr:=Random(MAXTAILLENAVIRE)+1;
		until nbr>1;
		
		Bateau[i].taille:=nbr;
		tailleB[i]:=Bateau[i].taille;
	end;

end;
//


//BUT:Deffini le nom des bateau
//ENTREE:1 tableau type Tnom,1 tableau type Tbateau,1 entier
//SORTIE:1 tableau type Tnom avec N valeur string
procedure NomBateau (Var Nom:Tnom;Var Bateau:Tbateau);
var
  i:integer;
begin

	Nom[1]:='Torpilleur';
	Nom[2]:='Sous-Marin';
	Nom[3]:='Contre-Torpilleur';
	Nom[4]:='Croiseur';
	Nom[5]:='Porte-Avions';
	Nom[6]:='Corvette';
	Nom[7]:='Cuirasse';
	Nom[8]:='Destroyeur';
	
	for i:=1 to MAXNAVIRE do
	begin
		Bateau[i].nom:=Nom[i];
	end;

end;
//


//BUT:Affecte les valeurs des bateaux a la flotte
//ENTREE:1 tableau type Tbateau, 1 tableau type Tcellule, 1 tableau type Ensemble,2 entier, 1 boolean
//SORTIE:Tableau type Tflotte avec N valeur entier
procedure CreateFlotte (Bateau:Tbateau; PosCellule:Tcellule; Var Ensemble:TFlotte);
var
	i,j:integer;
	test:boolean;
begin

	repeat
	begin
		InitFlotte(Bateau,Ensemble);
		
		for i:=1 to MAXNAVIRE do
		begin

			CreateNavire(PosCellule,Bateau,i);
			

			for j:=1 to Bateau[i].taille do
			begin	
					Ensemble[i,j].n1.n.ligne:=Bateau[j].n.ligne;
					Ensemble[i,j].n1.n.colonne:=Bateau[j].n.colonne;
			end;

		end;

		test:=TestCase(Bateau,Ensemble);
		
	end;
	until (test=true);

end;
//
	//Fin creation


	//Debut programme principal
var
	
	PosCellule,CelluleTouche:Tcellule;
	bateau:Tbateau;
	Nom:Tnom;
	tailleB:T;
	margin:marge;
	Ensemble:TFlotte;
	x1,y1,i,k,j,nbr:integer;
	y:char;
	x,pseudo:string;
	test:boolean;
	
	
BEGIN
	clrscr;
	
	textcolor(white);
	
	InitCellule(PosCellule,CelluleTouche);// Init des cellules

	AfficheMap();	//affiche le terrain
	
	AfficheLateral();	//affiche menu lateral
	
	CreateCellule(PosCellule);	//créer les cellules

	TailleBateau(Bateau,tailleB);	//defini le nombre de cellule des bateau
	
	NomBateau(Nom,Bateau);	//affecte les nom des bateau
	
	CreateFlotte(Bateau,PosCellule,Ensemble);	//creer la flotte de bateau
	
	
	//Affiche la flotte
	{ textcolor(red); }
	{ for j:=1 to MAXNAVIRE do }
	{ begin }
		{ for k:=1 to Bateau[j].taille do }
		{ begin }
		
		{ GotoXY(Ensemble[j,k].n1.n.ligne,Ensemble[j,k].n1.n.colonne); }
		{ write(j); }
		
		{ end; }
	{ end; }
	{ textcolor(white); }
	//

	
	//	x = Constante MAX * 4 (+5 marge largeur)
	//  y = Constante MAX * 3 (+6 marge hauteur)
	margin.x:=(MAX*4)+10;
	margin.y:=MAX;
	
	GotoXY(margin.x DIV 2,1);
	write('Bataile Navale !');
	
	GotoXY(margin.x,margin.y);
	write('Bienvenue Commandant,' );
	GotoXY(margin.x,margin.y+1);
	write('Quel est votre nom ?');
	
	repeat//boucle pseudo
	begin
		GotoXY(margin.x,margin.y+2);
		write('- ');
		readln(pseudo);
		pseudo:=Upcase(pseudo);
	end;
	until (length(pseudo)<=10) AND (length(pseudo)>1);
	
	
	Clrtxt;
	
	GotoXY(margin.x,margin.y);
	write('Bienvenue !');
	GotoXY(margin.x,margin.y+1);
	write('Commandant ',pseudo);

	AfficherFlotte(Bateau,margin,tailleB);
	
	repeat//boucle fin du jeu
	begin

			repeat//boucle coord x
			begin
				
				GotoXY(margin.x,margin.y+13);
				write('Coordonne x ? 1-10');
				GotoXY(margin.x,margin.y+14);
				write('.');
				readln(x);
				x1:=one1(x);
				if (x1=0) then
				begin
					for i:=margin.x to margin.x+10 do
					begin
						GotoXY(i,margin.y+14);
						write(' ');
					end;
				end;
			end;
			until (x1<>0) AND (x<>'');;
			
			clrtxt3;
			
			repeat//boucle coord y
			begin
				GotoXY(margin.x,margin.y+15);
				write('Coordonne y ? a-j');
				GotoXY(margin.x,margin.y+16);
				write('.');
				readln(y);
				y:=LowerCase(y);
				y1:=a1(y);
				if (y1=11) then
				begin
					for i:=margin.x to margin.x+10 do
					begin
						GotoXY(i,margin.y+16);
						write(' ');
					end;
				end;
			end;
			until (y1<>11);

		//si les valeur corresponde
		test:=trouver(Ensemble,Bateau,PosCellule,x1,y1,nbr);
		
		if test=true then
		begin
			
			//si les cellule touche est different de la cellule donne
			if (CelluleTouche[nbr].ligne<>PosCellule[x1].ligne) OR (CelluleTouche[nbr].colonne<>PosCellule[y1].colonne) then
			begin
				
				if (tailleB[nbr]>0) then
				begin
				CelluleTouche[nbr].ligne:=PosCellule[x1].ligne;
				CelluleTouche[nbr].colonne:=PosCellule[y1].colonne;
			
				GotoXY(PosCellule[x1].ligne,PosCellule[y1].colonne);
				write('T');
				GotoXY(margin.x,margin.y+24);
				write(Nom[nbr],' toucher !');
				tailleB[nbr]:=tailleB[nbr]-1;
				end;
				
				if tailleB[nbr]<=0 then//si bateau detruit
				begin
					GotoXY(margin.x,margin.y+25);
					write(Nom[nbr],' a ete coule !');
					textcolor(red);
					for i:=1 to Bateau[nbr].taille do
					begin
						GotoXY(Ensemble[nbr,i].n1.n.ligne,Ensemble[nbr,i].n1.n.colonne);
						write('C');
					end;
					tailleB[nbr]:=-1;
					textcolor(white);
				end;
			end
		end
		else
		begin
			GotoXY(margin.x,margin.y+24);
			write('Vous avez tirez dans la mer !');
			GotoXY(PosCellule[x1].ligne,PosCellule[y1].colonne);
			textcolor(blue);
			write('X');
			textcolor(white);
		end;
		
		clrtxt2;
		AfficherFlotte(Bateau,margin,tailleB);
			
		test:=Final(tailleB);// test si tout les bateau detruit
	end;
	until test=true;//fin du jeu
	delay(2000);
	
	clrtxt3;
	
	GotoXY(margin.x,margin.y+24);
	write('Fin de la partie !');
	GotoXY(margin.x,margin.y+25);
	write('Merci d''avoir jouer,');
	GotoXY(margin.x,margin.y+26);
	write('developper par Geuks.');
	
	readln;
END.
