unit DAO.Enderecos;

interface

uses
  System.SysUtils, System.Generics.Collections, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDAOEnderecos = class
  private
    fConector: TFDConnection;
  public
    function Get(const aFiltro: TPair<string, string>; aIdPaginacao: Int64 = -1): TJSONArray;
    function Insert(aJsonArray: TJSONArray): integer;
    function Update(const aId: Int64; aJsonArray: TJSONArray): Integer;
    function Delete(const aId: Int64): Integer;

    constructor Create(aConector: TFDConnection);
    destructor Destroy; override;
  published
  end;

implementation

{ TDAOEnderecos }

uses uJsonDataSetHelper;

constructor TDAOEnderecos.Create(aConector: TFDConnection);
begin
  fConector:= aConector;
end;

destructor TDAOEnderecos.Destroy;
begin

  inherited;
end;

function TDAOEnderecos.Get(const aFiltro: TPair<string, string>; aIdPaginacao: Int64 = -1): TJSONArray;
const
  _sql = 'SELECT ' +
         '  e.idendereco, ' +
         '  e.idpessoa, ' +
         '  e.dscep, ' +
         '  i.dsuf, ' +
         '  i.nmcidade, ' +
         '  i.nmbairro, ' +
         '  i.nmlogradouro, ' +
         '  i.dscomplemento ' +
         'FROM teste_delphi.endereco AS e ' +
         '  JOIN teste_delphi.endereco_integracao AS i ON (i.idendereco = e.idendereco)';
var
  fdqEndereco: TFDQuery;
begin
  Result:= nil;

  fdqEndereco:= nil;

  try
    try
      fdqEndereco:= TFDQuery.Create(nil);
      fdqEndereco.Connection:= fConector;
      fdqEndereco.SQL.Add(_sql);
      fdqEndereco.SQL.Add('WHERE');
      fdqEndereco.SQL.Add('  e.' + aFiltro.Key + ' = ' + aFiltro.Value);

      if aIdPaginacao > -1 then
        fdqEndereco.SQL.Add('  AND e.idendereco >= ' + aIdPaginacao.ToString);

      fdqEndereco.SQL.Add('ORDER BY e.idendereco');

      if (aIdPaginacao > -1) then
        fdqEndereco.SQL.Add('LIMIT 100');

      fdqEndereco.Open;

      Result:= fdqEndereco.ToJsonArray;
    except on E: Exception do
      raise;
    end;
  finally
    if fdqEndereco <> nil then
      FreeAndNil(fdqEndereco)
  end;
end;

function TDAOEnderecos.Insert(aJsonArray: TJSONArray): integer;
const
  _sql = 'CALL teste_delphi.endereco_enderecoIntegracao(' +
         '  :idpessoa, ' +
         '  :dscep, ' +
         '  :dsuf, ' +
         '  :nmcidade, ' +
         '  :nmbairro, ' +
         '  :nmlogradouro, ' +
         '  :dscomplemento' +
         ')';
var
  fdqEndereco: TFDQuery;
  jValores: TJSONValue;
  idx:      Integer;
begin
  idx:= 0;

  fdqEndereco:= nil;

  try
    try
      fdqEndereco:= TFDQuery.Create(nil);
      fdqEndereco.Connection:= fConector;
      fdqEndereco.SQL.Add(_sql);
      fdqEndereco.Params.ArraySize:= aJsonArray.Count;

      fConector.StartTransaction;

      for jValores in aJsonArray do
      begin
        fdqEndereco.ParamByName('idpessoa').AsLargeInts[idx]:=  jValores.GetValue<Largeint>('idpessoa');
        fdqEndereco.ParamByName('dscep').AsStrings[idx]:=         jValores.GetValue<string>('dscep');
        fdqEndereco.ParamByName('dsuf').AsStrings[idx]:=          jValores.GetValue<string>('dsuf');
        fdqEndereco.ParamByName('nmcidade').AsStrings[idx]:=      jValores.GetValue<string>('nmcidade');
        fdqEndereco.ParamByName('nmbairro').AsStrings[idx]:=      jValores.GetValue<string>('nmbairro');
        fdqEndereco.ParamByName('nmlogradouro').AsStrings[idx]:=  jValores.GetValue<string>('nmlogradouro');
        fdqEndereco.ParamByName('dscomplemento').AsStrings[idx]:= jValores.GetValue<string>('dscomplemento');

        Inc(idx);
      end;

      if idx > 0 then
        fdqEndereco.Execute(idx);

      fdqEndereco.SQL.Clear;
      fdqEndereco.SQL.Add('SELECT currval(pg_get_serial_sequence('+ QuotedStr('teste_delphi.endereco') + ',' + QuotedStr('idendereco') + ')) AS idendereco');
      fdqEndereco.Open;

      Result:= fdqEndereco.FieldByName('idendereco').AsLargeInt;

      fConector.Commit;
    except
      on E: Exception do
      begin
        fConector.Rollback;
        raise;
      end;
    end;
  finally
    if fdqEndereco <> nil then
      FreeAndNil(fdqEndereco);
  end;
end;

function TDAOEnderecos.Update(const aId: Int64; aJsonArray: TJSONArray): Integer;
const
  _sqlEndereco =
    'UPDATE teste_delphi.endereco ' +
    'SET ' +
    '  idpessoa = :idpessoa, ' +
    '  dscep    = :dscep ' +
    'WHERE idendereco = :idendereco';

  _sqlEnderecoIntegracao =
    'UPDATE teste_delphi.endereco_integracao ' +
    'SET ' +
    '  dsuf          = :dsuf, ' +
    '  nmcidade      = :nmcidade, ' +
    '  nmbairro      = :nmbairro, ' +
    '  nmlogradouro  = :nmlogradouro, ' +
    '  dscomplemento = :dscomplemento ' +
    'WHERE idendereco = :idendereco';
var
  fdqEndereco: TFDQuery;
  lValores: TJSONValue;
begin
{
  Foi mantido o usso do jsonArray para futuramente suportar a atualização de multiplos resgistros
  essa alteraçãos será feita com a criar de uma função concorrente (overload)
}
  Result:= 0;

  fdqEndereco:= nil;

  try
    try
      lValores:= aJsonArray.Items[0];

      fdqEndereco:= TFDQuery.Create(nil);
      fdqEndereco.Connection:= fConector;

      fConector.StartTransaction;

      fdqEndereco.SQL.Add(_sqlEndereco);
      fdqEndereco.ParamByName('idendereco').AsLargeInt:=   aId;
      fdqEndereco.ParamByName('idpessoa').AsLargeInt:= lValores.GetValue<Largeint>('idpessoa');
      fdqEndereco.ParamByName('dscep').AsString:=      lValores.GetValue<string>('dscep');
      fdqEndereco.ExecSQL;

      fdqEndereco.SQL.Clear;
      fdqEndereco.SQL.Add(_sqlEnderecoIntegracao);
      fdqEndereco.ParamByName('idendereco').AsLargeInt:=  aId;
      fdqEndereco.ParamByName('dsuf').AsString:=          lValores.GetValue<string>('dsuf');
      fdqEndereco.ParamByName('nmcidade').AsString:=      lValores.GetValue<string>('nmcidade');
      fdqEndereco.ParamByName('nmbairro').AsString:=      lValores.GetValue<string>('nmbairro');
      fdqEndereco.ParamByName('nmlogradouro').AsString:=   lValores.GetValue<string>('nmlogradouro');
      fdqEndereco.ParamByName('dscomplemento').AsString:= lValores.GetValue<string>('dscomplemento');
      fdqEndereco.ExecSQL;

      fConector.Commit;

      Result:= aJsonArray.Count;
    except
      on E: Exception do
      begin
        fConector.Rollback;
        raise;
      end;
    end;
  finally
    if fdqEndereco <> nil then
      FreeAndNil(fdqEndereco);
  end;
end;

function TDAOEnderecos.Delete(const aId: Int64): Integer;
const
  _sql = 'DELETE FROM teste_delphi.endereco	WHERE idendereco = :idendereco';
var
  fdqEndereco: TFDQuery;
begin
{
  O retorno foi mantido como inteiro para que futuramente a função possa ser
  alterada para suportar a deleção de multiplos registros
}
  Result:= 0;

  fdqEndereco:= nil;

  try
    try
      fdqEndereco:= TFDQuery.Create(nil);
      fdqEndereco.SQL.Add(_sql);

      fConector.StartTransaction;

      fdqEndereco.ParamByName('idendereco').AsLargeInt:=   aId;

      fdqEndereco.ExecSQL;

      fConector.Commit;

      Result:= 1;
    except
      on E: Exception do
      begin
        fConector.Rollback;
        raise;
      end;
    end;
  finally
    if fdqEndereco <> nil then
      FreeAndNil(fdqEndereco);
  end;
end;

end.
