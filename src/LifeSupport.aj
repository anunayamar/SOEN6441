public aspect LifeSupport {
	//Introduced isAlive variable
	boolean Crew.isAlive;

	//Manipulates isAlive status
	public boolean Crew.getLifeStatus() {
		return this.isAlive;
	}
	
	//Manipulates isAlive status
	public void Crew.kill() {
		this.isAlive = false;
	}

	//This sets isAlive status as true during the instantiation of Crew object.
	pointcut lifeStatus(Crew crew) : execution(public Crew.new(..)) && this(crew);

	after(Crew crew) returning(): lifeStatus(crew){
		crew.isAlive = true;
	}

	
	//This filters all the messages sent to OnBoardComputer's void methods.
	pointcut filterCrewOnBoardMessage1(OnBoardComputer obc, Crew crew): call(void OnBoardComputer.*())										
																		&& this(crew) && target(obc);

	void around(OnBoardComputer obc, Crew crew): filterCrewOnBoardMessage1(obc,crew){
		if (crew.getLifeStatus()) {
			proceed(obc, crew);
		}

	}

	
	//This filters all the messages sent to OnBoardComputer's non-void methods.
	pointcut filterCrewOnBoardMessage2(OnBoardComputer obc, Crew crew): call(String OnBoardComputer.*())										
										&& this(crew) && target(obc);

	String around(OnBoardComputer obc, Crew crew): filterCrewOnBoardMessage2(obc,crew){
		if (crew.getLifeStatus()) {
			return proceed(obc, crew);
		} else {
			return null;
		}
	}

}
