unit Controller.ViaCep;

interface

uses DAO.ViaCep, REST.Types, System.SysUtils;

type
  TDTOViaCep = class
  strict private
    fCep:         string;
    fLogradouro:  string;
    fComplemento: string;
    fBairro:      string;
    fLocalidade:  string;
    fUf:          string;
    fIbge:        string;
    fGia:         string;
    fDdd:         string;
    fSiafi:       string;
  public
    constructor Create;
  published
    property Cep:         string read fCep          write fCep;
    property Logradouro:  string read fLogradouro   write fLogradouro;
    property Complemento: string read fComplemento  write fComplemento;
    property Bairro:      string read fBairro       write fBairro;
    property Localidade:  string read fLocalidade   write fLocalidade;
    property Uf:          string read fUf           write fUf;
    property Ibge:        string read fIbge         write fIbge;
    property Gia:         string read fGia          write fGia;
    property Ddd:         string read fDdd          write fDdd;
    property Siafi:       string read fSiafi        write fSiafi;
  end;

  TControllerViaCep = class
  private
    fDAO: TDAOViaCep;
  public
    function GetDados(aCep: string): TDTOViaCep;
    constructor Create;
  end;

implementation

{ TDTOViaCep }

constructor TDTOViaCep.Create;
begin
  fCep:=         Default(string);
  fLogradouro:=  Default(string);
  fComplemento:= Default(string);
  fBairro:=      Default(string);
  fLocalidade:=  Default(string);
  fUf:=          Default(string);
  fIbge:=        Default(string);
  fGia:=         Default(string);
  fDdd:=         Default(string);
  fSiafi:=       Default(string);
end;

{ TControllerViaCep }

constructor TControllerViaCep.Create;
begin
  fDAO:= TDAOViaCep.GetInstance;
end;

function TControllerViaCep.GetDados(aCep: string): TDTOViaCep;
begin
  fDAO.Adapter.Active:= True;
  fDAO.Request.Method:= TRESTRequestMethod.rmGET;
  fDAO.Request.Params.Clear;
  fDAO.Request.Params.AddItem('qCep', aCep, TRESTRequestParameterKind.pkQUERY);
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
