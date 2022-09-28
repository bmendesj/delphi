# Teste Delphi

Conjunto de aplicações client/Servidor com Datasnap para analise. "Feito é melhor que perfeito"[^1].

## Servidor

Aplicação servidora REST stateless desenvolvida em Datasnap com uso de FireDAC na camada de persistência. Por se tratar de um servidor apenas para validação de conhecimentos de CRUD ele não possui arquivo de configuração, criptografia ou sistema de autenticação, itens esses indispensáveis em uma aplicação de emprego real.

Para máxima eficiência os inserts foram montados com suporte a Array DML consumindo stored procedures tornando o processo muito rápido e dispensando a necessidade de um endpoint específico para inserção em lote. 

O uso de stored procedures permite inserir registros em diferentes tabelas sem a necessidade de executar múltiplas instruções SQL para insersão e obtenção do ID da tabela mestre para uso na tabela Ficha. Esse arranjo permite inserir grandes quantidade de registros sem ferir a integridade e sem comprometer a performance. 


## Cliente

Cliente feito em CVL para consumir os serviços implementados no servidor REST



[^1]: George Patton