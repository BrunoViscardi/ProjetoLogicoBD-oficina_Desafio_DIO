-- criação do banco de dados para o cenário de uma oficina 
create database oficina;
use oficina;




-- ----------------------------------------------------------------------------
-- criar tabela cliente
create table clients(
		idClients int auto_increment primary key,
        NomeCompleto varchar(100),
        CPF char(11) not null,
        dataNascimento date,
        endereço varchar(100),
        contato char(11),
        constraint unique_cpf_client unique (CPF)
); 

insert into clients (NomeCompleto, CPF, dataNascimento, endereço, contato)
			  values('João Risorio Alarde', '12345678902','1996-10-04','Rua dos alpes, jardim falesias, 1985','69321458710'),
                    ('Maria guilhermina Santos', '12345357902','1962-10-31','Rua dos ipes, jardim das ilhas, 01','69321458989'),
                    ('Adamastor Rubéolo', '12345678000','1982-01-21','Rua dos iglus, jardim antartico, 987','69321458057'),
                    ('Keren Zuardes', '12345678331','1989-06-04','Rua dos lagos, jardim pantanal, 326','69321450368'),
                    ('Beatrice Monarca Alias', '12345678325','2000-03-03','Rua dos borboletas, jardim Real, 366','69321458654'),
                    ('Catarina Silva e Cruz', '12345678035','1999-09-07','Rua das penitencias, jardim latinos, 123','69321458123');





-- ----------------------------------------------------------------------------
-- criar tabela veículos
create table veiculo(
		idveiculo int auto_increment,
        idClients int,
        modelo varchar(40),
        ano year,
        placa char(7) not null,
        cor varchar(10),
        primary key(idveiculo,idClients),
        constraint unique_placa unique (placa),
        constraint fk_veiculo_cliente foreign key (idClients) references clients(idClients)
        
); 



insert into veiculo (idClients, modelo, ano, placa, cor)
              values (1,' Uno, Fiat', '2021', 'ABCDE69', 'Preto'),
                     (2, 'Gol, Volkswagen','2006','EDCBA68','Branco'),
                     (3, 'CrossFox, Volkswagen','2010','IOPLT00','Branco'),
                     (4, 'Siena, Fiat','2001','OLHTE11','Prata'),
                     (5, 'HB20, Hyundai','2019','HTALP20','Branco'),
                     (5, 'Cobalt, General Motors','2020','KLBOO21','Chumbo'),
                     (6, 'Corolla, Toyota ','2013','BRUN30','Chumbo');
                     
                



-- ----------------------------------------------------------------------------
-- criar tabela funcionário
create table funcionario(
		idFuncionario int auto_increment primary key,
        NomeCompleto varchar(100),
        Especialidade varchar(30),
        dataNascimento date,
        contato char(11),
        PIS char(11) not null,
        constraint unique_PIS unique (PIS)
); 

insert into funcionario(NomeCompleto, Especialidade, dataNascimento, contato, PIS)
				values('Cleiton Laranja Amorim', 'Venda', '1991-01-01','69999997630','09361071494'),
                      ('Lidia Atroz Maria', 'Balanceamento e Alinhamento', '1989-02-07','69995897698','09361071301'),
                      ('Ingrid Marães Costa', 'Mecânica geral', '2000-12-12','69999997777','09361071777'),
                      ('Alisson Nair Lima', 'Elétrica', '1997-04-04','69999991024','09361071685'),
                      ('Ulisses Guimarães', 'Mecânica geral', '1986-07-07','69999997888','09361071888'),
                      ('Eva Maria Anrrel', 'Funilaria', '1979-06-06','69999997976','09361071666');




-- -- ----------------------------------------------------------------------------
-- criar tabela fornecedor
create table fornecedor(
		idFornecedor int auto_increment primary key,
        NomeSocial varchar(40),
        CNPJ char(11) not null,
        contato char(11),
        Fo_local_UF char(2),
        constraint unique_CNPJ unique (CNPJ)
); 

insert into fornecedor(NomeSocial, CNPJ, contato, Fo_local_UF)
               values('Peças Cadeado','09361071494','69999997630','GO'),
                     ('Olearia','09361078857','69123997630','RJ'),
                     ('Armazém das Peças','09361071204','69999997365','GO'),
                     ('Cleitinho Pneus','09361071875','69999997300','MS');
                     




-- -- ----------------------------------------------------------------------------
-- criar tabela produto
create table produto(
		idProduto int auto_increment primary key,
        Pnome varchar(40),
        Descrição varchar (100),
        Qtd_Estoque int,
        Valor float,
        Fornecedor int,
        constraint fk_CNPJ foreign key (Fornecedor) references fornecedor(idFornecedor)
); 


insert into produto (Pnome, Descrição, Qtd_Estoque, Valor, Fornecedor)
              values('Vela de Ignição', 'AA, Grande', 50, 584, 3),
                    ('Junta do Cabeçote', '1200 cilindradas', 200, 100, 1),
                    ('Amortecedor Dianteiro', '25 cm', 3, 47, 1),
                    ('Disco de Freio', '80 cm', 44, 270, 3),
                    ('Óleo lubrificante', 'aditivado, Ml lub', 50, 80, 2),
                    ('Sensor Lambda', '50A, eletronico PA', 2, 350, 3),
                    ('Pneus', 'Dianteiro, não liso', 44, 350, 4),
                    ('Pneus', 'Traseiro, não liso', 44, 360, 4),
                    ('Válvula Termostática', 'AS termo Ele', 3, 36000, 1);
                    
	                 
                    
                    




-- -- ----------------------------------------------------------------------------
-- criar tabela (Venda de) Serviços
create table serviços(
		idserviço int auto_increment,
        idVeiculo int,
        Responsável int not null,
        DescriçãoServiço varchar (100),
        sStatus enum('Finalizado','Pendente','Em Operação') default 'Finalizado',
        primary key (idserviço, idVeiculo),
        constraint fk_veiculo_serviço foreign key (idVeiculo) references veiculo(idveiculo),
        constraint fk_funcionario_serviço foreign key (Responsável) references funcionario(idFuncionario)
); 




insert into serviços(idVeiculo, Responsável, DescriçãoServiço, sStatus)
             values (7, 5, 'Troca de óleo', default),
                    (6, 6, 'Pintura retrovisor', default),
                    (5, 2, 'Balanceamento eixo dianteiro', 'Pendente'),
                    (4, 3, 'Calibração', 'Em Operação'),
                    (3, 4, 'Manutenção ignição elétrica', default),
                    (2, 5, 'Troca de pneus dianteiro', default),
                    (1, 5, 'Troca de pneus dianteiro', 'Em Operação');
                    




-- -- ----------------------------------------------------------------------------
-- criar tabela Vendas de Produtos
create table vendasProduto(
		idVPvenda int auto_increment,
        idVPproduto int not null,
        Qtd int not null default 1,
        idVendedor int,
        primary key(idVPvenda, idVPproduto),
        constraint fk_venda_produto foreign key (idVPproduto) references produto(idProduto),
        constraint fk_venda_produto_funcionario foreign key (idVendedor) references funcionario(idFuncionario)
); 


select * from produto;
insert into vendasProduto(idVPproduto, Qtd, idVendedor)
				  values(6,1,1),
						(7,2,1),
                        (8,2,1),
                        (5,1,1),
                        (9,1,1),
                        (7,2,1),
                        (3,1,1);
                        


-- -- ----------------------------------------------------------------------------
-- criar tabela Vendas
create table vendas(
		idVenda int auto_increment,
        idCliente int,
        idVendasProduto int,
        idVendasServiço int,
        dataVenda date,
        primary key(idVenda, idCliente),
        constraint fk_vendas_cliente foreign key (idCliente) references clients(idClients),
        constraint fk_vendas_produto foreign key (idVendasProduto) references vendasProduto(idVPvenda),
        constraint fk_vendas_serviços foreign key (idVendasServiço) references serviços(idserviço)
); 


insert into vendas(idCliente, idVendasProduto, idVendasServiço, dataVenda)
			values(6,2,7,'2023-08-18'),
				  (6,3,null,'2023-07-08'),
                  (5,null,2,'2023-06-08'),
                  (6,null,1,'2023-05-08'),
                  (5,null,3,'2023-05-08'),
                  (4,4,4,'2023-05-08'),
				  (3,5,5,'2023-04-08'),
                  (2,6,6,'2023-05-08'),
                  (1,7,7,'2023-05-08'),
                  (1,3,null,'2023-04-08'),
                  (5,2,null,'2023-08-08'),
                  (3,1,null,'2023-02-08');
                  


-- -- ----------------------------------------------------------------------------
-- criar tabela Pagamento
create table pagamento(
		idpagamento int auto_increment,
        idPVenda int,
        valor float,
        formaPag enum('cartão de crédito','cartão de débito','boleto'),
        statusPag enum ('Confirmado','Pendente') default 'Confirmado',
        primary key(idpagamento, idPVenda),
        constraint fk_pagamento_venda foreign key (idPVenda) references vendas(idVenda)
); 


select * from vendas;

insert into pagamento(idPVenda, valor, formaPag, statusPag)
            values(12,3000,'cartão de crédito', default),
                  (11,1000,'cartão de débito', default),
                  (10,500,'cartão de crédito', default),
                  (9,400,'cartão de crédito', 'Pendente'),
                  (8,560,'boleto', default),
                  (7,256,'cartão de crédito', default),
                  (6,3598,'cartão de débito', default),
                  (5,2475,'cartão de crédito', default),
                  (4,6987,'cartão de crédito', default),
                  (3,325,'cartão de débito', default),
                  (2,758,'boleto', 'Pendente'),
                  (1,365,'cartão de crédito', default);


-- -------------------------------------------- Consultas ---------------------------------------------------------
select * from clients;
select * from veiculo;
select * from fornecedor;
select * from funcionario;
select * from pagamento;
select * from produto;
select * from serviços;
select * from vendas;


-- - Data de nascimentos dos funcionários e clientes (Atributo derivado)
select *, TIMESTAMPDIFF(year,dataNascimento,now()) as Idade from funcionario;
select *, TIMESTAMPDIFF(year,dataNascimento,now()) as Idade from clients; 


-- Clientes com pagamento pendente (Join, Where statment)
select c.idClients, c.NomeCompleto, c.CPF, v.idVendasProduto, v.dataVenda, p.valor from clients c inner join vendas v on c.idClients=v.idCliente inner join pagamento p on p.idPVenda=v.idVenda where statusPag='Pendente';


-- Ordenação das vendas de produtos ou serviços (order by) do mais recente para mais antigo
select * from vendas order by dataVenda desc;


-- Condição de filtros de grupos (Having statment)
-- Número de projetos finalizados que o funcionário id=5 possui
select  Responsável, count(*) as Número_de_serviços, sStatus as Status_do_serviço from serviços where sStatus='Finalizado'group by Responsável having Responsável=5;




