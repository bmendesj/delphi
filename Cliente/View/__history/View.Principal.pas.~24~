unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, REST.Types, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Imaging.pngimage,
  System.ImageList, Vcl.ImgList, Controller.Pessoas;

type
  TfrmPrincipal = class(TForm)
    pLateral: TPanel;
    btmPessoas: TSpeedButton;
    procedure btmPessoasClick(Sender: TObject);
  private
    { Private declarations }

    procedure OcultarPanelLateral;
  public
    { Public declarations }
    procedure ExibirPanelLateral;
  end;

const
  _LIMITPAGINACAO = 200;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses View.LstPessoas;

procedure TfrmPrincipal.btmPessoasClick(Sender: TObject);
var
  cp: TControllerPessoa;
begin
  cp:= nil;

  try
    cp:= TControllerPessoa.Create;
    cp.Select(0);

    lstPessoas:= TLstPessoas.Create(Self);
    lstPessoas.DBGrid.DataSource:= cp.GetDataSource;

    OcultarPanelLateral;
  finally
    if cp <> nil then
      FreeAndNil(cp);
  end;
end;

procedure TfrmPrincipal.ExibirPanelLateral;
begin
  pLateral.Visible:= True;
end;

procedure TfrmPrincipal.OcultarPanelLateral;
begin
  pLateral.Visible:= False;
end;

end.
