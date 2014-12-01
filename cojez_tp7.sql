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

--CREATE OR REPLACE FUNCTION RemplirOperations() RETURNS VOID AS $$
--    DECLARE 
        
        --Q2 modifier operations pas problemes

--E1Q3

--E1Q4

CREATE OR REPLACE FUNCTION nbAppels(d date) RETURNS INT AS $$
    BEGIN
        RETURN COUNT(codappel) FROM Appel GROUP BY DateOuverture HAVING DateOuverture=d;
    END; $$ LANGUAGE PLPGSQL;

SELECT * FROM nbAppels('2003-10-10');

--E1Q5

CREATE OR REPLACE FUNCTION coutAppelsOperations(d date) RETURNS INT AS $$
    BEGIN
        RETURN SUM(cout) FROM (
            SELECT cout FROM Appel WHERE DateOuverture=d
            UNION 
            SELECT cout FROM Operation WHERE Date=d) AS couts;
    END; $$ LANGUAGE PLPGSQL;

--E1Q6

CREATE OR REPLACE FUNCTION evaluation(op integer) RETURNS BOOLEAN AS $$
