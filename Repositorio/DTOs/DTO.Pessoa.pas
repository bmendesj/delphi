unit DTO.Pessoa;

interface

type
  TDTOPessoa = class
  strict private
    fIdpessoa:  Int64;
    fNatureza:  SmallInt;
    fDocumento: string;
    fPrimeiro:  string;
    fSegundo:   string;
    fRegistro:  TDate;
  public
    constructor Create;
  published
    property Idpessoa:  Int64    read fIdpessoa  write fIdpessoa;
    property Natureza:  SmallInt read fNatureza  write fNatureza;
    property Documento: string   read fDocumento write fDocumento;
    property Primeiro:  string   read fPrimeiro  write fPrimeiro;
    property Segundo:   string   read fSegundo   write fSegundo;
    property Registro:  TDate    read fRegistro  write fRegistro;
  end;

implementation

{ TDTOPessoa }

constructor TDTOPessoa.Create;
begin
  fIdpessoa:=  -1;
  fNatureza:=  Default(SmallInt);
  fDocumento:= Default(string);
  fPrimeiro:=  Default(string);
  fSegundo:=   Default(string);
  fRegistro:=  Default(TDate);
end;

end.
