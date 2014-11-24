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

		
		--Q2 modifier operations pas problemes
