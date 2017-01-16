//_______________________________________________________________________________
//BUT: Carre Magique
//ENTREE: 1 tableau 1 entier
//SORTIE: 1 entier et affichage tableau
//_______________________________________________________________________________



program CarreMagique;

uses crt;

CONST
	MAX=5;
	
Type
	Tableau2D=array [1..MAX,1..MAX] of integer;

	
//_______________________________________________________________________________
//BUT: Initialisation tableau
//ENTREE:1 tableau
//SORTIE:1 tableau avec valeur 0
//_______________________________________________________________________________
procedure InitT(var T:Tableau2D);

var
	i,j:integer;
	
begin

	for i:=1 to MAX do
	begin
		for j:=1 to MAX do
		begin
			T[i,j]:=0;
		end;
	end;

end;


//_______________________________________________________________________________
//BUT:Test si la valeur et inferieur a 1 mettre a MAX, si la valeur est a MAX mettre a 1
//ENTREE: 2 entier
//SORTIE: 2 entier
//_______________________________________________________________________________
procedure TestValeurNbrXY(var PosNbrX,PosNbrY:integer);
begin
	repeat
		//droite-gauche
		if PosNbrX>MAX then 
		begin
			PosNbrX:=PosNbrX-MAX;
		end
		//
		//gauche-droite
		else
			if PosNbrX<1 then
			begin
				PosNbrX:=PosNbrX+MAX
			end;
		//
		
		//bas-haut
		if PosNbrY>MAX then
		begin
			PosNbrY:=PosNbrY-MAX;
		end
		//haut-bas
		else	
			if PosNbrY<1 then
			begin
				PosNbrY:=PosNbrY+MAX;
			end;
		//
		until ((PosNbrX>=1) AND (PosNbrX<=MAX)) AND ((PosNbrY>=1) AND (PosNbrY<=MAX));

end;




//_______________________________________________________________________________
//BUT:Valeur du tableau(avec condition nord ouest etc)
//ENTREE: 1 tableau 3 entier
//SORTIE:1 tableau
//_______________________________________________________________________________
procedure ValeurT(var T:Tableau2D; var PosNbrX,PosNbrY:integer);
var
	nbr:integer;

begin
	
	nbr:=1;
	//init depart du carre magique
	PosNbrX:=(MAX DIV 2)+1;
	PosNbrY:=(MAX DIV 2);
	//
	
  for nbr:=1 to MAX*MAX do
	begin	
		
		//on test x,y 
		TestValeurNbrXY(PosNbrX,PosNbrY);
		//
		
		//on test si la valeur n''ai pas 0
		if (T[PosNbrX,PosNbrY]<>0) then
		begin
			//si elle l'ai on remplace x,y
			PosNbrX:=PosNbrX-1;
			PosNbrY:=PosNbrY-1;
			//
			
			//2 eme test x,y
			TestValeurNbrXY(PosNbrX,PosNbrY);
			//
		end;
		//
		
		//on remplace
		T[PosNbrX,PosNbrY]:=nbr;
		//
		
		//on continue
		PosNbrX:=PosNbrX+1; 
		PosNbrY:=PosNbrY-1;
		//
		
	end;

end;


//_______________________________________________________________________________
//BUT:affiche les valeur d'un tableau
//ENTREE: 2 entier 1 tableau
//SORTIE:affiche N entier
//_______________________________________________________________________________
procedure AfficherT(var T:Tableau2D);
var
	i,j:integer;
begin

	for i:=1 to MAX do
	begin
		for j:=1 to MAX do
		begin
			write(' ',T[j,i]);
		end;
		
		writeln;
		writeln;
	end;

end;



var
	T:Tableau2D;
	resultat,PosNbrX,PosNbrY:integer;
	
begin
	
	clrscr;
	
	InitT(T);//init du tableau
	
	writeln('Bonjour voici le carre magique en ', MAX, 'x', MAX);
	
	ValeurT(T,PosNbrX,PosNbrY);//valeur du tableau
	
	writeln;
	
	//affiche le tableau
	AfficherT(T);
	
	//nombre magique
	resultat := MAX*(MAX*MAX+1) div 2;
	writeln('Le resultat du carre magique est : ', resultat);
	
  readln;	

end.
