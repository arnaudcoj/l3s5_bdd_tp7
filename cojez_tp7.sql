--Arnaud Cojez, L3S5, G4
--CREATE LANGUAGE plpgsql;
--E1Q1 

SELECT * FROM Appel;

CREATE OR REPLACE FUNCTION AbonnementAdsl() RETURNS VOID AS $$
    DECLARE
        appelbad integer;
    BEGIN
        FOR appelbad IN SELECT codappel FROM Appel LEFT JOIN Client ON (Appel.idclient = Client.idclient)
            WHERE cout != 0 AND typecontrat = 'Abonnement Adsl'
        LOOP
            UPDATE Appel 
                SET cout = 0 WHERE codappel = appelbad;
        END LOOP;
    END; $$ LANGUAGE PLPGSQL;
		
SELECT * FROM AbonnementAdsl();

SELECT * FROM Appel;

--E1Q2

SELECT * FROM Operation; 

CREATE OR REPLACE FUNCTION remplirOperations() RETURNS VOID AS $$
    DECLARE
        demenagement integer;
        cout_max integer;
    BEGIN
        cout_max := MAX(cout) FROM Operation;
        FOR demenagement IN SELECT codappel FROM Appel WHERE codprob IN
                (SELECT codprob FROM Probleme WHERE description='demenagement de ligne')
        LOOP
            UPDATE Operation 
                SET duree=3, cout=cout_max, description='demenagement de ligne'
                    WHERE codappel=demenagement;
        END LOOP;
    END; $$ LANGUAGE PLPGSQL;

SELECT * FROM remplirOperations();

SELECT * FROM Operation; 

--E1Q3

SELECT * FROM Appel;

CREATE OR REPLACE FUNCTION coutAppels() RETURNS VOID AS $$
    DECLARE
        pl_appel integer;
    BEGIN
        FOR pl_appel IN SELECT codappel FROM Appel NATURAL JOIN Client WHERE typecontrat != 'Abonnement Adsl' AND tel = telappel
        LOOP
            UPDATE Appel
                SET cout = (duree * 6) WHERE codAppel = pl_appel;
        END LOOP;

        FOR pl_appel IN SELECT codappel FROM Appel NATURAL JOIN Client WHERE typecontrat != 'Abonnement Adsl' AND tel != telappel
        LOOP
            UPDATE Appel
                SET cout = 20 WHERE codAppel = pl_appel;
        END LOOP;
    END; $$ LANGUAGE PLPGSQL;

SELECT * FROM coutAppels();

SELECT * FROM Appel;

--E1Q4

CREATE OR REPLACE FUNCTION nbAppels(d date) RETURNS INT AS $$
    BEGIN
        RETURN COUNT(codappel) FROM Appel GROUP BY DateOuverture HAVING DateOuverture=d;
    END; $$ LANGUAGE PLPGSQL;


SELECT * FROM nbAppels('10-10-2003');

SELECT * FROM nbAppels('10-11-2003');

--E1Q5

CREATE OR REPLACE FUNCTION coutAppelsOperations(d date) RETURNS SETOF INTEGER AS $$
    BEGIN
        RETURN NEXT SUM(cout) FROM (SELECT cout FROM Appel WHERE DateOuverture=d) AS a1;
        RETURN NEXT SUM(cout) FROM (SELECT cout FROM Operation WHERE date=d) AS a2;
        RETURN;
    END; $$ LANGUAGE PLPGSQL;

SELECT * FROM coutAppelsOperations('10-10-2003');

SELECT * FROM coutAppelsOperations('11-03-2003');

--E1Q6

CREATE OR REPLACE FUNCTION evaluation(op integer) RETURNS BOOLEAN AS $$
    DECLARE
        tot_eval integer;
        eval_pos integer;
    BEGIN
        tot_eval := COUNT(resultat) FROM Appel WHERE codoper=op;
        eval_pos := COUNT(resultat) FROM Appel WHERE codoper=op AND resultat;
        IF eval_pos != 0 AND tot_eval != 0 THEN
            RETURN eval_pos / tot_eval > 0.5;
        ELSE
            RETURN false;
        END IF;
    END; $$ LANGUAGE PLPGSQL;

SELECT * FROM evaluation(0);

SELECT * FROM evaluation(1);

SELECT * FROM evaluation(2);

