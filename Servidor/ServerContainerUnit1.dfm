object ServerContainer1: TServerContainer1
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    Left = 16
    Top = 11
  end
  object DSSCPessoa: TDSServerClass
    OnGetClass = DSSCPessoaGetClass
    Server = DSServer1
    Left = 120
    Top = 3
  end
  object DSSVEndereco: TDSServerClass
    OnGetClass = DSSVEnderecoGetClass
    Server = DSServer1
    Left = 120
    Top = 51
  end
  object DSSCViaCep: TDSServerClass
    OnGetClass = DSSCViaCepGetClass
    Server = DSServer1
    Left = 120
    Top = 147
  end
end
