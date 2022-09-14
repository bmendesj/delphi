# Teste Delphi

Conjunto de aplicações client/Servidor com Datasnap para analise. "Feito é melhor que perfeito"[^1].

## Servidor

Aplicação servidor desenvolvida de Datasnap. Os inserts foram montados com 
suporte a Array DML do FireDAC o que acelera o processo de insersão de grandes 
quantidades de registros sem a necessidade de uma função especifica, reduzindo 
dessa forma, a complexidade do código. Por se tratar de um servidor apenas para
validação de conhecimentos de CRUD ela não possui arquivo de configuração, 
criptografia ou sistema de autenticação, itens esses indispensáveis em uma 
aplicação de emprego real.

## Cliente

Cliente feito em CVL para consumir os serviços implementados no servidor REST


[^1]: George Patton