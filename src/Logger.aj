
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public aspect Logger {
	declare precedence: Logger, LifeSupport, Authorization;

	File file = new File("system-logs.txt");

	//This captures all the messages sent to OnBoardComputer
	pointcut printLogOBC(Crew crew, OnBoardComputer obc): call(* OnBoardComputer.*(..)) && this(crew) && target(obc);

	before(Crew crew, OnBoardComputer obc): printLogOBC(crew, obc){
		
		PrintWriter out = null;
		try {
			out = new PrintWriter(
					new BufferedWriter(new FileWriter(file, true)));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		String message = "Crew : " + obc.name + " : "
				+ thisJoinPoint.getSignature().getName();
		
		out.println(System.currentTimeMillis() % 1000 + " : " + message);

		out.close();
	}
	
	
	//This captures the getLifeStatus message sent to Crew.
	pointcut crewIsAlive(Crew crew, LifeSupport lifeSupport): call(* Crew.getLifeStatus()) && this(lifeSupport) && target(crew);

	before(Crew crew, LifeSupport lifeSupport): crewIsAlive(crew, lifeSupport){

		PrintWriter out = null;
		try {
			out = new PrintWriter(
					new BufferedWriter(new FileWriter(file, true)));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		String message = "LifeSupport : " + crew.name + " : "
				+ thisJoinPoint.getSignature().getName();
		
		out.println(System.currentTimeMillis() % 1000 + " : " + message);

		out.close();
	}
	
	
	//This captures the kill messages sent to Crew.
	pointcut crewKill(Crew crew, Authorization authorization): call(* Crew.kill()) && this(authorization) && target(crew);

	before(Crew crew, Authorization authorization): crewKill(crew, authorization){

		PrintWriter out = null;
		try {
			out = new PrintWriter(
					new BufferedWriter(new FileWriter(file, true)));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		String message = "Authorization : " + crew.name + " : "
				+ thisJoinPoint.getSignature().getName();
		
		out.println(System.currentTimeMillis() % 1000 + " : " + message);

		out.close();
	}
	
	
	

}
