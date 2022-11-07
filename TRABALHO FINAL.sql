--MEDICOS
drop table tb_medico
CREATE TABLE tb_medico(
	[id] [int] NOT NULL primary key,
	[id_medico] [int] NOT NULL,
	[nome] [varchar] (50) NOT NULL,
	[data_nascimento] [date] NULL,
	[especialidade_medicas] [varchar] (20) NOT NULL)

insert into tb_medico
values (1, 1,'Grazyelly', '21-11-2000', 'Neurologista')
insert into tb_medico
values (2, 2,'Camila', '1993/07/28', 'Oncologista')
insert into tb_medico
values (3, 3,'Joaquim', '26/09/1998','Cardiologista')

select * from tb_medico

--PACIENTES
drop table tb_paciente

CREATE TABLE tb_paciente(
	[id] [int] NOT NULL primary key,
	[id_paciente] [int] NOT NULL,
	[nome_paciente] [varchar] (50) NOT NULL,
	[data_de_entrada] [date] NULL,
	[resultado_triagem] [varchar] (50) NOT NULL)

insert into tb_paciente
values (1, 1, 'João Silva', '17/10/2022', 'Dores no peito e falta de ar')
insert into tb_paciente
values (2, 3, 'Maria santos', '10/10/2022', 'Convulsões e tremores')
insert into tb_paciente
values (3, 2, 'Maria Joaquina', '16/10/2022', 'lesões na pele e dores na mama')

select * from tb_paciente

--GRAU DE GRAVIDADE

drop table tb_gravidade

CREATE TABLE tb_gravidade(
	[id] [int] NOT NULL primary key,
	[id_medico] [int] NOT NULL,
	[id_paciente] [int] NOT NULL,
	[nivel_de_gravidade] [varchar] (50) NOT NULL)

insert into tb_gravidade
values (1, 1, 1, 'MUITO URGENTE')
insert into tb_gravidade
values (2, 2, 3,'EMERGÊNCIA')
insert into tb_gravidade
values (3, 3, 4,'NÃO URGENTE')
insert into tb_gravidade
values (4, 1, 2, 'MUITO URGENTE')

select * from tb_gravidade

--QUARTOS
drop table tb_quarto
CREATE TABLE tb_quarto(
	[id] [int] NOT NULL primary key,
	[id_paciente] [int] NOT NULL,
	[numero_do_quarto] [int] NOT NULL,
	[tipo_do_quarto] [varchar] (50) NOT NULL,
	[capacidade_do_quarto] [varchar] (50) NOT NULL)

insert into tb_quarto
values (1, 1, 100, 'U.T.I', '10 leitos')
insert into tb_quarto
values (2, 2, 280, 'Enfermaria', '3 leitos')
insert into tb_quarto
values (3, 3, 10, 'Apartamento', '1 leito')

--QUARTOS VAGOS
drop table tb_quarto_vago
CREATE TABLE tb_quarto_vago(
	[id] [int] NOT NULL primary key,
	[id_paciente] [int] NOT NULL,
	[quarto_vago] [bit] NOT NULL,
	[leito_disponivel] [varchar] (50) NOT NULL)

insert into tb_quarto_vago
values (1, 1, 1, '4 leitos')
insert into tb_quarto_vago
values (2, 2, 0, 'Todos indisponiveis')
insert into tb_quarto_vago
values (3, 3, 0, 'Todos indisponiveis')

select * from tb_quarto_vago

--TABELA DE RESERVAS
drop table tb_reserva
CREATE TABLE tb_reserva(
	[id] [int] NOT NULL primary key,
	[id_paciente] [int] NOT NULL,
	[horario_reservado] [time] NOT NULL,
	[dia_reservado] [date] NOT NULL,
	[medico_escolhido] [varchar] (50) NOT NULL)

insert into tb_reserva
values (1, 1, '08:00', '01/11/2022', 'Neurologista')
insert into tb_reserva
values (2, 2,'08:00', '01/11/2022', 'Oncologista')
insert into tb_reserva
values (3, 3,'08:00', '01/11/2022', 'Cardiologista')

select * from tb_reserva

--RESUMOS DE ALTA 
drop table tb_resumo_alta
CREATE TABLE tb_resumo_alta(
	[id] [int] NOT NULL primary key,
	[id_paciente] [int] NOT NULL,
	[nome_paciente] [varchar] (50) NOT NULL,
	[data_de_entrada] [date] NOT NULL,
	[data_da_saida] [date] NOT NULL)

insert into tb_resumo_alta
values (1, 1, 'João Silva', '17/10/2022', '03/11/2022')
insert into tb_resumo_alta
values (2, 2, 'Maria santos', '10/10/2022', '31/10/2022')
insert into tb_resumo_alta
values (3, 2, 'Maria Joaquina', '16/10/2022', '20/10/2022')


ALTER TABLE tb_resumo_alta
WITH CHECK ADD CONSTRAINT RELA_01
FOREIGN KEY(id_paciente)
REFERENCES tb_paciente (id)

ALTER TABLE tb_paciente
WITH CHECK ADD CONSTRAINT RELA_02
FOREIGN KEY(id_paciente)
REFERENCES tb_quarto_vago (id)

ALTER TABLE tb_medico
WITH CHECK ADD CONSTRAINT RELA_03
FOREIGN KEY(id_medico)
REFERENCES tb_gravidade (id)

ALTER TABLE tb_paciente
WITH CHECK ADD CONSTRAINT RELA_04
FOREIGN KEY(id_paciente)
REFERENCES tb_reserva (id)

ALTER TABLE tb_paciente
WITH CHECK ADD CONSTRAINT RELA_05
FOREIGN KEY(id_paciente)
REFERENCES tb_gravidade (id)

ALTER TABLE tb_paciente
WITH CHECK ADD CONSTRAINT RELA_06
FOREIGN KEY(id_paciente)
REFERENCES tb_quarto (id)

--EXISTS
select * from tb_paciente 
where id = 1 and exists (select * from tb_gravidade where id_paciente = 1)

--IN
select * from tb_paciente 
where id IN (select id_paciente from tb_gravidade where id_paciente = 1)

--Group By (caunt contar) (as renomear)
select COUNT(id_paciente) as numero_paciente, nome_paciente from tb_paciente   
group by nome_paciente--Minselect min(id_medico) as minimo_paciente, nivel_de_gravidade
from tb_gravidade
group by nivel_de_gravidade--Maxselect max(id_medico) as minimo_paciente, nivel_de_gravidade
from tb_gravidade
group by nivel_de_gravidade
--HAVING
select sum(id_medico) as total_atendimento, nivel_de_gravidade
from tb_gravidade
group by nivel_de_gravidade
having sum(id_medico) > 2

select * from tb_medico
select * from tb_paciente
select * from tb_gravidade
select * from tb_quarto
select * from tb_quarto_vago
select * from tb_reserva
select * from tb_resumo_alta