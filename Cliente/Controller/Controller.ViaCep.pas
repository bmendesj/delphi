unit Controller.ViaCep;

interface

uses
  DAO.ViaCep, DTO.ViaCep,
  REST.Types, System.SysUtils;

type
  TControllerViaCep = class
  private
    fDAO: TDAOViaCep;
  public
    function GetDados(aCep: string): TDTOViaCep;
    constructor Create;
  end;

implementation

{ TControllerViaCep }

constructor TControllerViaCep.Create;
begin
  fDAO:= TDAOViaCep.GetInstance;
end;

function TControllerViaCep.GetDados(aCep: string): TDTOViaCep;
begin
  fDAO.Adapter.Active:= True;
  fDAO.Request.Method:= TRESTRequestMethod.rmGET;
  fDAO.Request.Resource:= 'consultacep/' + aCep;
  fDAO.Request.Execute;

  if not fDAO.Request.Response.Status.Success then
    raise Exception.Create(fDAO.Request.Response.StatusText);

  Result:= TDTOViaCep.Create;
  Result.Cep:=         fDAO.DataSetcep.Value;
  Result.Logradouro:=  fDAO.DataSetlogradouro.Value;
  Result.Complemento:= fDAO.DataSetcomplemento.Value;
  Result.Bairro:=      fDAO.DataSetbairro.Value;
  Result.Localidade:=  fDAO.DataSetlocalidade.Value;
  Result.Uf:=          fDAO.DataSetuf.Value;
  Result.Ibge:=        fDAO.DataSetibge.Value;
  Result.Gia:=         fDAO.DataSetgia.Value;
  Result.Ddd:=         fDAO.DataSetddd.Value;
  Result.Siafi:=       fDAO.DataSetsiafi.Value;
end;

end.
