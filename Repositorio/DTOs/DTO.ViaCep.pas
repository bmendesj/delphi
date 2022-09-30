unit DTO.ViaCep;

interface

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

end.
