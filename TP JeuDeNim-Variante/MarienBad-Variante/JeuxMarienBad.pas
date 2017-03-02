	{//BUT:Le jeu se joue à deux. Les deux joueurs se partagent un tas de 21 allumettes.
À tour de rôle, ils doivent retirer 1, 2 ou 3 allumettes du tas ;
le joueur qui retire la dernière allumette a perdu.}
//ENTREE:des entiers donnès par 2 joueurs
//SORTIE:1 gagnant
program JeuNim;

uses crt;

const
	MAXx=16;	//Nbr d'allumettes max
	MAXy=4;		//nbr de lignes

Type
	T=array[1..(MAXx DIV 2)-1] of integer;


	//BUT: Pseudo du joueur
//ENTREE:1 chaine
//SORTIE:stock dans une variable
procedure PseudoJoueur(var pseudo:string;joueur:integer);
begin

	repeat		//pseudo joueur 1
		write('Entrez le pseudo du joueur ',joueur,' (8 caracteres max):');
		readln(pseudo);
		if (pseudo='') OR (length(pseudo)>8) then
		begin
			writeln('Error');
			delay(1500);
			clrscr;
		end;
	until (pseudo<>'') AND (length(pseudo)<=8);

end;
//


//BUT:Initialise les valeur des allumettes sur chaque ligne
//ENTREE:1 tableau 2 entiers
//SORTIE:valeur initialisé du tableau
procedure InitAllumettes(var allumettes:T);
var
	i,cpt:integer;
begin
	
	cpt:=0;
	for i:=1 to MAXy do
	begin
		allumettes[i]:=1+cpt;
		cpt:=cpt+2;
	end;
	
end;
//


//BUT:affiche le nombre d'allumettes restante sur l'ecran de l'utilisateur
//ENTREE:1 tableau, 2 entiers
//SORTIE:affichage
procedure AfficheAllumettes(allumettes:T);
var
	i,j:integer;
begin
	
	for i:=1 to MAXy do
	begin
		write(i,': ');
		for j:=1 to allumettes[i] do
		begin
			write('|');
		end;
		writeln;
	end;
	
end;
//


//BUT:le tour d'un joueur 
//ENTREE:1 tableau 1 chaine 3 entiers
//SORTIE:1 entiers
procedure TourJoueur(joueur:string;var allumettes:T);
var
	i,x,y:integer;
begin
	
	writeln('Nombre d''allumettes restante(s): ');
	textcolor(lightgray);
	AfficheAllumettes(allumettes);
	textcolor(white);
	
	writeln('A vous de jouer ',joueur);
	
	repeat
		write('Ligne: ');
		readln(y);
		if (y<1) OR (y>4) then
		begin
			textcolor(red);
			writeln('Erreur 1-',MAXy,' max');
			textcolor(white);
		end
		else 
			if (allumettes[y]=0) then
				writeln('Il n''ya plus d''allumettes.');
	until (y>0) AND (y<5) AND (allumettes[y]<>0);
	
	writeln('Combien voulez vous retirer d''alumettes ?');
	
	repeat
		write('- ');
		readln(x);
		if (x<1) OR (x>allumettes[y]) then
		begin
			textcolor(red);
			writeln('Erreur 1-',allumettes[y],' max');
			textcolor(white);
		end;
	until (x>0) AND (x<=allumettes[y]);
	
	allumettes[y]:=allumettes[y]-x;

end;
//


//BUT:Test si il n'y a plus d'allumette
//ENTREE:1 tableau 1 entier 1 booleen
//SORTIE:1 booleen
function TestFin(allumettes:T):boolean;
var
	i:integer;
	test:boolean;
begin

	test:=true;
	
	for i:=1 to MAXy do
	begin
		if allumettes[i]<>0 then
			test:=false;
	end;
	
	TestFin:=test;

end;
//


	//Programme principal
var
	allumettes:T;
	joueur1,joueur2:string;
  test,perdu:boolean;
begin
	clrscr;
	test:=false;
	textcolor(white);
	
	writeln('Bonjour et bienvenue dans le jeu de Nim !');
	
	PseudoJoueur(joueur1,1);
	PseudoJoueur(joueur2,2);
	
	
	clrscr;
	
	writeln('Le jeu se joue a deux.');
	writeln('Les deux joueurs se partagent un tas de 16 allumettes sur 4 lignes. ');
	writeln('A tour de role, ils doivent retirer des allumettes dans une seule des lignes ; ');
	writeln('le joueur qui retire la derniere allumette a perdu.');
	
	readln;
	
	clrscr;
	
	InitAllumettes(allumettes);
	
	repeat
		
		if test=false then TourJoueur(joueur1,allumettes);
		test:=TestFin(allumettes);
		if test=true then writeln(joueur1, ' a perdu !');
		
		if test=false then TourJoueur(joueur2,allumettes);
		test:=TestFin(allumettes);
		if test=true then writeln(joueur2, ' a perdu !');
		
	until test=true;
	
	writeln('Fin de la partie !');
	
	
	
	readln;
end.
