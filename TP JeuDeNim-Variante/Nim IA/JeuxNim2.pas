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
procedure PseudoJoueur(var pseudo:string);
begin

	repeat		//pseudo joueur 1
		write('Entrez le pseudo du joueur (8 caractere max):');
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
//ENTREE:1 chaine 2 entier
//SORTIE:1 entier 1 booleen
procedure TourJoueurs(pseudo1:string;var allumettes:integer;var perdu:boolean);
var
	NbrRetire,i:integer;
begin

	writeln('Nombre d''allumettes restante(s): ',allumettes);
	write('- ');
	for i:=1 to allumettes do
		write('|');
	
	writeln;
	
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
	
	if allumettes=0 then perdu:=true;
	
	writeln;
	
end;
//


	//BUT:Verifie si la valeur est bien un multiple de 4 +1
//ENTREE:2 entier
//SORTIE:1 booleen
function TestIA(allumettes,NbrRetire:integer):boolean;
var
	test:boolean;
begin
	if ((allumettes-NbrRetire)MOD 4 =0+1) then TestIA:= true
	else
		TestIA:=false;
end;
//


	//BUT:Tour de l'IA
//ENTREE:2 entier 1 booleen
//SORTIE:1 entier 1 booleen
procedure TourIA(Var allumettes:integer;var perduIA:boolean);
var
	NbrRetire,i,test2:integer;
  test:boolean;
begin
	textcolor(red);
	
	test2:=0;
	test:=false;
	
	writeln('Au tour de l''IA !');
	writeln('Nombre d''allumettes restante(s): ',allumettes);
	write('- ');
	for i:=1 to allumettes do
		write('|');
	
	writeln;
	repeat
		NbrRetire:=Random(3)+1;
		test:=TestIA(allumettes,NbrRetire);
		test2:=test2+1;//si a partir de 10 fois il ne trouve pas renvoie un nombre au hasard
	until ((test=true) AND (allumettes-NbrRetire>=0)) OR ((test2>10) AND (allumettes-NbrRetire>=0));
	
	writeln('L''IA retire ',NbrRetire);
	allumettes:=allumettes-NbrRetire;
	
	if allumettes=0 then perduIA:=true;
	
	writeln;
	
	textcolor(white);
	
end;
//


	//Programme principal
var
	allumettes,premier:integer;
	joueur1,IA:string;
	perdu,perduIA:boolean;
begin
	clrscr;
	textcolor(white);
	
	//init des valeurs
	Randomize;
	
	allumettes:=MAX;
	perdu:=false;
	perduIA:=false;
	//
	
	
	writeln('Bonjour et bienvenue dans le jeu de Nim !');
	
	//on recupere le pseudo du joueur
	PseudoJoueur(joueur1);

	clrscr;
	
	writeln('Le jeu se joue a deux.');
	writeln('Les deux joueurs se partagent un tas de 21 allumettes. ');
	writeln('A tour de role, ils doivent retirer 1, 2 ou 3 allumettes du tas ; ');
	writeln('le joueur qui retire la derniere allumette a perdu.');
	
	readln;
	
	clrscr;
	
	//celui qui commence aleatoirement
	premier:=Random(2)+1;

	//boucle de test jusqua qu'il n'y a plus d'allumette
	repeat
		
		case premier of
			1:begin
					if allumettes>0 then TourJoueurs(joueur1,allumettes,perdu);
					if perdu=true then writeln(joueur1, ' a perdu !');
				end;
			
			2:begin
					if allumettes>0 then TourIA(allumettes,perduIA);
					if perduIA=true then writeln('IA a perdu !');
				end;
		end;
			
			if premier=1 then premier:=2	//pour que les tour se passe dans l'ordre
			else
				premier:=1;
				
	until allumettes=0;
	//
	
	writeln('Fin de la partie !');
	
	
	readln;
end.
