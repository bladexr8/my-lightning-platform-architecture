public with sharing class ContestantService {

	// inner class
	public class RaceRetirement {
		public Id contestantId;
		public String reason;
	}

	// process retirement
	public static void retireFromRace(List<RaceRetirement> retirements) {
		// Process race retirements
	}


	public static void awardChampionshipPoints(Set<Id> contestantIds)
	{
		System.debug(LoggingLevel.INFO, '*** Awarding Championship Points ***');
	}
}