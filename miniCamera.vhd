ENTITY minicamera IS
    PORT(E,Button,reset,clk:IN BIT;TR,ZR,ZL,TL: BUFFER BIT;R,G,B,C:OUT BIT);
END;

ARCHITECTURE behavior OF minicamera IS
    TYPE estado IS (closedcam,statephoto, resetTR, stateVideo, capturePhoto, deletePhoto,resetTR2,deleteVideo,filming,saveVideo);-- deletePhoto,stateVideo,resetTR2,filming,saveVideo,deletevideo);
    SIGNAL estado_atual : estado;
	 
	 COMPONENT temporizador IS 
		PORT(TR1,clk2:IN BIT;ZR1:OUT BIT);
	 END COMPONENT;
	 
	 COMPONENT temporizadorLento IS
		PORT(TR1,clk2:IN BIT;ZR1:OUT BIT);
	 END COMPONENT;
	 
    BEGIN
	 
		  temp: temporizador PORT MAP(clk2=>clk,ZR1=>Zr,TR1=>TR);
		  tempL: temporizadorLento PORT MAP(clk2=>clk,ZR1=>ZL,TR1=>TL);
		  
        PROCESS(clk,E,reset,Button,ZL,ZR) --Button,C,TR,TL,

            BEGIN 
                IF(reset='1') THEN
                    estado_atual<=closedcam;
                ELSIF(clk'EVENT and clk = '1') THEN
                    CASE estado_atual IS
                        when closedcam =>
										G<='0';
										R<='0';
										B<='0';
										TL<='1'; --
										TR<='0';
										C<='0';
										
                            IF(E='1') THEN
                                estado_atual<= statePhoto;
                            ELSE IF(E= '0') THEN
										estado_atual<= closedcam;
									 END IF;
									 END IF;
                         when statePhoto =>
										G<='1';
										R<='0';
										B<='0';
										TL<='0'; --
										TR<='1';
										C<='1';
										
                              IF(E='1' AND Button='0') THEN
                                      estado_atual<=closedcam;
								    	 ELSE IF (Button='1' AND ZL='0') THEN
												estado_atual <= resetTR;
										 ELSE IF (Button ='1' and ZL='1') THEN
												estado_atual <=stateVideo;										
										 END IF;
							    		 END IF;
										 END IF;
									
									when resetTR =>
										G<='1';
										R<='0';
										B<='0';
										TL<='0';
										TR<='0';
										C<='1';
										
										IF(Button='1' and ZR='0') THEN
                                      estado_atual<=deletePhoto;
									   ELSE IF( Button ='0' and ZR='1') THEN 
											     estado_atual <= capturePhoto;									   
										END IF;
										END IF;
									when deletePhoto =>
										G<='1';
										R<='0';
										B<='0';
										C<='1';
										TL<='0';
										TR<='0';
										
										estado_atual <=  statePhoto;
									when capturePhoto =>
										G<='0';
										R<='0';
										B<='0';
										C<='1';
										TL<='0';
										TR<='0';
										
										estado_atual <=  statePhoto;
									-- parte do video
									when stateVideo =>
										G<='0';
										R<='0';
										B<='1';
										TL<='1';
										TR<='1';
										C<='1';
										
                                    IF(Button='1' and ZL='1') THEN
                                            estado_atual<= statePhoto;
                                        ELSE IF(Button='1' and ZL='0') THEN
                                            estado_atual<=resetTR2;
                                        ELSE IF(E='1' and Button='0') THEN
                                            estado_atual<=closedcam;
                                        ELSE IF(Button='0' and E='0') THEN
                                            estado_atual<=StateVideo;
                                        END IF;
                                        END IF;
                                        END IF;
                                     END IF;
                                when resetTR2 =>
												G<='0';
												R<='0';
												B<='1';
												TL<='0';
										    	TR<='1';
												C<='1';
												
                                    IF(Button='1' and ZR='0') THEN
                                            estado_atual<=deleteVideo;
                                    ELSE IF(Button='0' and ZR='1') THEN
                                            estado_atual<=filming;
                                    END IF;
                                    END IF;
                                when deleteVideo =>
												G<='0';
												R<='0';
												B<='1';
												C<='1';
												TL<='0';
												TR<='0';
												
                                    estado_atual<=stateVideo;
                                when filming =>
												G<='0';
												R<='1';
												B<='0';
												C<='1';
												TL<='0';
									    		TR<='0';
												
                                    IF(Button='1') THEN
                                        estado_atual<=saveVideo;
                                    END IF;
                                when saveVideo =>
												G<='0';
												R<='0';
												B<='1';
												C<='1';
												TL<='0';
												TR<='0';
												
                                    estado_atual<=stateVideo;
                                
                    END CASE;
                END IF;
            END PROCESS;
   
                
    END;