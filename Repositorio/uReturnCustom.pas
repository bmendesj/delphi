{******************************************************************************}
{    AUTOR: Benjamim Mendes Junior                                             }
{                                                                              }
{    Esta biblioteca de Records se destina a tornar o retorno de métodos mais  }
{  funcional em quanto cria um padrão para passagem de paramentos validação de }
{  retornos e obtenção de mensagens de erros.                                  }
{                                                                              }
{  Ela é especialmente útil em médotos de validação                            }
{******************************************************************************}

unit uReturnCustom;

interface

uses
  classes, System.Generics.Collections, RTTI, System.SysUtils;

type
  {$SCOPEDENUMS ON}
  TBoolean = (False, True, Null);

  TFilter = TPair<string, TValue>;

  TTrio<TChave, TDescricao, TValor> = class
    Chave:     TChave;
    Descricao: TDescricao;
    Valor:     TValor;
    constructor Create(const aChave: TChave; const aDescricao: TDescricao; const aValor: TValor);
  end;

  TReturnCustom<T> = record
    HasError: Boolean;
    Value:    T;
    Mensage:  string;
    procedure Clear;
  end;

  TReturnCustomStatus<T, K> = record
    HasError: Boolean;
    Value:    T;
    Status:   K;
    Mensage:  string;
    procedure Clear;
  end;

  TReturnBoolean = record
    HasError: Boolean;
    Value:    Boolean;
    Mensage:  string;
    procedure Clear;
  end;

  TReturnCurreny = record
    HasError: Boolean;
    Value:    Currency;
    Mensage:  string;
    procedure Clear;
  end;

  TReturnDate = record
    HasError: Boolean;
    Value:    TDate;
    Mensage:  string;
    procedure Clear;
  end;

  TReturnDateTime = record
    HasError: Boolean;
    Value:    TDateTime;
    Mensage:  string;
    procedure Clear;
  end;

  TReturnInteger = record
    HasError: Boolean;
    Value:    Integer;
    Mensage:  string;
    procedure Clear;
  end;

  TReturnInt64 = record
    HasError: Boolean;
    Value:    Int64;
    Mensage:  string;
    procedure Clear;
  end;

  TReturnString = record
    HasError: Boolean;
    Value:    string;
    Mensage:  string;
    procedure Clear;
  end;

  TReturnTime = record
    HasError: Boolean;
    Value:    TTime;
    Mensage:  string;
    procedure Clear;
  end;

  TReturnTStrings = record
    HasError: Boolean;
    Value:    TStrings;
    Mensage:  string;
    procedure Clear;
  end;

implementation

{ TTrio<TChave, TDescricao, TValor> }

constructor TTrio<TChave, TDescricao, TValor>.Create(const aChave: TChave; const aDescricao: TDescricao; const aValor: TValor);
begin
  Chave:=     aChave;
  Descricao:= aDescricao;
  Valor:=     aValor;
end;

{ TReturnCustom<T> }

procedure TReturnCustom<T>.Clear;
begin
  HasError:= True;
  Value:=    Default(T);
  Mensage:=  '';
end;

{ TReturnCustomStatus<T, K> }

procedure TReturnCustomStatus<T, K>.Clear;
begin
  HasError:= True;
  Value:=    Default(T);
  Status:=   Default(K);
  Mensage:=  '';
end;

{ TReturnBoolean }

procedure TReturnBoolean.Clear;
begin
  HasError:= True;
  Value:=    False;
  Mensage:=  '';
end;

{ TReturnCurreny }

procedure TReturnCurreny.Clear;
begin
  HasError:= True;
  Value:=    0;
  Mensage:=  '';
end;

{ TReturnDate }

procedure TReturnDate.Clear;
begin
  HasError:= True;
  Value:=    0;
  Mensage:=  '';
end;

{ TReturnDateTime }

procedure TReturnDateTime.Clear;
begin
  HasError:= True;
  Value:=    0;
  Mensage:=  '';
end;

{ TReturnInteger }

procedure TReturnInteger.Clear;
begin
  HasError:= True;
  Value:=    0;
  Mensage:=  '';
end;

{ TReturnInt64 }

procedure TReturnInt64.Clear;
begin
  HasError:= True;
  Value:=    0;
  Mensage:=  '';
end;

{ TReturnString }

procedure TReturnString.Clear;
begin
  HasError:= True;
  Value:=    '';
  Mensage:=  '';
end;

{ TReturnTime }

procedure TReturnTime.Clear;
begin
  HasError:= True;
  Value:=    0;
  Mensage:=  '';
end;

{ TReturnTStrings }

procedure TReturnTStrings.Clear;
begin
  HasError:= True;
  Value:=    nil;
  Mensage:=  '';
end;

end.
