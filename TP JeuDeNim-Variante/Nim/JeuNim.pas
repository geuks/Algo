{//BUT:Le jeu se joue à deux. Les deux joueurs se partagent un tas de 21 allumettes.
À tour de rôle, ils doivent retirer 1, 2 ou 3 allumettes du tas ;
le joueur qui retire la dernière allumette a perdu.}
//ENTREE:des entiers donnès par 2 joueurs
//SORTIE:1 gagnant
program JeuNim;

uses crt;

const
	MAX=21;	//Nbr d'allumettes max


	//BUT: Pseudo du joueur
//ENTREE:1 chaine
//SORTIE:stock dans une variable
procedure PseudoJoueur(var pseudo:string;joueur:integer);
begin
	
	repeat		//pseudo joueur 1
		write('Entrez le pseudo du joueur ',joueur,' (8 caractere max):');
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
	

	//BUT:Test si la valeur entree est bien entre 1 et 3 et que les allumettes restante soit superieur ou egale a 0
//ENTREE:2 entiers
//SORTIE:1 booleen
function TestValeur(nbr:integer;allumettes:integer):boolean;
var
	test:boolean;
begin
	test:=false;
	if (nbr>0) AND (nbr<4) AND (allumettes-nbr>=0) then test:=true;
	
	TestValeur:=test;
end;
//


	//BUT:Tour d'un joueur
//ENTREE:1 chaine 1 entier
//SORTIE:1 entier
procedure TourJoueurs(pseudo1:string;var allumettes:integer);
var
	NbrRetire:integer;
begin

	writeln('Nombre d''allumettes restante(s): ',allumettes);
	
	repeat
		writeln('Combien d''allumettes voulez-vous retirer ',pseudo1,' 1-3 ? ');
		write('- ');

		readln(NbrRetire);
		if (TestValeur(NbrRetire,allumettes)=false) AND (allumettes-NbrRetire>=0)then
			writeln('Erreur 1 a 3');
			
		if allumettes-NbrRetire<0 then
			writeln('Erreur le nombre d''allumettes ne peut pas etre negatif');
			
	until TestValeur(NbrRetire,allumettes)=true;
	
	allumettes:=allumettes-NbrRetire;
	
end;
//


	//Programme principal
var
	allumettes:integer;
	joueur1,joueur2:string;
begin
	clrscr;
	
	allumettes:=MAX;
	
	writeln('Bonjour et bienvenue dans le jeu de Nim !');
	
	//on recupere les pseudo des joueurs
	PseudoJoueur(joueur1,1);
	PseudoJoueur(joueur2,2);
	//
	
	clrscr;
	
	writeln('Le jeu se joue a deux.');
	writeln('Les deux joueurs se partagent un tas de 21 allumettes. ');
	writeln('A tour de role, ils doivent retirer 1, 2 ou 3 allumettes du tas ; ');
	writeln('le joueur qui retire la derniere allumette a perdu.');
	
	readln;
	
	clrscr;
	
	repeat
		
		if allumettes>0 then TourJoueurs(joueur1,allumettes);
		if allumettes=0 then writeln(joueur1, ' a perdu !');
		
		if allumettes>0 then TourJoueurs(joueur2,allumettes);
		if allumettes=0 then writeln(joueur2, ' a perdu !');
		
	until allumettes=0;
	
	writeln('Fin de la partie !');
	
	
	readln;
end.