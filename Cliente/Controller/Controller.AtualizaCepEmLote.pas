unit Controller.AtualizaCepEmLote;

interface

uses
  DAO.AtualizaCepEmLote,
  System.Classes, System.SysUtils, System.JSON.Writers, System.JSON.Types,
  System.JSON, Data.DB, REST.Types, FireDAC.Comp.Client;

type
  TControllerAtualizaCepEmLote = class
  private
    fDAO: TDAOAtualizaCepEmLote;
  public
    constructor Create;
    function Atualizar: Integer;
  published
  end;

implementation

{ TControllerAtualizaCepEmLote }

function TControllerAtualizaCepEmLote.Atualizar: Integer;
begin
  fDAO.Adapter.Active:= True;
  fDAO.Request.Method:= TRESTRequestMethod.rmGET;
  fDAO.Request.Execute;

  if not fDAO.Request.Response.Status.Success then
    raise Exception.Create(fDAO.Request.Response.StatusText);

  Result:= fDAO.DataSetquantidade.Value;
end;

constructor TControllerAtualizaCepEmLote.Create;
begin
  fDAO:= TDAOAtualizaCepEmLote.GetInstance;
end;

end.
