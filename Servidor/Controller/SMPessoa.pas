unit SMPessoa;

interface

uses
  System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter, Datasnap.DSServer, Datasnap.DSAuth,

  Data.DBXPlatform, Web.HTTPApp, Datasnap.DSHTTPWebBroker,

  FireDAC.Stan.Option, Data.DB, System.Generics.Collections;

type
  TSMPessoa = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function Pessoas: TJSONArray;       //GET
    function UpdatePessoas: TJSONArray; //POST
    function AcceptPessoas: TJSONArray; //PUT
    function CancelPessoas: TJSONArray; //DELETE
  end;

implementation


{$R *.dfm}

uses
  uJsonDataSetHelper, WebModuleUnit1, DAO.DMConexao, DAO.Pessoas;

{ TSMPessoa }

function TSMPessoa.Pessoas: TJSONArray;
var
  metaData: TDSInvocationMetadata;
  pessoas:   TDAOPessoas;

  filtro:      TPair<string, string>;
  idPaginacao: Int64;
begin
{GET NO HTTP}
  Result:=       nil;
  pessoas:=      nil;

  filtro.Key:=   '';
  filtro.Value:= '';

  idPaginacao:= -1;

  try
    try
      metaData:= GetInvocationMetadata;

      if metaData.QueryParams.IndexOfName('qCampo') > -1 then
        filtro.Key:= metaData.QueryParams.Values['qCampo'];

      if metaData.QueryParams.IndexOfName('qValor') > -1 then
        filtro.Value:= metaData.QueryParams.Values['qValor'];

      if metaData.QueryParams.IndexOfName('qIdPaginacao') > -1 then
        idPaginacao:= StrToInt64(metaData.QueryParams.Values['qIdPaginacao']);

      pessoas:=TDAOPessoas.Create(DMConexao.FDPostgre);

      Result:= pessoas.Get(filtro, idPaginacao);

      GetInvocationMetadata().ResponseCode:=    200;
      GetInvocationMetadata().ResponseContent:= Result.ToString;
    except on E: Exception do
      begin
        GetInvocationMetadata().ResponseCode:= 500;
        GetInvocationMetadata().ResponseMessage:= 'Um erro inesperado ocorreu.';
      end;
    end;
  finally
    if pessoas <> nil then
      FreeAndNil(pessoas);
  end;
end;

function TSMPessoa.UpdatePessoas: TJSONArray;
var
  lModulo:       TWebModule;
  lJARequisicao: TJSONArray;

  pessoas:       TDAOPessoas;
  ultimaId:      Integer;
begin
{POST NO HTTP}
  Result:=  nil;
  pessoas:= nil;

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

      pessoas:= TDAOPessoas.Create(DMConexao.FDPostgre);

      ultimaId:= pessoas.Insert(lJARequisicao);

      Result:= TJSONArray.Create(TJSONObject.Create(TJSONPair.Create('ultimaId', ultimaId.ToString)));

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
    if pessoas <> nil then
      FreeAndNil(pessoas);
  end;
end;

function TSMPessoa.AcceptPessoas: TJSONArray;
var
  metaData:      TDSInvocationMetadata;
  lModulo:       TWebModule;
  lJARequisicao: TJSONArray;

  pessoas: TDAOPessoas;
  qId:     Int64;
begin
{PUT NO HTTP}
  Result:=  nil;
  pessoas:= nil;

  qId:=     -1;

  try
    try
      metaData:= GetInvocationMetadata;

      if metaData.QueryParams.IndexOfName('qId') > -1 then
        qId:= StrToInt64(metaData.QueryParams.Values['qId']);

      if qId < 1 then
      begin
        GetInvocationMetadata().ResponseCode:= 202;
        GetInvocationMetadata().ResponseMessage:= 'Id não informada.';
        Exit;
      end;

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

      pessoas:= TDAOPessoas.Create(DMConexao.FDPostgre);

      pessoas.Update(qId, lJARequisicao);

      Result:= TJSONArray.Create('message', 'Registro alterado.');

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
    if pessoas <> nil then
      FreeAndNil(pessoas);
  end;
end;

function TSMPessoa.CancelPessoas: TJSONArray;
var
  metaData: TDSInvocationMetadata;
  pessoas:  TDAOPessoas;

  qId:      Int64;
begin
{DELETE NO HTTP}
  Result:=  nil;
  pessoas:= nil;

  qId:=     -1;

  try
    try
      metaData:= GetInvocationMetadata;

      if metaData.QueryParams.IndexOfName('qId') > -1 then
        qId:= StrToInt64(metaData.QueryParams.Values['qId']);

      if qId < 1 then
      begin
        GetInvocationMetadata().ResponseCode:= 202;
        GetInvocationMetadata().ResponseMessage:= 'A id do registro não foi informada.';
        Exit;
      end;

      pessoas:= TDAOPessoas.Create(DMConexao.FDPostgre);

      pessoas.Delete(qId);

      Result:= TJSONArray.Create('message', 'Registro apagado.');

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
    if pessoas <> nil then
      FreeAndNil(pessoas);
  end;
end;

end.
