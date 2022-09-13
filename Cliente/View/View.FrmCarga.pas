unit View.FrmCarga;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Controller.Pessoas;

type
  TfrmCarga = class(TForm)
    OpenDialog1: TOpenDialog;
    btnCarregar: TSpeedButton;
    procedure btnCarregarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCarga: TfrmCarga;

implementation

{$R *.dfm}

procedure TfrmCarga.btnCarregarClick(Sender: TObject);
var
  cp: TControllerPessoa;
  sl: TStringList;
  id: Int64;
begin
  cp:= nil;
  sl:= nil;
  id:= 0;

  try
    try
      if not OpenDialog1.Execute() then
        Exit;

      sl:= TStringList.Create;
      sl.LoadFromFile(OpenDialog1.FileName);

      cp:= TControllerPessoa.Create;
      id:= cp.CargaEmLote(sl);

      if id > 0 then
      begin
        ShowMessage('Lote carregado com sucesso');
        ModalResult:= mrClose;
      end;
    except on E: Exception do
      ShowMessage(E.Message);
    end;
  finally
    if cp <> nil then
      FreeAndNil(cp);

    if sl <> nil then
      FreeAndNil(sl);
  end;
end;

end.
