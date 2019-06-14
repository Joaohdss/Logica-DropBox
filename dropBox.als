module dropBox
open Data as Data

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
sig DropBox {
	users : set User
}

sig User {
	storage : set (Folder),
	permission: one Permission
}

sig Folder{
	archives: set Archive,

}

sig Archive{
	info : one Info,
	date: one Date,
	backup: Backup -> Date

}

sig Backup{
}

sig Info{}
-- Permissao para ler e modificar arquivo

abstract sig Permission{
	archive : one Archive
}
sig Read extends Permission{}
sig Write extends Permission{}
sig Admin extends Permission{}

fact Folder{
	-- Toda Pasta deve pertencer a um usuario
   all f : Folder | one f.~storage
}
fact Archive{	
	-- Todo arquivo deve pertencer a uma pasta
	all a : Archive | one a.~archives
	-- Info deve pertencer apenas a um arquivo
	all i : Info | one i.~info	
}
fact {
	all d: Date | one d.~date
}
fact {
	all u: User | one u.~users
}
fact {
	all p:Permission | one p.~permission
	all a : Archive | some a.~archive
}
fact Date {
	all d:Date | one d.~date  -- Toda data deve pertencer a um Arquivo
	all d:Day | one d.~day  -- Todo dia deve pertencer a uma Data
	all h:Hour | one h.~hours  -- Toda hora deve pertencer a um Dia 
	all m:Minute | one m.~minutes -- Todo minuto deve pertencer a uma Hora
}

pred show[] {
}
run show for 5
