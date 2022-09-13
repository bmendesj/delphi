unit SMEnderecoIntegracao;

interface

uses
  System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter, Datasnap.DSServer, Datasnap.DSAuth,

  Data.DBXPlatform, Web.HTTPApp, Datasnap.DSHTTPWebBroker,

  FireDAC.Stan.Option, Data.DB;

type
  TSMEnderecoIntegracao = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function EnderecoIntegracao(aValue: Int64): TJSONArray;         //GET
    function UpdateEnderecoIntegracao: TJSONArray;                  //POST
    function AcceptEnderecoIntegracao(aValue: Integer): TJSONArray; //PUT
    function CancelEnderecoIntegracao(aValue: Int64): TJSONArray;   //DELETE
  end;

implementation


{$R *.dfm}

uses
  uJsonDataSetHelper, WebModuleUnit1, DAO.DMConexao, DAO.EnderecoIntegracao;

{ TSMEnderecoIntegracao }

function TSMEnderecoIntegracao.EnderecoIntegracao(aValue: Int64): TJSONArray;
var
  enderecoIntegracao: TDAOEnderecoIntegracao;
begin
{GET NO HTTP}
  Result:=  nil;
  enderecoIntegracao:= nil;

  try
    try
      enderecoIntegracao:= TDAOEnderecoIntegracao.Create(DMConexao.FDPostgre);

      Result:= enderecoIntegracao.Get(aValue);

      //Remove partes indesejadas do datasnap
      GetInvocationMetadata().ResponseCode:=    200;
      GetInvocationMetadata().ResponseContent:= Result.ToString;
    except on E: Exception do
      begin
        GetInvocationMetadata().ResponseCode:= 500;
        GetInvocationMetadata().ResponseMessage:= 'Um erro inesperado ocorreu.';
      end;
    end;
  finally
    if enderecoIntegracao <> nil then
      FreeAndNil(enderecoIntegracao);
  end;
end;

function TSMEnderecoIntegracao.UpdateEnderecoIntegracao: TJSONArray;
var
  lModulo:       TWebModule;
  lJARequisicao: TJSONArray;

  enderecoIntegracao: TDAOEnderecoIntegracao;
  qInseridos:    Integer;
begin
{POST NO HTTP}
  Result:=   nil;
  enderecoIntegracao:= nil;

  try
    try
      lModulo:= GetDataSnapWebModule;

      if lModulo.Request.content.IsEmpty then
      begin
        GetInvocationMetadata().ResponseCode:= 204;
        GetInvocationMetadata().ResponseMessage:= 'Não existe registros para inserir.';
        Abort;
      end;

      lJARequisicao:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(lModulo.Request.Content), 0) as TJSONArray;

      if lJARequisicao.Count < 1 then
      begin
        GetInvocationMetadata().ResponseCode:= 202;
        GetInvocationMetadata().ResponseMessage:= 'Não existe registros para inserir.';
        Exit;
      end;

      enderecoIntegracao:= TDAOEnderecoIntegracao.Create(DMConexao.FDPostgre);

      qInseridos:= enderecoIntegracao.Insert(lJARequisicao);

      Result:= TJSONArray.Create('incluidos', qInseridos.ToString);

      //Remove partes indesejadas do datasnap
      GetInvocationMetadata().ResponseCode:=    200;
      GetInvocationMetadata().ResponseContent:= Result.ToString;
    except
      on E: Exception do
      begin
        GetInvocationMetadata().ResponseCode:= 500;
        GetInvocationMetadata().ResponseMessage:= 'Um erro inesperado ocorreu.';
      end;
    end;
  finally
    if enderecoIntegracao <> nil then
      FreeAndNil(enderecoIntegracao);
  end;
end;

function TSMEnderecoIntegracao.AcceptEnderecoIntegracao(aValue: Integer): TJSONArray;
var
  lModulo:       TWebModule;
  lJARequisicao: TJSONArray;

  enderecoIntegracao: TDAOEnderecoIntegracao;
begin
{PUT NO HTTP}
  Result:=  nil;
  enderecoIntegracao:= nil;

  try
    try
      lModulo:= GetDataSnapWebModule;

      if lModulo.Request.content.IsEmpty then
      begin
        GetInvocationMetadata().ResponseCode:= 204;
        GetInvocationMetadata().ResponseMessage:= 'Sem registro para alterar.';
        Exit;
      end;

      lJARequisicao:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(lModulo.Request.Content), 0) as TJSONArray;

      if lJARequisicao.Count <> 1 then
      begin
        GetInvocationMetadata().ResponseCode:= 202;
        GetInvocationMetadata().ResponseMessage:= 'Dese ser informado exatamente um registro para alteração.';
        Exit;
      end;

      enderecoIntegracao:= TDAOEnderecoIntegracao.Create(DMConexao.FDPostgre);

      enderecoIntegracao.Update(aValue, lJARequisicao);

      Result:= TJSONArray.Create('message', 'Registro alterado.');

      //Remove partes indesejadas do datasnap
      GetInvocationMetadata().ResponseCode:=    200;
      GetInvocationMetadata().ResponseContent:= Result.ToString;
    except
      on E: Exception do
      begin
        GetInvocationMetadata().ResponseCode:= 500;
        GetInvocationMetadata().ResponseMessage:= 'Um erro inesperado ocorreu.';
      end;
    end;
  finally
    if enderecoIntegracao <> nil then
      FreeAndNil(enderecoIntegracao);
  end;
end;

function TSMEnderecoIntegracao.CancelEnderecoIntegracao(aValue: Int64): TJSONArray;
var
  enderecoIntegracao: TDAOEnderecoIntegracao;
begin
{DELETE NO HTTP}
  Result:=  nil;
  enderecoIntegracao:= nil;

  try
    try
      if aValue < 1 then
      begin
        GetInvocationMetadata().ResponseCode:= 202;
        GetInvocationMetadata().ResponseMessage:= 'A id do registro não foi informada.';
        Exit;
      end;

      enderecoIntegracao:= TDAOEnderecoIntegracao.Create(DMConexao.FDPostgre);

      enderecoIntegracao.Delete(aValue);

      Result:= TJSONArray.Create('message', 'Registro apagado.');

      //Remove partes indesejadas do datasnap
      GetInvocationMetadata().ResponseCode:=    200;
      GetInvocationMetadata().ResponseContent:= Result.ToString;
    except
      on E: Exception do
      begin
        GetInvocationMetadata().ResponseCode:= 500;
        GetInvocationMetadata().ResponseMessage:= 'Um erro inesperado ocorreu.';
      end;
    end;
  finally
    if enderecoIntegracao <> nil then
      FreeAndNil(enderecoIntegracao);
  end;
end;

end.
