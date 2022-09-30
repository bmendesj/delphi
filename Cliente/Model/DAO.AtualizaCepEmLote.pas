unit DAO.AtualizaCepEmLote;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter;

type
  TDAOAtualizaCepEmLote = class(TDataModule)
    Client: TRESTClient;
    Request: TRESTRequest;
    Response: TRESTResponse;
    Adapter: TRESTResponseDataSetAdapter;
    DataSource: TDataSource;
    DataSet: TFDMemTable;
    DataSetquantidade: TIntegerField;
  strict private
    { Private declarations }
    class var FInstance: TDAOAtualizaCepEmLote;
    constructor PrivateCreate;
  public
    { Public declarations }
    class function GetInstance: TDAOAtualizaCepEmLote;

    constructor Create;
    destructor  Destroy; override;
  end;

var
  DAOAtualizaCepEmLote: TDAOAtualizaCepEmLote;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDAOAtualizaCepEmLote }

constructor TDAOAtualizaCepEmLote.Create;
begin
  raise Exception.Create('Para obter uma instancia de DAO pessoas invoque o método GetIntance');
end;

destructor TDAOAtualizaCepEmLote.Destroy;
begin
  inherited;
end;

class function TDAOAtualizaCepEmLote.GetInstance: TDAOAtualizaCepEmLote;
begin
  if not Assigned(FInstance) then
    FInstance:= TDAOAtualizaCepEmLote.PrivateCreate;

  Result:= FInstance;
end;

constructor TDAOAtualizaCepEmLote.PrivateCreate;
begin
  inherited Create(nil);
end;

end.
