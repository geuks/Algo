{***************************BUT****PRINCIPAL****************************************
	*
	 *_CREATEUR:UNALAN Gökhan
	 *
	 *______BUT:Jeu du morpion, le premier des deux joueurs qui aura une ligne,
	 *        colonne avec la meme forme gagnera
	 *
	 *___ENTREE:2 joueurs qui choisissent leur cellules
	 *
	 *___SORTIE:1 gagnant et 1 perdant ou égalité
	 *
	*
***********************************************************************************}
program morpion;

uses crt,sysutils;

const
	TAILLEX=30;	//taille x de la grille du jeu
	TAILLEY=30;	//taille y de la grille du jeu
	DECALAGE=5;	//décalage de la grille
	DECALAGECONSOLEX=41;	//décalage de la grille du jeu pour écrire sur la droite
	DECALAGECONSOLEY=6;	//décalage de la hauteur du jeu

type
	player=record	//type record pour stocker les infos des joueurs
		pseudo:string;	//le pseudo
		manches:integer;	//le nombre de manche gagné
		nbrcoups:array [1..9] of integer;	//le nombre de coups joué
		forme:integer; //rond ou croix
	end;
	
type
	tChar=array [1..9] of char;	//tableau de caractère pour la grille
	tJoueur=array [1..2] of player; // tableau du type joueur pour les 2 joueurs

	
{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:afficher la grille d'aide
	 *__ENTREE:2 entier
	 *__SORTIE:grille d'aide afficher
*********************************************************************************}
procedure afficherAide();
var
	x,y:integer;
begin
	gotoXY(42,15);
	write('Numero des cases');
	textbackground(white);
	
	//début affichage par rapport au coordonné x,y de la console
	for y:=16 to 28 do
	begin
		for x:=DECALAGECONSOLEX to DECALAGECONSOLEX+18 do
		begin
			if x=DECALAGECONSOLEX then
			begin
				gotoXY(x,y);
				write(' ');
			end
			else
				if (x=(18 DIV 3)+DECALAGECONSOLEX) then
				begin
					gotoXY(x,y);
					write(' ');
					if y=20 then
					begin
						textbackground(black);
						textcolor(red);
						gotoXY(x -3, y -2);
						write('1');
						textcolor(white);
						textbackground(white);
					end
					else
						if y=24 then
						begin
							textbackground(black);
							textcolor(red);
							gotoXY(x -3, y -2);
							write('4');
							textcolor(white);
							textbackground(white);
							end
							else
								if y=28 then
								begin
									textbackground(black);
									textcolor(red);
									gotoXY(x -3, y -2);
									write('7');
									textcolor(white);
									textbackground(white);
								end;
				end
				else
					if (x= (18 DIV 3)+((18 DIV 3)+DECALAGECONSOLEX)) then
					begin
						gotoXY(x,y);
						write(' ');
						if y=20 then
						begin
							textbackground(black);
							textcolor(red);
							gotoXY(x -3, y -2);
							write('2');
							textcolor(white);
							textbackground(white);
						end
						else
							if y=24 then
							begin
								textbackground(black);
								textcolor(red);
								gotoXY(x -3, y -2);
								write('5');
								textcolor(white);
								textbackground(white);
								end
								else
									if y=28 then
									begin
										textbackground(black);
										textcolor(red);
										gotoXY(x -3, y -2);
										write('8');
										textcolor(white);
										textbackground(white);
									end;
					end
					else
						if (x=DECALAGECONSOLEX+18) then
						begin
							gotoXY(x,y);
							write(' ');
							if y=20 then
							begin
								textbackground(black);
								textcolor(red);
								gotoXY(x -3, y -2);
								write('3');
								textcolor(white);
								textbackground(white);
							end
							else
								if y=24 then
								begin
									textbackground(black);
									textcolor(red);
									gotoXY(x -3, y -2);
									write('6');
									textcolor(white);
									textbackground(white);
									end
									else
										if y=28 then
										begin
											textbackground(black);
											textcolor(red);
											gotoXY(x -3, y -2);
											write('9');
											textcolor(white);
											textbackground(white);
										end;
						end;
				
			if y=16 then
			begin
				gotoXY(x,y);
				write(' ');
			end
			else
				if (y=(12 DIV 3)+16) then
				begin
					gotoXY(x,y);
					write(' ');
				end
				else
					if (y= (12 DIV 3)+(12 DIV 3)+16) then
					begin
						gotoXY(x,y);
						write(' ');
					end
					else
						if (y=28) then
						begin
							gotoXY(x,y);
							write(' ');
						end;
			
						
		end;
	end;
	textbackground(black);
end;	
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:affiche la grille du jeu
	 *__ENTREE: 2 entier en local
	 *__SORTIE:grille afficher à l'écran
*********************************************************************************}
procedure afficherGrille();
var
	x,y:integer;
begin
	textbackground(white);
	for y:=DECALAGE to TAILLEY+DECALAGE do
	begin
		for x:=DECALAGE to TAILLEX+DECALAGE do
		begin

		if (y=DECALAGE) then
		begin
			gotoXY(x,y);
			write(' ');
		end
			else
			if (TAILLEY DIV 3 = y-DECALAGE) then
			begin
				gotoXY(x,y);
				write(' '); 	
			end
			else
				if ((TAILLEY DIV 3)+(TAILLEY DIV 3) = y-DECALAGE) then
				begin
					gotoXY(x,y);
					write(' '); 	
				end
				else
					if (TAILLEY = y-DECALAGE) then
					begin
						gotoXY(x,y);
						write(' ');
					end;
					
		if (x=DECALAGE) and (y<>DECALAGE) then
		begin
			gotoXY(x,y);
			write(' ');
		end
			else
			if (TAILLEX DIV 3 = x-DECALAGE) and (y<>DECALAGE) then
			begin
				gotoXY(x,y);
				write(' '); 	
			end
			else
				if ((TAILLEX DIV 3)+(TAILLEX DIV 3) = x-DECALAGE) and (y<>DECALAGE) then
				begin
					gotoXY(x,y);
					write(' '); 	
				end
				else
					if (TAILLEX = x-DECALAGE) and (y<>DECALAGE) then
					begin
						gotoXY(x,y);
						write(' '); 	
					end;
		end;
	end;
	textbackground(black);
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:affiche une croix à l'écran
	 *__ENTREE:2 entier en local
	 *__SORTIE:croix afficher
*********************************************************************************}
procedure afficherCroix(emplacement:integer);
var
	i,cpt:integer;
begin
	cpt:=DECALAGE+2;
	case emplacement of
		1:begin
				textbackground(red);
				for i:=DECALAGE+2 to DECALAGE+8 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
				end;
				cpt:=DECALAGE+2;
				for i:=DECALAGE+8 downto DECALAGE+2 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
					if i= DECALAGE+8 DIV 2 then
					begin
						gotoXY(cpt-2,i+1);
						write(' ');
					end;
				end;
				textbackground(black);
			end;
		2:begin
				textbackground(red);
				cpt:=DECALAGE+12;
				for i:=DECALAGE+2 to DECALAGE+8 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
				end;
				cpt:=DECALAGE+12;
				for i:=DECALAGE+8 downto DECALAGE+2 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
					if i= DECALAGE+8 DIV 2 then
					begin
						gotoXY(cpt-2,i+1);
						write(' ');
					end;
				end;
				textbackground(black);
			end;
		3:begin
				textbackground(red);
				cpt:=DECALAGE+22;
				for i:=DECALAGE+2 to DECALAGE+8 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
				end;
				cpt:=DECALAGE+22;
				for i:=DECALAGE+8 downto DECALAGE+2 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
					if i= DECALAGE+8 DIV 2 then
					begin
						gotoXY(cpt-2,i+1);
						write(' ');
					end;
				end;
				textbackground(black);
			end;
		4:begin
				textbackground(red);
				for i:=DECALAGE+12 to DECALAGE+18 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
				end;
				cpt:=DECALAGE+2;
				for i:=DECALAGE+18 downto DECALAGE+12 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
					if i= ((DECALAGE+18)+(DECALAGE+12))DIV 2 then
					begin
						gotoXY(cpt-1,i);
						write(' ');
					end;
				end;
				textbackground(black);
			end;
		5:begin
				cpt:=DECALAGE+12;
				textbackground(red);
				for i:=DECALAGE+12 to DECALAGE+18 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
				end;
				cpt:=DECALAGE+12;
				for i:=DECALAGE+18 downto DECALAGE+12 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
					if i= ((DECALAGE+18)+(DECALAGE+12))DIV 2 then
					begin
						gotoXY(cpt-1,i);
						write(' ');
					end;
				end;
				textbackground(black);
			end;
		6:begin
				cpt:=DECALAGE+22;
				textbackground(red);
				for i:=DECALAGE+12 to DECALAGE+18 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
				end;
				cpt:=DECALAGE+22;
				for i:=DECALAGE+18 downto DECALAGE+12 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
					if i= ((DECALAGE+18)+(DECALAGE+12))DIV 2 then
					begin
						gotoXY(cpt-1,i);
						write(' ');
					end;
				end;
				textbackground(black);
			end;
		7:begin
				textbackground(red);
				for i:=DECALAGE+22 to DECALAGE+28 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
				end;
				cpt:=DECALAGE+2;
				for i:=DECALAGE+28 downto DECALAGE+22 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
					if i= ((DECALAGE+28)+(DECALAGE+22))DIV 2 then
					begin
						gotoXY(cpt-1,i);
						write(' ');
					end;
				end;
				textbackground(black);
			end;
		8:begin
				cpt:=DECALAGE+12;
				textbackground(red);
				for i:=DECALAGE+22 to DECALAGE+28 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
				end;
				cpt:=DECALAGE+12;
				for i:=DECALAGE+28 downto DECALAGE+22 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
					if i= ((DECALAGE+28)+(DECALAGE+22))DIV 2 then
					begin
						gotoXY(cpt-1,i);
						write(' ');
					end;
				end;
				textbackground(black);
			end;
		9:begin
				cpt:=DECALAGE+22;
				textbackground(red);
				for i:=DECALAGE+22 to DECALAGE+28 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
				end;
				cpt:=DECALAGE+22;
				for i:=DECALAGE+28 downto DECALAGE+22 do
				begin
					gotoXY(cpt,i);
					write(' ');
					inc(cpt);
					if i= ((DECALAGE+28)+(DECALAGE+22))DIV 2 then
					begin
						gotoXY(cpt-1,i);
						write(' ');
					end;
				end;
				textbackground(black);
			end;
	end;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT: affiche un rond à l'écran
	 *__ENTREE:3 entier
	 *__SORTIE:rond afficher
*********************************************************************************}
procedure afficherRond(emplacement:integer);
var
	i,j,cpt:integer;
begin
	case emplacement of
		1:begin
				textbackground(blue);
				for i:=DECALAGE+2 to DECALAGE+8 do
				begin
					for j:=DECALAGE+2 to DECALAGE+8 do
					begin
						if (i=DECALAGE+2) or (i=DECALAGE+8) or (j=DECALAGE+2) or (j=DECALAGE+8) then
						begin
							gotoXY(i,j);
							write(' ');
						end;
					end;
				end;
				textbackground(black);
			end;
		2:begin
				textbackground(blue);
				for i:=DECALAGE+12 to DECALAGE+18 do
				begin
					for j:=DECALAGE+2 to DECALAGE+8 do
					begin
						if (i=DECALAGE+12) or (i=DECALAGE+18) or (j=DECALAGE+2) or (j=DECALAGE+8) then
						begin
							gotoXY(i,j);
							write(' ');
						end;
					end;
				end;
				textbackground(black);
			end;
			
		3:begin
				textbackground(blue);
				for i:=DECALAGE+22 to DECALAGE+28 do
				begin
					for j:=DECALAGE+2 to DECALAGE+8 do
					begin
						if (i=DECALAGE+22) or (i=DECALAGE+28) or (j=DECALAGE+2) or (j=DECALAGE+8) then
						begin
							gotoXY(i,j);
							write(' ');
						end;
					end;
				end;
				textbackground(black);
			end;
		4:begin
				textbackground(blue);
				for i:=DECALAGE+2 to DECALAGE+8 do
				begin
					for j:=DECALAGE+12 to DECALAGE+18 do
					begin
						if (i=DECALAGE+2) or (i=DECALAGE+8) or (j=DECALAGE+12) or (j=DECALAGE+18) then
						begin
							gotoXY(i,j);
							write(' ');
						end;
					end;
				end;
				textbackground(black);
			end;
		5:begin
				textbackground(blue);
				for i:=DECALAGE+12 to DECALAGE+18 do
				begin
					for j:=DECALAGE+12 to DECALAGE+18 do
					begin
						if (i=DECALAGE+12) or (i=DECALAGE+18) or (j=DECALAGE+12) or (j=DECALAGE+18) then
						begin
							gotoXY(i,j);
							write(' ');
						end;
					end;
				end;
				textbackground(black);
			end;
		6:begin
				textbackground(blue);
				for i:=DECALAGE+22 to DECALAGE+28 do
				begin
					for j:=DECALAGE+12 to DECALAGE+18 do
					begin
						if (i=DECALAGE+22) or (i=DECALAGE+28) or (j=DECALAGE+12) or (j=DECALAGE+18) then
						begin
							gotoXY(i,j);
							write(' ');
						end;
					end;
				end;
				textbackground(black);
			end;
		7:begin
				textbackground(blue);
				for i:=DECALAGE+2 to DECALAGE+8 do
				begin
					for j:=DECALAGE+22 to DECALAGE+28 do
					begin
						if (i=DECALAGE+2) or (i=DECALAGE+8) or (j=DECALAGE+22) or (j=DECALAGE+28) then
						begin
							gotoXY(i,j);
							write(' ');
						end;
					end;
				end;
				textbackground(black);
			end;
		8:begin
				textbackground(blue);
				for i:=DECALAGE+12 to DECALAGE+18 do
				begin
					for j:=DECALAGE+22 to DECALAGE+28 do
					begin
						if (i=DECALAGE+12) or (i=DECALAGE+18) or (j=DECALAGE+22) or (j=DECALAGE+28) then
						begin
							gotoXY(i,j);
							write(' ');
						end;
					end;
				end;
				textbackground(black);
			end;
		9:begin
				textbackground(blue);
				for i:=DECALAGE+22 to DECALAGE+28 do
				begin
					for j:=DECALAGE+22 to DECALAGE+28 do
					begin
						if (i=DECALAGE+22) or (i=DECALAGE+28) or (j=DECALAGE+22) or (j=DECALAGE+28) then
						begin
							gotoXY(i,j);
							write(' ');
						end;
					end;
				end;
				textbackground(black);
			end;
	end;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:initialise un tableau
	 *__ENTREE: 1 tableau de type tChar en parametre et 1 entier en local
	 *__SORTIE:tableau initialisé
*********************************************************************************}
procedure initTab(var tab:tChar);
var
	i:integer;
begin
	for i:=1 to 9 do
	begin
		tab[i]:=' ';
	end;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:efface un certain endroit de l'écran
	 *__ENTREE:2 entier en local
	 *__SORTIE:écran remplacer par des espaces
*********************************************************************************}
procedure clrtxt();
var
	i,j:integer;
begin
	for i:=DECALAGECONSOLEX to DECALAGECONSOLEX+40 do
	begin
		for j:=DECALAGECONSOLEY to DECALAGECONSOLEY+8 do
		begin
			gotoXY(i,j);
			write(' ');
		end;
	end;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Recupere le pseudo du joueur
	 *__ENTREE: 1 chaine en parametre
	 *__SORTIE:pseudo stocké
*********************************************************************************}
procedure pseudoJoueur(var joueur:string);
begin
	writeln('Entrez votre pseudo');
	write('- ');
	readln(joueur);
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:le tour d'un joueur, verification des valeurs entrer
	 *__ENTREE:1 entier, 1 tableau tChar, 1 chaine en parametre
	 *        1 entier et 1 chaine en local
	 *__SORTIE:1 emplacement de la grille
*********************************************************************************}
procedure tourJoueur(joueur:string; var grilleJoueur:tChar; nbr:integer);
var
	emplacement:integer;
begin
	repeat
		emplacement:=0;
		gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY);
		write(joueur,' entrez le numero de la case');
		
		repeat
			gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY+1);
			write('- ');
			readln(emplacement);
			if (emplacement=0) or (emplacement>9) then gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY+1);
		until (emplacement<>0) and (emplacement<=9);
		
		if grilleJoueur[emplacement]<>' ' then
		begin
			gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY+2);
			write('Emplacement deja occupe');
		end;
	until grilleJoueur[emplacement]=' ';
	
	
	if nbr=1 then
	begin
		afficherCroix(emplacement);
		grilleJoueur[emplacement]:='X';
	end
	else
	begin
		afficherRond(emplacement);
		grilleJoueur[emplacement]:='O';
	end;
	
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT: test si le jeu est terminé ou si l'un des joueurs a gagner
	 *__ENTREE: 1 tableau tChar en parametre et 2 entier en local
	 *__SORTIE:1 entier
*********************************************************************************}
function testFin(grilleJoueur:tChar):integer;
var
	i,test:integer;
begin
	test:=3;
	for i:=1 to 9 do
	begin
		if (grilleJoueur[1]='X') and (grilleJoueur[5]='X') and (grilleJoueur[9]='X') then
			test:=1
		else
			if (grilleJoueur[3]='X') and (grilleJoueur[5]='X') and (grilleJoueur[7]='X') then
				test:=1
		else
			if (grilleJoueur[1]='X') and (grilleJoueur[2]='X') and (grilleJoueur[3]='X') then
				test:=1
		else
			if (grilleJoueur[4]='X') and (grilleJoueur[5]='X') and (grilleJoueur[6]='X') then
				test:=1
		else
			if (grilleJoueur[7]='X') and (grilleJoueur[8]='X') and (grilleJoueur[9]='X') then
				test:=1
		else
			if (grilleJoueur[1]='X') and (grilleJoueur[4]='X') and (grilleJoueur[7]='X') then
				test:=1
		else
			if (grilleJoueur[2]='X') and (grilleJoueur[5]='X') and (grilleJoueur[8]='X') then
				test:=1
		else
			if (grilleJoueur[3]='X') and (grilleJoueur[6]='X') and (grilleJoueur[9]='X') then
				test:=1
		else
			if (grilleJoueur[1]='O') and (grilleJoueur[5]='O') and (grilleJoueur[9]='O') then
				test:=2
		else
			if (grilleJoueur[3]='O') and (grilleJoueur[5]='O') and (grilleJoueur[7]='O') then
				test:=2
		else
			if (grilleJoueur[1]='O') and (grilleJoueur[2]='O') and (grilleJoueur[3]='O') then
				test:=2
		else
			if (grilleJoueur[4]='O') and (grilleJoueur[5]='O') and (grilleJoueur[6]='O') then
				test:=2
		else
			if (grilleJoueur[7]='O') and (grilleJoueur[8]='O') and (grilleJoueur[9]='O') then
				test:=2
		else
			if (grilleJoueur[1]='O') and (grilleJoueur[4]='O') and (grilleJoueur[7]='O') then
				test:=2
		else
			if (grilleJoueur[2]='O') and (grilleJoueur[5]='O') and (grilleJoueur[8]='O') then
				test:=2
		else
			if (grilleJoueur[3]='O') and (grilleJoueur[6]='O') and (grilleJoueur[9]='O') then
				test:=2
		else
			test:=3;
	end;
	
	testFin:=test;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:initialise un tableau
	 *__ENTREE:1 tableau tJoueur en parametre et 1 entier en local
	 *__SORTIE:tableau initialiser
*********************************************************************************}
procedure initJoueurs(var joueurs:tJoueur);
var
	i,j:integer;
begin
	for i:=1 to 2 do
	begin
		joueurs[i].manches:=0;
		for j:=1 to 9 do
			joueurs[i].nbrcoups[j]:=0;
	end;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:création du fichier score
	 *__ENTREE: 1 fichier Text, 1 tableau tJoueur, 2 chaine en parametre et 1 entier en local
	 *__SORTIE:fichier créer et rempli
*********************************************************************************}
Procedure createFichier (var f:Text; joueurs:tJoueur; debutHeure,finHeure:string);
var
  i,j:integer;
begin
	Assign(f,'score.txt');
	append (f) ;
	
	writeln(f,'Heure de début: ' + debutHeure);
	
	for i:=1 to 2 do
	begin
		writeln (f,joueurs[i].pseudo, ' : ', joueurs[i].manches, ' manches gagner');
		for j:=1 to 9 do
		begin
			if joueurs[i].nbrCoups[j]<>0 then
				writeln(f, 'Manche ', j, ' gagner en ', joueurs[i].nbrcoups[j],' coup(s)');
		end;
	end;
		
	if joueurs[1].manches > joueurs[2].manches then
		writeln (f,'Le Joueur ',joueurs[1].pseudo,' a gagner la partie')
		else if joueurs[1].manches < joueurs[2].manches then
			writeln (f,'Le Joueur ',joueurs[2].pseudo,' a gagner la partie')
			else
				writeln (f,'Egalite') ;
	
	writeln(f,'Heure de fin: ' + finHeure);
	writeln(f);
	close (f) ;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


var
	i:integer;//compteur
	manches:integer;//nbr de manche a jouer
	debut:integer;//ordre des joueurs
	tour:integer;	//tour du jeu
	fin:integer;	//variable de fin du jeu
	grilleJoueur:tChar;//grille du jeu
	choix:char;	//variable pour recommencer
	recommencer:boolean;	//test pour la boucle
	joueurs:tJoueur;	//tableau des joueurs
	debutHeure,finHeure:string;	//stock l'heure de la partie
	fichier:Text;	//le fichier score
begin
	clrscr;
	Randomize;
	textcolor(white);
	
	for i:=1 to 2 do
	begin
		writeln('Joueur ', i);
		pseudoJoueur(joueurs[i].pseudo);
	end;
	
	//début de la partie
	repeat
		
		clrscr;
		writeln('Combien de manches voulez vous jouer ?');
		write('- ');
		readln(manches);
		
		debut:=Random(2)+1;
		joueurs[1].forme:=Random(2)+1;
		
		//nombre de manches a jouer
		for i:=1 to manches do
		begin
			clrscr;
			
			//choix entre rond ou croix par rapport au joueurs
			if joueurs[1].forme=1 then
			begin
				joueurs[2].forme:=2;
				gotoXY(DECALAGE,2);
				write(joueurs[1].pseudo, ' a les croix');
				gotoXY(DECALAGE,3);
				write(joueurs[2].pseudo, ' a les ronds');
			end
			else
			begin
				joueurs[2].forme:=1;
				gotoXY(DECALAGE,2);
				write(joueurs[1].pseudo,' a les ronds');
				gotoXY(DECALAGE,3);
				write(joueurs[2].pseudo,' a les croix');
			end;
			
			//on récupere l'heure de début
			debutHeure:=timetostr(Time);
			
			
			tour:=0;
			choix:=' ';
			recommencer:=true;
			fin:=3;
			
			initTab(grilleJoueur);
			
			afficherGrille();
			afficherAide();
			gotoXY(DECALAGECONSOLEX+1,DECALAGECONSOLEY-1);
			write('Manche ',i);
			
			//début de la manche
			repeat
				
				gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY-4);
				write(joueurs[1].pseudo,': ', joueurs[1].manches, ' manche(s) gagne');
				gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY-3);
				write(joueurs[2].pseudo,': ', joueurs[2].manches, ' manche(s) gagne');
			//début du jeu
				clrtxt;
				inc(tour);
				case debut of
					1:begin
							case joueurs[1].forme of
								1:tourJoueur(joueurs[1].pseudo,grilleJoueur,1);
								2:tourJoueur(joueurs[1].pseudo,grilleJoueur,2);
							end;
						end;
					2:begin
							case joueurs[2].forme of
								1:tourJoueur(joueurs[2].pseudo,grilleJoueur,1);
								2:tourJoueur(joueurs[2].pseudo,grilleJoueur,2);
							end;
						end;
				end;
				
				//inverse le tour des joueurs
				if debut=1 then
				begin
					joueurs[debut].nbrcoups[i]:=joueurs[debut].nbrcoups[i]+1;
					debut:=2
				end
				else
					begin
						joueurs[debut].nbrcoups[i]:=joueurs[debut].nbrcoups[i]+1;
						debut:=1;
					end;
					
				if tour>=5 then	fin:=testFin(grilleJoueur);
			until (tour=9) or (fin=1) or (fin=2);
			
			clrtxt;
			
			//verifie quel forme (rond ou croix) fini la manche
			if joueurs[1].forme=fin then
			begin
				gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY);
				write(joueurs[1].pseudo,' a gagner la manche');
				joueurs[1].manches:=joueurs[1].manches+1;
			end
			else
				if joueurs[2].forme=fin then
				begin
					gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY);
					write(joueurs[2].pseudo,' a gagner la manche');
					joueurs[2].manches:=joueurs[2].manches+1;
				end
				else
				begin
					gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY);
					write('Egalite !');
				end;
			
			gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY+1);
			write('Apuyez sur entrer');
			readln;
			
			//si la boucle atteint le nbr de manche, la partie est terminé
			if i=manches then
			begin
				clrtxt;
				if joueurs[1].manches>joueurs[2].manches then
				begin
					gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY);
					writeln(joueurs[1].pseudo, ' a gagner');
				end
				else
					if joueurs[2].manches>joueurs[1].manches then
					begin
						gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY);
						writeln(joueurs[2].pseudo, ' a gagner');
					end
					else
						begin
							gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY);
							writeln('Egalite');
						end;
			end;
			
			gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY-4);
			write(joueurs[1].pseudo,': ', joueurs[1].manches, ' manche(s) gagne');
			gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY-3);
			write(joueurs[2].pseudo,': ', joueurs[2].manches, ' manche(s) gagne');
		end;
		
		finHeure:=timetostr(Time);
		
		//on créer le fichier
		createFichier(fichier,joueurs,debutHeure,finHeure);
		
		//propose de recommencer
		gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY+1);
		write('Voulez vous rejouer ? O/N');
		repeat
			gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY+2);
			write('- ');
			readln(choix);
			choix:=upcase(choix);
			if (choix<>'O') OR (choix<>'N') then
			begin
				gotoXY(DECALAGECONSOLEX,DECALAGECONSOLEY+3);
				write('Erreur, O ou N');
			end;
		until (choix='O') or (choix='N');
		clrtxt;
		
		if choix='N' then recommencer:=false;.
		
		initJoueurs(joueurs);
	until recommencer=false;
	
	clrscr;
	
	writeln('Developper par Geuks.');
	writeln('Merci d''avoir jouer !');
	
	readln;
end.


//**************************FIN****PRINCIPAL**************************************
