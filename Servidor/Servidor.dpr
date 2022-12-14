program Servidor;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uView.Principal in 'View\uView.Principal.pas' {Principal},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  DAO.DMConexao in 'Model\DAO.DMConexao.pas' {DMConexao: TDataModule},
  uJsonDataSetHelper in 'uJsonDataSetHelper.pas',
  DAO.Pessoas in 'Model\DAO.Pessoas.pas',
  DAO.Enderecos in 'Model\DAO.Enderecos.pas',
  SMPessoa in 'Controller\SMPessoa.pas' {SMPessoa: TDSServerModule},
  SMEndereco in 'Controller\SMEndereco.pas' {SMEndereco: TDSServerModule},
  SMViaCep in 'Controller\SMViaCep.pas' {SMViaCep: TDSServerModule},
  DTO.Endereco in '..\Repositorio\DTOs\DTO.Endereco.pas',
  DTO.Pessoa in '..\Repositorio\DTOs\DTO.Pessoa.pas',
  DTO.ViaCep in '..\Repositorio\DTOs\DTO.ViaCep.pas',
  SMAtualizaCepEmLote in 'Controller\SMAtualizaCepEmLote.pas' {SMAtualizaCepEmLote: TDSServerModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TPrincipal, Principal);
  Application.CreateForm(TDMConexao, DMConexao);
  Application.Run;
end.
