program BullAndCowProject;

uses
  Vcl.Forms,
  BullAndCowUnit in 'BullAndCowUnit.pas' {FBullsCows};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFBullsCows, FBullsCows);
  Application.Run;
end.
