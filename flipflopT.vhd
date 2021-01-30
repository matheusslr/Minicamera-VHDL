ENTITY flipflopT IS
    PORT(clk,T:IN BIT;Q:BUFFER BIT);
END;
ARCHITECTURE behavior OF flipflopT IS 
    SIGNAL B:BIT;
    BEGIN
        PROCESS (clk,T,Q)
            BEGIN 
                B<=Q;
                IF(clk'EVENT AND clk='0' AND T='1') THEN
                        Q<=NOT B;
						
            END IF;

				IF(T='0') THEN
					Q<='0';
				END IF;

            END PROCESS;
END;