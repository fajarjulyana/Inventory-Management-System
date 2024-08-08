program Inventory;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLogin in 'src\uLogin.pas' {Form1},
  uMenu in 'src\uMenu.pas' {Form2},
  uDM in 'src\uDM.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
