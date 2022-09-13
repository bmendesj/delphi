unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, REST.Types, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Imaging.pngimage,
  System.ImageList, Vcl.ImgList;

type
  TfrmPrincipal = class(TForm)
    pLateral: TPanel;
    apagar: TSpeedButton;
    Editar: TSpeedButton;
    btnAdicionar: TSpeedButton;
    btnBuscar: TSpeedButton;
    btnProximo: TSpeedButton;
    btnAnterior: TSpeedButton;
    btnCarregar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses DAO.Pessoas;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
//var
//  pesoas: TDAOPessoas;
begin
//  pesoas:= TDAOPessoas.Create(Self);
//  pesoas.Request.Method:= TRESTRequestMethod.rmGET;
//  pesoas.Request.Params.Clear;
//  pesoas.Request.Params.AddItem('qCampo', 'idpessoa', TRESTRequestParameterKind.pkQUERY);
//  pesoas.Request.Params.AddItem('qValor', '74',       TRESTRequestParameterKind.pkQUERY);
//  pesoas.Request.Execute;
//
//  DBGrid1.DataSource:= pesoas.dsPessoas;
end;

end.
