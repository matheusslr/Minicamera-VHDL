ENTITY temporizadorLento IS
 
PORT(TR1,clk2:IN BIT;ZR1:OUT BIT);
END;
ARCHITECTURE BEHAVIOR OF temporizadorLento IS 
COMPONENT contadorLento IS
PORT(E,clk1:IN BIT;
	Q1,Q2,Q3,Q4: OUT BIT);
END COMPONENT;
signal s1,s2,s3,s4:bit;
BEGIN 

		cont: contadorLento port map(clk1=>clk2,q1=>s1,q2=>s2,q3=>s3,q4=>s4,e=>tr1);
		zr1<=(s1 and s2 and s3 and s4);
		
		
end;