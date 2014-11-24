drop table client cascade;
drop table operateur cascade;
drop table probleme cascade;
drop table appel cascade;
drop table operation;

CREATE TABLE client(
IdClient int,
Prenom varchar(30),
Nom    varchar(30),
DateN  date,
Tel    varchar(20),
TypeContrat varchar(20),
primary key (IdClient));

CREATE TABLE operateur(
CodOper int,
Nom varchar(30),
Prenom varchar(30),
DateN date,
Status int,
primary key (CodOper));

CREATE TABLE probleme(
CodProb int,
Description varchar(50),
Categorie varchar(20),
NiveauDiff float,
primary key (CodProb));

CREATE TABLE appel(
CodAppel int,
IdClient int,
CodOper int,
CodProb int,
DateOuverture date,
TelAppel varchar(20),
Duree int,
Cout float,
Resultat bool,
primary key (CodAppel),
foreign key (IdClient) references client(IdClient),
foreign key (CodOper) references operateur(CodOper),
foreign key (CodProb) references probleme(CodProb));

create table operation(
CodAppel int,
Date date,
Duree int,
Cout float,
Description varchar(50),
primary key (CodAppel,Date),
foreign key (CodAppel) references appel(CodAppel));


INSERT INTO client VALUES(0, 'beni', 'soitil', '04-03-1992', '0320232323', 'tropbien');
INSERT INTO client VALUES(1, 'harry', 'potter', '12-11-1990', '0101010101', 'Abonnement Adsl');
INSERT INTO client VALUES(2, 'pierre', 'petitboule', '10-05-1993', '0688093751', 'kwed');

INSERT INTO operateur VALUES(0, 'vert', 'green', '10-10-1995', 1);
INSERT INTO operateur VALUES(1, 'expansive', 'rodolph', '10-10-2005', 2);

INSERT INTO probleme VALUES(100, 'demenagement de ligne', 'grave', 23);
INSERT INTO probleme VALUES(200,'malfonctionnement free box','mineur',1);

INSERT INTO appel VALUES(0, 1, 0, 100, '10-10-2003', '0320255332', 10, 15, true);
INSERT INTO appel VALUES(1, 0, 1, 200, '11-03-2003', '0320255332', 10, 30, true);

INSERT INTO operation VALUES(0, '10-10-2003', 10, 15, 'wreck');
INSERT INTO operation VALUES(1, '11-03-2003', 10, 30, 'fix');
