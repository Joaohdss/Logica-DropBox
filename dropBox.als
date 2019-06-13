module dropBox

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
sig User {
	folders: set Folder
}
sig Folder{
	archives: set Archive
}

sig Date {
	day: one Day
}
sig Day {
	hours : one Hour
}

sig Hour {
	minutes : one Minute
}
sig Minute {

}
abstract sig Version{}
sig VersionCurrent extends Version{}
sig VersionPrevious extends Version{}

sig Archive{
	date: one Date,
	newDate: one Date,
	createUser: one User,
	versions : set Version
}
fact{}
fact {
	-- Toda Pasta deve pertencer a um usuario
   all f : Folder | one f.~folders
}

fact {	
	-- Todo arquivo deve pertencer a uma pasta
	all a : Archive | one a.~archives
	
}

fact Date {
	all d:Date | one d.~date  -- Toda data deve pertencer a um Arquivo
	all d:Day | one d.~day  -- Todo dia deve pertencer a uma Data
	all h:Hour | one h.~hours  -- Toda hora deve pertencer a um Dia 
	all m:Minute | one m.~minutes -- Todo minuto deve pertencer a uma Hora
}


pred show[] {
}
run show for 3
