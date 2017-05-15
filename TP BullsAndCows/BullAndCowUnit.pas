{***************************BUT****PRINCIPAL****************************************
  *
   *_CREATEUR:UNALAN G�khan
   *
   *______BUT:Jeu de Bull & Cows
   *           L'utilisateur entre un mot (chaine) et doit trouver le mot cach�.
   *           Bulls=Code correct et � la bonne position.
   *           Cows=Code correct mais � la mauvaise position.
   *
   *___ENTREE:L'utilisateur entre un mot (chaine).
   * 
   *___SORTIE:Une fois le nombre de faute atteint ou que l'utilisateur trouve le mot,
   *           il gagne ou perd la partie, il peut recommencer ou quitter.
  *
***********************************************************************************}
unit BullAndCowUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls;
  
type
  TFBullsCows = class(TForm)
  
    EMot: TEdit;  //partie ou l'utilisateur entre le mot
    EBulls: TEdit; //affiche le nbr de bulls
    ECows: TEdit;  //affiche le nbr de cows
    EFaute: TEdit; //affiche le nbr de faute de l'utilisateur
    EEssai: TEdit; //affiche le nbr de faute MAX

    //Remplace le Label, aide pour l'interface
    PMot: TPanel;
    PBulls: TPanel;
    PCows: TPanel;
    PFaute: TPanel;
    PEssai: TPanel;
    PText: TPanel;
    PTaille: TPanel;
    
    BCheck: TButton;  //v�rifie si l'utilisateur � trouver le mot
    BRestart: TButton;  //relance la partie
    BQuit: TButton;   //quitte l'application
    BRegle: TButton;  //affiche les r�gles du jeu

    MHistorique: TMemo; //memo pour stocker les mot d�j� tapper
    MDictionnaire: TMemo; //memo pour stocker la biblioteque
    TText: TTimer;  //timer pour effacer le message (5sc)

    IFond: TImage;//image de fond
    
    procedure BQuitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BCheckClick(Sender: TObject);
    procedure TTextTimer(Sender: TObject);
    procedure BRestartClick(Sender: TObject);
    procedure redemarreCpt();
    procedure BRegleClick(Sender: TObject);
  private
    { D�clarations priv�es }
    mot:string;//Le mot � trouv�
    nbrFaute:integer;//Nbr de faute max
    faute:integer;//Nbr de faute du joueur
  public
    { D�clarations publiques }
  end;

  Type
      etat=(isOk,isMin,isIso,isIn);

  var
  FBullsCows: TFBullsCows;

implementation

{$R *.dfm}

{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Redemarre et r�initialise le timer.
	 *__ENTREE:1 timer 
	 *__SORTIE:le timer est r�initialiser
*********************************************************************************}
procedure TFBullsCows.redemarreCpt();
begin
  if TText.Enabled=true then  //si le timer est activ�
  begin
    TText.Enabled:=false;  //d�sactive
    TText.Enabled:=true;   //r�active
  end
  else
    TText.Enabled:=true;    //si il n'est pas activ� alors on l'active
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Renvoie une valeur en fonction de la longueur du mot donn� en param�tre.
	 *__ENTREE:1 chaine en parametre et 1 entier en local. 
	 *__SORTIE:Renvoie 1 entier
*********************************************************************************}
function calcFaute(mot:string):integer;
var
  nbr:integer;//variable de stockage
begin
  nbr:=0;
  case Length(mot) of
    3:nbr:=4;
    4:nbr:=7;
    5:nbr:=10;
    6:nbr:=16;
    7:nbr:=20;
    8:nbr:=24;
    9:nbr:=27;
  end;

  calcFaute:=nbr;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:V�rifie si le mot donn� en param�tre ne contient que des minuscule, 
   *          et renvoie un bool�en. 
	 *__ENTREE:1 chaine en param�tre, 1 entier et 1 bool�en en local.
	 *__SORTIE:Renvoie 1 bool�en.
*********************************************************************************}
function testMin(mot:string):etat;
var
  i: Integer;//boucle
  test:etat;//variable de stockage
begin
  test:=isMin;
  for i := 1 to Length(mot) do
    if (mot[i]<'a') OR (mot[i]>'z') then
      test:=isOk;
  testMin:=test;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Renvoie le nombre de bulls dans une chaine donn�e 
   *          en param�tre avec une autre. 
	 *__ENTREE:2 chaine en param�tre, 2 entier en local 
	 *__SORTIE:Renvoie 1 entier
*********************************************************************************}
function nbrBulls(mEntree,mFinal:string):integer;
var
  i:integer;  //boucle
  cpt: Integer; //compteur de bulls
begin
  cpt:=0;
  for i := 1 to Length(mEntree) do
    if mEntree[i]=mFinal[i] then
      inc(cpt);
  nbrBulls:=cpt;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Renvoie le nombre de cows dans une chaine donn�e 
   *          en param�tre avec une autre. 
	 *__ENTREE:2 chaine en param�tre, 3 entier en local 
	 *__SORTIE:Renvoie 1 entier
*********************************************************************************}
function nbrCows(mEntree,mFinal:string):integer;
var
  i,j:integer;  //boucle
  cpt:integer;  //compteur de cows
begin
  cpt:=0;
  for i := 1 to Length(mEntree) do
    for j := 1 to Length(mEntree) do
      if (mEntree[i]=mFinal[j]) AND (i<>j) then
        inc(cpt);
  nbrCows:=cpt;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Verifie si une chaine est dans un memo 
	 *__ENTREE:1 chaine et 1 TMemo en parametre, 1 entier et 1 boolean en local 
	 *__SORTIE:Renvoie 1 booleen
*********************************************************************************}
function testExiste(mEntree:string; MHistorique:TMemo):etat;
var
  i: Integer;//boucle
  test:etat;//variable de stockage
begin
  test:=isIn;
  for i := 0 to MHistorique.Lines.Count-1 do
    if mEntree=MHistorique.Lines[i] then
      test:=isOk;
  testExiste:=test;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Verifie si dans une chaine il y a la m�me lettre 
	 *__ENTREE:1 chaine en parametre, 2 entier et 1 booleen en local 
	 *__SORTIE:Renvoie 1 booleen
*********************************************************************************}
function testMemeLettre(mEntree:string):etat;
var
  i,j:integer;//boucle
  test:etat;//variable de stockage
begin
  test:=isIso;
  for i := 1 to Length(mEntree) do
    for j := 1 to Length(mEntree) do
      if (mEntree[i]=mEntree[j]) AND (i<>j) then
        test:=isOk;
  testMemeLettre:=test;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Au clique du bouton Check (BCheck) 
	 *__ENTREE:1 TObject en param�tre, 2 chaine et 2 entier en locale 
	 *__SORTIE:Affiche si l'utilisateur � gagner, perdu, ou qu'il a fait une erreur.
*********************************************************************************}
procedure TFBullsCows.BCheckClick(Sender: TObject);
var
  mEntree:string; //mot entr�e par l'utilisateur
  mFinal:string;  //mot � trouver
  bulls,cows:integer; //Nbr de bulls/cows
begin
  mFinal:=mot;  //on affecte le mot � trouver
  mEntree:=EMot.Text; //on affecte le mot entr�e par l'utilisateur

  //si la longueur du mot est la m�me que le mot � trouver
  if Length(mEntree)=Length(mot) then
  begin
    //Si toute les lettres sont minuscule
    if testMin(mEntree)=isMin then
    begin
      //Si il n'y a pas 2 fois la m�me lettre dans le mot tapper
      if testMemeLettre(mEntree)=isIso then
      begin
        //Si le mot entr� n'a pas �t� tapper
        if testExiste(mEntree,MHistorique)=isIn then
        begin
          bulls:=nbrBulls(mEntree,mFinal);  //calcul le nbr de bulls
          cows:=nbrCows(mEntree,mFinal);    //calcul le nbr de cows

          //affiche le resultat � l'�cran
          EBulls.Text:=inttostr(bulls);
          ECows.Text:=inttostr(cows);

          if (bulls=Length(mot)) then //GAGNE
          begin
            PText.Caption:='Bravo ! Le mot �tait bien '+mot+'.';
            BRestartClick(Sender);  //On force le restart en appelant la proc�dure
          end
          else
            if (faute=nbrFaute) then //PERDU
            begin
              PText.Caption:='Perdu ! Le mot �tait '+mot+'.';
              BRestartClick(Sender);  //On force le restart en appelant la proc�dure
            end
            else  //FAUTE
            begin
              inc(faute); //incr�mente la variable
              //affiche � l'�cran
              PText.Caption:='C''est votre '+inttostr(faute)+' essai(s).';
              redemarreCpt; //Redemarre le compteur
              //ajoute le mot dans le memo
              MHistorique.Lines.Add(EMot.Text);
              {permet d'avoir la scroll bar toujours en bas pour que l'utilisateur 
                puisse voir le dernier mot}
              SendMessage(MHistorique.Handle,WM_VSCROLL,SB_BOTTOM,0);
            end;
        end
        //Sinon le mot � �tait tapper
        else
        begin
          redemarreCpt; //Redemarre le compteur
          PText.Caption:='Vous avez d�j� �crit ce mot.';
        end;
      end
      //Sinon le mot � au minimum 2 fois la meme lettre
      else
      begin
        redemarreCpt; //Redemarre le compteur
        PText.Caption:='Il ne peut y avoir plus de 2 fois la m�me lettre.';
      end;
    end
    //Sinon les lettres ne sont pas minuscule
    else
    begin
      redemarreCpt; //Redemarre le compteur
      PText.Caption:='Erreur, le mot doit �tre en minuscule.';
    end;
  end
  //Sinon le mot entr�e ne fait pas la m�me taille que le mot
  else
  begin
    redemarreCpt; //Redemarre le compteur 
    PText.Caption:='Erreur, le mot doit faire '+inttostr(Length(mot))+' lettres.';
  end;

  //Affiche � l'�cran
  EFaute.Text:=inttostr(faute);
  EEssai.Text:=inttostr(nbrFaute);

  EMot.SetFocus;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Au clique du bouton Quit (BQuit) 
	 *__ENTREE:1 TObject en param�tre 
	 *__SORTIE:Affiche un message dialog qui permet � l'utilisateur de quitter.
*********************************************************************************}
procedure TFBullsCows.BQuitClick(Sender: TObject);
begin
  if MessageDlg('Voulez-vous vraiment quitter?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then Close;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Au clique du bouton R�gle (BRegle) 
	 *__ENTREE:1 TObject en param�tre 
	 *__SORTIE:Affiche un message dialog qui permet de lire les r�gles
*********************************************************************************}
procedure TFBullsCows.BRegleClick(Sender: TObject);
begin
  redemarreCpt;
  MessageDlg('D�couvre le code cach� !' +#13#10+ 'Bulls=Code correct et � la bonne position.' +
                 #13#10+'Cows=Code correct mais � la mauvaise position.', 
                 mtInformation,[mbOk], 0, mbOk);
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Au clique du bouton Restart (BRestart) 
	 *__ENTREE:1 TObject en param�tre 
	 *__SORTIE:Affiche un message dialog qui permet � l'utilisateur de recommencer la partie
*********************************************************************************}
procedure TFBullsCows.BRestartClick(Sender: TObject);
begin
  if MessageDlg('Voulez-vous recommencer?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    //Si l'utilisateur clique sur oui, on r�initialise les valeurs des variables
    faute:=0;
    mot:=MDictionnaire.Lines[Random(MDictionnaire.Lines.Count-1)];
    nbrFaute:=calcFaute(mot);
    MHistorique.Text:='';

    //Affiche � l'�cran
    EBulls.Text:='0';
    ECows.Text:='0';
    EFaute.Text:=inttostr(faute);
    EEssai.Text:=inttostr(nbrFaute);
    EMot.Text:='';
    PTaille.Caption:='Taille: '+inttostr(Length(mot));
    PText.Caption:='';
    PText.Caption:='Nouvelle Partie.';

    EMot.SetFocus;
    //Redemarre le compteur
    redemarreCpt;
  end
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:A la cr�ation de l'application 
	 *__ENTREE:1 TObject en param�tre
	 *__SORTIE:initialise les valeurs des variables / objets
*********************************************************************************}
procedure TFBullsCows.FormCreate(Sender: TObject);
begin
  //initialise les valeurs des variables
  faute:=0;
  nbrFaute:=0;

  //charge la bibliot�que dans un memo
  MDictionnaire.Lines.LoadFromFile('Dictionnaire.txt');
  //R�cup�re un mot al�atoire du memo
  mot:=MDictionnaire.Lines[Random(MDictionnaire.Lines.Count-1)];
  //Calcule le nbr de faute que l'utilisateur pourra faire
  nbrFaute:=calcFaute(mot);
  //affiche � l'�cran
  EEssai.Text:=inttostr(nbrFaute);
  PTaille.Caption:='Taille: '+inttostr(Length(mot));
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************


{*************************PROCEDURE***//***FONCTION*******************************
	 *_____BUT:Un timer qui au bout de 5 sc r�initialise une valeur 
	 *__ENTREE:1 TObject 
	 *__SORTIE:R�initialise une valeur
*********************************************************************************}
procedure TFBullsCows.TTextTimer(Sender: TObject);
begin
  PText.Caption:='';
  TText.Enabled:=false;
end;
//********************FIN***PROCEDURE***//***FONCTION*****************************

//**************************FIN****PRINCIPAL****************************************
end.
