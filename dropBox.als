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
pred show[] {
}
run show for 3
