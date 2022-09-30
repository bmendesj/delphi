unit DTO.Endereco;

interface

type
  TDTOEndereco = class
  strict private
    fIdEndereco:  Int64;
    fIdPessoa:    Int64;
    fCep:         string;
    fUf:          string;
    fCidade:      string;
    fBairro:      string;
    fLogradouro:  string;
    fComplemento: string;
  public
    constructor Create;               overload;
    constructor Create(aCep: string); overload;
  published
    property IdEndereco:  Int64  read fIdEndereco  write fIdEndereco;
    property IdPessoa:    Int64  read fIdPessoa    write fIdPessoa;
    property Cep:         string read fCep         write fCep;
    property Uf:          string read fUf          write fUf;
    property Cidade:      string read fCidade      write fCidade;
    property Bairro:      string read fBairro      write fBairro;
    property Logradouro:  string read fLogradouro  write fLogradouro;
    property Complemento: string read fComplemento write fComplemento;
  end;

implementation

{ TDTOEndereco }

constructor TDTOEndereco.Create;
begin
    fIdEndereco:=  -1;
    fIdPessoa:=    Default(Int64);
    fCep:=         Default(string);
    fUf:=          Default(string);
    fCidade:=      Default(string);
    fBairro:=      Default(string);
    fLogradouro:=  Default(string);
    fComplemento:= Default(string);
end;

constructor TDTOEndereco.Create(aCep: string);
begin
  Create;

  fCep:= aCep;
end;

end.
