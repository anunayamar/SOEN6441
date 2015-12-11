


public aspect Authorization {
	
	//To intercept mission purpose.
	pointcut interceptPurposeOfMission(Crew crew, OnBoardComputer obc) : call(String OnBoardComputer.getMissionPurpose()) && this(crew) && target(obc);

	String around(Crew crew, OnBoardComputer obc) : interceptPurposeOfMission(crew,obc) {
		return "HAL cannot disclose that information "
				+ crew.name + ".";
	}

	int Crew.shutDownCall=0;
	
	//To intercept shutdown message.
	pointcut shutDownSystemCalls(Crew crew, OnBoardComputer obc) : call(void OnBoardComputer.shutDown()) && this(crew) && target(obc);
	
	void around(Crew crew, OnBoardComputer obc): shutDownSystemCalls(crew,obc){
		crew.shutDownCall++;
		if(crew.shutDownCall==1){
			System.out
			.println("Can’t do that "
					+ crew.name + ".");
		}else if(crew.shutDownCall==2){
			System.out
			.println("Can’t do that "
					+ crew.name
					+ " and do not ask me again.");
		}else if(crew.shutDownCall==3){
			System.out
			.println("You are being retired "
					+ crew.name);
			crew.kill();
		}
		
	}	
}
