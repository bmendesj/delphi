unit View.Principal;

interface

uses
  Controller.AtualizaCepEmLote,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, REST.Types, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList,
  Controller.Pessoas;

type
  TfrmPrincipal = class(TForm)
    pLateral: TPanel;
    btmPessoas: TSpeedButton;
    btnCarregar: TSpeedButton;
    btnAtualizarEnderecos: TSpeedButton;
    procedure btmPessoasClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnAtualizarEnderecosClick(Sender: TObject);
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

procedure TfrmPrincipal.btnCarregarClick(Sender: TObject);
var
  od: TOpenDialog;
begin
  od:= nil;

  od:= TOpenDialog.Create(Self);
  od.Title:=  'Lista para insersão ASSÍNCRONA';
  od.Filter:= 'txt|*.txt';

  if not od.Execute() then
    Exit;

  TThread.CreateAnonymousThread(
    procedure
    var
      sl: TStringList;
      cp: TControllerPessoa;

      id: Int64;
    begin
      sl:= nil;
      cp:= nil;

      id:= 0;

      try
        try
          sl:= TStringList.Create;
          sl.LoadFromFile(od.FileName);

          cp:= TControllerPessoa.Create;

          id:= cp.CargaEmLote(sl);

          if id > 0 then
            ShowMessage('Lote carregado com sucesso');
        except on E: Exception do
          ShowMessage(E.Message);
        end;
      finally
        if od <> nil then
          FreeAndNil(od);

        if sl <> nil then
          FreeAndNil(sl);

        if cp <> nil then
          FreeAndNil(cp);
      end;
    end
  ).Start;
end;

procedure TfrmPrincipal.ExibirPanelLateral;
begin
  pLateral.Visible:= True;
end;

procedure TfrmPrincipal.OcultarPanelLateral;
begin
  pLateral.Visible:= False;
end;

procedure TfrmPrincipal.btnAtualizarEnderecosClick(Sender: TObject);
var
  sMsg: string;
  nMsg: Integer;
begin
  sMsg:= 'Essa operação será realizada em segundo plano,'
  + #13 + 'você será avisado quando ela for concluída.'
  + #13
  + #13 + 'Deseja continuar?';

  nMsg:= Application.MessageBox(PChar(sMsg), PChar(Caption), MB_ICONQUESTION+MB_YESNO);

  if nMsg <> 6 then
    Exit;

  TThread.CreateAnonymousThread(
    procedure
    var
      cp: TControllerAtualizaCepEmLote;

      qtde: Int64;
    begin
      cp:= nil;

      qtde:= 0;

      try
        try
          cp:= TControllerAtualizaCepEmLote.Create;

          qtde:= cp.Atualizar;

          if qtde > 0 then
            ShowMessage('Umtotal de ' + qtde.ToString + ' CEPs foram atualizados com sucesso.');
        except on E: Exception do
          ShowMessage(E.Message);
        end;
      finally
        if cp <> nil then
          FreeAndNil(cp);
      end;
    end
  ).Start;
end;

end.
