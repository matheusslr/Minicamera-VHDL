ENTITY contadorLento IS
PORT(E,clk1:IN BIT;
	Q1,Q2,Q3,Q4: OUT BIT);
END contadorLento;

ARCHITECTURE behavior of contadorLento IS 
	
	SIGNAL SIG1: BIT;
	SIGNAL SIG2: BIT;
	SIGNAL SIG3: BIT;
	
COMPONENT flipflopT IS
	PORT(clk,T:IN BIT;Q:BUFFER BIT);
END COMPONENT;

BEGIN
	u1: flipflopT PORT MAP(clk=>clk1, T=>NOT(E), Q=>SIG1);
	u2: flipflopT PORT MAP(clk=>SIG1, T=>NOT(E), Q=>SIG2);
	u3: flipflopT PORT MAP(clk=>SIG2, T=>NOT(E), Q=>SIG3);
	u4: flipflopT PORT MAP(clk=>SIG3, T=>NOT(E), Q=>Q4);
	
	Q1<=SIG1;
	Q2<=SIG2;
	Q3<=SIG3;

END behavior;