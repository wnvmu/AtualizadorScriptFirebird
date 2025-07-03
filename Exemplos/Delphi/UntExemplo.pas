unit UntExemplo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ComObj;

type
  TUIExemplo = class(TForm)
    Label1: TLabel;
    BtnAtualizarRegistrado: TButton;
    procedure BtnAtualizarRegistradoClick(Sender: TObject);
  private
    procedure AtualizacaoPorRegistroDLL();
  public
    { Public declarations }
  end;

var
  UIExemplo: TUIExemplo;

implementation

{$R *.dfm}

procedure TUIExemplo.AtualizacaoPorRegistroDLL;
var
  Atualizador: Variant;
begin
  try
    Atualizador := CreateOleObject('AtualizadorFirebird.Atualizador');
    Atualizador.Conectar('User=SYSDBA;Password=masterkey;Database=127.0.0.1:C:\WNV\Atualizador Firebird\Exemplos\Delphi\Bin\EXEMPLO.FDB;Charset=UTF8');
    Atualizador.AtualizarBanco;
    ShowMessage('Banco atualizado com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;
end;

procedure TUIExemplo.BtnAtualizarRegistradoClick(Sender: TObject);
begin
  AtualizacaoPorRegistroDLL();
end;

end.
