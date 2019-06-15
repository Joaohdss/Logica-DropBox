module DropBox
open Date as Date
open Objeto as Object
open util/ordering[Date] as to

------------------------------------------------------------------------
-- PROJETO ALLOY:  DROPBOX

-- GRUPO: 4

--	João Henrique
--	Luan
--	Caio
-- 	Fabiana 

-- CLIENTE : TIAGO MASSONI

-- PROFESSOR : TIAGO MASSONI

-------------------------------------------------------------------------

one sig User {
	storage : set Folder,
	device: set Device -> Date -- O usuario ta conectado no momento em um aparelho
}

sig Folder{
	archives: set Object -> Date
}

abstract sig Archive extends Object {
	info : one Info,
   backup : set Backup ->Date,
	permission: set Permission ->Date
}

sig Music extends Archive{}
sig Movie extends Archive{}
sig Text extends Archive{}
sig Image extends Archive{}
sig Rar extends Archive{}

sig Info {}
abstract sig Device {
	permission : one Permission
}

sig Pc extends Device{}
sig Cell extends Device{}
sig Kindle extends Device{}
sig Tablet extends Device{}

-- Permissao para ler e modificar arquivo

abstract sig Permission{}
one sig Read extends Permission{}
one sig Write_Read extends Permission{}

sig Backup{
}
--------- FATOS
fact Folder{
	-- Toda Pasta deve pertencer a um usuario
   all f : Folder | one f.~storage
}

fact Archive{	
	-- Info deve pertencer apenas a um arquivo
	all i : Info | one i.~info	
	-- Todo arquivo deve ter algum tipo de permissao
	all a:Archive,t:Date  | one a.(permission.t)
	
}
fact Device{
	-- Todo aparelho que for celular ou kindle sua permissao é Leitura
	all d:Device | (d in Cell || d in Kindle) => (d.permission = Read)
	-- Todo aparelho que for Pc ou Tablet é Leitura e Escrita 
	all d:Device | (d in Pc || d in Tablet) => (d.permission = Write_Read)
}
fact add_remove_update_archive {

	all date: Date-last | 
    let pos = date.next |
    some d:Object, p:Folder | 
    addArchive[d,p,date,pos] ||
	removeArchive[d,p,date,pos] 

}
---- PREDICADOS

pred addArchive[d:Object,p:Folder,t,t':Date] {
 	d !in p.(archives.t)
	(p.archives).t' = (p.archives).t + d
}
pred removeArchive[d:Object,p:Folder,t,t':Date] {
 	d !in p.(archives.t)
	(p.archives).t' = (p.archives).t- d
}
pred updateArchive[a:Archive,b:Backup,d,d':Date] {
	b !in ((a.backup).d)
	(a.backup).d' = b
}

pred show[] {}

run show for 4
