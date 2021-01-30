ENTITY temporizador IS
 
PORT(TR1,clk2:IN BIT;ZR1:OUT BIT);
END;
ARCHITECTURE BEHAVIOR OF TEMPORIZADOR IS 
COMPONENT contador IS
PORT(E,clk1:IN BIT;
	Q1,Q2,Q3: OUT BIT);
END COMPONENT;
signal s1,s2,s3:bit;
BEGIN 

		cont: contador port map(clk1=>clk2,q1=>s1,q2=>s2,q3=>s3,e=>tr1);
		zr1<=(s1 and s2 and s3);
		
		
end;