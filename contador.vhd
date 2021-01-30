ENTITY contador IS
PORT(E,clk1:IN BIT;
	Q1,Q2,Q3: OUT BIT);
END contador;

ARCHITECTURE behavior of contador IS 
	
	SIGNAL SIG1: BIT;
	SIGNAL SIG2: BIT;
	
COMPONENT flipflopT IS
	PORT(clk,T:IN BIT;Q:BUFFER BIT);
END COMPONENT;

BEGIN
	u1: flipflopT PORT MAP(clk=>clk1, T=>NOT(E), Q=>SIG1);
	u2: flipflopT PORT MAP(clk=>SIG1, T=>NOT(E), Q=>SIG2);
	u3: flipflopT PORT MAP(clk=>SIG2, T=>NOT(E), Q=>Q3);
	
	Q1<=SIG1;
	Q2<=SIG2;

END behavior;