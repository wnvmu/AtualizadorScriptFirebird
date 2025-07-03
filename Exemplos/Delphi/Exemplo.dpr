program Exemplo;

uses
  Vcl.Forms,
  UntExemplo in 'UntExemplo.pas' {UIExemplo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TUIExemplo, UIExemplo);
  Application.Run;
end.
