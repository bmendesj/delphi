unit DAO.Pessoas;

interface

uses
  System.SysUtils, System.JSON, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDAOPessoas = class
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

{ TDAOPessoas }

uses uJsonDataSetHelper;

constructor TDAOPessoas.Create(aConector: TFDConnection);
begin
  fConector:= aConector;
end;

destructor TDAOPessoas.Destroy;
begin

  inherited;
end;

function TDAOPessoas.Get(const aFiltro: TPair<string, string>; aIdPaginacao: Int64 = -1): TJSONArray;
const
  _sql = 'SELECT * FROM teste_delphi.pessoa';
var
  fdqPessoa: TFDQuery;
begin
  Result:=    nil;
  fdqPessoa:= nil;

  try
    try
      fdqPessoa:= TFDQuery.Create(nil);
      fdqPessoa.Connection:= fConector;
      fdqPessoa.SQL.Add(_sql);

      if (aFiltro.Key.Length > 0) or (aIdPaginacao > -1) then
        fdqPessoa.SQL.Add('WHERE');

      if aFiltro.Key.Length  > 0 then
        fdqPessoa.SQL.Add('  ' + aFiltro.Key + ' = ' + aFiltro.Value)
      else
        if aIdPaginacao > -1 then
          fdqPessoa.SQL.Add('  idpessoa >= ' + aIdPaginacao.ToString);


      fdqPessoa.SQL.Add('ORDER BY idpessoa');

      if (aFiltro.Key.Length = 0) and (aIdPaginacao > -1) then
        fdqPessoa.SQL.Add('LIMIT 200');

      fdqPessoa.Open;

      Result:= fdqPessoa.ToJsonArray;
    except on E: Exception do
      raise;
    end;
  finally
    if fdqPessoa <> nil then
      FreeAndNil(fdqPessoa);
  end;
end;

function TDAOPessoas.Insert(aJsonArray: TJSONArray): integer;
const
  _sql = 'CALL teste_delphi.pessoa_endereco(' +
         '  :flnatureza, ' +
         '  :dsdocumento, ' +
         '  :nmprimeiro, ' +
         '  :nmsegundo, ' +
         '  :dtregistro, ' +
         '  :dscep, ' +
         '  :dsuf, ' +
         '  :nmcidade, ' +
         '  :nmbairro, ' +
         '  :nmlogradouro, ' +
         '  :dscomplemento' +
         ')';
var
  fdqPessoa: TFDQuery;
  jValores: TJSONValue;
  idx:      Integer;
begin
  idx:= 0;

  fdqPessoa:= nil;

  try
    try
      fdqPessoa:= TFDQuery.Create(nil);
      fdqPessoa.SQL.Clear;
      fdqPessoa.SQL.Add(_sql);
      fdqPessoa.Params.ArraySize:= aJsonArray.Count;

      fConector.StartTransaction;

      for jValores in aJsonArray do
      begin
        fdqPessoa.ParamByName('flnatureza').AsSmallInts[idx]:=  jValores.GetValue<SmallInt>('flnatureza');
        fdqPessoa.ParamByName('dsdocumento').AsStrings[idx]:=   jValores.GetValue<string>('dsdocumento');
        fdqPessoa.ParamByName('nmprimeiro').AsStrings[idx]:=    jValores.GetValue<string>('nmprimeiro');
        fdqPessoa.ParamByName('nmsegundo').AsStrings[idx]:=     jValores.GetValue<string>('nmsegundo');
        fdqPessoa.ParamByName('dtregistro').AsDates[idx]:=      StrToDate(jValores.GetValue<string>('dtregistro'));
        fdqPessoa.ParamByName('dscep').AsStrings[idx]:=         jValores.GetValue<string>('dscep');
        fdqPessoa.ParamByName('dsuf').AsStrings[idx]:=          jValores.GetValue<string>('dsuf');
        fdqPessoa.ParamByName('nmcidade').AsStrings[idx]:=      jValores.GetValue<string>('nmcidade');
        fdqPessoa.ParamByName('nmbairro').AsStrings[idx]:=      jValores.GetValue<string>('nmbairro');
        fdqPessoa.ParamByName('nmlogradouro').AsStrings[idx]:=  jValores.GetValue<string>('nmlogradouro');
        fdqPessoa.ParamByName('dscomplemento').AsStrings[idx]:= jValores.GetValue<string>('dscomplemento');

        Inc(idx);
      end;

      if idx > 0 then
        fdqPessoa.Execute(idx);

      fdqPessoa.SQL.Clear;
      fdqPessoa.SQL.Add('SELECT currval(pg_get_serial_sequence('+ QuotedStr('teste_delphi.pessoa') + ',' + QuotedStr('idpessoa') + ')) AS idpessoa');
      fdqPessoa.Open;

      Result:= fdqPessoa.FieldByName('idpessoa').AsLargeInt;

      fConector.Commit;
    except
      on E: Exception do
      begin
        fConector.Rollback;
        raise;
      end;
    end;
  finally
    if fdqPessoa <> nil then
      FreeAndNil(fdqPessoa);
  end;
end;

function TDAOPessoas.Update(const aId: Int64; aJsonArray: TJSONArray): Integer;
const
  _sql = 'UPDATE teste_delphi.pessoa ' +
         'SET ' +
         '  flnatureza  = :flnatureza, ' +
         '  dsdocumento = :dsdocumento, ' +
         '  nmprimeiro  = :nmprimeiro, ' +
         '  nmsegundo   = :nmsegundo, ' +
         '  dtregistro  = :dtregistro ' +
         'WHERE idpessoa = :idPessoa';
var
  fdqPessoa: TFDQuery;
  lValores:  TJSONValue;
begin
{
  Foi mantido o usso do jsonArray para futuramente suportar a atualização de multiplos resgistros
  essa alteraçãos será feita com a criar de uma função concorrente (overload)
}
  Result:= 0;

  fdqPessoa:= nil;

  try
    try
      lValores:= aJsonArray.Items[0];

      fdqPessoa:= TFDQuery.Create(nil);
      fdqPessoa.Connection:= fConector;
      fdqPessoa.SQL.Add(_sql);

      fConector.StartTransaction;

      fdqPessoa.ParamByName('idpessoa').AsLargeInt:=   aId;
      fdqPessoa.ParamByName('flnatureza').AsSmallInt:= lValores.GetValue<SmallInt>('flnatureza');
      fdqPessoa.ParamByName('dsdocumento').AsString:=  lValores.GetValue<string>('dsdocumento');
      fdqPessoa.ParamByName('nmprimeiro').AsString:=   lValores.GetValue<string>('nmprimeiro');
      fdqPessoa.ParamByName('nmsegundo').AsString:=    lValores.GetValue<string>('nmsegundo');
      fdqPessoa.ParamByName('dtregistro').AsDate:=     StrToDate(lValores.GetValue<string>('dtregistro'));

      fdqPessoa.ExecSQL;

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
    if fdqPessoa <> nil then
      FreeAndNil(fdqPessoa);
  end;
end;  

function TDAOPessoas.Delete(const aId: Int64): Integer;
const
  _sql = 'DELETE FROM teste_delphi.pessoa	WHERE idpessoa = :idpessoa';
var
  fdqPessoa: TFDQuery;
begin
{
  O retorno foi mantido como inteiro para que futuramente a função possa ser
  alterada para suportar a deleção de multiplos registros
}
  Result:= 0;

  fdqPessoa:= nil;

  try
    
    fdqPessoa:= TFDQuery.Create(nil);
    fdqPessoa.Connection:= fConector;
    fdqPessoa.SQL.Add(_sql);
    fConector.StartTransaction;

    fdqPessoa.ParamByName('idpessoa').AsLargeInt:=   aId;

    fdqPessoa.ExecSQL;

    fConector.Commit;

    Result:= 1;
  except
    on E: Exception do
    begin
      fConector.Rollback;
      raise;
    end;
  end;
end;

end.
