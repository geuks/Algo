//BUT:Le jeu du pendu consiste à trouver un mot caché, dont on connaît initialement le nombre de lettres. 
//ENTREE:1 chaine 1 caractere
//SORTIE:1 chaine 1 booleen
program Pendu;

uses crt;


//BUT:Affiche les partie du pendu
//ENTREE:3 entier
//SORTIE:affichage
procedure AffichagePendu(erreur:integer);
var
	i,j:integer;
begin

	case erreur of
		1:begin		//poteau bas
				textcolor(8);
				GotoXY(60,28);
				write('_____');
				textcolor(15);
			end;
		
		2:begin//poteau
				textcolor(8);
				for i:=10 to 28 do
				begin
					GotoXY(62,i);
					write('|');
				end;
				textcolor(15);
			end;
		
		3:begin//poteau haut
				textcolor(8);
				for i:=62 to 72 do
				begin
					GotoXY(i,9);
					write('_');
				end;
				textcolor(15);
			end;
		
		4:begin//corde
				textcolor(lightgray);
				for i:=10 to 13 do
				begin
					GotoXY(72,i);
					write('|');
				end;
				textcolor(15);
			end;
		
		5:begin//tete
				for i:=14 to 18 do
				begin
					GotoXY(69,i);
					write('|');
					GotoXY(75,i);
					write('|');
				end;
				
				for i:=70 to 74 do
					begin
						if i<>72 then
						begin
							GotoXY(i,13);
							write('_');
						end;
						GotoXY(i,18);
						write('_');
					end;
			end;
		
		6:begin//corp
				for i:=19 to 24 do
				begin
					GotoXY(72,i);
					write('|');
				end;
			end;
		
		7:begin//bras gauche
				for i:=67 to 71 do
				begin
					GotoXY(i,20);
					write('_');
				end;
				
				GotoXY(66,20);
				write('#');
			end;
		
		8:begin//bras droit
				for i:=73 to 77 do
				begin
					GotoXY(i,20);
					write('_');
				end;
				
				GotoXY(78,20);
				write('#');
			end;
		
		9:begin//jambe gauche
				for i:=70 to 71 do
				begin
					GotoXY(i,24);
					write('_');
				end;
				
				for i:=25 to 27 do
				begin
					GotoXY(69,i);
					write('|');
				end;
				
				GotoXY(68,27);
				write('_');
			end;
		
		10:begin//jambe droite
				for i:=73 to 74 do
				begin
					GotoXY(i,24);
					write('_');
				end;
				
				for i:=25 to 27 do
				begin
					GotoXY(75,i);
					write('|');
				end;
				
				GotoXY(76,27);
				write('_');
			end;
		
		11:begin//visage
				textcolor(red);
				GotoXY(71,15);
				write('X');
				
				GotoXY(73,15);
				write('X');
				textcolor(lightgray);
				
				GotoXY(72,16);
				write(Chr(30));
				
				for i:=71 to 73 do
				begin
					GotoXY(i,17);
					write('_')
				end;
			end;
	end;

end;
//


//BUT:Le mot que l'utilisateur veut faire deviner
//ENTREE:2 chaine 1 entier
//SORTIE:2 chaine
procedure EntreeMot(var mot,trouve:string);
var
	i:integer;
begin

	repeat
		writeln('Entrez le mot que vous voulez faire deviner');
		writeln('3 a 12 caracteres maximum.');
		write('- ');
	
		readln(mot);
		mot:=Upcase(mot);
		if (Length(mot)<2) OR (Length(mot)>13) OR (mot='') OR (mot<Chr(65)) OR (mot>Chr(90)) then
		begin
			writeln('Erreur');
			delay(1500);
			clrscr;
		end;
	until (Length(mot)>2) AND (Length(mot)<13) AND (mot<>'') AND (mot>Chr(64)) AND (mot<Chr(91));
	
	trouve:=mot;
	
	for i:=1 to Length(trouve) do
	begin
		trouve[i]:='_';
	end;

end;
//


//BUT:permet d'effacer le text a gauche de lecran
//ENTREE:2 entier
//SORTIE:text effacer
procedure clrtxt ();
var
	i,j:integer;
begin

	for i:=1 to 10 do
	begin
		for j:=1 to 40 do
		begin
			GotoXY(j,i);
			write(' ');
		end;
	end;

end;
//


//BUT:La lettre que l'utilisateur veut tester
//ENTREE:1 caractere
//SORTIE:1 caractere
procedure EntreeLettre(var lettre:char);
begin
	repeat
		writeln('Entrez une lettre');
		write('- ');
		readln(lettre);
		lettre:=Upcase(lettre);
		if (lettre<Chr(65)) OR (lettre>Chr(90)) OR (lettre='') then
		begin
			writeln('Erreur');
			delay(500);
		end;
	until (lettre>Chr(64)) AND (lettre<Chr(91)) AND (lettre<>'');
	
end;
//


//BUT:Affiche le nombre de lettre restante et trouver par l'utilisateur
//ENTREE:1 entier 1 chaine
//SORTIE:affichage
procedure AffichageMotTrouve (trouve:string);
var
	i:integer;
begin
	
	for i:=1 to Length(trouve) do
	begin
		write(trouve[i],' ');
	end;

end;
//


//BUT:Test de la lettre si elle est dans le mot a trouvé
//ENTREE:1 caractere 2 chaine 1 entier 1 booleen
//SORTIE:1 booleen 1 chaine
function TestLettre(lettre:char;mot:string; var trouve:string):boolean;
var
	i:integer;
  test:boolean;
begin
	
	test:=false;
	
	for i:=1 to Length(mot) do
	begin
	
		if lettre=mot[i] then
		begin
			trouve[i]:=mot[i];
			test:=true;
		end;

	end;

	TestLettre:=test;

end;
//


//Programme Principal
var
	erreur,i:integer;
	mot,trouve:string;//mot = mot a trouve ; trouve = nombre de lettre que lutilisateur a trouver
	lettre:char;
  test:boolean;
begin

	clrscr;
	textcolor(15);
	erreur:=0;

	//PARTIE PRESENTATION DU JEU A L'UTILISATEUR
	writeln('Bonjour et bienvenue dans le jeu du pendu !');
	writeln('Le but est de trouver le mot caché en indiquant lettre par lettre');
	writeln('et en se trompant un minimum de fois,');
	writeln('en sachant que le nombre d''erreur maximum est 11');
	readln;

	writeln('Voici le pendu :');

	//affichage du pendu en entier
	textcolor(lightgray);
	for i:=1 to 11 do
  begin
		AffichagePendu(i);
		Delay(500);
	end;
	textcolor(white);
	//fin affichage

	GotoXY(1,6);
	write('Bonne chance !  ');

	writeln;
	writeln('Patientez.... Le jeu va demarrer');
	Delay(4000);
	//FIN PRESENTATION

	clrscr;//on efface l'ecran de presentation


	//utilisateur entre le mot a deviner
	EntreeMot(mot,trouve);
	//

	clrscr;//on efface l'ecran du mot a deviner
	
	//Boucle de tour de jeu
	repeat
		clrtxt;//procedure qui permet deffacer juste le texte a gauche
		GotoXY(1,1);
		writeln('Vous avez ',erreur,' erreur(s)');
		write('Le mot est : ');
		AffichageMotTrouve(trouve);//on affiche le mot a trouvé avec des '_'

		writeln;
		writeln;

		EntreeLettre(lettre);
		//on test si la lettre est bien dans le mot
		Test:=TestLettre(lettre,mot,trouve);
		
		if test=true then
		begin
			writeln('Bravo vous avez trouver !');
			Delay(1500);
		end
		else
		begin
			writeln('Desole vous n''avez pas trouver!');
			Delay(1500);
			erreur:=erreur+1;
			AffichagePendu(erreur);//on affiche une partie du pendu si la lettre est pas dans le mot
		end;
	until (mot=trouve) OR (erreur=11);
	
	clrtxt;
	
	GotoXY(1,1);
	
	if erreur=11 then
		writeln('Vous avez ete pendu !')
	else
		writeln('Bravo !');
	
	writeln('Le mot etait :',mot);
	writeln;
	writeln;
	writeln('Merci d''avoir jouer !');
	writeln('Developper par Geuks.');
	
	readln;
end.
