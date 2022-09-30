unit SMAtualizaCepEmLote;

interface

uses
  DAO.DMConexao, DAO.Enderecos, DTO.Endereco,
  System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter, Datasnap.DSServer, Datasnap.DSAuth,
  Data.DBXPlatform, Web.HTTPApp, Datasnap.DSHTTPWebBroker,
  FireDAC.Stan.Option, Data.DB, REST.Types, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.Generics.Collections;

type
  TSMAtualizaCepEmLote = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function Atualizar: TJSONArray;
  end;

implementation


{$R *.dfm}

uses
  uJsonDataSetHelper, WebModuleUnit1, SMViaCep;

{ TSMAtualizaCepEmLote }

function TSMAtualizaCepEmLote.Atualizar: TJSONArray;
var
  daoEnderecos: TDAOEnderecos;
  lstEnderecos: TObjectList<TDTOEndereco>;
  dtoEndereco:  TDTOEndereco;
  SMViaCep:     TSMViaCep;
  jsonArray:    TJSONArray;
  jsonObj:      TJSONObject;

  qtde: Integer;
begin
  daoEnderecos:= nil;
  lstEnderecos:= nil;
  dtoEndereco:=  nil;
  SMViaCep:=     nil;
  jsonArray:=    nil;
  jsonObj:=      nil;

  try
    try
      daoEnderecos:= TDAOEnderecos.Create(DMConexao.FDPostgre);

      lstEnderecos:= daoEnderecos.GetCeps;

      SMViaCep:= TSMViaCep.Create(Self);

      for dtoEndereco in lstEnderecos do
      begin
        jsonArray:= SMViaCep.ConsultaCep(dtoEndereco.Cep);
        jsonObj:= (jsonArray.Items[0] as TJSONObject);

        if jsonObj.Count < 2 then
          Continue;

        dtoEndereco.Uf:=          jsonObj.GetValue<string>('uf');
        dtoEndereco.Cidade:=      jsonObj.GetValue<string>('localidade');
        dtoEndereco.Bairro:=      jsonObj.GetValue<string>('bairro');
        dtoEndereco.Logradouro:=  jsonObj.GetValue<string>('logradouro');
        dtoEndereco.Complemento:= jsonObj.GetValue<string>('complemento');
        Inc(qtde);
      end;

      qtde:= daoEnderecos.AtualizaCeps(lstEnderecos);

      Result:= TJSONArray.Create(TJSONObject.Create(TJSONPair.Create('quantidade', qtde.ToString)));

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
    if daoEnderecos <> nil then
      FreeAndNil(daoEnderecos);

    if lstEnderecos <> nil then
      FreeAndNil(lstEnderecos);

    if SMViaCep <> nil then
      FreeAndNil(SMViaCep);
  end;
end;

end.
