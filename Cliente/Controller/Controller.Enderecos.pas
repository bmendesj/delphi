unit Controller.Enderecos;

interface

uses
  DAO.Enderecos, DTO.Endereco,
  System.Classes, System.SysUtils, System.JSON.Writers, System.JSON.Types,
  System.JSON, Data.DB, REST.Types, FireDAC.Comp.Client;

type
  TControllerEndereco = class
  private
    fDAO:         TDAOEnderecos;
    fIdPaginacao: Int64;
    function Insert(aLista: TJSonArray): Int64; overload;
    function Update(aID:Int64; aLista: TJSonArray): Boolean; overload;
    function Delete(aID:Int64): Boolean; overload;
  public
    function GetDataSource: TDataSource;
    function GetRegistro: TDTOEndereco;
    function Select(aIdPessoa: Int64; aIdPaginacao: Int64 = 0): Boolean;
    function Insert(aEndereco: TDTOEndereco): Int64; overload;
    function Update(aEndereco: TDTOEndereco): Boolean; overload;
    function Delete: Boolean; overload;
    procedure Close;
    Procedure InsertSomenteNoDataSet(aEndereco: TDTOEndereco);
    procedure ProximaPagina(aIdPessoa: Int64);
    procedure PaginaAnterior(aIdPessoa: Int64);

    constructor Create;
  published
  end;

implementation

{ TControllerPessoa }

constructor TControllerEndereco.Create;
begin
  fIdPaginacao:= 0;
  fDAO:= TDAOEnderecos.GetInstance;
end;

function TControllerEndereco.Select(aIdPessoa: Int64; aIdPaginacao: Int64 = 0): Boolean;
begin
  Result:= False;

  if aIdPaginacao <> 0 then
    fIdPaginacao:= aIdPaginacao;

  fDAO.Adapter.AutoUpdate:= True;
  fDAO.Request.Method:= TRESTRequestMethod.rmGET;
  fDAO.Request.Params.Clear;
  fDAO.Request.Params.AddItem('qCampo',       'idPessoa',            TRESTRequestParameterKind.pkQUERY);
  fDAO.Request.Params.AddItem('qValor',       aIdPessoa.ToString,    TRESTRequestParameterKind.pkQUERY);
  fDAO.Request.Params.AddItem('qIdPaginacao', fIdPaginacao.ToString, TRESTRequestParameterKind.pkQUERY);
  fDAO.Request.Execute;

  if not fDAO.Request.Response.Status.Success then
    raise Exception.Create(fDAO.Request.Response.StatusText);

  Result:= True;
end;

function TControllerEndereco.Insert(aEndereco: TDTOEndereco): Int64;
var
  stringWriter:   TStringWriter;
  jsonTextWriter: TJsonTextWriter;
  jsonArray:      TJSonArray;
begin
  stringWriter:=   nil;
  jsonTextWriter:= nil;

  try
    stringWriter:= TStringWriter.Create;

    jsonTextWriter:= TJsonTextWriter.Create(stringWriter);
    jsonTextWriter.Formatting:= TJsonFormatting.Indented;

    jsonTextWriter.WriteStartArray;
    jsonTextWriter.WriteStartObject;

    jsonTextWriter.WritePropertyName('idpessoa');      jsonTextWriter.WriteValue(aEndereco.IdPessoa.ToString);
    jsonTextWriter.WritePropertyName('dscep');         jsonTextWriter.WriteValue(aEndereco.Cep);
    jsonTextWriter.WritePropertyName('dsuf');          jsonTextWriter.WriteValue(aEndereco.Uf);
    jsonTextWriter.WritePropertyName('nmcidade');      jsonTextWriter.WriteValue(aEndereco.Cidade);
    jsonTextWriter.WritePropertyName('nmbairro');      jsonTextWriter.WriteValue(aEndereco.Bairro);
    jsonTextWriter.WritePropertyName('nmlogradouro');  jsonTextWriter.WriteValue(aEndereco.Logradouro);
    jsonTextWriter.WritePropertyName('dscomplemento'); jsonTextWriter.WriteValue(aEndereco.Complemento);

    jsonTextWriter.WriteEndObject;
    jsonTextWriter.WriteEndArray;

    jsonArray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(stringWriter.ToString), 0) as TJSONArray;

    Result:= Self.Insert(jsonArray);

    if Result < 1 then
      Exit;

    fDAO.DataSet.Insert;
    fDAO.DataSetidendereco.Value:=    Result;
    fDAO.DataSetidpessoa.Value:=      aEndereco.IdPessoa;
    fDAO.DataSetdscep.Value:=         aEndereco.Cep;
    fDAO.DataSetdsuf.Value:=          aEndereco.Uf;
    fDAO.DataSetnmcidade.Value:=      aEndereco.Cidade;
    fDAO.DataSetnmbairro.Value:=      aEndereco.Bairro;
    fDAO.DataSetnmlogradouro.Value:=  aEndereco.Logradouro;
    fDAO.DataSetdscomplemento.Value:= aEndereco.Complemento;
    fDAO.DataSet.Post;
  finally
    if stringWriter <> nil then
      FreeAndNil(stringWriter);

    if jsonTextWriter <> nil then
      FreeAndNil(jsonTextWriter);
  end;
end;

procedure TControllerEndereco.InsertSomenteNoDataSet(aEndereco: TDTOEndereco);
begin
  fDAO.DataSet.Insert;
  fDAO.DataSetidendereco.Value:=    aEndereco.IdEndereco;
  fDAO.DataSetidpessoa.Value:=      aEndereco.IdPessoa;
  fDAO.DataSetdscep.Value:=         aEndereco.Cep;
  fDAO.DataSetdsuf.Value:=          aEndereco.Uf;
  fDAO.DataSetnmcidade.Value:=      aEndereco.Cidade;
  fDAO.DataSetnmbairro.Value:=      aEndereco.Bairro;
  fDAO.DataSetnmlogradouro.Value:=  aEndereco.Logradouro;
  fDAO.DataSetdscomplemento.Value:= aEndereco.Complemento;
  fDAO.DataSet.Post;
end;

function TControllerEndereco.Insert(aLista: TJSonArray): Int64;
var
 jsonRetorno: TJSONArray;
begin
  Result:= 0;

  if (aLista = nil) or (aLista.Count = 0) then
    raise Exception.Create('Informe a lista de insersão');

  fDAO.Adapter.AutoUpdate:= False;
  fDAO.Request.Method:= TRESTRequestMethod.rmPOST;
  fDAO.Request.Params.Clear;
  fDAO.Request.Body.ClearBody;
  fDAO.Request.Body.Add(aLista.ToString, ContentTypeFromString(CONTENTTYPE_APPLICATION_JSON));
  fDAO.Request.Execute;

  if not fDAO.Request.Response.Status.Success then
    raise Exception.Create(fDAO.Request.Response.StatusText);

  jsonRetorno:= (fDAO.Request.Response.JSONValue AS TJSONArray);

  Result:= (jsonRetorno.Items[0] AS TJSONObject).GetValue<Int64>('ultimaId');
end;

function TControllerEndereco.Update(aEndereco: TDTOEndereco): Boolean;
var
  stringWriter:   TStringWriter;
  jsonTextWriter: TJsonTextWriter;
  jsonArray:      TJSonArray;
begin
  stringWriter:=   nil;
  jsonTextWriter:= nil;

  try
    stringWriter:= TStringWriter.Create;

    jsonTextWriter:= TJsonTextWriter.Create(stringWriter);
    jsonTextWriter.Formatting:= TJsonFormatting.Indented;

    jsonTextWriter.WriteStartArray;
    jsonTextWriter.WriteStartObject;

    jsonTextWriter.WritePropertyName('idpessoa');      jsonTextWriter.WriteValue(aEndereco.IdPessoa.ToString);
    jsonTextWriter.WritePropertyName('dscep');         jsonTextWriter.WriteValue(aEndereco.Cep);
    jsonTextWriter.WritePropertyName('dsuf');          jsonTextWriter.WriteValue(aEndereco.Uf);
    jsonTextWriter.WritePropertyName('nmcidade');      jsonTextWriter.WriteValue(aEndereco.Cidade);
    jsonTextWriter.WritePropertyName('nmbairro');      jsonTextWriter.WriteValue(aEndereco.Bairro);
    jsonTextWriter.WritePropertyName('nmlogradouro');  jsonTextWriter.WriteValue(aEndereco.Logradouro);
    jsonTextWriter.WritePropertyName('dscomplemento'); jsonTextWriter.WriteValue(aEndereco.Complemento);

    jsonTextWriter.WriteEndObject;
    jsonTextWriter.WriteEndArray;

    jsonArray:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(stringWriter.ToString), 0) as TJSONArray;

    Result:= Self.Update(aEndereco.IdEndereco, jsonArray);

    if not Result then
      Exit;

    fDAO.DataSet.Edit;
    fDAO.DataSetidendereco.Value:=    aEndereco.IdEndereco;
    fDAO.DataSetidpessoa.Value:=      aEndereco.IdPessoa;
    fDAO.DataSetdscep.Value:=         aEndereco.Cep;
    fDAO.DataSetdsuf.Value:=          aEndereco.Uf;
    fDAO.DataSetnmcidade.Value:=      aEndereco.Cidade;
    fDAO.DataSetnmbairro.Value:=      aEndereco.Bairro;
    fDAO.DataSetnmlogradouro.Value:=  aEndereco.Logradouro;
    fDAO.DataSetdscomplemento.Value:= aEndereco.Complemento;
    fDAO.DataSet.Post;
  finally
    if stringWriter <> nil then
      FreeAndNil(stringWriter);

    if jsonTextWriter <> nil then
      FreeAndNil(jsonTextWriter);
  end;
end;

function TControllerEndereco.Update(aID: Int64; aLista: TJSonArray): Boolean;
begin
  Result:= False;

  if (aLista = nil) or (aLista.Count = 0) then
    raise Exception.Create('Informe a lista de insersão');

  fDAO.Adapter.AutoUpdate:= False;
  fDAO.Request.Method:= TRESTRequestMethod.rmPUT;
  fDAO.Request.Params.Clear;
  fDao.Request.Params.AddItem('qId', aId.ToString, TRESTRequestParameterKind.pkQUERY);
  fDAO.Request.Body.ClearBody;
  fDAO.Request.Body.Add(aLista.ToString, ContentTypeFromString(CONTENTTYPE_APPLICATION_JSON));
  fDAO.Request.Execute;

  if not fDAO.Request.Response.Status.Success then
    raise Exception.Create(fDAO.Request.Response.StatusText);

  Result:= True;
end;

function TControllerEndereco.Delete: Boolean;
begin
  fDao.Adapter.AutoUpdate:= False;
  fDao.Request.Method:= TRESTRequestMethod.rmDELETE;
  fDao.Request.Params.Clear;
  fDao.Request.Params.AddItem('qId', fDao.DataSetidendereco.Value.ToString, TRESTRequestParameterKind.pkQUERY);
  fDao.Request.Execute;

  if fDao.Request.Response.Status.Success then
    fDao.DataSet.Delete
  else
    raise Exception.Create(fDAO.Request.Response.StatusText);
end;

function TControllerEndereco.Delete(aID: Int64): Boolean;
begin
  fDao.Adapter.AutoUpdate:= False;
  fDao.Request.Method:= TRESTRequestMethod.rmDELETE;
  fDao.Request.Params.Clear;
  fDao.Request.Params.AddItem('qId', fDao.DataSetidpessoa.Value.ToString, TRESTRequestParameterKind.pkQUERY);
  fDao.Request.Execute;

  if fDao.Request.Response.Status.Success then
    fDao.DataSet.Delete
  else
    raise Exception.Create(fDAO.Request.Response.StatusText);
end;

function TControllerEndereco.GetDataSource: TDataSource;
begin
  Result:= fDAO.DataSource;
end;

function TControllerEndereco.GetRegistro: TDTOEndereco;
begin
  Result:= TDTOEndereco.Create;

  Result.IdEndereco:=  fDAO.DataSetidendereco.Value;
  Result.IdPessoa:=    fDAO.DataSetidpessoa.Value;
  Result.Cep:=         fDAO.DataSetdscep.Value;
  Result.Uf:=          fDAO.DataSetdsuf.Value;
  Result.Cidade:=      fDAO.DataSetnmcidade.Value;
  Result.Bairro:=      fDAO.DataSetnmbairro.Value;
  Result.Logradouro:=  fDAO.DataSetnmlogradouro.Value;
  Result.Complemento:= fDAO.DataSetdscomplemento.Value;
end;

procedure TControllerEndereco.Close;
begin
  fDAO.DataSet.EmptyDataSet;
end;

procedure TControllerEndereco.PaginaAnterior(aIdPessoa: Int64);
var
  recNo: Integer;
  nTemp: Int64;
begin
  nTemp:= 9999999999999;

  try
    recNo:= fDAO.DataSet.RecNo;

    fDAO.DataSet.DisableControls;
    fDAO.DataSet.First;

    while not fDAO.DataSet.Eof do
    begin
      if fDAO.DataSetidendereco.Value < nTemp then
        nTemp:= fDAO.DataSetidendereco.Value;

      fDAO.DataSet.Next;
    end;
  finally
    fDAO.DataSet.RecNo:= recNo;
    fDAO.DataSet.EnableControls;
  end;

  nTemp:= nTemp - 200;
  Self.Select(aIdPessoa, nTemp);
end;

procedure TControllerEndereco.ProximaPagina(aIdPessoa: Int64);
var
  recNo: Integer;
  nTemp: Int64;
begin
  nTemp:= 0;

  try
    recNo:= fDAO.DataSet.RecNo;

    fDAO.DataSet.DisableControls;
    fDAO.DataSet.First;

    while not fDAO.DataSet.Eof do
    begin
      if fDAO.DataSetidpessoa.Value > nTemp then
        nTemp:= fDAO.DataSetidpessoa.Value;

      fDAO.DataSet.Next;
    end;
  finally
    fDAO.DataSet.RecNo:= recNo;
    fDAO.DataSet.EnableControls;
  end;

  Self.Select(aIdPessoa, nTemp);
end;

end.
